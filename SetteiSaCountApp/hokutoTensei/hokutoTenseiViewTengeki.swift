//
//  hokutoTenseiViewTengeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct hokutoTenseiViewTengeki: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            // ハズレでの天撃成功率
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・4G全てハズレだった場合の失敗・成功をカウント")
                    Text("　（小役成立時の成功率は設定差ないため）")
                }
                
                // カウントボタン横並び
                HStack {
                    // 失敗
                    unitCountButtonPercentWithFunc(
                        title: "失敗",
                        count: $hokutoTensei.tengekiCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $hokutoTensei.tengekiCountSum,
                        numberofDicimal: 0,
                        minusBool: $hokutoTensei.minusCheck) {
                            hokutoTensei.tengekiSumFunc()
                        }
                    // 成功
                    unitCountButtonPercentWithFunc(
                        title: "成功",
                        count: $hokutoTensei.tengekiCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $hokutoTensei.tengekiCountSum,
                        numberofDicimal: 0,
                        minusBool: $hokutoTensei.minusCheck) {
                            hokutoTensei.tengekiSumFunc()
                        }
                }
                
                // 参考情報）ハズレでの成功率
                unitLinkButtonViewBuilder(sheetTitle: "ハズレでの成功期待度") {
                    hokutoTenseiTableTengeki(hokutoTensei: hokutoTensei)
                }
                
                // 参考情報）成立役・ゲームごとの成功率詳細
                unitLinkButtonViewBuilder(sheetTitle: "成立役・ゲームごとの成功率詳細") {
                    hokutoTenseiTableTengekiDetail()
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hokutoTenseiViewBayes(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ハズレでの天撃成功率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuTengekiBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("天撃")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hokutoTensei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hokutoTensei.resetTengeki)
            }
        }
    }
}

#Preview {
    hokutoTenseiViewTengeki(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
