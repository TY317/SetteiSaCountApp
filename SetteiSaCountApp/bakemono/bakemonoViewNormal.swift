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
    
    @State var selectedRare: String = "🍉"
    let rareList: [String] = ["🍉", "強🍒・チャンス目"]
    
    let gameList: [String] = ["200G", "300G"]
    @State var selectedGame: String = "200G"
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
//                    .popoverTip(tipVer3170bakemonoSuikaRatio())
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
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bakemonoViewBayes(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("小役確率")
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
            
            // 通常時レア役からのCZ当選
            Section {
                // 注意書き
                Text("状態は完全に見抜けないと思いますがメモ代わりにご利用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // セグメントピッカー
                Picker("", selection: self.$selectedRare) {
                    ForEach(self.rareList, id: \.self) { rare in
                        Text(rare)
                    }
                }
                .pickerStyle(.segmented)
//                .popoverTip(tipVer3171BakemonoRareCz())
                
                // カウントボタン横並び
                // スイカ
                if self.selectedRare == self.rareList[0] {
                    HStack {
                        // スイカ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "🍉",
                            count: $bakemono.rareCzCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.rareCzSumFunc()
                            }
                        // CZ当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ当選",
                            count: $bakemono.rareCzCountSuikaHit,
                            color: .personalSummerLightPurple,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.rareCzSumFunc()
                            }
                    }
                }
                // 強チェリー、チャンス目
                else {
                    HStack {
                        // 強チェリー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "強🍒",
                            count: $bakemono.rareCzCountKyoCherry,
                            color: .red,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.rareCzSumFunc()
                            }
                        // チャンス目
                        unitCountButtonWithoutRatioWithFunc(
                            title: "チャンス目",
                            count: $bakemono.rareCzCountChance,
                            color: .blue,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.rareCzSumFunc()
                            }
                        // CZ当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ当選",
                            count: $bakemono.rareCzCountKyoRareHit,
                            color: .purple,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.rareCzSumFunc()
                            }
                    }
                }
                
                // 確率結果
                HStack {
                    // スイカ
                    unitResultRatioPercent2Line(
                        title: "🍉",
                        count: $bakemono.rareCzCountSuikaHit,
                        bigNumber: $bakemono.rareCzCountSuika,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 強チェリー、チャンス目
                    unitResultRatioPercent2Line(
                        title: "強🍒・チャンス目",
                        count: $bakemono.rareCzCountKyoRareHit,
                        bigNumber: $bakemono.rareCzCountKyoRareSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // 参考情報）レア役からのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選率") {
                    bakemonoTableRareCz(bakemono: bakemono)
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bakemonoView95Ci(
                            bakemono: bakemono,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bakemonoViewBayes(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("通常滞在時 レア役からのCZ当選率")
            }
            
            // ---- 規定ゲーム数での解呪ノ儀当選率
            Section {
                // ピッカー
                Picker("", selection: self.$selectedGame) {
                    ForEach(self.gameList, id: \.self) { game in
                        Text(game)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3221BakemonoGameKaiju())
                
                // カウントボタン横並び
                HStack {
                    // 200G
                    if self.selectedGame == self.gameList[0] {
                        // なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "なし",
                            count: $bakemono.kiteiCount200Miss,
                            color: .personalSummerLightBlue,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.kiteiSumFunc()
                            }
                        // あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $bakemono.kiteiCount200Hit,
                            color: .personalSummerLightGreen,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.kiteiSumFunc()
                            }
                    }
                    // 300G
                    else {
                        // なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "なし",
                            count: $bakemono.kiteiCount300Miss,
                            color: .personalSpringLightYellow,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.kiteiSumFunc()
                            }
                        // あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $bakemono.kiteiCount300Hit,
                            color: .personalSummerLightRed,
                            minusBool: $bakemono.minusCheck) {
                                bakemono.kiteiSumFunc()
                            }
                    }
                }
                
                // 確率結果
                HStack {
                    // 200G
                    unitResultRatioPercent2Line(
                        title: "200G",
                        count: $bakemono.kiteiCount200Hit,
                        bigNumber: $bakemono.kiteiCount200Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 300G
                    unitResultRatioPercent2Line(
                        title: "300G",
                        count: $bakemono.kiteiCount300Hit,
                        bigNumber: $bakemono.kiteiCount300Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // 参考情報）解呪ノ儀当選率
                unitLinkButtonViewBuilder(sheetTitle: "解呪ノ儀当選率") {
                    bakemonoTableKiteiGameKaiju(bakemono: bakemono)
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bakemonoView95Ci(
                            bakemono: bakemono,
                            selection: 5,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bakemonoViewBayes(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ゲーム数での解呪ノ儀当選率")
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
