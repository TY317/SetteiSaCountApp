//
//  goeva2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var goeva2: Goeva2
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
    var body: some View {
        List {
            // ---- 入力方式（セクションに入れず背景を透明にして上部に置く）
            Picker("", selection: $goeva2.firstHitInputMode) {
                ForEach(goeva2.firstHitInputModeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)

            // 履歴入力
            if goeva2.isHistoryInputMode {
                // ---- 履歴登録
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ゲーム数",
                        inputValue: $goeva2.inputGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)
                    // ボーナス種類
                    unitPickerMenuString(
                        title: "ボーナス種類",
                        selected: $goeva2.selectedBonusKind,
                        selectlist: goeva2.bonusKindList
                    )
                    // AT当否（AT直撃は当選1択なので表示のみ）
                    if goeva2.selectedBonusKind == goeva2.bonusKindList[2] {
                        HStack {
                            Text("AT当否")
                            Spacer()
                            Text(goeva2.atResultList[1])
                                .foregroundStyle(Color.secondary)
                        }
                    } else {
                        unitPickerMenuString(
                            title: "AT当否",
                            selected: $goeva2.selectedAtResult,
                            selectlist: goeva2.atResultList
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // マイナスチェック入っていれば1行削除
                        if goeva2.minusCheck {
                            goeva2.removeLastHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // 入っていなければデータ登録
                        else {
                            goeva2.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        unitButtonSubmitLabel(minusCheck: goeva2.minusCheck)
                    }
                } header: {
                    HStack {
                        Text("初当り登録")
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "初当り登録",
                                textBody1: "・ボーナス、AT直撃に当選するごとに登録してください",
    //                            textBody2: "・ゲーム数は前回の初当りから当選までのゲーム数を入力してください",
                                textBody3: "・登録結果からボーナス、ATの初当り確率と通常ゲーム数を自動で算出します",
                            )
                        }
                    }
                }

                // ---- 履歴表示
                Section {
                    ScrollView {
                        // //// 配列のデータ数が0以上なら履歴表示
                        let gameArray = decodeIntArray(from: goeva2.gameArrayData)
                        if gameArray.count > 0 {
                            let bonusKindArray = decodeStringArray(from: goeva2.bonusKindArrayData)
                            let atResultArray = decodeStringArray(from: goeva2.atResultArrayData)
                            let startFlagList = goeva2.atIntervalStartFlagList
                            ForEach(gameArray.indices, id: \.self) { index in
                                let viewIndex = gameArray.count - index - 1
                                HStack {
                                    // ゲーム数
                                    if gameArray.indices.contains(viewIndex) {
                                        Text("\(gameArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // ボーナス種類
                                    if bonusKindArray.indices.contains(viewIndex) {
                                        Text(goeva2.bonusKindShortName(bonusKindArray[viewIndex]))
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // AT当否
                                    if atResultArray.indices.contains(viewIndex) {
                                        Text(atResultArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                // AT区間の区切りは赤線
                                if startFlagList.indices.contains(viewIndex) && startFlagList[viewIndex] {
                                    Divider()
                                        .overlay(Color.red)
                                } else {
                                    Divider()
                                }
                            }
                        }
                        // //// 配列のデータ数が0なら履歴なしを表示
                        else {
                            unitLabelHistoryZero()
                        }
                    }
                    .frame(height: self.scrollViewHeight)
                } header: {
                    unitHeaderHistoryColumns(
                        column1Bool: false,
                        column2: "ゲーム数",
                        column3: "ボーナス種類",
                        column4: "AT当否"
                    )
                }

                // ---- 集計結果
                Section {
                    // 通常ゲーム数
                    HStack {
                        Text("通常ゲーム数")
                        Spacer()
                        Text("\(goeva2.playGameSum)    G")
                            .foregroundStyle(Color.secondary)
                    }

                    // 確率横並び
                    HStack {
                        // ボーナス
                        unitResultRatioDenomination2Line(
                            title: "ボーナス",
                            count: $goeva2.firstHitCountBonus,
                            bigNumber: $goeva2.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $goeva2.firstHitCountAt,
                            bigNumber: $goeva2.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "ボーナス",
                                denominateList: goeva2.ratioFirstHitBonus
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: goeva2.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            goeva2View95Ci(
                                goeva2: goeva2,
                                selection: 9,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        goeva2ViewBayes(
                            goeva2: goeva2,
                        )
                    }
                } header: {
                    Text("集計結果")
                }

                // ---- 月蝕変異の発生率
                Section {

                    // 月蝕変異の発生率
                    unitResultRatioDenomination2Line(
                        title: "月蝕変異",
                        count: $goeva2.gesshokuCount,
                        bigNumber: $goeva2.playGameSum,
                        numberofDicimal: 0
                    )

                    // 参考情報）月蝕変異の発生率
                    unitLinkButtonViewBuilder(sheetTitle: "月蝕変異の発生率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "月蝕変異",
                                denominateList: goeva2.ratioGesshoku
                            )
                        }
                    }
                    .popoverTip(tipVer4110Goeva2Gesshoku())

                    // カウント
                    DisclosureGroup {
                        // 通常ゲーム数（上の集計結果の値を表示のみ）
                        HStack {
                            Text("通常ゲーム数")
                            Spacer()
                            Text("\(goeva2.playGameSum)    G")
                                .foregroundStyle(Color.secondary)
                        }
                        // カウントボタン
                        HStack {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "月蝕変異",
                                count: $goeva2.gesshokuCount,
                                color: .personalSummerLightPurple,
                                minusBool: $goeva2.minusCheck) {
                                }
                        }

                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                goeva2View95Ci(
                                    goeva2: goeva2,
                                    selection: 11,
                                )
                            )
                        )

                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            goeva2ViewBayes(
                                goeva2: goeva2,
                            )
                        }
                    } label: {
                        Text("カウント")
                            .foregroundStyle(Color.blue)
                    }
                } header: {
                    Text("月蝕変異の発生率")
                }
            
            }
            // カウント入力
            else {
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "通常ゲーム数",
                        inputValue: $goeva2.manualNormalGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)

                    // カウントボタン横並び
                    HStack {
                        // エヴァンゲリオンボーナス
                        unitCountButtonVerticalDenominate(
                            title: "エヴァ",
                            count: $goeva2.manualFirstHitCountEva,
                            color: .personalSummerLightPurple,
                            bigNumber: $goeva2.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $goeva2.minusCheck
                        )
                        // ゴジラボーナス
                        unitCountButtonVerticalDenominate(
                            title: "ゴジラ",
                            count: $goeva2.manualFirstHitCountGodzilla,
                            color: .personalSummerLightGreen,
                            bigNumber: $goeva2.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $goeva2.minusCheck
                        )
                        // AT
                        unitCountButtonVerticalDenominate(
                            title: "AT",
                            count: $goeva2.manualFirstHitCountAt,
                            color: .personalSummerLightRed,
                            bigNumber: $goeva2.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $goeva2.minusCheck
                        )
                    }

                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $goeva2.manualFirstHitCountBonus,
                        bigNumber: $goeva2.manualNormalGame,
                        numberofDicimal: 0
                    )

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "ボーナス",
                                denominateList: goeva2.ratioFirstHitBonus
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: goeva2.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            goeva2View95Ci(
                                goeva2: goeva2,
                                selection: 9,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        goeva2ViewBayes(
                            goeva2: goeva2,
                        )
                    }
                } header: {
                    Text("カウント")
                }

                // ---- 月蝕変異の発生率
                Section {

                    // 月蝕変異の発生率
                    unitResultRatioDenomination2Line(
                        title: "月蝕変異",
                        count: $goeva2.manualGesshokuCount,
                        bigNumber: $goeva2.manualNormalGame,
                        numberofDicimal: 0
                    )

                    // 参考情報）月蝕変異の発生率
                    unitLinkButtonViewBuilder(sheetTitle: "月蝕変異の発生率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "月蝕変異",
                                denominateList: goeva2.ratioGesshoku
                            )
                        }
                    }
                    .popoverTip(tipVer4110Goeva2Gesshoku())

                    // カウント
                    DisclosureGroup {
                        // 通常ゲーム数（上のカウントの値を表示のみ）
                        HStack {
                            Text("通常ゲーム数")
                            Spacer()
                            Text("\(goeva2.manualNormalGame)    G")
                                .foregroundStyle(Color.secondary)
                        }
                        // カウントボタン
                        HStack {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "月蝕変異",
                                count: $goeva2.manualGesshokuCount,
                                color: .personalSummerLightPurple,
                                minusBool: $goeva2.minusCheck) {
                                }
                        }

                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(
                            Ci95view: AnyView(
                                goeva2View95Ci(
                                    goeva2: goeva2,
                                    selection: 11,
                                )
                            )
                        )

                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            goeva2ViewBayes(
                                goeva2: goeva2,
                            )
                        }
                    } label: {
                        Text("カウント")
                            .foregroundStyle(Color.blue)
                    }
                } header: {
                    Text("月蝕変異の発生率")
                }
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goeva2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
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
                unitButtonMinusCheck(minusCheck: $goeva2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: goeva2.resetFirstHit)
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
    goeva2ViewFirstHit(
        goeva2: Goeva2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
