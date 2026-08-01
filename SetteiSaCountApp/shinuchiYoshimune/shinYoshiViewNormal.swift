//
//  shinYoshiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import SwiftUI

struct shinYoshiViewNormal: View {
    @ObservedObject var shinYoshi: ShinYoshi
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
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            // ---- 抜刀チャンス当選率
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "抜刀チャンス当選率",
                    count: $shinYoshi.battoCountHit,
                    bigNumber: $shinYoshi.battoCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）当選率
                unitLinkButtonViewBuilder(sheetTitle: "抜刀チャンス当選率") {
                    VStack(spacing: 20) {
                        Text("・AT終了後の初回と5周期目は除外")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "抜刀チャンス当選率",
                                percentList: shinYoshi.ratioBattoChance
                            )
                        }
                    }
                }
                
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・AT終了後の初回と5周期目は除外")
                    }
                    
                    // カウントボタン横並び
                    HStack {
                        // 当選なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選なし",
                            count: $shinYoshi.battoCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $shinYoshi.minusCheck) {
                                shinYoshi.battoSumFunc()
                            }
                        // 当選あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選あり",
                            count: $shinYoshi.battoCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $shinYoshi.minusCheck) {
                                shinYoshi.battoSumFunc()
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            shinYoshiView95Ci(
                                shinYoshi: shinYoshi,
                                selection: 2,
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
                Text("抜刀メーターMAX時の抜刀チャンス当選率")
            }
            // ---- レア役停止系
            Section {
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    shinYoshiTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // ---- CZモード
            Section {
                // CZモード
                unitLinkButtonViewBuilder(sheetTitle: "CZモードについて") {
                    shinYoshiTableMode()
                }
            } header: {
                Text("CZモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: shinYoshi.resetNormal)
            }
        }
    }
}

#Preview {
    shinYoshiViewNormal(
        shinYoshi: ShinYoshi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
