//
//  azurLaneViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import SwiftUI

struct azurLaneViewNormal: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var azurLane: AzurLane
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
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowInputView: Bool = false
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // 注意書き
                VStack {
                    Text("・ぱちログでは小役確率は終了時QRでのみ確認可能なため、途中経過で確率チェックする場合は自力でのカウントを推奨")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・AT中もカウントして下さい")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                
                // カウントボタン横並び
                HStack {
                    // 共通ベル
                    unitCountButtonWithoutRatioWithFunc(
                        title: "共通🔔",
                        count: $azurLane.koyakuCountCommonBell,
                        color: .personalSpringLightYellow,
                        minusBool: $azurLane.minusCheck,
                        flushColor: .yellow,
                    ) {
                        azurLane.koyakuSumFunc()
                    }
                    .popoverTip(tipVer3110AzurLaneNormal())
                    // 弱🍒
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍒",
                        count: $azurLane.koyakuCountJakuCherry,
                        color: .personalSummerLightRed,
                        minusBool: $azurLane.minusCheck,
                    ) {
                        azurLane.koyakuSumFunc()
                    }
                    // 弱🍉
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍉",
                        count: $azurLane.koyakuCountJakuSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $azurLane.minusCheck,
                    ) {
                        azurLane.koyakuSumFunc()
                    }
                }
                
                // 確率結果横並び
                VStack {
                    HStack {
                        // 共通🔔
                        unitResultRatioDenomination2Line(
                            title: "共通🔔",
                            count: $azurLane.koyakuCountCommonBell,
                            bigNumber: $azurLane.gameNumberPlay,
                            numberofDicimal: 1,
                            spacerBool: false,
                        )
                        // 弱🍒
                        unitResultRatioDenomination2Line(
                            title: "弱🍒",
                            count: $azurLane.koyakuCountJakuCherry,
                            bigNumber: $azurLane.gameNumberPlay,
                            numberofDicimal: 1,
                            spacerBool: false,
                        )
                        // 弱🍉
                        unitResultRatioDenomination2Line(
                            title: "弱🍉",
                            count: $azurLane.koyakuCountJakuSuika,
                            bigNumber: $azurLane.gameNumberPlay,
                            numberofDicimal: 1,
                            spacerBool: false,
                        )
//                        // 合算
//                        unitResultRatioDenomination2Line(
//                            title: "合算",
//                            count: $azurLane.koyakuCountSum,
//                            bigNumber: $azurLane.gameNumberPlay,
//                            numberofDicimal: 1,
//                            spacerBool: false,
//                        )
                    }
                    // 合算
                    unitResultRatioDenomination2Line(
                        title: "合算",
                        count: $azurLane.koyakuCountSum,
                        bigNumber: $azurLane.gameNumberPlay,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                
                // 小役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形", linkText: "レア役停止形") {
                    azurLaneTableKoyakuPattern()
                }
                // 弱レア役確率
                unitLinkButtonViewBuilder(sheetTitle: "設定差のある小役確率") {
                    VStack {
                        Text("・共通ベル、弱レア役の確率に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "共通🔔",
                                denominateList: azurLane.ratioCommonBell
                            )
                            unitTableDenominate(
                                columTitle: "弱🍒",
                                denominateList: azurLane.ratioJakuCherry,
                                numberofDicimal: 1,
                            )
                            unitTableDenominate(
                                columTitle: "弱🍉",
                                denominateList: azurLane.ratioJakuSuika,
                                numberofDicimal: 1,
                            )
                            unitTableDenominate(
                                columTitle: "合算",
                                denominateList: azurLane.ratioJakuRareSum,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        azurLaneView95Ci(
                            azurLane: azurLane,
                            selection: 10,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    azurLaneViewBayes(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
                
            } header: {
                Text("レア役")
            }
            
            // //// ゲーム数入力
            Section {
                // 注意書き
                VStack {
                    Text("・ぱちログで確認して入力して下さい")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・AT中もカウントする場合は総遊技数の数値を入力して下さい")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $azurLane.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: azurLane.gameNumberStart) {
                    let playGame = azurLane.gameNumberCurrent - azurLane.gameNumberStart
                    azurLane.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $azurLane.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: azurLane.gameNumberCurrent) {
                    let playGame = azurLane.gameNumberCurrent - azurLane.gameNumberStart
                    azurLane.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: azurLane.gameNumberPlay
                )
                
            } header: {
                HStack {
                    Text("ゲーム数入力")
//                    unitToolbarButtonQuestion {
//                        unitExView5body2image(
//                            title: "ゲーム数入力",
//                            textBody1: "・AT中もカウントする場合は総遊技数の数値を入力して下さい",
//                        )
//                    }
                }
            }
            
            // //// モード
            Section {
                // 通常時モード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    azurLaneTableMode()
                }
                // 参考情報）高確示唆演出
                unitLinkButtonViewBuilder(sheetTitle: "高確示唆演出") {
                    azurLaneTableModeSisa()
                }
                // ボーナス当選率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス当選率") {
                    azurLaneTableKoyakuHitRatio(azurLane: azurLane)
                }
                // 裏モード
                unitLinkButtonViewBuilder(sheetTitle: "裏モード") {
                    VStack {
                        Text("・滞在中に当選したボーナスが全てAT直撃に書き換えられるモード")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・ボーナス非当選の強弱🍉で移行抽選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・継続G数は100G")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・裏モード滞在は主に絆ゾーン滞在で示唆")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        Text("[裏モード移行率]")
                            .font(.title2)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "弱🍉",
                                percentList: [0.8,0.8,0.8,0.9,0.9,1.0],
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "強🍉",
                                percentList: [100],
                                lineList: [6],
                                colorList: [.white],
                            )
                        }
                    }
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.azurLaneMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: azurLane.resetNormal)
                }
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
    azurLaneViewNormal(
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
