//
//  happyJugV3Ver2ViewJissenStartData.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct happyJugV3Ver2ViewJissenStartData: View {
//    @ObservedObject var happyJugV3 = HappyJugV3()
    @ObservedObject var happyJugV3: HappyJugV3
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $happyJugV3.startGameInput)
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
                // ビッグ回数
                unitTextFieldGamesInput(title: "BIG回数", inputValue: $happyJugV3.startBigCountInput)
                    .focused($isFocused)
                // レギュラー回数
                unitTextFieldGamesInput(title: "REG回数", inputValue: $happyJugV3.startRegCountInput)
                    .focused($isFocused)
                // ぶどう逆算トグルスイッチ
                Toggle("ぶどう逆算有効化", isOn: $happyJugV3.startBackCalculationEnable)
                // //// 差枚数とぶどう逆算値
                if happyJugV3.startBackCalculationEnable {
                    // 差枚数
                    unitTextFieldGamesInput(
                        title: "差枚数",
                        inputValue: $happyJugV3.startCoinDifferenceInput,
                        numberPadTypeSelect: false
                    )
                    .focused($isFocused)
                    // ぶどう回数
                    HStack {
                        Text("ぶどう逆算値")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(happyJugV3.startBellBackCalculationCount)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(Color.secondary)
                    }
                    
                    // //// 確率算出結果
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        HStack {
                            // ぶどう確率
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $happyJugV3.startBellBackCalculationCount,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            // ビッグ確率
                            unitResultRatioDenomination2Line(
                                title: "BIG確率",
                                count: $happyJugV3.startBigCountInput,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $happyJugV3.startRegCountInput,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $happyJugV3.startBonusCountSum,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                        }
                    }
                    // //// 縦画面
                    else {
                        // ぶどう確率
                        HStack {
                            unitResultRatioDenomination2Line(
                                title: "ぶどう確率",
                                count: $happyJugV3.startBellBackCalculationCount,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.clear)
                        }
                        HStack {
                            // ビッグ確率
                            unitResultRatioDenomination2Line(
                                title: "BIG確率",
                                count: $happyJugV3.startBigCountInput,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $happyJugV3.startRegCountInput,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $happyJugV3.startBonusCountSum,
                                bigNumber: $happyJugV3.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                        }
                    }
                } else {
                    // //// 確率算出結果
                    HStack {
                        // ビッグ確率
                        unitResultRatioDenomination2Line(
                            title: "BIG確率",
                            count: $happyJugV3.startBigCountInput,
                            bigNumber: $happyJugV3.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            count: $happyJugV3.startRegCountInput,
                            bigNumber: $happyJugV3.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $happyJugV3.startBonusCountSum,
                            bigNumber: $happyJugV3.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ハッピージャグラーV3設定差",
                            image1: Image("happyJugV3Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(happyJugV3Ver2View95CiStart(happyJugV3: happyJugV3)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("データ入力")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
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
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
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
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("打ち始めデータ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: happyJugV3.resetStartData)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    happyJugV3Ver2ViewJissenStartData(happyJugV3: HappyJugV3())
}
