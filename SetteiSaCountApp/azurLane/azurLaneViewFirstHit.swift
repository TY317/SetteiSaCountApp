//
//  azurLaneViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/25.
//

import SwiftUI

struct azurLaneViewFirstHit: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var azurLane: AzurLane
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
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
    let lazyVGridCountLandscape: Int = 4
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            Section {
                // //// 注意書き
                Text("現在値、履歴はぱちログで確認して入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
//                // アズールレーンボーナス
//                unitTextFieldNumberInputWithUnit(
//                    title: "アズールレーンBONUS",
//                    inputValue: $azurLane.bonusCount,
//                )
//                .focused($isFocused)
                // アズールレーンボーナス 白７
                unitTextFieldNumberInputWithUnit(
                    title: "アズールレーンBONUS 白7",
                    inputValue: $azurLane.bonusCountWhite,
                )
                .focused($isFocused)
                .onChange(of: azurLane.bonusCountWhite) { oldValue, newValue in
                    azurLane.bonusSumFunc()
                }
                .popoverTip(tipVer391AzurLaneBonus())
                // アズールレーンボーナス 青７
                unitTextFieldNumberInputWithUnit(
                    title: "アズールレーンBONUS 青7",
                    inputValue: $azurLane.bonusCountBlue,
                )
                .focused($isFocused)
                .onChange(of: azurLane.bonusCountBlue) { oldValue, newValue in
                    azurLane.bonusSumFunc()
                }
                // アズールレーンラッシュ
                unitTextFieldNumberInputWithUnit(
                    title: "アズールレーンRUSH",
                    inputValue: $azurLane.atCount,
                )
                .focused($isFocused)
                // 確率横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
//                HStack {
                    // 白７
                    unitResultRatioDenomination2Line(
                        title: "白7",
                        count: $azurLane.bonusCountWhite,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 青７
                    unitResultRatioDenomination2Line(
                        title: "青7",
                        count: $azurLane.bonusCountBlue,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // ボーナス
                    unitResultRatioDenomination2Line(
//                        title: "ボーナス",
                        title: "合算",
                        count: $azurLane.bonusCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $azurLane.atCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率", linkText: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "白7",
                            denominateList: azurLane.ratioBonusWhite
                        )
                        unitTableDenominate(
                            columTitle: "青7",
                            denominateList: azurLane.ratioBonusBlue
                        )
                        unitTableDenominate(
                            columTitle: "合算",
                            denominateList: azurLane.ratioBonus,
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: azurLane.ratioAt,
                        )
                    }
                }
                // 参考情報）ボーナス規定回数
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス規定回数") {
                    VStack {
                        Text("・AT終了時、設定変更時に規定回数を抽選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・モードによる管理はなし")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        Text("[期待度テーブル]")
                            .font(.title2)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: [
                                    "1回目",
                                    "2回目",
                                    "3回目",
                                    "4回目",
                                    "5回目",
                                    "6回目",
                                    "7回目",
                                    "8回目",
                                    "9回目",
                                    "10回目",
                                ],
                                maxWidth: 80,
                            )
                            unitTableString(
                                columTitle: "AT後",
                                stringList: ["◎","△","◎","△","◯","△","◎","△","△","天井"]
                            )
                            unitTableString(
                                columTitle: "設定変更後",
                                stringList: ["◎","▲","◎","▲","◯","▲","天井","grayOut","grayOut","grayOut"]
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        azurLaneView95Ci(
                            azurLane: azurLane,
                            selection: 7,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    azurLaneViewBayes(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
            
            // //// ゲーム数入力
            Section {
                // 注意書き
                VStack {
                    Text("・ぱちログで確認して入力して下さい")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・通常時遊技数の数値を入力して下さい")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $azurLane.gameNormalNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: azurLane.gameNormalNumberStart) {
                    let playGame = azurLane.gameNormalNumberCurrent - azurLane.gameNormalNumberStart
                    azurLane.gameNormalNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $azurLane.gameNormalNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: azurLane.gameNormalNumberCurrent) {
                    let playGame = azurLane.gameNormalNumberCurrent - azurLane.gameNormalNumberStart
                    azurLane.gameNormalNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: azurLane.gameNormalNumberPlay
                )
                
            } header: {
                HStack {
                    Text("ゲーム数入力")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.azurLaneMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: azurLane.resetFirstHit)
                }
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
    azurLaneViewFirstHit(
        ver391: Ver391(),
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
