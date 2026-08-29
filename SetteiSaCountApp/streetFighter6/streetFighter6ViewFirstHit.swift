//
//  streetFighter6ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var streetFighter6: StreetFighter6
    @State var isShowDestination: Bool = false
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
    
    let itemList: [String] = ["1回目", "2回目","3回目","4回目",]
    @State var selectedItem: String = "1回目"
    
    var body: some View {
        List {
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $streetFighter6.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // FB
                unitCountButtonVerticalDenominate(
                    title: "FB",
                    count: $streetFighter6.firstHitCountFb,
                    color: .personalSummerLightBlue,
                    bigNumber: $streetFighter6.normalGame,
                    numberofDicimal: 0,
                    minusBool: $streetFighter6.minusCheck
                )
                // ボーナス
                unitCountButtonVerticalDenominate(
                    title: "ボーナス",
                    count: $streetFighter6.firstHitCountBonus,
                    color: .personalSummerLightRed,
                    bigNumber: $streetFighter6.normalGame,
                    numberofDicimal: 0,
                    minusBool: $streetFighter6.minusCheck
                )
            }

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "FB",
                        denominateList: streetFighter6.ratioFirstHitFb
                    )
                    unitTableDenominate(
                        columTitle: "ボーナス",
                        denominateList: streetFighter6.ratioFirstHitBonus
                    )
                }
            }

            // //// 95%%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    streetFighter6View95Ci(
                        streetFighter6: streetFighter6,
                        selection: 2,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                streetFighter6ViewBayes(
                    streetFighter6: streetFighter6,
                )
            }
            
            // ---- FBスルー天井
            Section {
                // 確率結果
                HStack {
                    // 1回以
                    unitResultRatioPercent2Line(
                        title: "1回",
                        count: $streetFighter6.fbTenjoCount1Hit,
                        bigNumber: $streetFighter6.fbTenjoCount1Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 2回以
                    unitResultRatioPercent2Line(
                        title: "2回",
                        count: $streetFighter6.fbTenjoCount2Hit,
                        bigNumber: $streetFighter6.fbTenjoCount2Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 3回以
                    unitResultRatioPercent2Line(
                        title: "3回",
                        count: $streetFighter6.fbTenjoCount3Hit,
                        bigNumber: $streetFighter6.fbTenjoCount3Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 4回以
                    unitResultRatioPercent2Line(
                        title: "4回",
                        count: $streetFighter6.fbTenjoCount4Hit,
                        bigNumber: $streetFighter6.fbTenjoCount4Sum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報 FBスルー天井振分け
                unitLinkButtonViewBuilder(sheetTitle: "FBスルー天井振分け") {
                    streetFighter6TableFbTenjo(streetFighter6: streetFighter6)
                }
                
                // 参考情報）
                unitLinkButtonViewBuilder(sheetTitle: "通常時スマホ演出での示唆") {
                    streetFighter6TableSmartPhone()
                }
                .popoverTip(tipVer450StreetFighter6SmartPhone())
                
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・FB天井到達時はFB突入時に全て一撃アイコンの勝利濃厚状態でスタートとなるため、それで天井ありなしを判断")
                    }
                    VStack {
                        // セグメントピッカー
                        Picker("", selection: self.$selectedItem) {
                            ForEach(self.itemList, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        if self.selectedItem == self.itemList[0] {
                            Text("0スルー状態 1回目のFB")
                        } else if self.selectedItem == self.itemList[1] {
                            Text("1スルー状態 2回目のFB")
                        } else if self.selectedItem == self.itemList[2] {
                            Text("2スルー状態 3回目のFB")
                        } else {
                            Text("3スルー状態 4回目のFB")
                        }
                    }
                    
                    // カウントボタン横並び
                    // 1回目
                    if self.selectedItem == self.itemList[0] {
                        HStack {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $streetFighter6.fbTenjoCount1Miss,
                                color: .personalSummerLightBlue,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $streetFighter6.fbTenjoCount1Hit,
                                color: .personalSpringLightYellow,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                        }
                    }
                    // 2回目
                    else if self.selectedItem == self.itemList[1] {
                        HStack {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $streetFighter6.fbTenjoCount2Miss,
                                color: .personalSummerLightGreen,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $streetFighter6.fbTenjoCount2Hit,
                                color: .personalSummerLightRed,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                        }
                    }
                    // 3回目
                    else if self.selectedItem == self.itemList[2] {
                        HStack {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $streetFighter6.fbTenjoCount3Miss,
                                color: .blue,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $streetFighter6.fbTenjoCount3Hit,
                                color: .yellow,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                        }
                    }
                    // 2回目
                    else{
                        HStack {
                            // 天井なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井なし",
                                count: $streetFighter6.fbTenjoCount4Miss,
                                color: .green,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                            // 天井あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "天井あり",
                                count: $streetFighter6.fbTenjoCount4Hit,
                                color: .red,
                                minusBool: $streetFighter6.minusCheck) {
                                    streetFighter6.fbTenjoSumFunc()
                                }
                        }
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("FBスルー天井振分け")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.streetFighter6MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $streetFighter6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: streetFighter6.resetFirstHit)
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
    streetFighter6ViewFirstHit(
        streetFighter6: StreetFighter6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
