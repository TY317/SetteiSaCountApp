//
//  tokyoGhoulViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/22.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct tokyoGhoulTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ当選、AT直撃ごとに入力して下さい。入力結果から\n・CZ初当り確率\n・AT初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// //////////////////
// Tip：朝イチトグルスイッチの説明
// //////////////////
struct tokyoGhoulTipMorningMode: Tip {
    var title: Text {
        Text("朝一モード除外")
    }
    
    var message: Text? {
        Text("設定変更時に移行する朝一モードを除外した当選率が対象のため、朝一稼働でリセットされる店舗ではONにして下さい")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct tokyoGhoulViewHistory: View {
    @ObservedObject var tokyoGhoul = TokyoGhoul()
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
    
    var body: some View {
        List {
            Section {
                // //// 登録種類の選択
                Picker("", selection: $tokyoGhoul.selectedSegment) {
                    ForEach(tokyoGhoul.selectListSegment, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                // //// ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $tokyoGhoul.inputGame,
                    unitText: "Ｇ"
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
                // //// CZ選択肢
                if tokyoGhoul.selectedSegment == tokyoGhoul.selectListSegment[0] {
                    unitPickerMenuString(
                        title: "CZ種類",
                        selected: $tokyoGhoul.selectedCzKind,
                        selectlist: tokyoGhoul.selectListCzKind
                    )
                    unitPickerMenuString(
                        title: "当選契機",
                        selected: $tokyoGhoul.selectedCzTrigger,
                        selectlist: tokyoGhoul.selectListCzTrigger
                    )
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $tokyoGhoul.selectedCzAtHit,
                        selectlist: tokyoGhoul.selectListCzAtHit
                    )
                }
                // //// AT選択肢
                else {
                    HStack {
                        Text("種類")
                        Spacer()
                        Text("AT直撃")
                            .foregroundStyle(Color.secondary)
                    }
                    unitPickerMenuString(
                        title: "当選契機",
                        selected: $tokyoGhoul.selectedAtTrigger,
                        selectlist: tokyoGhoul.selectListAtTrigger
                    )
                    HStack {
                        Text("AT当否")
                        Spacer()
                        Text("当選")
                            .foregroundStyle(Color.secondary)
                    }
                }
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if tokyoGhoul.minusCheck {
                        tokyoGhoul.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        // CZ時の登録
                        if tokyoGhoul.selectedSegment == tokyoGhoul.selectListSegment[0] {
                            tokyoGhoul.addHistoryCz()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // AT時の登録
                        else {
                            tokyoGhoul.addHistoryAt()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if tokyoGhoul.minusCheck == false {
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
                Text("初当り登録")
            }
            .popoverTip(tokyoGhoulTipHistoryInput())
            
            // //// 参考情報セクション
            Section {
                // //// 参考情報リンク
                unitLinkButton(
                    title: "CZ終了画面について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ終了画面",
                            textBody1: "・終了画面でボタンPUSHでカード表示",
                            textBody2: "・基本は滞在モード示唆だが、一部で設定を示唆",
                            image1: Image("tokyoGhoulEndCard")
                        )
                    )
                )
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・6種類のモードで規定ゲーム数の抽選テーブルを管理",
                            textBody2: "・モード移行契機はCZ失敗時",
                            textBody3: "・天国以外は転落なし",
                            image1: Image("tokyoGhoulCzTable")
                        )
                    )
                )
            }
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: tokyoGhoul.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 種類
                                let kindArray = decodeStringArray(from: tokyoGhoul.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    if kindArray[viewIndex] == tokyoGhoul.selectListCzKind[0] {
                                        Text("レミニ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else if kindArray[viewIndex] == tokyoGhoul.selectListCzKind[1] {
                                        Text("利世")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else if kindArray[viewIndex] == tokyoGhoul.selectListCzKind[2] {
                                        Text("エピボ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        Text("\(kindArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: tokyoGhoul.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let atHitArray = decodeStringArray(from: tokyoGhoul.atHitArrayData)
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
            } header: {
                unitHeaderHistoryColumns(
                    column1Bool: false,
                    column2: "ゲーム数",
                    column3: "種類",
                    column4: "当選契機",
                    column5: "AT当否"
                )
            }
            
            // //// 初当り確率
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(tokyoGhoul.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    HStack {
                        // レミニセンス
                        unitResultRatioDenomination2Line(
                            title: "ﾚﾐﾆｾﾝｽ",
                            count: $tokyoGhoul.czCountRemini,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0
                        )
                        // 利世
                        unitResultRatioDenomination2Line(
                            title: tokyoGhoul.selectListCzKind[1],
                            count: $tokyoGhoul.czCountRise,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0
                        )
                        // CZ
                        unitResultRatioDenomination2Line(
                            title: "CZ合算",
                            count: $tokyoGhoul.czCountSum,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0
                        )
                        // エピソードボーナス
                        unitResultRatioDenomination2Line(
                            title: "エピボ",
                            count: $tokyoGhoul.czCountEpisode,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $tokyoGhoul.atCount,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0
                        )
                    }
                }
                // //// 縦画面
                else {
                    // 確率横並び1段目
                    HStack {
                        // レミニセンス
                        unitResultRatioDenomination2Line(
                            title: "ﾚﾐﾆｾﾝｽ",
                            count: $tokyoGhoul.czCountRemini,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 利世
                        unitResultRatioDenomination2Line(
                            title: tokyoGhoul.selectListCzKind[1],
                            count: $tokyoGhoul.czCountRise,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // CZ
                        unitResultRatioDenomination2Line(
                            title: "CZ合算",
                            count: $tokyoGhoul.czCountSum,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                    // 確率横並び2段目
                    HStack {
                        // エピソードボーナス
                        unitResultRatioDenomination2Line(
                            title: "エピボ",
                            count: $tokyoGhoul.czCountEpisode,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $tokyoGhoul.atCount,
                            bigNumber: $tokyoGhoul.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            textBody1: "・弱レア役からのCZ・AT当選率に設定差あると思われる",
                            image1: Image("tokyoGhoulHitRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(tokyoGhoulView95Ci(selection: 3)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り確率")
            }
            
            // //// 100G以内の当選率
            Section {
                // 朝一データ除外のトグルスイッチ
                Toggle("朝一データ除外", isOn: $tokyoGhoul.morningModeEnable)
                    .popoverTip(tokyoGhoulTipMorningMode())
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "100G以内当選率",
                    count: $tokyoGhoul.under100CountHit,
                    bigNumber: $tokyoGhoul.firstHitCountSum,
                    numberofDicimal: 0
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "100G以内の当選率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "100G以内の当選率",
                            textBody1: "・100G以内での当選率に設定差あり",
                            textBody2: "・設定変更時に移行する朝一モードは算出の対象外",
                            image1: Image("tokyoGhoul100Hit")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(tokyoGhoulView95Ci(selection: 6)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("100G以内での当選率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
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
        .navigationTitle("CZ,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $tokyoGhoul.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetHistory)
                }
            }
        }
    }
}

#Preview {
    tokyoGhoulViewHistory()
}
