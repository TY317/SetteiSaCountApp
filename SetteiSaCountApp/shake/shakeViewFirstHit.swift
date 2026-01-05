//
//  shakeViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewFirstHit: View {
    @ObservedObject var shake: Shake
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
//    @FocusState var isFocused: Bool
    @FocusState var focusedField: ShakeField?
    enum ShakeField: Hashable {
        case normalGame
        case gameStart
        case gameCurrent
        case count(Int)
    }
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
            // 初当り
            Section {
                // 総ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "累計ゲーム数",
                    inputValue: $shake.normalGame,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
//                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // BIG
                    unitCountButtonWithoutRatioWithFunc(
                        title: "BIG",
                        count: $shake.bonusCountBig,
                        color: .personalSummerLightRed,
                        minusBool: $shake.minusCheck) {
                            shake.bonusSumFunc()
                        }
                    // REG
                    unitCountButtonWithoutRatioWithFunc(
                        title: "REG",
                        count: $shake.bonusCountReg,
                        color: .personalSummerLightBlue,
                        minusBool: $shake.minusCheck) {
                            shake.bonusSumFunc()
                        }
                }
                
                // 確率結果
                HStack {
                    // BIG
                    unitResultRatioDenomination2Line(
                        title: "BIG",
                        count: $shake.bonusCountBig,
                        bigNumber: $shake.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // REG
                    unitResultRatioDenomination2Line(
                        title: "REG",
                        count: $shake.bonusCountReg,
                        bigNumber: $shake.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $shake.bonusCountSum,
                        bigNumber: $shake.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）ボーナス確率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: shake.ratioBonusBig
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: shake.ratioBonusReg
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス合算",
                            denominateList: shake.ratioBonusSum
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        shakeView95Ci(
                            shake: shake,
                            selection: 4,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    shakeViewBayes(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ボーナス確率")
            }
            
            // 特定契機のボーナス
            Section {
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $shake.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: shake.gameNumberStart) {
                    let playGame = shake.gameNumberCurrent - shake.gameNumberStart
                    shake.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $shake.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: shake.gameNumberCurrent) {
                    let playGame = shake.gameNumberCurrent - shake.gameNumberStart
                    shake.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: shake.gameNumberPlay
                )
                
                // カウントボタン横並び
                HStack(alignment: .bottom) {
                    // スイカ＋ナディアBIG
                    unitCountButtonDenominateWithFunc(
                        title: "🍉＋\nﾅﾃﾞｨｱBIG",
                        count: $shake.idenBonusCountSuika,
                        color: .personalSummerLightGreen,
                        bigNumber: $shake.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck) {
                            shake.idenBonusSumFunc()
                        }
                    // ベル＋ナディアBIG
                    unitCountButtonDenominateWithFunc(
                        title: "🔔＋\nREG",
                        count: $shake.idenBonusCountBell,
                        color: .personalSpringLightYellow,
                        bigNumber: $shake.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck,
                        flushColor: .yellow) {
                            shake.idenBonusSumFunc()
                        }
                    // 特殊役I＋ボーナス
                    unitCountButtonDenominateWithFunc(
                        title: "特殊役I＋\nボーナス",
                        count: $shake.idenBonusCountSpecialI,
                        color: .personalSummerLightPurple,
                        bigNumber: $shake.gameNumberPlay,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck) {
                            shake.idenBonusSumFunc()
                        }
                }
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "3役合算",
                    count: $shake.idenBonusCountSum,
                    bigNumber: $shake.gameNumberPlay,
                    numberofDicimal: 0
                )
                
                // 参考情報）ボーナス確率
                unitLinkButtonViewBuilder(sheetTitle: "特定契機のボーナス確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(
                            settingList: [1,2,5,6],
                            titleLine: 2,
                        )
                        unitTableDenominate(
                            columTitle: "🍉＋\nナディアBIG",
                            denominateList: shake.ratioIdenBonusSuika,
                            titleLine: 2,
                        )
                        unitTableDenominate(
                            columTitle: "🔔＋\nREG",
                            denominateList: shake.ratioIdenBonusBell,
                            titleLine: 2,
                        )
                        unitTableDenominate(
                            columTitle: "特殊役I＋\nボーナス",
                            denominateList: shake.ratioIdenBonusSpecialI,
                            titleLine: 2,
                        )
                        unitTableDenominate(
                            columTitle: "3役合算",
                            denominateList: shake.ratioIdenBonusSum,
                            titleLine: 2,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        shakeView95Ci(
                            shake: shake,
                            selection: 7,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    shakeViewBayes(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("特定契機のボーナス確率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
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
                unitButtonMinusCheck(minusCheck: $shake.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shake.resetFirstHit)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        focusedField = nil
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
//            ToolbarItem(placement: .keyboard) {
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        isFocused = false
//                    }, label: {
//                        Text("完了")
//                            .fontWeight(.bold)
//                    })
//                }
//            }
        }
    }
}

#Preview {
    shakeViewFirstHit(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
