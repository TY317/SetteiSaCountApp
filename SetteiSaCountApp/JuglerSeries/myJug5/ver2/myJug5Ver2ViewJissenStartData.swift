//
//  myJug5Ver2ViewJissenStartData.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/18.
//

import SwiftUI

struct myJug5Ver2ViewJissenStartData: View {
//    @ObservedObject var myJug5 = MyJug5()
    @ObservedObject var myJug5: MyJug5
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
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $myJug5.startGameInput)
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
                unitTextFieldGamesInput(title: "BIG回数", inputValue: $myJug5.startBigCountInput)
                    .focused($isFocused)
                // レギュラー回数
                unitTextFieldGamesInput(title: "REG回数", inputValue: $myJug5.startRegCountInput)
                    .focused($isFocused)
                // ぶどう逆算トグルスイッチ
                Toggle("ぶどう逆算有効化", isOn: $myJug5.startBackCalculationEnable)
                // //// 差枚数とぶどう逆算値
                if myJug5.startBackCalculationEnable {
                    // 差枚数
                    unitTextFieldGamesInput(
                        title: "差枚数",
                        inputValue: $myJug5.startCoinDifferenceInput,
                        numberPadTypeSelect: false
                    )
                    .focused($isFocused)
                    // ぶどう回数
                    HStack {
                        Text("ぶどう逆算値")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(myJug5.startBellBackCalculationCount)")
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
                                count: $myJug5.startBellBackCalculationCount,
                                bigNumber: $myJug5.startGameInput,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            // ビッグ確率
                            unitResultRatioDenomination2Line(
                                title: "BIG確率",
                                count: $myJug5.startBigCountInput,
                                bigNumber: $myJug5.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $myJug5.startRegCountInput,
                                bigNumber: $myJug5.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $myJug5.startBonusCountSum,
                                bigNumber: $myJug5.startGameInput,
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
                                count: $myJug5.startBellBackCalculationCount,
                                bigNumber: $myJug5.startGameInput,
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
                                count: $myJug5.startBigCountInput,
                                bigNumber: $myJug5.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $myJug5.startRegCountInput,
                                bigNumber: $myJug5.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $myJug5.startBonusCountSum,
                                bigNumber: $myJug5.startGameInput,
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
                            count: $myJug5.startBigCountInput,
                            bigNumber: $myJug5.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            count: $myJug5.startRegCountInput,
                            bigNumber: $myJug5.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $myJug5.startBonusCountSum,
                            bigNumber: $myJug5.startGameInput,
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
                            title: "マイジャグラー5設定差",
                            tableView: AnyView(myJug5TableRatio(myJug5: myJug5))
//                            image1: Image("myJug5Analysis")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(myJug5Ver2View95CiStart(myJug5: myJug5)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("データ入力")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マイジャグラー5",
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
                    unitButtonReset(isShowAlert: $isShowAlert, action: myJug5.resetStartData)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    myJug5Ver2ViewJissenStartData(myJug5: MyJug5())
}
