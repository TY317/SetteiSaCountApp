//
//  arifureViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/02.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct arifureTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("ボーナス、AT当選ごとに入力して下さい。入力結果から\n・ボーナス初当り確率\n・AT初当り確率　を算出します\nゲーム数は実ゲーム数を入力して下さい")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct arifureViewHistory: View {
    @ObservedObject var arifure = Arifure()
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
            // //// 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "実ゲーム数",
                    inputValue: $arifure.inputGame,
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
                // ボーナス、種類選択
                unitPickerMenuString(
                    title: "初当り種類",
                    selected: $arifure.selectedBonusKind,
                    selectlist: arifure.selectListBonusKind
                )
                // AT当否
                if arifure.selectedBonusKind == arifure.selectListBonusKind[0] {
                    HStack {
                        Text("AT当否")
                        Spacer()
                        Text("当選")
                            .foregroundStyle(Color.secondary)
                    }
                } else {
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $arifure.selectedAtHit,
                        selectlist: arifure.selectListAtHit
                    )
                }
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if arifure.minusCheck {
                        arifure.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        // AT時の登録
                        if arifure.selectedBonusKind == arifure.selectListBonusKind[0] {
                            arifure.addHistoryAt()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // ミューボーナス時の登録
                        else {
                            arifure.addHistoryMyu()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if arifure.minusCheck == false {
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
            .popoverTip(arifureTipHistoryInput())
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: arifure.gameArrayData)
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
                                // 種類
                                let kindArray = decodeStringArray(from: arifure.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    if kindArray[viewIndex] == arifure.selectListBonusKind[0] {
                                        Text("大迷宮")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        Text("ミュウ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let atHitArray = decodeStringArray(from: arifure.atHitArrayData)
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
                    column2: "ゲーム数",
                    column3: "種類",
                    column4: "AT当否"
                )
            }
            
            // //// 初当り確率
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(arifure.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // 確率横並び
                    HStack {
                        // ミュウボーナス
                        unitResultRatioDenomination2Line(
                            title: "ミュウボーナス",
                            count: $arifure.myuBonusCountAll,
                            bigNumber: $arifure.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $arifure.atCount,
                            bigNumber: $arifure.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ミュウボーナスからのAT
                        unitResultRatioPercent2Line(
                            title: "ﾐｭｳﾎﾞｰﾅｽからのAT",
                            count: $arifure.myuBonusCountAtHit,
                            bigNumber: $arifure.myuBonusCountAll,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 100G以内
                        unitResultRatioPercent2Line(
                            title: "100G+α以内の当選",
                            count: $arifure.hitUnder100gCount,
                            bigNumber: $arifure.hitCountAll,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 縦画面
                else {
                    // 確率横並び1段目
                    HStack {
                        // ミュウボーナス
                        unitResultRatioDenomination2Line(
                            title: "ミュウボーナス",
                            count: $arifure.myuBonusCountAll,
                            bigNumber: $arifure.playGameSum,
                            numberofDicimal: 0
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $arifure.atCount,
                            bigNumber: $arifure.playGameSum,
                            numberofDicimal: 0
                        )
                    }
                    // 確率横並び2段目
                    HStack {
                        // ミュウボーナスからのAT
                        unitResultRatioPercent2Line(
                            title: "ﾐｭｳﾎﾞｰﾅｽからのAT",
                            count: $arifure.myuBonusCountAtHit,
                            bigNumber: $arifure.myuBonusCountAll,
                            numberofDicimal: 0
                        )
                        // 100G以内
                        unitResultRatioPercent2Line(
                            title: "100G+α以内の当選",
                            count: $arifure.hitUnder100gCount,
                            bigNumber: $arifure.hitCountAll,
                            numberofDicimal: 0
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            image1: Image("arifureHitRatio")
                        )
                    )
                )
                unitLinkButton(
                    title: "ﾐｭｳﾎﾞｰﾅｽ開始時のAT当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ミュウボーナス開始時のAT当選",
                            textBody1: "・ミュウボーナス開始時に内部的にAT当選を抽選。当選率は高設定ほど優遇",
                            textBody2: "・ボーナス消化中の自力当選もあるため、開始時の当選を完全に見抜くことはできないと思われるが、設定差大きいため参考する価値はあると考えられる",
                            image1: Image("arifureMyuAt")
                        )
                    )
                )
                unitLinkButton(
                    title: "天国モードでの当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "天国モードでの当選",
                            textBody1: "・リセット、AT終了後の天国モード移行率に設定差あり",
                            textBody2: "・天国モード滞在は完全に見抜くことができないと思われるため、本アプリでは参考として全初当り中の100G+32以内の初当りの割合を算出",
                            image1: Image("arifureTengokuRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(selection: 4)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("確率集計")
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
        .navigationTitle("ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetHistory)
                }
            }
        }
    }
}

#Preview {
    arifureViewHistory()
}
