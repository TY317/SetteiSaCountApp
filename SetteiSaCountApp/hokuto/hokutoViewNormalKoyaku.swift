//
//  hokutoViewNormalKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/01.
//

import SwiftUI

struct hokutoViewNormalKoyaku: View {
    @ObservedObject var ver380: Ver380
    @ObservedObject var hokuto: Hokuto
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            // //// ベル
            Section {
                // //// 縦画面
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    // //// カウント
                    HStack {
                        // 斜めベル
                        unitCountButtonVerticalWithoutRatio(title: "斜めベル", count: $hokuto.normalBellNanameCount, color: .personalSpringLightYellow, minusBool: $hokuto.minusCheck)
                        // 中段平行
                        unitCountButtonVerticalWithoutRatio(title: "中段平行ベル", count: $hokuto.normalBellHorizontalCount, color: .yellow, minusBool: $hokuto.minusCheck)
                    }
                    // //// 結果表示
                    HStack {
                        // 比率
                        unitResultRatioRatioRightOneLine(title: "斜め：平行", color: .grayBack, count1: $hokuto.normalBellNanameCount, count2: $hokuto.normalBellHorizontalCount, numberofDicimal: 1)
                        // 平行ベル出現率
                        unitResultRatioDenomination2Line(title: "平行出現率", color: .grayBack, count: $hokuto.normalBellHorizontalCount, bigNumber: $hokuto.normalPlayGame, numberofDicimal: 0)
                    }
                }
                // //// 横画面
                else {
                    // //// カウント＆確率表示
                    HStack {
                        // 斜めベル
                        unitCountButtonVerticalWithoutRatio(title: "斜めベル", count: $hokuto.normalBellNanameCount, color: .personalSpringLightYellow, minusBool: $hokuto.minusCheck)
                        // 中段平行
                        unitCountButtonVerticalWithoutRatio(title: "中段平行ベル", count: $hokuto.normalBellHorizontalCount, color: .yellow, minusBool: $hokuto.minusCheck)
                        // 比率
                        unitResultRatioRatioRightOneLine(title: "斜め：平行", color: .grayBack, count1: $hokuto.normalBellNanameCount, count2: $hokuto.normalBellHorizontalCount, numberofDicimal: 1)
                            .padding(.vertical)
                        // 平行ベル出現率
                        unitResultRatioDenomination2Line(title: "平行出現率", color: .grayBack, count: $hokuto.normalBellHorizontalCount, bigNumber: $hokuto.normalPlayGame, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                }
                // 参考情報へのリンク
                unitLinkButton(
                    title: "ナビなしベルについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のベル",
                            textBody1: "・押し順は中・右・左を遵守",
                            textBody2: "・中段に平行揃いするベルに設定差があると言われている",
                            textBody3: "・斜めベルとの比率も指標になるため、斜め揃いもカウントを推奨",
                            textBody4: "・通常時ゲーム数はマイスロを参照",
                            tableView: AnyView(hokutoTableNormalBell())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(hokutoView95Ci(hokuto: hokuto, selection: 1)))
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
            // //// モード示唆部分
            Section {
                unitLinkButton(title: "モード示唆演出", exview: AnyView(unitExView5body2image(title: "モード示唆演出", image1: Image("hokutoMode"))))
            } header: {
                Text("モード示唆演出")
            }
            // //// ゲーム数入力部分
            Section {
                // 打ち始め
                unitTextFieldGamesInput(title: "打ち始め", inputValue: $hokuto.normalStartGame)
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
                unitTextFieldGamesInput(title: "現在", inputValue: $hokuto.normalCurrentGame)
                    .focused($isFocused)
                // 消化ゲーム数
                HStack {
                    Text("消化ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(hokuto.normalPlayGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("通常時回転数入力")
            }
            // //// レア役の情報
            Section {
                Text("マイスロの数値を転記して下さい")
                    .foregroundStyle(Color.secondary)
                // 総ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "総ゲーム数",
                    inputValue: $hokuto.totalGame,
                    unitText: "Ｇ",
                )
                .focused($isFocused)
                .popoverTip(tipVer380hokutoNormal())
                // 弱スイカ
                unitTextFieldNumberInputWithUnit(
                    title: "弱🍉",
                    inputValue: $hokuto.rareCountSuikaJaku,
                )
                .onChange(of: hokuto.rareCountSuikaJaku, { oldValue, newValue in
                    hokuto.rareCountSuikaSum = hokuto.rareCountSuikaJaku + hokuto.rareCountSuikaKyo
                })
                .focused($isFocused)
                // 強スイカ
                unitTextFieldNumberInputWithUnit(
                    title: "強🍉",
                    inputValue: $hokuto.rareCountSuikaKyo,
                )
                .onChange(of: hokuto.rareCountSuikaKyo, { oldValue, newValue in
                    hokuto.rareCountSuikaSum = hokuto.rareCountSuikaJaku + hokuto.rareCountSuikaKyo
                })
                .focused($isFocused)
                // 中段チェリー
                unitTextFieldNumberInputWithUnit(
                    title: "中段🍒",
                    inputValue: $hokuto.rareCount2Cherry,
                )
                .focused($isFocused)
                // 確率結果
                HStack {
                    // スイカ合算
                    unitResultRatioDenomination2Line(
                        title: "🍉合算",
                        count: $hokuto.rareCountSuikaSum,
                        bigNumber: $hokuto.totalGame,
                        numberofDicimal: 0
                    )
                    // スイカ合算
                    unitResultRatioDenomination2Line(
                        title: "中段🍒",
                        count: $hokuto.rareCount2Cherry,
                        bigNumber: $hokuto.totalGame,
                        numberofDicimal: 0
                    )
                }
                unitLinkButton(
                    title: "レア役について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のレア役確率",
                            tableView: AnyView(hokutoTableRareKoyakuRatio())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(hokutoView95Ci(hokuto: hokuto, selection: 7)))
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
                Text("レア役")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver380.hokutoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スマスロ北斗の拳",
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
//        // //// 画面の向き情報の取得部分
//        .onAppear {
//            // ビューが表示されるときにデバイスの向きを取得
//            self.orientation = UIDevice.current.orientation
//            // 向きがフラットでなければlastOrientationの値を更新
//            if self.orientation.isFlat {
//                
//            }
//            else {
//                self.lastOrientation = self.orientation
//            }
//            // デバイスの向きの変更を監視する
//            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
//                self.orientation = UIDevice.current.orientation
//                // 向きがフラットでなければlastOrientationの値を更新
//                if self.orientation.isFlat {
//                    
//                }
//                else {
//                    self.lastOrientation = self.orientation
//                }
//            }
//        }
//        .onDisappear {
//            // ビューが非表示になるときに監視を解除
//            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
//        }
        .navigationTitle("通常時子役")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $hokuto.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetNormalKoyaku)
                }
            }
        }
    }
}

#Preview {
    hokutoViewNormalKoyaku(
        ver380: Ver380(),
        hokuto: Hokuto(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
