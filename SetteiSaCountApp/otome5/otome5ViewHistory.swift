//
//  otome5ViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5ViewHistory: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    var body: some View {
        List {
            // ---- 履歴登録
            Section {
                // 周期選択
                unitPickerMenuIntToString(
                    title: "周期",
                    selectedInt: otome5.$selectedCycle,
                    selectList: otome5.cycleList,
                    unitText: "周期"
                )
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $otome5.inputGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                // 前兆種類
                unitPickerMenuString(
                    title: "前兆種類",
                    selected: $otome5.selectedKind,
                    selectlist: otome5.kindList
                )
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if otome5.minusCheck {
                        otome5.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        otome5.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    unitButtonSubmitLabel(minusCheck: otome5.minusCheck)
                }
            } header: {
                HStack {
                    Text("周期結果登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "周期結果登録",
                            textBody1: "各周期の結果メモとしてご利用下さい",
                        )
                    }
                }
            }
            
            // ---- 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let cycleArray = decodeIntArray(from: otome5.cycleArrayData)
                    if cycleArray.count > 0 {
                        ForEach(cycleArray.indices, id: \.self) { index in
                            let viewIndex = cycleArray.count - index - 1
                            HStack {
                                // 周期
                                Text("\(cycleArray[viewIndex])周期")
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                // 液晶G数
                                let gameArray = decodeIntArray(from: otome5.gameArrayData)
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // 前兆種類
                                let kindArray = decodeStringArray(from: otome5.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    Text(kindArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
                    }
                    // //// 配列のデータ数が0なら履歴なしを表示
                    else {
                        unitLabelHistoryZero()
                    }
                }
                .frame(height: self.scrollViewHeight)
                
                // 周期テーブル
                unitLinkButtonViewBuilder(sheetTitle: "周期テーブル") {
                    otome5TableCycleTable()
                }
                
                // ゲーム数モード
                unitLinkButtonViewBuilder(sheetTitle: "規定ゲーム数モード") {
                    otome5TableGameMode()
                }
                
                // 概要
                unitLinkButtonViewBuilder(sheetTitle: "乙女ストラップモードについて") {
                    otome5TableStrapMode()
                }
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "周期",
                    column3: "液晶G数",
                    column4: "前兆種類",
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuHistoryBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("周期履歴メモ")
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
                unitButtonMinusCheck(minusCheck: $otome5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: otome5.resetHistory)
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
    otome5ViewHistory(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
