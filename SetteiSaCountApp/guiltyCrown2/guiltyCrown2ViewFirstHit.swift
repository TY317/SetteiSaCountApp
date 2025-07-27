//
//  guiltyCrown2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2ViewFirstHit: View {
//    @ObservedObject var ver350: Ver350
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 2
    let lazyVGridCountLandscape: Int = 4
    @State var lazyVGridCount: Int = 2
    
    var body: some View {
        List {
            Section {
                Text("現在値はユニメモを確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                guiltyCrown2TableFirstHit(
                                    guiltyCrown2: guiltyCrown2
                                )
                            )
                        )
                    )
                )
//                // 参考情報）スイカ契機のボーナス
//                unitLinkButton(
//                    title: "🍉契機のボーナス当選について",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "🍉契機のボーナス当選",
//                            textBody1: "・🍉契機の同時当選に設定差あり",
//                            textBody2: "・特に弱🍉契機の赤異色の設定差が大きいらしい",
//                        )
//                    )
//                )
                // 参考情報）水着のボーナス確定画面
                unitLinkButton(
                    title: "水着のボーナス確定画面について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "水着のボーナス確定画面",
                            textBody1: "・設定2,3否定かつ高設定示唆となる"
                        )
                    )
                )
//                .popoverTip(tipVer350GuiltyCrownBonusScreen())
            }
            
            Section {
                // //// ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $guiltyCrown2.normalGame,
                    unitText: "Ｇ"
                )
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
                
                // //// カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount,
                )
                LazyVGrid(columns: gridItem) {
                    // 弱🍉+赤異色
                    unitCountButtonDenominateWithFunc(
                        title: "弱🍉+赤異色",
                        count: $guiltyCrown2.bonusDetailCountJakuRedIshoku,
                        color: .personalSummerLightRed,
                        bigNumber: $guiltyCrown2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $guiltyCrown2.minusCheck,
                        action: guiltyCrown2.bonusDetailCountSumFunc
                    )
                    .padding(.bottom)
                    // 強🍉+赤7
                    unitCountButtonDenominateWithFunc(
                        title: "強🍉+赤7",
                        count: $guiltyCrown2.bonusDetailCountKyoRed,
                        color: .red,
                        bigNumber: $guiltyCrown2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $guiltyCrown2.minusCheck,
                        action: guiltyCrown2.bonusDetailCountSumFunc
                    )
                    .padding(.bottom)
                    // 強🍉+白7
                    unitCountButtonDenominateWithFunc(
                        title: "強🍉+白7",
                        count: $guiltyCrown2.bonusDetailCountKyoWhite,
                        color: .purple,
                        bigNumber: $guiltyCrown2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $guiltyCrown2.minusCheck,
                        action: guiltyCrown2.bonusDetailCountSumFunc
                    )
                    .padding(.bottom)
                    // 強🍉+白異色
                    unitCountButtonDenominateWithFunc(
                        title: "強🍉+白異色",
                        count: $guiltyCrown2.bonusDetailCountKyoWhiteIshoku,
                        color: .personalSummerLightPurple,
                        bigNumber: $guiltyCrown2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $guiltyCrown2.minusCheck,
                        action: guiltyCrown2.bonusDetailCountSumFunc
                    )
                    .padding(.bottom)
                }
                
                // //// 合算確率
                unitResultRatioDenomination2Line(
                    title: "合算",
                    count: $guiltyCrown2.bonusDetailCountSum,
                    bigNumber: $guiltyCrown2.normalGame,
                    numberofDicimal: 0
                )
                
                // //// 参考情報）設定差のあるボーナス確率
                unitLinkButton(
                    title: "🍉契機 設定差のあるボーナス確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "🍉契機 設定差のあるボーナス確率",
                            tableView: AnyView(
                                guiltyCrown2TableBonusDetail(guiltyCrown2: guiltyCrown2)
                            )
                        )
                    )
                )
                
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        guiltyCrown2View95Ci(
                            guiltyCrown2: guiltyCrown2,
                            selection: 3,
                        )
                    )
                )
            } header: {
                Text("スイカ契機 設定差のあるボーナス")
//                    .popoverTip(tipVer350GuiltyCrownSuikaBonusDetail())
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver350.guiltyCrown2MenuFirstHitBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $guiltyCrown2.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: guiltyCrown2.resetFirstHit)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    guiltyCrown2ViewFirstHit(
//        ver350: Ver350(),
        guiltyCrown2: GuiltyCrown2(),
    )
}
