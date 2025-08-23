//
//  mt5View5coin.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/07.
//

import SwiftUI
import TipKit
import Charts

// //////////////////
// Tip：5枚役 ゲーム数の種類の説明
// //////////////////
struct mt5TipCoin5Game: Tip {
    var title: Text {
        Text("総ゲーム数の入力")
    }
    
    var message: Text? {
        Text("液晶メニューの「総ゲーム数」の数字を参照（AT中もカウントする前提）")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

struct mt5View5coin: View {
    @ObservedObject var ver370: Ver370
    @ObservedObject var mt5: Mt5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                HStack {
                    // カウントボタン
                    unitCountButtonVerticalWithoutRatio(title: "5枚役", count: $mt5.coin5Count, color: .personalSummerLightBlue, minusBool: $mt5.minusCheck)
                    // 確率
                    unitResultRatioDenomination2Line(title: "5枚役出現率", color: .grayBack, count: $mt5.coin5Count, bigNumber: $mt5.playGame, numberofDicimal: 1)
                        .padding(.vertical)
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "5枚役について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "5枚役",
                            textBody1: "・5枚役の出現率に大きな設定差があるらしい",
                            textBody2: "・AT中含めて全状態でカウント可能",
                            textBody3: "・AT中含めてカウントの場合は液晶メニュー画面の総ゲーム数を分母とする",
                            textBody4: "・停止形は下記画像を参照",
//                            image1: Image("mt5coin5Ratio"),
//                            image2: Image("mt5Coin5Image")
                            tableView: AnyView(mt5Table5Coin())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mt5View95Ci(mt5: mt5, selection: 1)))
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mt5ViewBayes(
                        ver370: ver370,
                        mt5: mt5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
//                NavigationStack {
//                    NavigationLink {
//                        mt5ViewBayes(
//                            ver370: ver370,
//                            mt5: mt5,
//                            bayes: bayes,
//                            viewModel: viewModel,
//                        )
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Image(systemName: "gauge.open.with.lines.needle.33percent")
//                                .font(.title2)
//                                .foregroundStyle(Color.blue)
//                        }
//                    }
//
//                }
            } header: {
                Text("5枚役のカウント")
            }
            
            // //// ゲーム数入力部分
            Section {
                // 打ち始め
                unitTextFieldGamesInput(title: "打ち始め", inputValue: $mt5.startGame)
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
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $mt5.currentGame)
                    .focused($isFocused)
                // 消化ゲーム数
                HStack {
                    Text("消化ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(mt5.playGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("総ゲーム数入力")
            }
            .popoverTip(mt5TipCoin5Game())
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
        .navigationTitle("5枚役")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetCoin5)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


#Preview {
    mt5View5coin(
        ver370: Ver370(),
        mt5: Mt5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
