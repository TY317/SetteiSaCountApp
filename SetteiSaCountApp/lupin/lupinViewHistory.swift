//
//  lupinViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/10.
//

import SwiftUI
import TipKit

struct lupinViewHistory: View {
//    @ObservedObject var lupin = Lupin()
    @ObservedObject var lupin: Lupin
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
            // //// 強チェ、CZカウント
            Section {
                // //// カウントボタン横並び
                HStack {
                    // 強チェリー
                    unitCountButtonVerticalWithoutRatio(
                        title: "強🍒",
                        count: $lupin.cherryCountAll,
                        color: .personalSummerLightRed,
                        minusBool: $lupin.minusCheck
                    )
                    // CZ
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ ICPO",
                        count: $lupin.czCountAll,
                        color: .personalSummerLightPurple,
                        minusBool: $lupin.minusCheck
                    )
                }
            } header: {
                Text("強🍒、CZのカウント")
            }
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: lupin.gameArrayData)
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
                                let bonusArray = decodeStringArray(from: lupin.bonusArrayData)
                                if bonusArray.indices.contains(viewIndex) {
                                    Text("\(bonusArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: lupin.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .font(.footnote)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let atHitArray = decodeStringArray(from: lupin.atHitArrayData)
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
                
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if lupin.minusCheck {
                            let gameArray = decodeIntArray(from: lupin.gameArrayData)
                            if gameArray.count > 0 {
                                lupin.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if lupin.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: lupin.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        lupinSubViewDataInput(lupin: lupin)
                            .presentationDetents([.large])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "規定ゲーム数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定ゲーム数について",
                            textBody1: "・ゲーム数消化でCZや高確移行を抽選",
                            textBody2: "・天井は基本1000だが短縮天井が選ばれる場合あり。高設定ほど短縮天井の確率が上がるらしい",
                            textBody3: "・設定変更時は最大天井が700に短縮される",
                            tableView: AnyView(lupinTableKiteiGame())
//                            image1: Image("lupinGameNumber")
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(
                    column1Bool: false,
                    column2: "実ゲーム数",
                    column3: "ボナ種類",
                    column4: "当選契機",
                    column5: "AT当否"
                )
            }
            
            // //// 初当り
            Section {
                // 通常ゲーム数
                unitResultCount2Line(
                    title: "通常G数",
                    count: $lupin.playGameSum
                )
                // //// ボーナス初当り
                HStack {
                    // ボーナス回数
                    unitResultCount2Line(title: "ボーナス回数", count: $lupin.bonusCount)
                    // ボーナス確率
                    unitResultRatioDenomination2Line(
                        title: "ボーナス確率",
                        count: $lupin.bonusCount,
                        bigNumber: $lupin.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // //// AT初当り
                HStack {
                    // AT回数
                    unitResultCount2Line(title: "AT回数", count: $lupin.atCount)
                    // AT確率
                    unitResultRatioDenomination2Line(
                        title: "AT確率",
                        count: $lupin.atCount,
                        bigNumber: $lupin.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボーナス、AT 初当り確率",
                            tableView: AnyView(lupinTableFirstHit())
//                            image1: Image("lupinHitRatio")
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(lupinView95Ci(lupin: lupin, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り")
            }
            
            // //// CZ確率、成功率
            Section {
                HStack {
                    // CZ確率
                    unitResultRatioDenomination2Line(
                        title: "CZ確率",
                        count: $lupin.czCountAll,
                        bigNumber: $lupin.playGameSum,
                        numberofDicimal: 0
                    )
                    // CZ成功率
                    unitResultRatioPercent2Line(
                        title: "CZ成功率",
                        count: $lupin.czCountHit,
                        bigNumber: $lupin.czCountAll,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "CZ確率、成功率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ 確率、成功率",
//                            image1: Image("lupinCz")
                            tableView: AnyView(lupinTableCz())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(lupinView95Ci(lupin: lupin, selection: 3)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("CZ ICPO確率、成功率")
            }
            
            // 強チェリー
            Section {
                HStack {
                    // 強チェリー直撃数
                    unitResultCount2Line(title: "強🍒直撃回数", count: $lupin.cherryCountHit)
                    // 強チェリー当選率
                    unitResultRatioPercent2Line(
                        title: "強🍒直撃率",
                        count: $lupin.cherryCountHit,
                        bigNumber: $lupin.cherryCountAll,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "強🍒からの直撃率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "強🍒からの直撃率",
                            textBody1: "・このアプリでは合算での直撃回数と直撃率を算出しています",
//                            image1: Image("lupinCherry")
                            tableView: AnyView(lupinTableKyoCherry())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(lupinView95Ci(lupin: lupin, selection: 5)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("強🍒当選率")
            }
            
            // //// ボーナスキャラ種類
            Section {
                // ルパン
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $lupin.bonusCharaCountLupin,
                    flashColor: .gray,
                    bigNumber: $lupin.bonusCharaCountSum,
                    numberofDigit: 0
                )
                // 次元
                unitResultCountListPercent(
                    title: "設定 2,3,4,6示唆",
                    count: $lupin.bonusCharaCountJigen,
                    flashColor: .blue,
                    bigNumber: $lupin.bonusCharaCountSum,
                    numberofDigit: 0
                )
                // 五右衛門
                unitResultCountListPercent(
                    title: "設定1,3,5,6示唆",
                    count: $lupin.bonusCharaCountGoemon,
                    flashColor: .yellow,
                    bigNumber: $lupin.bonusCharaCountSum,
                    numberofDigit: 0
                )
                // 不二子
                unitResultCountListPercent(
                    title: "設定6示唆",
                    count: $lupin.bonusCharaCountFujiko,
                    flashColor: .red,
                    bigNumber: $lupin.bonusCharaCountSum,
                    numberofDigit: 0
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "シングル揃い キャラによる示唆",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "キャラによる示唆",
                            textBody1: "・シングル揃い時のキャラ振り分けに設定差あり",
                            textBody2: "・設定4は次元が別格、設定5は五エ門が別格といった特徴あり",
                            textBody3: "・不二子は設定3以上が期待でき、特に6が別格といった特徴あり",
                            textBody4: "・高設定ほどデフォルトのルパン比率が低い。設定1,2はルパン以外は20回に1回程度。設定6は5〜6回に1回程度でルパン以外が選ばれる",
//                            image1: Image("lupinSingleChara"),
//                            image2: Image("lupinSingleCharaRatio")
                            tableView: AnyView(lupinTableChara())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(lupinView95Ci(lupin: lupin, selection: 6)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("シングル揃い ボーナスキャラ種類")
            }
//            .popoverTip(tipVer180LupinSingleCharaRatioAdd())
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ルパン3世 大航海者の秘宝",
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
        .navigationTitle("初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $lupin.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: lupin.resetHistory)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////////
// ビュー：データインプット画面
// ///////////////////////////
struct lupinSubViewDataInput: View {
    @ObservedObject var lupin: Lupin
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $lupin.inputGame)
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
                        selected: $lupin.selectedBonus,
                        selectList: lupin.selectListBonus
                    )
                    .popoverTip(tipLupinCirclePickerBonus())
                    // 当選契機
                    unitPickerCircleString(
                        title: "当選契機",
                        selected: $lupin.selectedTriger,
                        selectList: lupin.selectListTrigger
                    )
//                    .popoverTip(tipLupinCirclePickerTrigger())
                }
                // サークルピッカー横並び ２段目
                HStack {
                    // AT当否
                    if lupin.selectedBonus == lupin.selectListBonus[0] {
                        // ダブル揃い用の選択肢
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $lupin.selectedAtHit,
                            selectList: lupin.selectListAtHitDouble,
                            pickerHeight: 120
                        )
                    } else {
                        // シングル揃い用の選択肢
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $lupin.selectedAtHit,
                            selectList: lupin.selectListAtHitSingle,
                            pickerHeight: 120
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
                        lupin.addDataHistory()
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

// /////////////////////
// Tip：ボーナス種類選択肢の説明
// /////////////////////
struct tipLupinCirclePickerBonus: Tip {
    var title: Text {
        Text("ボーナス種類")
    }
    
    var message: Text? {
        Text("SH：スーパーヒーロー、ダブル揃い\nキャラ名：シングル揃い")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// /////////////////////
// Tip：当選契機選択肢の説明
// /////////////////////
struct tipLupinCirclePickerTrigger: Tip {
    var title: Text {
        Text("当選契機")
    }
    
    var message: Text? {
        Text("直撃は2種類から選択\n強チェからの直撃 → 強チェ直撃\nそれ以外のレア役直撃 → レア役直撃")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


#Preview {
    lupinViewHistory(lupin: Lupin())
}
