//
//  hokutoViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/01.
//

import SwiftUI

struct hokutoViewHistory: View {
    @ObservedObject var hokuto = Hokuto()
    @State var isShowAlert = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    
    var body: some View {
//        NavigationView {
            List {
                // //// 履歴
                Section {
                    // ////履歴表示
                    // //// 縦画面
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        ScrollView {
                            // //// 配列のデータ数が0以上なら履歴表示
                            let gameArray = decodeIntArray(from: hokuto.gameArrayData)
                            if gameArray.count > 0 {
                                ForEach(gameArray.indices, id: \.self) { index in
                                    let viewIndex = gameArray.count - index - 1
                                    HStack {
                                        // 回数
                                        Text("\(viewIndex+1)")
                                            .frame(width: 40.0)
                                        // ゲーム数
                                        if gameArray.indices.contains(viewIndex) {
                                            Text("\(gameArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // モード
                                        let modeArray = decodeStringArray(from: hokuto.modeArrayData)
                                        if modeArray.indices.contains(viewIndex) {
                                            Text("\(modeArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 契機
                                        let triggerArray = decodeStringArray(from: hokuto.triggerArrayData)
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
                        .frame(height: 300)
                    }
                    // //// 横画面
//                    else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    else {
                        ScrollView {
                            // //// 配列のデータ数が0以上なら履歴表示
                            let gameArray = decodeIntArray(from: hokuto.gameArrayData)
                            if gameArray.count > 0 {
                                ForEach(gameArray.indices, id: \.self) { index in
                                    let viewIndex = gameArray.count - index - 1
                                    HStack {
                                        // 回数
                                        Text("\(viewIndex+1)")
                                            .frame(width: 40.0)
                                        // ゲーム数
                                        if gameArray.indices.contains(viewIndex) {
                                            Text("\(gameArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // モード
                                        let modeArray = decodeStringArray(from: hokuto.modeArrayData)
                                        if modeArray.indices.contains(viewIndex) {
                                            Text("\(modeArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 契機
                                        let triggerArray = decodeStringArray(from: hokuto.triggerArrayData)
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
                        .frame(height: 150)
                    }
                    
                    // //// 登録、1行削除ボタン
                    HStack {
                        Spacer()
                        // ボタン
                        Button(action: {
                            if hokuto.minusCheck {
                                let gameArray = decodeIntArray(from: hokuto.gameArrayData)
                                if gameArray.count > 0 {
                                    hokuto.removeLastHistory()
                                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                }
                            } else {
                                isShowDataInputView.toggle()
                            }
                        }, label: {
                            if hokuto.minusCheck {
                                Image(systemName: "minus")
                            } else {
                                Image(systemName: "plus")
                            }
                        })
                        .buttonStyle(PlusDeleatButtonStyle(MinusBool: hokuto.minusCheck))
                        .sheet(isPresented: $isShowDataInputView, content: {
                            hokutoSubViewDataInput(hokuto: hokuto)
                                .presentationDetents([.medium])
                        })
                        Spacer()
                    }
                    // //// 結果表示
                    HStack {
                        // 初当たり回数
                        unitResultCount2Line(title: "初当たり回数", color: .grayBack, count: $hokuto.bbHitCount)
                        // 初当たり確率
                        unitResultRatioDenomination2Line(title: "初当たり確率", color: .grayBack, count: $hokuto.bbHitCount, bigNumber: $hokuto.bbGameSum, numberofDicimal: 0)
                    }
                    // //// 参考情報のリンク
                    unitLinkButton(title: "バトルボーナス初当たりについて", exview: AnyView(unitExView5body2image(title: "BB初当たり", textBody1: "・初当たり確率に設定差", textBody2: "・天国中の弱スイカ、角チェでの当選に設定差", textBody3: "弱レア役でのモード移行にも設定差", textBody4: "・天井短縮や謎当たりにも大きな設定差があるらしい。800仮天井のヒット率は設定6で3割くらい、設定1で1割未満くらいとの噂も", image1: Image("hokutoBbHit"))))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(hokutoView95Ci(selection: 2)))
                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    unitHeaderHistoryColumns(column2: "ゲーム", column3: "モード", column4: "当選契機")
                }
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 250)
                } else {
                    
                }
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
                // デバイスの向きの変更を監視する
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    self.orientation = UIDevice.current.orientation
                    // 向きがフラットでなければlastOrientationの値を更新
                    if self.orientation.isFlat {
                        
                    }
                    else {
                        self.lastOrientation = self.orientation
                    }
                }
            }
            .onDisappear {
                // ビューが非表示になるときに監視を解除
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .navigationTitle("BB初当たり履歴")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $hokuto.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetHistory)
                    }
                }
            }
//        }
//        .navigationTitle("BB初当たり履歴")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $hokuto.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetHistory)
//                }
//            }
//        }
    }
}


// ///////////////////////
// ビュー：データインプット画面
// ///////////////////////
struct hokutoSubViewDataInput: View {
    @ObservedObject var hokuto: Hokuto
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $hokuto.inputGame)
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
                // //// サークルピッカー横並び
                HStack {
                    unitPickerCircleString(title: "モード", selected: $hokuto.selectedMode, selectList: hokuto.selectListMode)
                    unitPickerCircleString(title: "当選契機", selected: $hokuto.selectedTrigger, selectList: hokuto.selectListTrigger)
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        hokuto.addDataHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        dismiss()
                    }, label: {
                        Text("登録")
                            .fontWeight(.bold)
                    })
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
    hokutoViewHistory()
}
