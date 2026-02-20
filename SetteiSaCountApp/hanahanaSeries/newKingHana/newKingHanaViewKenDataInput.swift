//
//  newKingHanaViewKenDataInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/20.
//

import SwiftUI

struct newKingHanaViewKenDataInput: View {
    @ObservedObject var newKingHana: NewKingHana
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldGamesInput(
                    title: "ゲーム数",
                    inputValue: $newKingHana.kenGameIput
                )
                    .focused($isFocused)
                    .onChange(of: newKingHana.kenGameIput) { oldValue, newValue in
                        newKingHana.kenBellBackCalculationCount = newKingHana.bellBackCalculate(
                            game: newKingHana.kenGameIput,
                            bigCount: newKingHana.kenBigCountInput,
                            regCount: newKingHana.kenRegCountInput,
                            coinDifference: newKingHana.kenCoinDifferenceInput
                        )
                    }
                // ビッグ回数
                unitTextFieldGamesInput(title: "BIG回数", inputValue: $newKingHana.kenBigCountInput)
                    .focused($isFocused)
                    .onChange(of: newKingHana.kenBigCountInput) { oldValue, newValue in
                        newKingHana.kenBellBackCalculationCount = newKingHana.bellBackCalculate(
                            game: newKingHana.kenGameIput,
                            bigCount: newKingHana.kenBigCountInput,
                            regCount: newKingHana.kenRegCountInput,
                            coinDifference: newKingHana.kenCoinDifferenceInput
                        )
                    }
                // レギュラー回数
                unitTextFieldGamesInput(title: "REG回数", inputValue: $newKingHana.kenRegCountInput)
                    .focused($isFocused)
                    .onChange(of: newKingHana.kenRegCountInput) { oldValue, newValue in
                        newKingHana.kenBellBackCalculationCount = newKingHana.bellBackCalculate(
                            game: newKingHana.kenGameIput,
                            bigCount: newKingHana.kenBigCountInput,
                            regCount: newKingHana.kenRegCountInput,
                            coinDifference: newKingHana.kenCoinDifferenceInput
                        )
                    }
                
                // ぶどう逆算トグルスイッチ
                Toggle("ベル逆算有効化", isOn: $newKingHana.kenBackCalculationEnable)
                // //// 差枚数とぶどう逆算値
                if newKingHana.kenBackCalculationEnable {
                    // 差枚数
                    unitTextFieldGamesInput(
                        title: "差枚数",
                        inputValue: $newKingHana.kenCoinDifferenceInput,
                        numberPadTypeSelect: false
                    )
                    .focused($isFocused)
                    .onChange(of: newKingHana.kenCoinDifferenceInput) { oldValue, newValue in
                        newKingHana.kenBellBackCalculationCount = newKingHana.bellBackCalculate(
                            game: newKingHana.kenGameIput,
                            bigCount: newKingHana.kenBigCountInput,
                            regCount: newKingHana.kenRegCountInput,
                            coinDifference: newKingHana.kenCoinDifferenceInput
                        )
                    }
                    
                    // 逆算結果
                    VStack {
                        Text("[逆算結果]")
                        HStack {
                            // ベル回数
                            unitResultCount2Line(
                                title: "ベル回数",
                                count: $newKingHana.kenBellBackCalculationCount
                            )
                            // ベル確率
                            unitResultRatioDenomination2Line(
                                title: "ベル確率",
                                count: $newKingHana.kenBellBackCalculationCount,
                                bigNumber: $newKingHana.kenGameIput,
                                numberofDicimal: 2,
                            )
                        }
                    }
                }
                
                // ボーナス確率結果
                HStack {
                    // ビッグ確率
                    unitResultRatioDenomination2Line(
                        title: "BIG確率",
                        count: $newKingHana.kenBigCountInput,
                        bigNumber: $newKingHana.kenGameIput,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG確率
                    unitResultRatioDenomination2Line(
                        title: "REG確率",
                        count: $newKingHana.kenRegCountInput,
                        bigNumber: $newKingHana.kenGameIput,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $newKingHana.kenBonusCountSum,
                        bigNumber: $newKingHana.kenGameIput,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                
                // 参考情報）ベル、ボーナス確率
                unitLinkButtonViewBuilder(sheetTitle: "🔔,ボーナス確率") {
                    newKingHanaTableBellBonus(newKingHana: newKingHana)
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        newKingHanaView95CiKen(
                            newKingHana: newKingHana,
                            selection: 1,
                        )
                    )
                )
                unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
            } header: {
                Text("データ入力")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("[見] データ確認")
        .navigationBarTitleDisplayMode(.inline)
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $newKingHana.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newKingHana.resetKenDataInput)
            }
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
    }
}

#Preview {
    newKingHanaViewKenDataInput(
        newKingHana: NewKingHana(),
    )
    .environmentObject(commonVar())
}
