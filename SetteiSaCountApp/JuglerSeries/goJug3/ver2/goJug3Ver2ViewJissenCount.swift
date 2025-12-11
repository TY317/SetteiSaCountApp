//
//  goJug3Ver2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/23.
//

import SwiftUI

struct goJug3Ver2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var goJug3: GoJug3
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    private let autoCountTimer = Timer.publish(every: 4.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        List {
            // //// 小役、ボーナスカウント
            Section {
                // //// カウントボタン
                HStack {
                    // ぶどう
                    unitCountButtonVerticalDenominate(
                        title: "ぶどう",
                        count: $goJug3.personalBellCount,
                        color: .personalSummerLightGreen,
                        bigNumber: $goJug3.playGame,
                        numberofDicimal: 2,
                        minusBool: $goJug3.minusCheck
                    )
                    // BIG
                    unitCountButtonVerticalDenominate(
                        title: "BIG",
                        count: $goJug3.personalBigCount,
                        color: .personalSummerLightRed,
                        bigNumber: $goJug3.playGame,
                        numberofDicimal: 0,
                        minusBool: $goJug3.minusCheck
                    )
                    // REG
                    unitCountButtonVerticalDenominate(
                        title: "REG",
                        count: $goJug3.personalRegCountSum,
                        color: .personalSummerLightBlue,
                        bigNumber: $goJug3.playGame,
                        numberofDicimal: 0,
                        minusBool: $goJug3.minusCheck
                    )
                }
                // //// 結果
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $goJug3.personalBonusCountSum,
                        bigNumber: $goJug3.playGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ゴーゴージャグラー3設定差",
                            textBody1: "・REGは単独、チェリー重複ともに均一の設定差と思われるので分けてカウントしなくてもいいらしい",
                            tableView: AnyView(goJugTableRatio(goJug3: goJug3))
//                            image1: Image("goJug3Ratio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(goJug3Ver2View95CiPersonal(goJug3: goJug3)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    goJug3ViewBayes(
//                        ver391: ver391,
                        goJug3: goJug3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("小役,ボーナス カウント")
            }
            
            // //// ゲーム数入力
            Section {
                // 打ち始め
                HStack {
                    Text("打ち始め")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(goJug3.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $goJug3.currentGames)
                    .focused($isFocused)
                    .toolbar {
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
                // 消化ゲーム数
                HStack {
                    Text("自分のプレイ数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(goJug3.playGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴーゴージャグラー3",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$goJug3.currentGames,
            nextDate: self.$nextAutoCountDate,
            interval: 4.1
        )
        .navigationTitle("実戦カウント")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // 自動G数カウント
                unitToolbarButtonAutoGameCount(
                    autoBool: self.$isAutoCountOn,
                    nextAutoCountDate: self.$nextAutoCountDate,
                )
                .popoverTip(commonTipAutoGameCount())
            }
            ToolbarItem(placement: .automatic) {
                // カウント入力
                unitButtonCountNumberInput(
                    inputView: AnyView(
                        goJug3SubViewCountInput(
                            goJug3: goJug3
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $goJug3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: goJug3.resetCountData)
            }
        }
    }
}

#Preview {
    goJug3Ver2ViewJissenCount(
//        ver391: Ver391(),
        goJug3: GoJug3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
