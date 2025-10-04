//
//  urmiraVer2ViewJissenStartData.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraVer2ViewJissenStartData: View {
    @ObservedObject var urmira: Urmira
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $urmira.startGameInput)
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
                unitTextFieldGamesInput(title: "BIG回数", inputValue: $urmira.startBigCountInput)
                    .focused($isFocused)
                // レギュラー回数
                unitTextFieldGamesInput(title: "REG回数", inputValue: $urmira.startRegCountInput)
                    .focused($isFocused)
                // ぶどう逆算トグルスイッチ
                Toggle("ぶどう逆算有効化", isOn: $urmira.startBackCalculationEnable)
                // //// 差枚数とぶどう逆算値
                if urmira.startBackCalculationEnable {
                    // 差枚数
                    unitTextFieldGamesInput(
                        title: "差枚数",
                        inputValue: $urmira.startCoinDifferenceInput,
                        numberPadTypeSelect: false
                    )
                    .focused($isFocused)
                    // ぶどう回数
                    HStack {
                        Text("ぶどう逆算値")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(urmira.startBellBackCalculationCount)")
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
                                count: $urmira.startBellBackCalculationCount,
                                bigNumber: $urmira.startGameInput,
                                numberofDicimal: 2,
                                spacerBool: false
                            )
                            // ビッグ確率
                            unitResultRatioDenomination2Line(
                                title: "BIG確率",
                                count: $urmira.startBigCountInput,
                                bigNumber: $urmira.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $urmira.startRegCountInput,
                                bigNumber: $urmira.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $urmira.startBonusCountSum,
                                bigNumber: $urmira.startGameInput,
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
                                count: $urmira.startBellBackCalculationCount,
                                bigNumber: $urmira.startGameInput,
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
                                count: $urmira.startBigCountInput,
                                bigNumber: $urmira.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // REG確率
                            unitResultRatioDenomination2Line(
                                title: "REG確率",
                                count: $urmira.startRegCountInput,
                                bigNumber: $urmira.startGameInput,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // ボーナス合算
                            unitResultRatioDenomination2Line(
                                title: "ボーナス合算",
                                count: $urmira.startBonusCountSum,
                                bigNumber: $urmira.startGameInput,
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
                            count: $urmira.startBigCountInput,
                            bigNumber: $urmira.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // REG確率
                        unitResultRatioDenomination2Line(
                            title: "REG確率",
                            count: $urmira.startRegCountInput,
                            bigNumber: $urmira.startGameInput,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $urmira.startBonusCountSum,
                            bigNumber: $urmira.startGameInput,
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
                            title: "\(urmira.machineName)設定差",
                            tableView: AnyView(urmiraTableRatio(urmira: urmira))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(urmiraView95CiStart(urmira: urmira)))
            } header: {
                Text("データ入力")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
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
        .navigationTitle("打ち始めデータ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: urmira.resetStartData)
                }
            }
        }
    }
}

#Preview {
    urmiraVer2ViewJissenStartData(
        urmira: Urmira()
    )
}
