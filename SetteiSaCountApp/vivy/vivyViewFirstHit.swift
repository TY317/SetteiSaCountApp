//
//  vivyViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var vivy: Vivy
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
            Picker("", selection: $vivy.firstHitInputMode) {
                ForEach(vivy.firstHitInputModeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)

            // 履歴入力
            if vivy.isHistoryInputMode {
                // ---- 履歴登録
                Section {
                    // 登録の種類
                    Picker("", selection: $vivy.selectedEntryKind) {
                        ForEach(vivy.entryKindList, id: \.self) { kind in
                            Text(kind)
                        }
                    }
                    .pickerStyle(.segmented)

                    // 周期到達
                    if vivy.isCycleEntry {
                        unitPickerMenuString(
                            title: "周期",
                            selected: $vivy.selectedCycle,
                            selectlist: vivy.cycleList
                        )
                        unitPickerMenuString(
                            title: "規定ポイント",
                            selected: $vivy.selectedPoint,
                            selectlist: vivy.pointList
                        )
                    }
                    // AT当選
                    else {
                        unitTextFieldNumberInputWithUnit(
                            title: "ゲーム数",
                            inputValue: $vivy.inputGame,
                            unitText: "Ｇ"
                        )
                        .focused($isFocused)
                        unitPickerMenuString(
                            title: "当選契機",
                            selected: $vivy.selectedTrigger,
                            selectlist: vivy.triggerList
                        )
                    }

                    // //// 登録ボタン
                    Button {
                        // マイナスチェック入っていれば1行削除
                        if vivy.minusCheck {
                            vivy.removeLastHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // 入っていなければデータ登録
                        else {
                            vivy.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        unitButtonSubmitLabel(minusCheck: vivy.minusCheck)
                    }
                } header: {
                    HStack {
                        Text("履歴登録")
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "履歴登録",
                                textBody1: "・周期到達とAT当選を同じ履歴に登録できます",
                                textBody2: "・周期到達時は周期数と規定ポイントを登録してください",
                                textBody3: "・AT当選時は前回のAT当選からのゲーム数と当選契機を登録してください",
                                textBody4: "・登録結果からATの初当り確率と通常ゲーム数を自動で算出します",
                            )
                        }
                    }
                }

                // ---- 履歴表示
                Section {
                    ScrollView {
                        // //// 配列のデータ数が0以上なら履歴表示
                        let kindArray = decodeStringArray(from: vivy.entryKindArrayData)
                        if kindArray.count > 0 {
                            let gameArray = decodeIntArray(from: vivy.gameArrayData)
                            let centerArray = decodeStringArray(from: vivy.centerArrayData)
                            let rightArray = decodeStringArray(from: vivy.rightArrayData)
                            let startFlagList = vivy.atIntervalStartFlagList
                            ForEach(kindArray.indices, id: \.self) { index in
                                let viewIndex = kindArray.count - index - 1
                                let isCycleRow = kindArray[viewIndex] == vivy.entryKindList[0]
                                HStack {
                                    // ゲーム数（周期到達の行は空欄）
                                    Text(isCycleRow || !gameArray.indices.contains(viewIndex) ? "" : "\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                    // 中央列（周期数／AT）
                                    Text(centerArray.indices.contains(viewIndex) ? centerArray[viewIndex] : "")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                    // 右列（規定ポイント／当選契機）
                                    Text(rightArray.indices.contains(viewIndex) ? rightArray[viewIndex] : "")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                        .frame(maxWidth: .infinity)
                                }
                                // 周期到達の行は文字色を薄くする
                                .foregroundStyle(isCycleRow ? Color.secondary : Color.primary)
                                .font(isCycleRow ? .subheadline : .body)
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

                    // 参考情報）周期モードについて
                    unitLinkButtonViewBuilder(sheetTitle: "周期モードについて") {
                        vivyTableCycleMode()
                    }

                    // 参考情報）モードごとの規定ポイント期待度
                    unitLinkButtonViewBuilder(sheetTitle: "モードごとの規定ポイント期待度") {
                        vivyTablePointKitai()
                    }
                } header: {
                    // AT当選の見出しの下に、周期到達の見出しを行と同じ色で添える
                    VStack(spacing: 2) {
                        unitHeaderHistoryColumns(
                            column1Bool: false,
                            column2: "ゲーム数",
                            column3: "初当り",
                            column4: "当選契機"
                        )
                        HStack {
                            Text("")
                                .frame(maxWidth: .infinity)
                            Text("周期")
                                .frame(maxWidth: .infinity)
                            Text("規定pt")
                                .frame(maxWidth: .infinity)
                        }
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    }
                }

                // ---- 集計結果
                Section {
                    // 通常ゲーム数
                    HStack {
                        Text("通常ゲーム数")
                        Spacer()
                        Text("\(vivy.playGameSum)    G")
                            .foregroundStyle(Color.secondary)
                    }

                    // AT初当り
                    unitResultRatioDenomination2Line(
                        title: "AT初当り",
                        count: $vivy.firstHitCountAt,
                        bigNumber: $vivy.playGameSum,
                        numberofDicimal: 0
                    )

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: vivy.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            vivyView95Ci(
                                vivy: vivy,
                                selection: 8,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        vivyViewBayes(
                            vivy: vivy,
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
                        inputValue: $vivy.manualNormalGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)

                    // カウントボタン横並び
                    HStack {
                        // AT
                        unitCountButtonVerticalDenominate(
                            title: "AT",
                            count: $vivy.manualFirstHitCountAt,
                            color: .personalSummerLightRed,
                            bigNumber: $vivy.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $vivy.minusCheck
                        )
                    }

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: vivy.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            vivyView95Ci(
                                vivy: vivy,
                                selection: 8,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        vivyViewBayes(
                            vivy: vivy,
                        )
                    }
                } header: {
                    Text("カウント")
                }
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vivyMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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
                unitButtonMinusCheck(minusCheck: $vivy.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vivy.resetFirstHit)
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
    vivyViewFirstHit(
        vivy: Vivy(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
