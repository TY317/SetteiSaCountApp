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
//    @ObservedObject var ver350: Ver350
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
    @State var selectedItem: String = "100G"
    let itemList: [String] = ["100G","200G","300G","400G","500G","600G","700G","800G","900G","1000G",]
    @EnvironmentObject var common: commonVar
    
    var body: some View {
//        TipView(dmc5TipHistoryInput())
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
                HStack {
                    Text("初当り登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "初当り登録",
                            textBody1: "ボーナス、ST直撃当選ごとに入力して下さい",
                            textBody2: "ゲーム数は液晶ゲーム数を入力して下さい",
                            textBody3: "入力結果から\n　・ボーナス初当り確率\n　・ST初当り確率\nを算出します",
                        )
                    }
                }
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
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・4つのモードで規定ゲーム数を管理")
                        }
                        .padding(.bottom)
                        Text("[ゾーンごとの期待度]")
                            .font(.title2)
                        HStack {
                            Text("ゾーン選択：")
                            Picker(selection: self.$selectedItem) {
                                ForEach(self.itemList, id: \.self) { item in
                                    Text(item)
                                }
                            } label: {
                                Text("ゾーン：\(self.selectedItem)")
                            }
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "通常A",
                                percentList: modeARatio(zone: self.selectedItem),
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "通常B",
                                percentList: modeBRatio(zone: self.selectedItem),
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "通常C",
                                percentList: modeCRatio(zone: self.selectedItem),
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "天国",
                                percentList: modeDRatio(zone: self.selectedItem),
                                numberofDicimal: 1,
                            )
//                            if self.selectedItem == self.itemList[0] {
//                                unitTablePercent(
//                                    columTitle: "天国",
//                                    percentList: [100],
//                                    lineList: [6],
//                                    colorList: [.white]
//                                )
//                            } else {
//                                unitTableString(
//                                    columTitle: "天国",
//                                    stringList: ["grayOut","grayOut","grayOut","grayOut","grayOut",]
//                                )
//                            }
                        }
                    }
                }
                .popoverTip(tipVer3110DmcMode())
//                unitLinkButton(
//                    title: "通常時のモードについて",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "通常時のモード",
//                            textBody1: "・4つのモードで規定ゲーム数を管理",
//                            textBody2: "・ゾーン外（100Gごと以外）のゲーム数でのボーナス当選は高設定の可能性がアップする",
//                            tableView: AnyView(dmc5TableMode())
//                        )
//                    )
//                )
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
//                .popoverTip(tipVer350Dmc5NazoCz())
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
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.dmc5MenuFirstHitBadge)
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
    
    func modeARatio(zone: String) -> [Double] {
        switch zone {
        case self.itemList[0]: return [35.0,35.2,35.3,39.4,39.9,41.8]
        case self.itemList[1]: return [35.0,35.2,35.3,39.4,39.9,41.8]
        case self.itemList[2]: return [0.9,0.9,0.9,1.8,1.9,2.3]
        case self.itemList[3]: return [0.9,0.9,1,2.2,2.4,3]
        case self.itemList[4]: return [15.6,15.8,15.9,20.7,21.3,23.4]
        case self.itemList[5]: return [24.1,24.3,24.4,28.5,29.1,30.9]
        case self.itemList[6]: return [0.9,0.9,0.9,1.7,1.8,2.1]
        case self.itemList[7]: return [0.9,0.9,0.9,1.7,1.8,2.1]
        case self.itemList[8]: return [0.9,0.9,0.9,1.7,1.8,2.1]
        case self.itemList[9]: return [100,100,100,100,100,100]
        default: return [0,0,0,0,0,0]
        }
    }
    func modeBRatio(zone: String) -> [Double] {
        switch zone {
        case self.itemList[0]: return [35,35.2,35.3,39.6,40.1,42]
        case self.itemList[1]: return [39.7,39.8,40,44.3,44.8,46.7]
        case self.itemList[2]: return [0.9,0.9,1,2.2,2.4,3]
        case self.itemList[3]: return [50.8,51,51.2,57.4,58.2,60.9]
        case self.itemList[4]: return [0.8,0.8,0.8,0.8,0.8,0.9]
        case self.itemList[5]: return [50.7,50.8,51,56.1,56.7,58.9]
        case self.itemList[6]: return [0.8,0.8,0.8,0.9,0.9,0.9,]
        case self.itemList[7]: return [0.9,1,1,2.6,2.8,3.5]
        case self.itemList[8]: return [100,100,100,100,100,100,]
        case self.itemList[9]: return [0,0,0,0,0,0,]
        default: return [0,0,0,0,0,0]
        }
    }
    func modeCRatio(zone: String) -> [Double] {
        switch zone {
        case self.itemList[0]: return [37.4,37.5,37.6,41.9,42.5,44.4]
        case self.itemList[1]: return [37.4,37.5,37.6,41.9,42.5,44.4]
        case self.itemList[2]: return [40.2,40.2,40.3,41.5,41.7,42.3]
        case self.itemList[3]: return [0.8,0.8,0.8,0.8,0.8,0.9]
        case self.itemList[4]: return [21.1,21.2,21.4,26.3,26.9,29]
        case self.itemList[5]: return [25.7,25.8,25.9,30.1,30.6,32.4]
        case self.itemList[6]: return [0.8,0.8,0.8,0.8,0.8,0.9]
        case self.itemList[7]: return [100,100,100,100,100,100,]
        case self.itemList[8]: return [0,0,0,0,0,0,]
        case self.itemList[9]: return [0,0,0,0,0,0,]
        default: return [0,0,0,0,0,0]
        }
    }
    func modeDRatio(zone: String) -> [Double] {
        switch zone {
        case self.itemList[0]: return [100,100,100,100,100,100,]
        case self.itemList[1]: return [0,0,0,0,0,0,]
        case self.itemList[2]: return [0,0,0,0,0,0,]
        case self.itemList[3]: return [0,0,0,0,0,0,]
        case self.itemList[4]: return [0,0,0,0,0,0,]
        case self.itemList[5]: return [0,0,0,0,0,0,]
        case self.itemList[6]: return [0,0,0,0,0,0,]
        case self.itemList[7]: return [0,0,0,0,0,0,]
        case self.itemList[8]: return [0,0,0,0,0,0,]
        case self.itemList[9]: return [0,0,0,0,0,0,]
        default: return [0,0,0,0,0,0]
        }
    }
}

#Preview {
    dmc5ViewFristHit(
        dmc5: Dmc5(),
    )
    .environmentObject(commonVar())
}
