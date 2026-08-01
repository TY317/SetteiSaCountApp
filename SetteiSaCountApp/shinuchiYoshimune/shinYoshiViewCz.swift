//
//  shinYoshiViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct shinYoshiViewCz: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var shinYoshi: ShinYoshi
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3

    var body: some View {
        List {
            // 柳生選択率
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "柳生選択率",
                    count: $shinYoshi.czCharaCountYagyu,
                    bigNumber: $shinYoshi.czCharaCountSum,
                    numberofDicimal: 0
                )
                
                // 選択率
                unitLinkButtonViewBuilder(sheetTitle: "柳生選択率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "柳生選択率",
                            percentList: shinYoshi.ratioCzYagyu,
                            numberofDicimal: 1,
                        )
                    }
                }
                
                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 柳生以外
                        unitCountButtonWithoutRatioWithFunc(
                            title: "柳生以外",
                            count: $shinYoshi.czCharaCountOther,
                            color: .personalSummerLightBlue,
                            minusBool: $shinYoshi.minusCheck) {
                                shinYoshi.czCharaSumFunc()
                            }
                        // 柳生
                        unitCountButtonWithoutRatioWithFunc(
                            title: "柳生",
                            count: $shinYoshi.czCharaCountYagyu,
                            color: .personalSummerLightRed,
                            minusBool: $shinYoshi.minusCheck) {
                                shinYoshi.czCharaSumFunc()
                            }
                    }
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            shinYoshiView95Ci(
                                shinYoshi: shinYoshi,
                                selection: 3,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        shinYoshiViewBayes(
                            shinYoshi: shinYoshi,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("柳生選択率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
                unitButtonMinusCheck(minusCheck: $shinYoshi.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shinYoshi.resetCz)
            }
        }
    }
}

#Preview {
    shinYoshiViewCz(
        shinYoshi: ShinYoshi(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
