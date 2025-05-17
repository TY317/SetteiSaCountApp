//
//  gundamSeedViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct gundamSeedTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ、AT直撃当選ごとに入力して下さい。ゲーム数は液晶ゲーム数で入力して下さい。入力結果から\n・CZ初当り確率\n・AT初当り確率\n・ST終了後100G以内の当選率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

struct gundamSeedViewFirstHit: View {
    @ObservedObject var gundamSeed: GundamSeed
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
    //    let segmentList: [String] = [
    //        "CZ",
    //        "AT直撃"
    //    ]
    //    @State var selectedSegment: String = "CZ"
    
    var body: some View {
        TipView(gundamSeedTipHistoryInput())
        List {
            // //// 履歴登録
            Section {
                // 登録種類の選択
                Picker("", selection: $gundamSeed.selectedBonusKind) {
                    ForEach(gundamSeed.selectListBonusKind, id: \.self) { bonus in
                        Text(bonus)
                    }
                }
                .pickerStyle(.segmented)
                
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $gundamSeed.inputGame,
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
                
                // CZ
                if gundamSeed.selectedBonusKind == gundamSeed.selectListBonusKind[0] {
                    HStack {
                        Text("種類")
                        Spacer()
                        Text(gundamSeed.selectedBonusKind)
                            .foregroundStyle(Color.secondary)
                    }
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $gundamSeed.selectedAtHit,
                        selectlist: gundamSeed.selectListAtHit
                    )
                }
                // AT
                else {
                    HStack {
                        Text("種類")
                        Spacer()
                        Text(gundamSeed.selectedBonusKind)
                            .foregroundStyle(Color.secondary)
                    }
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
                    if gundamSeed.minusCheck {
                        gundamSeed.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        if gundamSeed.selectedBonusKind == gundamSeed.selectListBonusKind[1] {
                            gundamSeed.selectedAtHit = gundamSeed.selectListAtHit[0]
                        }
                        gundamSeed.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if gundamSeed.minusCheck == false {
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
                    let gameArray = decodeIntArray(from: gundamSeed.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            let atHitArray = decodeStringArray(from: gundamSeed.atHitArrayData)
                            HStack {
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    // AT当選の場合は黒字で表示
                                    if atHitArray.indices.contains(viewIndex) && atHitArray[viewIndex] == gundamSeed.selectListAtHit[0] {
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
                                let bonusKindArray = decodeStringArray(from: gundamSeed.bonusKindArrayData)
                                if bonusKindArray.indices.contains(viewIndex) {
                                        Text(bonusKindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
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
                    column2: "液晶G数",
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
                    Text("\(gundamSeed.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }
                // 確率横並び
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ合算",
                        count: $gundamSeed.czCount,
                        bigNumber: $gundamSeed.playGameSum,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $gundamSeed.atCount,
                        bigNumber: $gundamSeed.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // 100G以内の当選率
                VStack {
                    Text("[ST終了後99G以内の当選率]")
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        // 0〜49G
                        unitResultRatioPercent2Line(
                            title: "0〜49G",
                            count: $gundamSeed.under100Count49,
                            bigNumber: $gundamSeed.underOver100CountSum,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        // 0〜49G
                        unitResultRatioPercent2Line(
                            title: "50〜99G",
                            count: $gundamSeed.under100Count99,
                            bigNumber: $gundamSeed.underOver100CountSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 合算
                        unitResultRatioPercent2Line(
                            title: "合算",
                            count: $gundamSeed.under100CountSum,
                            bigNumber: $gundamSeed.underOver100CountSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(gundamSeedTableFirstHit(gundamSeed: gundamSeed))
                        )
                    )
                )
                // //// 参考情報）９９G以内の当選
                unitLinkButton(
                    title: "99G以内の当選率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "99G以内の当選率",
                            textBody1: "・リセット後、ST終了後99G以内のCZorボーナス当選率に設定差あり",
                            tableView: AnyView(gundamSeedTableUnder99Ratio(gundamSeed: gundamSeed))
                        )
                    )
                )
                
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(gundamSeedView95Ci(
                    gundamSeed: gundamSeed,
                    selection: 1
                )))
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
        .navigationTitle("CZ,AT 初当り履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $gundamSeed.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: gundamSeed.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    gundamSeedViewFirstHit(
        gundamSeed: GundamSeed()
    )
}
