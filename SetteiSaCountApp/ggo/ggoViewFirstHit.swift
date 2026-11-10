//
//  ggoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ggo: Ggo
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
            Picker("", selection: $ggo.firstHitInputMode) {
                ForEach(ggo.firstHitInputModeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)

            // 履歴入力
            if ggo.isHistoryInputMode {
                // ---- 履歴登録
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ゲーム数",
                        inputValue: $ggo.inputGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)
                    // ボーナス種類
                    unitPickerMenuString(
                        title: "ボーナス種類",
                        selected: $ggo.selectedBonusKind,
                        selectlist: ggo.bonusKindList
                    )
                    // ST当否（直撃は当選1択なので表示のみ）
                    if ggo.selectedBonusKind == ggo.bonusKindList[3] {
                        HStack {
                            Text("ST当否")
                            Spacer()
                            Text(ggo.stResultList[1])
                                .foregroundStyle(Color.secondary)
                        }
                    } else {
                        unitPickerMenuString(
                            title: "ST当否",
                            selected: $ggo.selectedStResult,
                            selectlist: ggo.stResultList
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // マイナスチェック入っていれば1行削除
                        if ggo.minusCheck {
                            ggo.removeLastHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // 入っていなければデータ登録
                        else {
                            ggo.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        unitButtonSubmitLabel(minusCheck: ggo.minusCheck)
                    }
                } header: {
                    HStack {
                        Text("初当り登録")
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "初当り登録",
                                textBody1: "・ボーナス、ST直撃に当選するごとに登録してください",
                                textBody2: "・ゲーム数は前回の初当りから当選までのゲーム数を入力してください",
                                textBody3: "・登録結果からボーナス合算、STの初当り確率と通常ゲーム数を自動で算出します",
                            )
                        }
                    }
                }

                // ---- 履歴表示
                Section {
                    ScrollView {
                        // //// 配列のデータ数が0以上なら履歴表示
                        let gameArray = decodeIntArray(from: ggo.gameArrayData)
                        if gameArray.count > 0 {
                            let bonusKindArray = decodeStringArray(from: ggo.bonusKindArrayData)
                            let stResultArray = decodeStringArray(from: ggo.stResultArrayData)
                            let startFlagList = ggo.stIntervalStartFlagList
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
                                        Text(bonusKindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // ST当否
                                    if stResultArray.indices.contains(viewIndex) {
                                        Text(stResultArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                // ST区間の区切りは赤線
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
                        column4: "ST当否"
                    )
                }

                // ---- 集計結果
                Section {
                    // 通常ゲーム数
                    HStack {
                        Text("通常ゲーム数")
                        Spacer()
                        Text("\(ggo.playGameSum)    G")
                            .foregroundStyle(Color.secondary)
                    }

                    // 確率横並び
                    HStack {
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ボーナス合算",
                            count: $ggo.firstHitCountBonus,
                            bigNumber: $ggo.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // ST
                        unitResultRatioDenomination2Line(
                            title: "ST",
                            count: $ggo.firstHitCountSt,
                            bigNumber: $ggo.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        ggoTableFirstHit(ggo: ggo)
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ggoView95Ci(
                                ggo: ggo,
                                selection: 2,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ggoViewBayes(
                            ggo: ggo,
                        )
                    }
                } header: {
                    Text("集計結果")
                }
            }
            // カウント入力
            else {
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "通常ゲーム数",
                        inputValue: $ggo.manualNormalGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)

                    // カウントボタン横並び
                    HStack {
                        // BIG
                        unitCountButtonVerticalDenominate(
                            title: "BIG",
                            count: $ggo.manualFirstHitCountBig,
                            color: .personalSummerLightRed,
                            bigNumber: $ggo.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ggo.minusCheck
                        )
                        // REG
                        unitCountButtonVerticalDenominate(
                            title: "REG",
                            count: $ggo.manualFirstHitCountReg,
                            color: .personalSummerLightBlue,
                            bigNumber: $ggo.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ggo.minusCheck
                        )
                        // エピソード
                        unitCountButtonVerticalDenominate(
                            title: "エピボ",
                            count: $ggo.manualFirstHitCountEpisode,
                            color: .personalSummerLightPurple,
                            bigNumber: $ggo.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ggo.minusCheck
                        )
                        // ST
                        unitCountButtonVerticalDenominate(
                            title: "ST",
                            count: $ggo.manualFirstHitCountSt,
                            color: .personalSummerLightGreen,
                            bigNumber: $ggo.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ggo.minusCheck
                        )
                    }

                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $ggo.manualFirstHitCountBonus,
                        bigNumber: $ggo.manualNormalGame,
                        numberofDicimal: 0
                    )

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        ggoTableFirstHit(ggo: ggo)
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ggoView95Ci(
                                ggo: ggo,
                                selection: 2,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ggoViewBayes(
                            ggo: ggo,
                        )
                    }
                } header: {
                    Text("カウント")
                }
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ggoMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
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
                unitButtonMinusCheck(minusCheck: $ggo.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ggo.resetFirstHit)
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

// //// 参考情報）初当り確率
struct ggoTableFirstHit: View {
    @ObservedObject var ggo: Ggo
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス合算",
                denominateList: ggo.ratioFirstHitBonus
            )
            unitTableDenominate(
                columTitle: "ST",
                denominateList: ggo.ratioFirstHitSt
            )
        }
    }
}

#Preview {
    ggoViewFirstHit(
        ggo: Ggo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
