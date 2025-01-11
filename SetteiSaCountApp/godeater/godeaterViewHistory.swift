//
//  godeaterViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/09.
//

import SwiftUI

struct godeaterViewHistory: View {
    @ObservedObject var godeater = Godeater()
    @State var isShowAlert = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // //// 縦画面
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    Section {
                        // //// 履歴
                        ScrollView {
                            // //// 配列のデータ数が0以上なら履歴表示
                            let gameArray = decodeIntArray(from: godeater.gameArrayData)
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
                                        // 種類
                                        let bonusArray = decodeStringArray(from: godeater.bonusArrayData)
                                        if bonusArray.indices.contains(viewIndex) {
                                            Text("\(bonusArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 当選契機
                                        let triggerArray = decodeStringArray(from: godeater.triggerArrayData)
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
                        .frame(height: 250)
                        
                        // //// 登録、1行削除ボタン
                        HStack {
                            Spacer()
                            Button(action: {
                                if godeater.minusCheck {
                                    let gameArray = decodeIntArray(from: godeater.gameArrayData)
                                    if gameArray.count > 0 {
                                        godeater.removeLastHistory()
                                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                    }
                                } else {
                                    isShowDataInputView.toggle()
                                }
                            }, label: {
                                if godeater.minusCheck {
                                    Image(systemName: "minus")
                                } else {
                                    Image(systemName: "plus")
                                }
                            })
                            .buttonStyle(PlusDeleatButtonStyle(MinusBool: godeater.minusCheck))
                            .sheet(isPresented: $isShowDataInputView, content: {
                                godeaterSubViewDataInput(godeater: godeater)
                                    .presentationDetents([.medium])
                            })
                            Spacer()
                        }
                        // CZ結果表示
                        HStack {
                            // CZ初当たり回数
                            unitResultCount2Line(title: "CZ初当り回数", color: .grayBack, count: $godeater.czHitCount)
                            // CZ初当たり確率
                            unitResultRatioDenomination2Line(title: "CZ初当り確率", color: .grayBack, count: $godeater.czHitCount, bigNumber: $godeater.playGame, numberofDicimal: 0)
                        }
                        // AT結果表示
                        HStack {
                            // AT初当たり回数
                            unitResultCount2Line(title: "AT初当り回数", color: .grayBack, count: $godeater.atHitCount)
                            // AT初当たり確率
                            unitResultRatioDenomination2Line(title: "AT初当り確率", color: .grayBack, count: $godeater.atHitCount, bigNumber: $godeater.playGame, numberofDicimal: 0)
                        }
                        // //// 参考情報
                        unitLinkButton(title: "初当りについて", exview: AnyView (unitExView5body2image(title: "初当りについて", textBody1: "・CZ,ATの初当り確率に設定差", textBody2: "・C Zは基本レア役からの当選。弱レア役での当選により設定差があるのではとの噂も？", textBody3: "・ATのメイン契機は規定ゲーム数。規定ゲーム数は100,200,300,450,600,750,1000。", textBody4: "・200と450での当選率に特に設定差があるのではと言われている", textBody5: "・レア役でのAT直撃にも設定差があると言われている" ,image1: Image("godeaterHit"))))
                        // 通常滞在時のレア役からのCZ当選率
                        unitLinkButton(
                            title: "通常滞在時 レア役からのCZについて",
                            exview: AnyView(
                                unitExView5body2image(
                                    title: "通常滞在時 レア役からのCZ",
                                    textBody1: "・レア役成立時はCZ抽選。当選時はアラガミ防衛戦 or 殲滅モードへ突入",
                                    textBody2: "・通常滞在時のレア役からのCZ当選に設定差あり",
                                    image1Title: "[レア役からのCZ当選率]",
                                    image1: Image("godeaterNormalRareCz")
                                )
                            )
                        )
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(Ci95view: AnyView(godeaterView95Ci(selection: 1)))
                            .popoverTip(tipUnitButtonLink95Ci())
                    } header: {
                        unitHeaderHistoryColumns(column2: "ゲーム", column3: "種類", column4: "当選契機")
                    }
                    
                    // スクロールのための空スペース
                    unitClearScrollSection(spaceHeight: 250)
                }
                
                // //// 横画面
//                else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                else {
                    Section {
                        // //// 履歴
                        ScrollView {
                            // //// 配列のデータ数が0以上なら履歴表示
                            let gameArray = decodeIntArray(from: godeater.gameArrayData)
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
                                        // 種類
                                        let bonusArray = decodeStringArray(from: godeater.bonusArrayData)
                                        if bonusArray.indices.contains(viewIndex) {
                                            Text("\(bonusArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 当選契機
                                        let triggerArray = decodeStringArray(from: godeater.triggerArrayData)
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
                        
                        // //// 登録、1行削除ボタン
                        HStack {
                            Spacer()
                            Button(action: {
                                if godeater.minusCheck {
                                    let gameArray = decodeIntArray(from: godeater.gameArrayData)
                                    if gameArray.count > 0 {
                                        godeater.removeLastHistory()
                                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                    }
                                } else {
                                    isShowDataInputView.toggle()
                                }
                            }, label: {
                                if godeater.minusCheck {
                                    Image(systemName: "minus")
                                } else {
                                    Image(systemName: "plus")
                                }
                            })
                            .buttonStyle(PlusDeleatButtonStyle(MinusBool: godeater.minusCheck))
                            .sheet(isPresented: $isShowDataInputView, content: {
                                godeaterSubViewDataInput(godeater: godeater)
                                    .presentationDetents([.medium])
                            })
                            Spacer()
                        }
                        // CZ結果表示
                        HStack {
                            // CZ初当たり回数,AT結果表示
                            unitResultCount2Line(title: "CZ初当り回数", color: .grayBack, count: $godeater.czHitCount)
                            // CZ初当たり確率
                            unitResultRatioDenomination2Line(title: "CZ初当り確率", color: .grayBack, count: $godeater.czHitCount, bigNumber: $godeater.playGame, numberofDicimal: 0)
                            // AT初当たり回数
                            unitResultCount2Line(title: "AT初当り回数", color: .grayBack, count: $godeater.atHitCount)
                            // AT初当たり確率
                            unitResultRatioDenomination2Line(title: "AT初当り確率", color: .grayBack, count: $godeater.atHitCount, bigNumber: $godeater.playGame, numberofDicimal: 0)
                        }
                        // //// 参考情報
                        unitLinkButton(title: "初当りについて", exview: AnyView (unitExView5body2image(title: "初当りについて", textBody1: "・CZ,ATの初当り確率に設定差", textBody2: "・C Zは基本レア役からの当選。弱レア役での当選により設定差があるのではとの噂も？", textBody3: "・ATのメイン契機は規定ゲーム数。規定ゲーム数は100,200,300,450,600,750,1000。", textBody4: "・200と450での当選率に特に設定差があるのではと言われている", textBody5: "・レア役でのAT直撃にも設定差があると言われている" ,image1: Image("godeaterHit"))))
                        // //// 95%信頼区間グラフへのリンク
                        unitNaviLink95Ci(Ci95view: AnyView(godeaterView95Ci(selection: 1)))
                            .popoverTip(tipUnitButtonLink95Ci())
                    } header: {
                        unitHeaderHistoryColumns(column2: "ゲーム", column3: "種類", column4: "当選契機")
                    }
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
            .navigationTitle("AT,CZ 当選履歴")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $godeater.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetHistory)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("AT,CZ 当選履歴")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $godeater.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetHistory)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}


// //////////////////////////
// ビュー：データインプット画面
// //////////////////////////
struct godeaterSubViewDataInput: View {
    @ObservedObject var godeater: Godeater
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $godeater.inputGame)
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
                    unitPickerCircleString(title: "種類", selected: $godeater.selectedBonus, selectList: godeater.selectListBonus)
                    if godeater.selectedBonus == "AT" {
                        unitPickerCircleString(title: "当選契機", selected: $godeater.selectedAtTrigger, selectList: godeater.selectListAtTrigger)
                    } else if godeater.selectedBonus == "CZ" {
                        unitPickerCircleString(title: "当選契機", selected: $godeater.selectedCzTrigger, selectList: godeater.selectListCzTrigger)
                    } else {
                        unitPickerCircleString(title: "", selected: $godeater.selectedNowTrigger, selectList: godeater.selectListNowTrigger)
                    }
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        if godeater.selectedBonus == "AT" {
                            godeater.addDataHistoryAT()
                        } else if godeater.selectedBonus == "CZ" {
                            godeater.addDataHistoryCZ()
                        } else {
                            godeater.addDataHistoryNow()
                        }
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
    godeaterViewHistory()
}
