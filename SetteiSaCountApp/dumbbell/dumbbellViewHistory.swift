//
//  dumbbellViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct dumbbellTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ当選ごとに入力して下さい。入力結果から\n・CZ初当り確率\n・前半パート突破率\n・後半パート成功率\n・ボーナス初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct dumbbellTipWithoutCzBonusCount: Tip {
    var title: Text {
        Text("CZ非経由のボーナス初当り")
    }
    
    var message: Text? {
        Text("履歴データからでは、CZ経由の初当りボーナスしかカウントできないため、AT間天井やフリーズなどCZ非経由の初当りボーナスがあった場合はこちらのボタンでカウントして下さい")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct dumbbellViewHistory: View {
//    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbell: Dumbbell
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
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: dumbbell.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 回数
//                                Text("\(viewIndex+1)")
//                                    .frame(width: 40.0)
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // カロリー
                                let calorieArray = decodeStringArray(from: dumbbell.calorieArrayData)
                                if calorieArray.indices.contains(viewIndex) {
                                    Text("\(calorieArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 前半パート
                                let firstHarfArray = decodeStringArray(from: dumbbell.firstArrayData)
                                if firstHarfArray.indices.contains(viewIndex) {
                                    Text("\(firstHarfArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 後半パート
                                let secondHalfArray = decodeStringArray(from: dumbbell.secondArrayData)
                                if secondHalfArray.indices.contains(viewIndex) {
                                    Text("\(secondHalfArray[viewIndex])")
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
                .popoverTip(dumbbellTipHistoryInput())
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if dumbbell.minusCheck {
                            let gameArray = decodeIntArray(from: dumbbell.gameArrayData)
                            if gameArray.count > 0 {
                                dumbbell.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if dumbbell.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: dumbbell.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        dumbbellSubViewDataInputVer2(dumbbell: dumbbell)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                
                // //// 参考情報リンク
                unitLinkButton(
                    title: "摂取カロリーについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "摂取カロリー",
                            textBody1: "・主に小役成立時に加算される",
                            textBody2: "・10,000kcalごとにCZを抽選。100,000kcalの天井到達時はCZ当選",
                            image1: Image("dumbbellCalorieRatio")
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(column1Bool: false, column2: "ゲーム数", column3: "カロリー", column4: "前半パート", column5: "後半パート")
            }
            
            // //// CZ関連まとめ
            Section {
                // //// 1段目
                HStack {
                    // 通常ゲーム数
                    unitResultCount2Line(title: "通常G数", count: $dumbbell.playGameSum, spacerBool: false)
                    // CZ回数
                    unitResultCount2Line(title: "CZ回数", count: $dumbbell.czCount, spacerBool: false)
                    // CZ確率
                    unitResultRatioDenomination2Line(
                        title: "CZ確率",
                        count: $dumbbell.czCount,
                        bigNumber: $dumbbell.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 2段目
                HStack {
                    // 前半パート突破率
                    unitResultRatioPercent2Line(
                        title: "前半パート突破率",
                        count: $dumbbell.czFirstSuccessCount,
                        bigNumber: $dumbbell.czCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 後半パート成功率
                    unitResultRatioPercent2Line(
                        title: "後半パート成功率",
                        count: $dumbbell.czSecondSuccessCount,
                        bigNumber: $dumbbell.czFirstSuccessCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報
                unitLinkButton(
                    title: "CZ関連の設定差について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ関連の設定差",
                            textBody1: "・CZ初当り確率は未発表。大きな設定差はない！？",
                            textBody2: "・CZの後半パート成功率に設定差あり",
                            textBody3: "・前半パートの突破率公表値は約77%",
                            textBody4: "・CZ高確示唆の神社ステージへの移行率も高設定ほど優遇",
                            image1: Image("dumbbellSecondHalfSuccessRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(dumbbellView95Ci(dumbbell: dumbbell, selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("CZ関連まとめ")
            }
            
            // //// ボーナス初当り
            Section {
                HStack {
                    // カウントボタン
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ非経由ボーナス",
                        count: $dumbbell.bonusCountWithoutCz,
                        color: .personalSummerLightRed,
                        minusBool: $dumbbell.minusCheck
                    )
                    .popoverTip(dumbbellTipWithoutCzBonusCount())
                    // ボーナス確率
                    unitResultRatioDenomination2Line(
                        title: "ボーナス確率",
                        count: $dumbbell.bonusCountSum,
                        bigNumber: $dumbbell.playGameSum,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ボーナス初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボーナス初当り確率",
                            image1: Image("dumbellBonusRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(dumbbellView95Ci(dumbbell: dumbbell, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ボーナス初当り")
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
        .navigationTitle("CZ、ボーナス初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dumbbell.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// データインプットビュー
// /////////////////////////
struct dumbbellSubViewDataInputVer2: View {
    @ObservedObject var dumbbell: Dumbbell
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $dumbbell.inputGame)
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
                // //// サークルピッカー横並び
                HStack {
                    // カロリー
                    unitPickerCircleString(
                        title: "カロリー",
                        selected: $dumbbell.selectedCalorie,
                        selectList: dumbbell.selectListCalorie
                    )
                    // 前半パート
                    unitPickerCircleString(
                        title: "前半パート",
                        selected: $dumbbell.selectedFirstHalf,
                        selectList: dumbbell.selectListFirstHalf
                    )
                    // 後半パート、前半パートの結果に応じて使い分け
                    if dumbbell.selectedFirstHalf == dumbbell.selectListFirstHalf[0]{
                        // 後半パート、前半突破
                        unitPickerCircleString(
                            title: "後半パート",
                            selected: $dumbbell.selectedSecondHalfAfterSuccess,
                            selectList: dumbbell.selectListSecondHalfAfterSuccess
                        )
                    } else {
                        // 後半パート、前半失敗
                        unitPickerCircleString(
                            title: "後半パート",
                            selected: $dumbbell.selectedSecondHalfAfterFailed,
                            selectList: dumbbell.selectListSecondHalfAfterFailed
                        )
                    }
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        // //// 前半突破の場合
                        if dumbbell.selectedFirstHalf == dumbbell.selectListFirstHalf[0] {
                            dumbbell.selectedSecondHalf = dumbbell.selectedSecondHalfAfterSuccess
                        }
                        // //// 前半失敗の場合
                        else {
                            dumbbell.selectedSecondHalf = dumbbell.selectedSecondHalfAfterFailed
                        }
                        dumbbell.addDataHistory()
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
    dumbbellViewHistory(dumbbell: Dumbbell())
}
