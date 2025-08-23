//
//  hokutoViewBbBell.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/01.
//

import SwiftUI
import TipKit

struct hokutoViewBbBell: View {
    @ObservedObject var ver380: Ver380
    @ObservedObject var hokuto: Hokuto
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
        List {
            Section {
                // //// 縦画面
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    // //// カウント
                    HStack {
                        // 斜めベル
                        unitCountButtonVerticalWithoutRatio(title: "斜めベル", count: $hokuto.bbBellNanameCount, color: .personalSpringLightYellow, minusBool: $hokuto.minusCheck)
                        // 中段平行
                        unitCountButtonVerticalWithoutRatio(title: "中段平行ベル", count: $hokuto.bbBellHorizontalCount, color: .yellow, minusBool: $hokuto.minusCheck)
                    }
                    // //// 結果表示
                    HStack {
                        // 比率
                        unitResultRatioRatioRightOneLine(title: "斜め：平行", color: .grayBack, count1: $hokuto.bbBellNanameCount, count2: $hokuto.bbBellHorizontalCount, numberofDicimal: 1)
                        // 平行ベル出現率
                        unitResultRatioDenomination2Line(title: "平行出現率", color: .grayBack, count: $hokuto.bbBellHorizontalCount, bigNumber: $hokuto.bbPlayGame, numberofDicimal: 0)
                    }
                }
                // //// 横画面
                else {
                    HStack {
                        // 斜めベル
                        unitCountButtonVerticalWithoutRatio(title: "斜めベル", count: $hokuto.bbBellNanameCount, color: .personalSpringLightYellow, minusBool: $hokuto.minusCheck)
                        // 中段平行
                        unitCountButtonVerticalWithoutRatio(title: "中段平行ベル", count: $hokuto.bbBellHorizontalCount, color: .yellow, minusBool: $hokuto.minusCheck)
                        // 比率
                        unitResultRatioRatioRightOneLine(title: "斜め：平行", color: .grayBack, count1: $hokuto.bbBellNanameCount, count2: $hokuto.bbBellHorizontalCount, numberofDicimal: 1)
                            .padding(.vertical)
                        // 平行ベル出現率
                        unitResultRatioDenomination2Line(title: "平行出現率", color: .grayBack, count: $hokuto.bbBellHorizontalCount, bigNumber: $hokuto.bbPlayGame, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                }
                // //// 参考情報
                unitLinkButton(
                    title: "ナビなしベルについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "BB中のナビなしベル",
                            textBody1: "・押し順は中・右・左を遵守",
                            textBody2: "・小役パート中が対象。バトルパート中は対象外",
                            textBody3: "・中段に平行揃いするベルに設定差があると言われている",
                            textBody4: "・斜めベルとの比率も指標になるため、斜め揃いもカウントを推奨",
                            textBody5: "・消化ゲーム数はサブ液晶のセット数×30Gで算出",
                            tableView: AnyView(hokutoTableBBBell())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(hokutoView95Ci(hokuto: hokuto, selection: 3)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hokutoViewBayes(
                        ver380: ver380,
                        hokuto: hokuto,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ナビなしベル")
            }
            
            Section {
                // 打ち始め
                unitTextFieldGamesInput(title: "打ち始め", inputValue: $hokuto.bbStartSet)
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
                unitTextFieldGamesInput(title: "現在", inputValue: $hokuto.bbCurrentSet)
                    .focused($isFocused)
                // 消化ゲーム数
                HStack {
                    Text("消化ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(hokuto.bbPlayGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("セット数入力")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スマスロ北斗の拳",
                screenClass: screenClass
            )
        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("BB中のベル")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $hokuto.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetBbBell)
                }
            }
        }
    }
}

#Preview {
    hokutoViewBbBell(
        ver380: Ver380(),
        hokuto: Hokuto(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
