//
//  myJug5Ver2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/18.
//

import SwiftUI

struct myJug5Ver2ViewJissenCount: View {
    @ObservedObject var myJug5: MyJug5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    
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
                        count: $myJug5.personalBellCount,
                        color: .personalSummerLightGreen,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 2,
                        minusBool: $myJug5.minusCheck
                    )
                    // BIG
                    unitCountButtonVerticalDenominate(
                        title: "BIG",
                        count: $myJug5.personalBigCount,
                        color: .personalSummerLightRed,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0,
                        minusBool: $myJug5.minusCheck
                    )
                    // 単独REG
                    unitCountButtonVerticalDenominate(
                        title: "単独REG",
                        count: $myJug5.personalAloneRegCount,
                        color: .personalSummerLightBlue,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0,
                        minusBool: $myJug5.minusCheck
                    )
                    // 🍒REG
                    unitCountButtonVerticalDenominate(
                        title: "🍒REG",
                        count: $myJug5.personalCherryRegCount,
                        color: .personalSummerLightPurple,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0,
                        minusBool: $myJug5.minusCheck
                    )
                }
                // //// 結果
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $myJug5.personalBonusCountSum,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0
                    )
                    // REG合算
                    unitResultRatioDenomination2Line(
                        title: "REG合算",
                        count: $myJug5.personalRegCountSum,
                        bigNumber: $myJug5.playGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "マイジャグラー5設定差",
                            tableView: AnyView(myJug5TableRatio(myJug5: myJug5))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(myJug5Ver2View95CiPersonal(myJug5: myJug5)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    myJug5ViewBayes(
                        myJug5: myJug5,
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
                    Text("\(myJug5.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $myJug5.currentGames)
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
                    Text("\(myJug5.playGame)")
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
                screenName: "マイジャグラー5",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$myJug5.currentGames,
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
                        myJug5SubViewCountInput(
                            myJug5: myJug5
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $myJug5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: myJug5.resetCountData)
            }
        }
    }
}

#Preview {
    myJug5Ver2ViewJissenCount(
        myJug5: MyJug5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
