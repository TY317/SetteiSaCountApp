//
//  inuyashaViewHistoryVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/28.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct inuyashaTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ当選、直AT当選ごとに入力して下さい。入力結果から\n・CZ初当り確率\n・333G天井越え確率\n・AT初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct inuyashaViewHistoryVer2: View {
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
                                // ボーナス種類
                                let bonusArray = decodeStringArray(from: inuyasha.bonusArrayData)
                                if bonusArray.indices.contains(viewIndex) {
                                    Text("\(bonusArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 備考
                                let triggerArray = decodeStringArray(from: inuyasha.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let atHitArray = decodeStringArray(from: inuyasha.atHitArrayData)
                                if atHitArray.indices.contains(viewIndex) {
                                    Text("\(atHitArray[viewIndex])")
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
                .popoverTip(inuyashaTipHistoryInput())
                
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
                        inuyashaSubViewDataInputVer2(inuyasha: inuyasha)
                            .presentationDetents([.large])
                    }
                    Spacer()
                }
            } header: {
                unitHeaderHistoryColumns(column2: "ゲーム数", column3: "種類", column4: "備考", column5: "AT当否")
            }
            
            // //// 初当り
            Section {
                // 通常ゲーム数
                unitResultCount2Line(title: "通常G数", count: $inuyasha.playGameSum)
                // //// CZ初当り
                VStack {
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        HStack {
                            // CZ回数
                            unitResultCount2Line(title: "CZ回数", count: $inuyasha.czCount)
                            // CZ確率
                            unitResultRatioDenomination2Line(
                                title: "CZ確率",
                                count: $inuyasha.czCount,
                                bigNumber: $inuyasha.playGameSum,
                                numberofDicimal: 0
                            )
                            // 333天井越え確率
                            unitResultRatioPercent2Line(
                                title: "333+α越え確率",
                                count: $inuyasha.over333CzCount,
                                bigNumber: $inuyasha.czCount,
                                numberofDicimal: 1
                            )
                            // CZ成功率
                            unitResultRatioPercent2Line(
                                title: "CZ成功率",
                                count: $inuyasha.czHitCountWithoutTenjo,
                                bigNumber: $inuyasha.cycleSumWithoutTenjo,
                                numberofDicimal: 0
                            )
                        }
                    }
                    // //// 縦画面
                    else {
                        HStack {
                            // CZ回数
                            unitResultCount2Line(title: "CZ回数", count: $inuyasha.czCount)
                            // CZ確率
                            unitResultRatioDenomination2Line(
                                title: "CZ確率",
                                count: $inuyasha.czCount,
                                bigNumber: $inuyasha.playGameSum,
                                numberofDicimal: 0
                            )
                        }
                        // CZ確率
                        HStack {
                            // 333天井越え確率
                            unitResultRatioPercent2Line(
                                title: "333+α越え確率",
                                count: $inuyasha.over333CzCount,
                                bigNumber: $inuyasha.czCount,
                                numberofDicimal: 1
                            )
                            // CZ成功率
                            unitResultRatioPercent2Line(
                                title: "CZ成功率",
                                count: $inuyasha.czHitCountWithoutTenjo,
                                bigNumber: $inuyasha.cycleSumWithoutTenjo,
                                numberofDicimal: 0
                            )
                        }
                    }
                    // CZ成功率の注釈
                    Text("※ CZ成功率は周期天井CZを除外して算出")
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
//                            image1: Image("inuyashaHitRatio")
                            tableView: AnyView(inuyashaTableFirstHit())
                        )
                    )
                )
                unitLinkButton(
                    title: "CZ間 333G天井について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ間 333G天井について",
                            textBody1: "・CZ失敗後、AT終了後にCZ間天井ゲーム数を内部的に抽選",
                            textBody2: "・333G+α以下の選択率に大きな設定差あり",
                            textBody3: "・独自に各設定でCZ100万回シミュレーションを行った結果を下記に記載（独自計算値なので参考まで）",
                            textBody4: "・このアプリでは+α=32Gと仮定し、履歴データ内で333+32=365Gを越えた回数とCZの初当り回数から333G天井越え確率を算出",
//                            image1: Image("inuyasha333Tenjo"),
//                            image2Title:"CZ回数別の333G天井選択率",
//                            image2: Image("inuyasha333Ratio")
                            tableView: AnyView(inuyashaTableCz333())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(inuyashaView95Ci(inuyasha: inuyasha, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "犬夜叉2",
                screenClass: screenClass
            )
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
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

// /////////////////////////
// データインプットビュー
// /////////////////////////
struct inuyashaSubViewDataInputVer2: View {
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
                // 種類
                unitPickerCircleString(
                    title: "当選種類",
                    selected: $inuyasha.selectedBonus,
                    selectList: inuyasha.selectListBonus
                )
                // //// 直ATの場合
                if inuyasha.selectedBonus == inuyasha.selectListBonus[1]{
                    HStack {
                        // 当選契機
                        unitPickerCircleString(
                            title: "当選契機",
                            selected: $inuyasha.selectedTriggerAt,
                            selectList: inuyasha.selectListTriggerAt
                        )
                        // AT当否
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $inuyasha.selectedAtHitAt,
                            selectList: inuyasha.selectListAtHitAt
                        )
                    }
                }
                // //// CZの場合
                else {
                    HStack {
                        // 当選契機
                        unitPickerCircleString(
                            title: "CZ周期",
                            selected: $inuyasha.selectedTriggerCz,
                            selectList: inuyasha.selectListTriggerCz
                        )
                        // AT当否
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $inuyasha.selectedAtHitCz,
                            selectList: inuyasha.selectListAtHitCz
                        )
                    }
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        // //// 直ATの場合
                        if inuyasha.selectedBonus == inuyasha.selectListBonus[1] {
                            inuyasha.selectedTrigger = inuyasha.selectedTriggerAt
                            inuyasha.selectedAtHit = inuyasha.selectedAtHitAt
                        }
                        // //// CZの場合
                        else {
                            inuyasha.selectedTrigger = inuyasha.selectedTriggerCz
                            inuyasha.selectedAtHit = inuyasha.selectedAtHitCz
                        }
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
    inuyashaViewHistoryVer2(inuyasha: Inuyasha())
}
