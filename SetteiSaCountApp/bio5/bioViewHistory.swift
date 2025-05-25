//
//  bioViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct bioTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ、AT直撃当選ごとに入力して下さい。入力結果から\n・CZ初当り確率\n・AT初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct bioViewHistory: View {
//    @ObservedObject var bio = Bio()
    @ObservedObject var bio: Bio
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
    let segmentList: [String] = [
        "CZ",
        "AT直撃"
    ]
    @State var selectedSegment: String = "CZ"
    
    var body: some View {
        List {
            // 履歴登録
            Section {
                // 登録種類の選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "実ゲーム数",
                    inputValue: $bio.inputGame,
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
                // //// CZ
                if self.selectedSegment == self.segmentList[0] {
                    unitPickerMenuString(
                        title: "CZ種類",
                        selected: $bio.selectedCzKind,
                        selectlist: bio.selectListCzKind
                    )
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $bio.selectedAtHit,
                        selectlist: bio.selectListAtHit
                    )
                }
                // //// AT直撃
                else {
                    HStack {
                        Text("種類")
                        Spacer()
                        Text("AT直撃")
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
                    if bio.minusCheck {
                        bio.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        // //// CZ
                        if self.selectedSegment == self.segmentList[0] {
                            bio.addHistoryCz()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // //// AT直撃
                        else {
                            bio.addHistoryAt()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if bio.minusCheck == false {
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
            .popoverTip(bioTipHistoryInput())
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: bio.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            let atHitArray = decodeStringArray(from: bio.atHitArrayData)
                            HStack {
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    // AT当選の場合は黒字で表示
                                    if atHitArray.indices.contains(viewIndex) && atHitArray[viewIndex] == bio.selectListAtHit[0] {
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
                                let kindArray = decodeStringArray(from: bio.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    if kindArray[viewIndex] == bio.selectListCzKind[0] {
                                        Text("PZ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else if kindArray[viewIndex] == bio.selectListCzKind[1] {
                                        Text("WZ")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        Text(kindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
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
                    Text("\(bio.playGameSum)    G")
                        .foregroundStyle(Color.secondary)
                }
                // 確率横並び
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ合算",
                        count: $bio.czCount,
                        bigNumber: $bio.playGameSum,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $bio.atCount,
                        bigNumber: $bio.playGameSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(bioSubViewTableFirstHit(bio: bio))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(bioView95Ci(bio: bio, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("確率集計")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
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
        .navigationTitle("CZ,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $bio.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: bio.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    bioViewHistory(bio: Bio())
}
