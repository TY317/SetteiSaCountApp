//
//  azurLaneViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/25.
//

import SwiftUI

struct azurLaneViewFirstHit: View {
    @ObservedObject var azurLane: AzurLane
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            Section {
                // //// 注意書き
                Text("現在値、履歴はぱちログで確認して入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // アズールレーンボーナス
                unitTextFieldNumberInputWithUnit(
                    title: "アズールレーンBONUS",
                    inputValue: $azurLane.bonusCount,
                )
                .focused($isFocused)
                // アズールレーンラッシュ
                unitTextFieldNumberInputWithUnit(
                    title: "アズールレーンRUSH",
                    inputValue: $azurLane.atCount,
                )
                .focused($isFocused)
                // 確率横並び
                HStack {
                    // ボーナス
                    unitResultRatioDenomination2Line(
                        title: "ボーナス",
                        count: $azurLane.bonusCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $azurLane.atCount,
                        bigNumber: $azurLane.gameNormalNumberPlay,
                        numberofDicimal: 0
                    )
                }
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率", linkText: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ボーナス",
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
                            selection: 4,
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
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
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
