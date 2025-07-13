//
//  izaBanchoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct izaBanchoTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("AT,通常ボーナス当選ごとに入力して下さい。入力結果から\n・AT初当り確率\n・通常ボーナス初当り確率\n・合算初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}



struct izaBanchoViewFirstHit: View {
//    @ObservedObject var ver340: Ver340
    @ObservedObject var izaBancho: IzaBancho
    @State var isShowAlert = false
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
        TipView(izaBanchoTipHistoryInput())
        List {
            Section {
                Text("現在値はダイトモで確認して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                izaBanchoTableFirstHit(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
                // 番長ボーナス直撃
                unitLinkButton(
                    title: "番長ボーナス直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "番長ボーナス直撃",
                            textBody1: "・通常時の番長ボーナス直撃に設定差あり",
                            textBody2: "・CZで虹まで昇格させて出てくるボーナスは対象外",
                            tableView: AnyView(
                                izaBanchoTableBBChokugeki(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
            } header: {
                Text("基本情報")
            }
            
            // //// 初当り履歴
            Section {
                Text("履歴機能はメモ代わりに活用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $izaBancho.inputGame,
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
                // ボーナス種類
                unitPickerMenuString(
                    title: "種類",
                    selected: $izaBancho.selectedBonusKind,
                    selectlist: izaBancho.selectListBonusKind
                )
                // 当選契機
                unitPickerMenuString(
                    title: "当選契機",
                    selected: $izaBancho.selectedTrigger,
                    selectlist: izaBancho.selectListTrigger
                )
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if izaBancho.minusCheck {
                        izaBancho.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        izaBancho.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if izaBancho.minusCheck == false {
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
                    let gameArray = decodeIntArray(from: izaBancho.gameArrayData)
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
                                let bonusKindArray = decodeStringArray(from: izaBancho.bonusKindArrayData)
                                if bonusKindArray.indices.contains(viewIndex) {
                                    if bonusKindArray[viewIndex] == izaBancho.selectListBonusKind[0]{
                                            Text(bonusKindArray[viewIndex])
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                    } else {
                                        Text("通常ﾎﾞｰﾅｽ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let triggerArray = decodeStringArray(from: izaBancho.triggerArrayData)
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
                // モード基本情報
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・4つのモードで規定ゲーム数を管理",
                            textBody2: "・高設定ほどモード移行が優遇されると思われる",
                            textBody3: "・設定変更後、上位AT後は通常モードは選択されない",
                            tableView: AnyView(izaBanchoTableMode())
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(
                    column2: "ゲーム数",
                    column3: "種類",
                    column4: "当選契機",
                )
            }
            
            // //// 初当り確率
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(izaBancho.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }
                // 確率横並び
                HStack {
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $izaBancho.atCount,
                        bigNumber: $izaBancho.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 通常ボーナス
                    unitResultRatioDenomination2Line(
                        title: "通常ボーナス",
                        count: $izaBancho.bonusCount,
                        bigNumber: $izaBancho.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 合算
                    unitResultRatioDenomination2Line(
                        title: "合算",
                        count: $izaBancho.firstHitCount,
                        bigNumber: $izaBancho.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                // 初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                izaBanchoTableFirstHit(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
                // 番長ボーナス直撃
                unitLinkButton(
                    title: "番長ボーナス直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "番長ボーナス直撃",
                            textBody1: "・通常時の番長ボーナス直撃に設定差あり",
                            textBody2: "・CZで虹まで昇格させて出てくるボーナスは対象外",
                            tableView: AnyView(
                                izaBanchoTableBBChokugeki(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        izaBanchoView95Ci(
                            izaBancho: izaBancho,
                            selection: 1
                        )
                    )
                )
            } header: {
                Text("初当り確率集計")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver340.izaBanchoMenuFirstHitBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
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
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $izaBancho.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: izaBancho.resetHistory)
                }
            }
        }
    }
}

#Preview {
    izaBanchoViewFirstHit(
//        ver340: Ver340(),
        izaBancho: IzaBancho()
    )
}
