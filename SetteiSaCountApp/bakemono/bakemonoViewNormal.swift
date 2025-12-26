//
//  bakemonoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoViewNormal: View {
    @ObservedObject var bakemono: Bakemono
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
            // //// レア役
            Section {
                // スイカカウント
                // 注意書き
//                Text("マイスロを参考に入力して下さい")
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $bakemono.totalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // スイカカウント
                unitCountButtonVerticalDenominate(
                    title: "🍉",
                    count: $bakemono.koyakuCountSuika,
                    color: .personalSummerLightGreen,
                    bigNumber: $bakemono.totalGame,
                    numberofDicimal: 0,
                    minusBool: $bakemono.minusCheck
                )
//                unitTextFieldNumberInputWithUnit(
//                    title: "🍉",
//                    inputValue: $bakemono.koyakuCountSuika,
//                )
//                .focused(self.$isFocused)
                unitLinkButtonViewBuilder(
                    sheetTitle: "🍉確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "🍉",
                                denominateList: bakemono.ratioSuika
                            )
                        }
                    }
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    bakemonoTableKoyakuPattern()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bakemonoView95Ci(
                            bakemono: bakemono,
                            selection: 2,
                        )
                    )
                )
            } header: {
                Text("レア役")
            }
            
            // //// 弱🍒からのAT直撃
            Section {
                // カウントボタン横並び
                HStack {
                    // 弱チェリー
                    unitCountButtonVerticalWithoutRatio(
                        title: "通常時弱🍒",
                        count: $bakemono.koyakuCountJakuCherry,
                        color: .personalSummerLightRed,
                        minusBool: $bakemono.minusCheck
                    )
                    // AT直撃
                    unitCountButtonVerticalWithoutRatio(
                        title: "AT直撃",
                        count: $bakemono.jakuCherryAtCount,
                        color: .personalSummerLightPurple,
                        minusBool: $bakemono.minusCheck
                    )
                }
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "AT直撃率",
                    count: $bakemono.jakuCherryAtCount,
                    bigNumber: $bakemono.koyakuCountJakuCherry,
                    numberofDicimal: 1
                )
                // 参考情報）直撃確率
                unitLinkButtonViewBuilder(sheetTitle: "AT直撃率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "AT直撃",
                            percentList: bakemono.ratioJakuCherryAt,
                            numberofDicimal: 1,
                        )
                    }
                }
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bakemonoViewBayes(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("弱🍒からのAT直撃")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $bakemono.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bakemono.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    bakemonoViewNormal(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
