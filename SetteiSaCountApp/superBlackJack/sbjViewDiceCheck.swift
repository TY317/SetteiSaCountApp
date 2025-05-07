//
//  sbjViewDiceCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI
import TipKit

// /////////////////////
// Tip：ダイスチェック履歴登録
// /////////////////////
struct sbjTipDiceCheckHistoryInput: Tip {
    var title: Text {
        Text("ダイスチェック履歴")
    }
    
    var message: Text? {
        Text("ダイスチェック発生時はこちらで履歴登録してください")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// /////////////////////
// Tip：ストックタイム履歴登録
// /////////////////////
struct sbjTipStHistoryInput: Tip {
    var title: Text {
        Text("登録データ切り替え")
    }
    
    var message: Text? {
        Text("スイカ規定回数からのストックタイム初当り時はこちらで切り替えて登録してください")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}



struct sbjViewDiceCheck: View {
//    @ObservedObject var sbj = Sbj()
    @ObservedObject var sbj: Sbj
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let historyImageSize = 25.0
    let segmentSelectList = ["ダイスチェック", "ストックタイム"]
    @State var selectedMode = "ダイスチェック"
    let diceImageSize = 50.0
    let hstackSize = 80.0
//    let rectangleWidth = 25.0
    var body: some View {
        List {
            Section {
                // //// 登録種類の選択
                Picker("", selection: self.$selectedMode) {
                    ForEach(self.segmentSelectList, id: \.self) { mode in
                        Text(mode)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(sbjTipStHistoryInput())
                // //// ダイス選択
                if self.selectedMode == "ダイスチェック" {
                    HStack {
                        Spacer()
                        // ダイス1
                        VStack(spacing: 0) {
                            Picker(selection: $sbj.selectedDiceLeft) {
                                ForEach(sbj.selectListDice, id: \.self) { dice in
                                    Text("\(dice)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            } label: {
                            }
                            .pickerStyle(.menu)
                            Image("sbjDice\(sbj.selectedDiceLeft)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: self.diceImageSize, height: self.diceImageSize)
                        }
                        Spacer()
                        // ダイス2
                        VStack(spacing: 0) {
                            Picker(selection: $sbj.selectedDiceRight) {
                                ForEach(sbj.selectListDice, id: \.self) { dice in
                                    Text("\(dice)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            } label: {
                            }
                            .pickerStyle(.menu)
                            Image("sbjDice\(sbj.selectedDiceRight)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50.0, height: 50.0)
                        }
                        Spacer()
                    }
                    .frame(height: self.hstackSize)
                }
                // //// ストックタイム選択時
                else {
                    HStack {
                        Text("スイカ規定回数からの\nストックタイム初当り")
                    }
                    .frame(height: self.hstackSize)
                }
                // //// スイカ回数登録
                VStack(spacing: 2) {
                    unitTextFieldNumberInputWithUnit(
                        title: "現在スイカ回数",
                        inputValue: $sbj.nextInputSuikaCount
                    )
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
                    Text("現在回数はスロプラNEXTで確認できます")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if sbj.minusCheck {
                        sbj.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        if self.selectedMode == "ダイスチェック" {
                            sbj.addDataHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        } else {
                            sbj.stAddHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if sbj.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("1行削除")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }

            } header: {
                Text("ダイスチェック履歴登録")
            }
            // //// 履歴メモ
            Section {
                ScrollView {
                    // //// 履歴のデータ数が0なら履歴表示
                    let diceLeftArray = decodeStringArray(from: sbj.diceLeftArrayData)
                    if diceLeftArray.count > 0 {
                        ForEach(diceLeftArray.indices, id: \.self) { index in
                            let viewIndex = diceLeftArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // 出目
                                HStack {
                                    Spacer()
                                    // ダイス１
                                    if diceLeftArray.indices.contains(viewIndex) {
                                        if diceLeftArray[viewIndex] == sbj.stAddString {
                                            Text(diceLeftArray[viewIndex])
                                        }
                                        else {
                                            Image("sbjDice\(diceLeftArray[viewIndex])")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: self.historyImageSize, height: self.historyImageSize)
                                        }
                                    }
                                    // ダイス２
                                    let diceRightArray = decodeStringArray(from: sbj.diceRightArrayData)
                                    if diceRightArray.indices.contains(viewIndex) {
                                        if diceRightArray[viewIndex] == sbj.stAddString {
                                            
                                        }
                                        else {
                                            Image("sbjDice\(diceRightArray[viewIndex])")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: self.historyImageSize, height: self.historyImageSize)
                                        }
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                // スイカ回数
                                let suikaArray = decodeIntArray(from: sbj.suikaArrayData)
                                if suikaArray.indices.contains(viewIndex) {
                                    Text("\(suikaArray[viewIndex])")
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
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ダイスチェックについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ダイスチェック",
                            textBody1: "・通常時BB間 150/450/750Gで発生",
                            textBody2: "・出目でスイカ規定回数を示唆",
                            textBody3: "・規定回数の法則矛盾の場合は設定示唆",
                            textBody4: "・規定回数到達時はストックタイムに当選",
                            textBody5: "[注!] 赤ダイスはゾロ目濃厚演出。示唆内容は白ダイスと同じと思われる",
                            tableView: AnyView(sbjTableDiceCheck())
//                            image1: Image("sbjDiceCheck")
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(column2: "出目", column3: "スイカ回数")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
//        .onAppear {
//            if ver230.sbjMenuDiceCheckBadgeStatus != "none" {
//                ver230.sbjMenuDiceCheckBadgeStatus = "none"
//            }
//        }
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
        .navigationTitle("ダイスチェック")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sbj.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sbj.resetDiceCheck)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sbjViewDiceCheck(sbj: Sbj())
}
