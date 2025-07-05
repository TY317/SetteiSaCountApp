//
//  dmc5ViewFristHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct dmc5TipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("ボーナス、ST直撃当選ごとに入力して下さい\nゲーム数は液晶ゲーム数を入力して下さい\n入力結果から\n・ボーナス初当り確率\n・ST初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct dmc5ViewFristHit: View {
    @ObservedObject var ver350: Ver350
    @ObservedObject var dmc5: Dmc5
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
        TipView(dmc5TipHistoryInput())
        List {
            // 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $dmc5.inputGame,
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
                // ボーナス種類選択
                unitPickerMenuString(
                    title: "ボーナス種類",
                    selected: $dmc5.selectedBonusKind,
                    selectlist: dmc5.selectListBonusKind
                )
                // 当選契機
                unitPickerMenuString(
                    title: "当選契機",
                    selected: $dmc5.selectedTrigger,
                    selectlist: dmc5.selectListTrigger
                )
                // ST当否
                if dmc5.selectedBonusKind == dmc5.selectListBonusKind[0] {
                    unitPickerMenuString(
                        title: "ST当否",
                        selected: $dmc5.selectedStHit,
                        selectlist: dmc5.selectListStHit
                    )
                } else {
                    HStack {
                        Text("ST当否")
                        Spacer()
                        Text("当選")
                            .foregroundStyle(Color.secondary)
                    }
                }
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if dmc5.minusCheck {
                        dmc5.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        // //// DMCボーナス
                        if dmc5.selectedBonusKind == dmc5.selectListBonusKind[0] {
                            dmc5.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // //// エピソードボーナス
                        else {
                            dmc5.selectedStHit = dmc5.selectListStHit[0]
                            dmc5.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if dmc5.minusCheck == false {
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
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: dmc5.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            let stHitArray = decodeStringArray(from: dmc5.stHitArrayData)
                            HStack {
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    // AT当選の場合は黒字で表示
                                    if stHitArray.indices.contains(viewIndex) && stHitArray[viewIndex] == dmc5.selectListStHit[0] {
                                        Text("\(gameArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // AT非当選の場合は()付きグレーで表示
                                    else {
                                        Text("(\(gameArray[viewIndex]))")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle(Color.secondary)
                                    }
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 種類
                                let kindArray = decodeStringArray(from: dmc5.bonusKindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    if kindArray[viewIndex] == dmc5.selectListBonusKind[0] {
                                        Text(kindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        Text("エピボ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: dmc5.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text(triggerArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
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
                // モード基本情報
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・4つのモードで規定ゲーム数を管理",
                            textBody2: "・ゾーン外（100Gごと以外）のゲーム数でのボーナス当選は高設定の可能性がアップする",
                            tableView: AnyView(dmc5TableMode())
                        )
                    )
                )
                // 謎ダンテCZについて
                unitLinkButton(
                    title: "謎ダンテCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "謎ダンテCZ",
                            textBody1: "・CZ周期の到達やチャンス目の成立に関係なく急にダンテCZが出現することがある＝謎ダンテ",
                            textBody2: "・CZ周期到達前にダンテCZの煽りが発生し、ダンテCZ当選したら謎ダンテの期待度アップ",
                            tableView: AnyView(dmc5TableNazoDante())
                        )
                    )
                )
                .popoverTip(tipVer350Dmc5NazoCz())
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "液晶G数",
                    column3: "種類",
                    column4: "当選契機",
                    column5: "ST当否",
                )
            }
            
            // //// 初当り確率
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(dmc5.normalGame)    G")
                        .foregroundStyle(Color.secondary)
                }
                // 確率横並び
                HStack {
                    // ボーナス
                    unitResultRatioDenomination2Line(
                        title: "ボーナス",
                        count: $dmc5.bonusCount,
                        bigNumber: $dmc5.normalGame,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "ST",
                        count: $dmc5.stCount,
                        bigNumber: $dmc5.normalGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                dmc5TableFirstHit(
                                    dmc5: dmc5
                                )
                            )
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 1
                        )
                    )
                )
            } header: {
                Text("確率集計")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
//            Section {
//                // 通常ゲーム数入力
//                unitTextFieldNumberInputWithUnit(
//                    title: "通常ゲーム数",
//                    inputValue: $dmc5.normalGame,
//                    unitText: "Ｇ"
//                )
//                .focused($isFocused)
//                .toolbar {
//                    ToolbarItem(placement: .keyboard) {
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                isFocused = false
//                            }, label: {
//                                Text("完了")
//                                    .fontWeight(.bold)
//                            })
//                        }
//                    }
//                }
//                // //// カウント横並び
//                HStack {
//                    // ボーナス
//                    unitCountButtonVerticalDenominate(
//                        title: "ボーナス",
//                        count: $dmc5.bonusCount,
//                        color: .personalSummerLightRed,
//                        bigNumber: $dmc5.normalGame,
//                        numberofDicimal: 0,
//                        minusBool: $dmc5.minusCheck
//                    )
//                    // ST
//                    unitCountButtonVerticalDenominate(
//                        title: "ST",
//                        count: $dmc5.stCount,
//                        color: .personalSummerLightPurple,
//                        bigNumber: $dmc5.normalGame,
//                        numberofDicimal: 0,
//                        minusBool: $dmc5.minusCheck
//                    )
//                }
//                
//                // //// 参考情報）初当り確率
//                unitLinkButton(
//                    title: "初当り確率",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "初当り確率",
//                            tableView: AnyView(
//                                dmc5TableFirstHit(
//                                    dmc5: dmc5
//                                )
//                            )
//                        )
//                    )
//                )
//                // //// 95%信頼区間グラフへのリンク
//                unitNaviLink95Ci(
//                    Ci95view: AnyView(
//                        dmc5View95Ci(
//                            dmc5: dmc5,
//                            selection: 1
//                        )
//                    )
//                )
//            } header: {
//                Text("初当りカウント")
//            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.dmc5MenuFirstHitBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetHistory)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dmc5ViewFristHit(
        ver350: Ver350(),
        dmc5: Dmc5(),
    )
}
