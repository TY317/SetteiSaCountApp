//
//  inuyashaViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/14.
//

import SwiftUI

struct inuyashaViewHistory: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    
    var body: some View {
        List {
            // //// 333超えCZカウント
            Section {
                // カウントボタン
                unitCountButtonVerticalWithoutRatio(
                    title: "333越えCZ",
                    count: $inuyasha.over333CzCount,
                    color: .personalSummerLightBlue,
                    minusBool: $inuyasha.minusCheck
                )
            } header: {
                Text("333G天井越えでのCZ当選カウント")
            }
            // //// 履歴
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: inuyasha.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選CZ周期
                                let cycleArray = decodeStringArray(from: inuyasha.cycleArrayData)
                                if cycleArray.indices.contains(viewIndex) {
                                    Text("\(cycleArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: inuyasha.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
                    }
                    // //// 配列のデータ数が0なら履歴なしを表示
                    else {
                        HStack {
                            Spacer()
                            Text("履歴なし")
                                .font(.title)
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
                .frame(height: self.scrollViewHeight)
                
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if inuyasha.minusCheck {
                            let gameArray = decodeIntArray(from: inuyasha.gameArrayData)
                            if gameArray.count > 0 {
                                inuyasha.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if inuyasha.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: inuyasha.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        inuyashaSubViewDataInput(inuyasha: inuyasha)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
            } header: {
                unitHeaderHistoryColumns(column2: "実ゲーム数", column3: "当選CZ周期", column4: "当選契機")
            }
            
            // //// 初当り
            Section {
                // 通常ゲーム数
                unitResultCount2Line(title: "通常G数", count: $inuyasha.playGameSum)
                // //// CZ初当り
                VStack {
                    HStack {
                        // CZ回数
                        unitResultCount2Line(title: "CZ回数", count: $inuyasha.cycleSum, spacerBool: false)
                        // CZ確率
                        unitResultRatioDenomination2Line(
                            title: "CZ確率",
                            count: $inuyasha.cycleSum,
                            bigNumber: $inuyasha.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                    // CZ確率
                    HStack {
                        // 333天井越え確率
                        unitResultRatioPercent2Line(
                            title: "333天井越え確率",
                            count: $inuyasha.over333CzCount,
                            bigNumber: $inuyasha.cycleSum,
                            numberofDicimal: 1
                        )
                        // CZ成功率
                        unitResultRatioPercent2Line(
                            title: "CZ成功率",
                            count: $inuyasha.czHitCountWithoutTenjo,
                            bigNumber: $inuyasha.cycleSumWithoutTenjo,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                    // CZ成功率の注釈
                    Text("※ CZ成功率は天井CZを除外して算出")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                // //// AT初当り
                HStack {
                    // AT回数
                    unitResultCount2Line(title: "AT回数", count: $inuyasha.atHitCount, spacerBool: false)
                    // AT確率
                    unitResultRatioDenomination2Line(
                        title: "AT確率",
                        count: $inuyasha.atHitCount,
                        bigNumber: $inuyasha.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ,AT 初当り確率",
                            image1: Image("inuyashaHitRatio")
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(inuyashaView95Ci(inuyasha: inuyasha, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("AT初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $inuyasha.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// データインプットビュー
// /////////////////////////
struct inuyashaSubViewDataInput: View {
    @ObservedObject var inuyasha: Inuyasha
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $inuyasha.inputGame)
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
                // サークルピッカー横並び
                HStack {
                    // CZ当選周期
                    unitPickerCircleString(
                        title: "当選CZ周期",
                        selected: $inuyasha.selectedCycle,
                        selectList: inuyasha.selectListCycle
                    )
                    // 当選契機
                    unitPickerCircleString(
                        title: "当選契機",
                        selected: $inuyasha.selectedTrigger,
                        selectList: inuyasha.selectListTrigger
                    )
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        inuyasha.addDataHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        dismiss()
                    } label: {
                        Text("登録")
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
            }
            .navigationTitle("履歴登録")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}


#Preview {
    inuyashaViewHistory(inuyasha: Inuyasha())
}
