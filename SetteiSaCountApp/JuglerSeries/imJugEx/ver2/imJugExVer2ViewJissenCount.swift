//
//  imJugExVer2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/22.
//

import SwiftUI
import Combine

struct imJugExVer2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var imJugEx: ImJugEx
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    @State private var isAutoCountOn: Bool = false
    @State private var nextAutoCountDate: Date? = nil
    @EnvironmentObject var common: commonVar
    private var autoCountTimer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: common.autoGameInterval, on: .main, in: .common).autoconnect() }
    
    var body: some View {
        List {
            // //// 小役、ボーナスカウント
            Section {
                // //// カウントボタン
                HStack {
                    // ぶどう
                    unitCountButtonVerticalDenominate(
                        title: "ぶどう",
                        count: $imJugEx.personalBellCount,
                        color: .personalSummerLightGreen,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 2,
                        minusBool: $imJugEx.minusCheck
                    )
                    // チェリー
                    unitCountButtonVerticalDenominate(
                        title: "🍒",
                        count: $imJugEx.personalCherryCount,
                        color: .personalSummerLightRed,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 1,
                        minusBool: $imJugEx.minusCheck
                    )
                }
                // 2段目
                HStack {
                    // BIG
                    unitCountButtonVerticalDenominate(
                        title: "BIG",
                        count: $imJugEx.personalBigCount,
                        color: .personalSummerLightRed,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0,
                        minusBool: $imJugEx.minusCheck
                    )
                    // 単独REG
                    unitCountButtonVerticalDenominate(
                        title: "単独REG",
                        count: $imJugEx.personalAloneRegCount,
                        color: .personalSummerLightBlue,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0,
                        minusBool: $imJugEx.minusCheck
                    )
                    // 🍒REG
                    unitCountButtonVerticalDenominate(
                        title: "🍒REG",
                        count: $imJugEx.personalCherryRegCount,
                        color: .personalSummerLightPurple,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0,
                        minusBool: $imJugEx.minusCheck
                    )
                }
                // //// 結果
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $imJugEx.personalBonusCountSum,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0
                    )
                    // REG合算
                    unitResultRatioDenomination2Line(
                        title: "REG合算",
                        count: $imJugEx.personalRegCountSum,
                        bigNumber: $imJugEx.playGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "アイムジャグラーEX設定差",
                            tableView: AnyView(imJugExTableRatio(imJugEx: imJugEx))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(imJugExVer2View95CiPersonal(imJugEx: imJugEx)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    imJugExViewBayes(
//                        ver391: ver391,
                        imJugEx: imJugEx,
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
                    Text("\(imJugEx.startGameInput)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundStyle(Color.secondary)
                }
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $imJugEx.currentGames)
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
                    Text("\(imJugEx.playGame)")
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
                screenName: "アイムジャグラーEX",
                screenClass: screenClass
            )
        }
        .autoGameCount(
            isOn: self.$isAutoCountOn,
            currentGames: self.$imJugEx.currentGames,
            nextDate: self.$nextAutoCountDate,
            interval: common.autoGameInterval
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
                        imJugExSubViewCountInput(
                            imJugEx: imJugEx
                        )
                    )
                )
            }
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $imJugEx.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: imJugEx.resetCountData)
            }
        }
    }
}

#Preview {
    imJugExVer2ViewJissenCount(
//        ver391: Ver391(),
        imJugEx: ImJugEx(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
