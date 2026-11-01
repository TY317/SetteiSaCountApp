//
//  seiyaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var seiya: Seiya
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
            // ---- 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $seiya.inputGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                // CZ種類
                unitPickerMenuString(
                    title: "CZ種類",
                    selected: $seiya.selectedCzKind,
                    selectlist: seiya.czKindList
                )
                // AT当否（AT直撃は当選1択なので表示のみ）
                if seiya.selectedCzKind == seiya.czKindList[2] {
                    HStack {
                        Text("AT当否")
                        Spacer()
                        Text(seiya.atResultList[1])
                            .foregroundStyle(Color.secondary)
                    }
                } else {
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $seiya.selectedAtResult,
                        selectlist: seiya.atResultList
                    )
                }
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if seiya.minusCheck {
                        seiya.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        seiya.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    unitButtonSubmitLabel(minusCheck: seiya.minusCheck)
                }
            } header: {
                HStack {
                    Text("初当り登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "初当り登録",
                            textBody1: "・CZ、AT直撃に当選するごとに登録してください",
                            textBody2: "・ゲーム数はAT当選までの累積ゲーム数を入力してください",
                            textBody3: "・登録結果からCZ、ATの初当り確率と通常ゲーム数を自動で算出します",
                        )
                    }
                }
            }

            // ---- 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: seiya.gameArrayData)
                    if gameArray.count > 0 {
                        let czKindArray = decodeStringArray(from: seiya.czKindArrayData)
                        let atResultArray = decodeStringArray(from: seiya.atResultArrayData)
                        let startFlagList = seiya.atIntervalStartFlagList
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    // AT当選の場合は黒字で表示
                                    if atResultArray.indices.contains(viewIndex) && atResultArray[viewIndex] == seiya.atResultList[1] {
                                        Text("\(gameArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // リセットされないゲーム数は()付きグレーで表示
                                    else {
                                        Text("(\(gameArray[viewIndex]))")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle(Color.secondary)
                                    }
                                }
                                // CZ種類
                                if czKindArray.indices.contains(viewIndex) {
                                    Text(seiya.czKindShortName(czKindArray[viewIndex]))
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
                    column3: "CZ種類",
                    column4: "AT当否"
                )
            }

            // ---- 集計結果
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(seiya.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }

                // 確率横並び
                HStack {
                    // CZ合算
                    unitResultRatioDenomination2Line(
                        title: "CZ合算",
                        count: $seiya.firstHitCountCz,
                        bigNumber: $seiya.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $seiya.firstHitCountAt,
                        bigNumber: $seiya.playGameSum,
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
                            columTitle: "CZ合算",
                            denominateList: seiya.ratioFirstHitCz
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: seiya.ratioFirstHitAt
                        )
                    }
                }

                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        seiyaView95Ci(
                            seiya: seiya,
                            selection: 2,
                        )
                    )
                )

                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    seiyaViewBayes(
                        seiya: seiya,
                    )
                }
            } header: {
                Text("集計結果")
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.seiyaMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
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
                unitButtonMinusCheck(minusCheck: $seiya.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: seiya.resetFirstHit)
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
    seiyaViewFirstHit(
        seiya: Seiya(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
