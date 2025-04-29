//
//  danvineViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/25.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct danvineTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("ボーナス当選ごとに入力。入力結果から\n・ボーナス初当り確率\n・ST初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct danvineViewHistory: View {
//    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvine: Danvine
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            // //// 履歴表示
            Section {
                ScrollView {
                    // 配列のデータが0以上なら履歴表示
                    let gameArray = decodeIntArray(from: danvine.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // ボーナス種類
                                let bonusArray = decodeStringArray(from: danvine.bonusArrayData)
                                if bonusArray.indices.contains(viewIndex) {
                                    Text("\(bonusArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .font(.footnote)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: danvine.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .font(.footnote)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // ST当否
                                let stHitArray = decodeStringArray(from: danvine.stHitArrayData)
                                if stHitArray.indices.contains(viewIndex) {
                                    Text("\(stHitArray[viewIndex])")
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
                .popoverTip(danvineTipHistoryInput())
                
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if danvine.minusCheck {
                            let gameArray = decodeIntArray(from: danvine.gameArrayData)
                            if gameArray.count > 0 {
                                danvine.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if danvine.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: danvine.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        danvineSubViewDataInput(danvine: danvine)
                            .presentationDetents([.large])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                // 偶数周期での当選について
                unitLinkButton(
                    title: "周期について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "周期について",
                            textBody1: "・偶数周期での当選は高設定期待度アップとなる",
                            textBody2: "・周期のボーナス期待度として下記表の数値が公表されているが、周期当選の設定差があるならば高設定はこれよりも高い数値になる可能性もあり",
                            image1: Image("danvineCycleRatio")
                        )
                    )
                )
                // 規定ポイントについて
//                unitLinkButton(
//                    title: "規定Ptについて",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "規定Ptについて",
//                            textBody1: "・オーラ役成立時にポイントを獲得し、規定ポイントに到達すると前兆へ移行、ボーナス当否を告知する",
//                            textBody2: "・下表の規定ポイント以外（1ptを除く）で当選した場合は高設定の期待度アップとなる",
//                            textBody3: "・青オーラ役成立時は複数ポイント獲得。かつモードによって獲得ポイントが異なるため現在モードの推測も可能",
//                            image1: Image("danvinePoint"),
//                            image2: Image("danvineGetPoint")
//                        )
//                    )
//                )
                // 当選契機について
                unitLinkButton(
                    title: "当選契機について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "当選契機について",
                            textBody1: "・2Gバトルでのボーナス当選率は高設定ほど高い",
                            textBody2: "・ボーナス直撃当選は高設定ほど多い"
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(
                    column1Bool: false,
                    column2: "実ゲーム数",
                    column3: "ボナ種類",
                    column4: "当選契機",
                    column5: "ST当否"
                )
            }
            
            // //// 初当り
            Section {
                // 通常ゲーム数
                unitResultCount2Line(
                    title: "通常G数",
                    count: $danvine.playGameSum
                )
                // //// ボーナス初当り
                HStack {
                    // ボーナス回数
                    unitResultCount2Line(title: "ボーナス回数", count: $danvine.bonusCount)
                    // ボーナス確率
                    unitResultRatioDenomination2Line(
                        title: "ボーナス確率",
                        count: $danvine.bonusCount,
                        bigNumber: $danvine.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // //// ST初当り
                HStack {
                    // ST回数
                    unitResultCount2Line(title: "ST回数", count: $danvine.stCount)
                    // ST確率
                    unitResultRatioDenomination2Line(
                        title: "ST確率",
                        count: $danvine.stCount,
                        bigNumber: $danvine.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボーナス、ST 初当り確率",
                            textBody1: "・2Gバトルでの当選率は高設定ほど高いらしい",
                            textBody2: "・直撃は高設定ほど多くなるらしい",
                            image1: Image("danvineHitRatio")
                        )
                    )
                )
                // //// 参考情報）上位ラッシュ引き継ぎ
                unitLinkButton(
                    title: "上位ラッシュスタートについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "上位ラッシュスタート",
                            textBody1: "・63G+αを超えて前回のラッシュ情報を持ち越す場合がある",
                            textBody2: "・通常ラッシュ後は全設定0.4%",
                            textBody3: "・上位ラッシュ後は特大の設定差あり",
                            textBody4: "　上位ラッシュ後63G+α超えた初当りで上位ラッシュスタートが確認できれば高設定に期待",
                            tableView: AnyView(danvineTableExRushStart())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(danvineView95Ci(danvine: danvine, selection: 1)))
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
        .navigationTitle("初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

// /////////////////////
// データインプット画面
// /////////////////////
struct danvineSubViewDataInput: View {
    @ObservedObject var danvine: Danvine
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $danvine.inputGame)
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
                // サークルピッカー横並び １段目
                HStack {
                    // ボーナス種類
                    unitPickerCircleString(
                        title: "ボーナス種類",
                        selected: $danvine.selectedBonus,
                        selectList: danvine.selectListBonus
                    )
                    // 当選契機
                    unitPickerCircleString(
                        title: "当選契機",
                        selected: $danvine.selectedTrigger,
                        selectList: danvine.selectListTrigger
                    )
                }
                // サークルピッカー横並び ２段目
                HStack {
                    // ST当否
                    if danvine.selectedBonus == danvine.selectListBonus[0] {
                        // フェラリオ時の選択肢
                        unitPickerCircleString(
                            title: "ST当否",
                            selected: $danvine.selectedStHit,
                            selectList: danvine.selectListStHit
                        )
                    } else {
                        // フェラリオ以外の選択肢
                        unitPickerCircleString(
                            title: "ST当否",
                            selected: $danvine.selectedStHit,
                            selectList: danvine.selectListStHitOraHyper
                        )
                    }
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.clear)
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        danvine.addDataHistory()
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
    danvineViewHistory(danvine: Danvine())
}
