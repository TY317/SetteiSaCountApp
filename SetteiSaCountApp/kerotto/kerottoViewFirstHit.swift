//
//  kerottoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kerotto: Kerotto
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
    let lazyVGridCountLandscape: Int = 6
    @State var lazyVGridCount: Int = 3
    var body: some View {
        List {
            Section {
                // 初当り確率横並び
                HStack {
                    // SBB
                    unitResultRatioDenomination2Line(
                        title: "SBB",
                        count: $kerotto.firstHitCountSBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // BB
                    unitResultRatioDenomination2Line(
                        title: "BB",
                        count: $kerotto.firstHitCountBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // REG
                    unitResultRatioDenomination2Line(
                        title: "REG",
                        count: $kerotto.firstHitCountREGSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 赤白比率横並び
                HStack {
                    // 赤頭
                    unitResultRatioPercent2Line(
                        title: "赤頭",
                        count: $kerotto.firstHitCountRSum,
                        bigNumber: $kerotto.firstHitCountAllSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 赤頭
                    unitResultRatioPercent2Line(
                        title: "白頭",
                        count: $kerotto.firstHitCountWSum,
                        bigNumber: $kerotto.firstHitCountAllSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率＆赤白比率") {
                    kerottoTableFirstHit(kerotto: kerotto)
                }
                
                DisclosureGroup {
                    // //// カウントボタン横並び
                    let gridItem = Array(
                        repeating: GridItem(
                            .flexible(minimum: 80, maximum: 150),
                            spacing: 5,
                            alignment: .center,
                        ),
                        count: self.lazyVGridCount
                    )
                    LazyVGrid(columns: gridItem) {
                        // 白頭SBB
                        unitCountButtonDenominateWithFunc(
                            title: "白頭SBB",
                            count: $kerotto.firstHitCountWSBB,
                            color: .personalSummerLightBlue,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                        // 白頭BB
                        unitCountButtonDenominateWithFunc(
                            title: "白頭BB",
                            count: $kerotto.firstHitCountWBB,
                            color: .personalSummerLightGreen,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                        // 白頭RB
                        unitCountButtonDenominateWithFunc(
                            title: "白頭RB",
                            count: $kerotto.firstHitCountWREG,
                            color: .personalSummerLightPurple,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                        // 赤頭SBB
                        unitCountButtonDenominateWithFunc(
                            title: "赤頭SBB",
                            count: $kerotto.firstHitCountRSBB,
                            color: .blue,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                        // 赤頭BB
                        unitCountButtonDenominateWithFunc(
                            title: "赤頭BB",
                            count: $kerotto.firstHitCountRBB,
                            color: .green,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                        // 赤頭RB
                        unitCountButtonDenominateWithFunc(
                            title: "赤頭RB",
                            count: $kerotto.firstHitCountRREG,
                            color: .purple,
                            bigNumber: $kerotto.gameNumberPlay,
                            numberofDicimal: 0,
                            minusBool: $kerotto.minusCheck,
                            action: kerotto.firstHitSumFunc
                        )
                        .padding(.bottom)
                    }
                    
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kerottoView95Ci(
                                kerotto: kerotto,
                                selection: 1
                            )
                        )
                    )
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kerottoViewBayes(
                            kerotto: kerotto,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("初当り")
            }
            
            // //// ゲーム数入力
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $kerotto.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: kerotto.gameNumberStart) {
                    let playGame = kerotto.gameNumberCurrent - kerotto.gameNumberStart
                    kerotto.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $kerotto.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: kerotto.gameNumberCurrent) {
                    let playGame = kerotto.gameNumberCurrent - kerotto.gameNumberStart
                    kerotto.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: kerotto.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kerottoMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
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
                unitButtonMinusCheck(minusCheck: $kerotto.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kerotto.resetFirstHit)
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
    kerottoViewFirstHit(
        kerotto: Kerotto(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
