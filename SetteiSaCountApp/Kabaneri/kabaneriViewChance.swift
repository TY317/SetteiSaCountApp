//
//  kabaneriViewChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/29.
//

import SwiftUI

struct kabaneriViewChance: View {
//    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneri: Kabaneri
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // //// 縦画面
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    Section {
                        HStack {
                            // 発光なしカウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "発光なし", count: $kabaneri.chanceWithoutFlushCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 発光ありカウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "発光あり", count: $kabaneri.chanceWithFlushCount, color: .personalSummerLightRed, minusBool: $kabaneri.minusCheck)
                            // 発光率
                            unitResultRatioPercent2Line(title: "発光率", color: .grayBack, count: $kabaneri.chanceWithFlushCount, bigNumber: $kabaneri.chanceCountSum, numberofDicimal: 0)
                                .padding(.vertical)
                        }
                        // 参考情報リンク
                        unitLinkButton(title: "発光率について", exview: AnyView(unitExView5body2image(title: "1個チャンス目の発光率", textBody1: "・好機、発光していないチャンス目が単独で出現した時がカウント対象", textBody2: "・発光率に設定差あり。通常時の判別要素のメインになり得る", image1: Image("kabaneriChance"))))
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(Ci95view: AnyView(kabaneriView95Ci(kabaneri: kabaneri, selection: 1)))
                            .popoverTip(tipUnitButtonLink95Ci())
                    } header: {
                        Text("1個チャンス目の発光率")
                    }
                    // //// 共通ベル
                    Section {
                        HStack {
                            // カウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "共通ベル", count: $kabaneri.bellCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck, flushColor: Color.yellow)
                            // 確率
                            unitResultRatioDenomination2Line(title: "出現率", color: .grayBack, count: $kabaneri.bellCount, bigNumber: $kabaneri.playGame, numberofDicimal: 1)
                                .padding(.vertical)
                        }
                        // 打ち始めゲーム数
                        unitTextFieldGamesInput(title: "打ち始め", inputValue: $kabaneri.startGame)
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
                        // 現在ゲーム数
                        unitTextFieldGamesInput(title: "現在", inputValue: $kabaneri.currentGame)
                            .focused($isFocused)
                        // プレイゲーム数
                        HStack {
                            Text("消化ゲーム数")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(kabaneri.playGame)")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        // 参考情報リンク
                        unitLinkButton(title: "共通ベルについて", exview: AnyView(unitExView5body2image(title: "共通ベル", textBody1: "・中段または下段に平行に揃うベル（画像参照）に設定差あり", textBody2: "・基本的に状態不問でカウント可能", textBody3: "・ベルは赤・青のどちらでもOK", image1: Image("kabaneriBellRatio"), image2: Image("kabaneriBell"))))
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(Ci95view: AnyView(kabaneriView95Ci(kabaneri: kabaneri, selection: 2)))
                            .popoverTip(tipUnitButtonLink95Ci())
                    } header: {
                        Text("共通ベル")
                    }
                    unitClearScrollSection(spaceHeight: 120)
//                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
//                        unitClearScrollSection(spaceHeight: 120)
//                    } else {
//                        
//                    }
                }
                
                // //// 横画面
                else {
                    Section {
                        // //// カウントボタン
                        HStack {
                            // 発光なしカウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "発光なし", count: $kabaneri.chanceWithoutFlushCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 発光ありカウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "発光あり", count: $kabaneri.chanceWithFlushCount, color: .personalSummerLightRed, minusBool: $kabaneri.minusCheck)
                            // 共通ベルカウントボタン
                            unitCountButtonVerticalWithoutRatio(title: "共通ベル", count: $kabaneri.bellCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck, flushColor: Color.yellow)
                        }
                        // //// 結果表示
                        HStack {
                            // 発光率
                            unitResultRatioPercent2Line(title: "発光率", color: .grayBack, count: $kabaneri.chanceWithFlushCount, bigNumber: $kabaneri.chanceCountSum, numberofDicimal: 0)
//                                .padding(.vertical)
                            // 確率
                            unitResultRatioDenomination2Line(title: "共通ベル出現率", color: .grayBack, count: $kabaneri.bellCount, bigNumber: $kabaneri.playGame, numberofDicimal: 1)
//                                .padding(.vertical)
                        }
                        // //// 参考情報リンク
                        // 参考情報リンク
                        unitLinkButton(title: "発光率について", exview: AnyView(unitExView5body2image(title: "1個チャンス目の発光率", textBody1: "・好機、発光していないチャンス目が単独で出現した時がカウント対象", textBody2: "・発光率に設定差あり。通常時の判別要素のメインになり得る", image1: Image("kabaneriChance"))))
                        // 参考情報リンク
                        unitLinkButton(title: "共通ベルについて", exview: AnyView(unitExView5body2image(title: "共通ベル", textBody1: "・中段または下段に平行に揃うベル（画像参照）に設定差あり", textBody2: "・基本的に状態不問でカウント可能。通常時だけでなくST中、ボーナス中もカウントしマイスロのゲーム数から算出", textBody3: "・ベルは赤・青のどちらでもOK", image1: Image("kabaneriBellRatio"), image2: Image("kabaneriBell"))))
                        // 打ち始めゲーム数
                        unitTextFieldGamesInput(title: "打ち始め", inputValue: $kabaneri.startGame)
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
                        // 現在ゲーム数
                        unitTextFieldGamesInput(title: "現在", inputValue: $kabaneri.currentGame)
                            .focused($isFocused)
                        // プレイゲーム数
                        HStack {
                            Text("消化ゲーム数")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(kabaneri.playGame)")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } header: {
                        Text("1個チャンス目の発光率, 共通ベル")
                    }
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "甲鉄城のカバネリ",
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
            .navigationTitle("通常時小役")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetChance)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("通常時小役")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetChance)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    kabaneriViewChance(kabaneri: Kabaneri())
}
