//
//  symphoViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/15.
//

import SwiftUI

struct symphoViewHistory: View {
//    @ObservedObject var sympho = Symphogear()
    @ObservedObject var sympho: Symphogear
    @State var isShowAlert = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 230.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 230.0
    
    
    var body: some View {
        //        NavigationView {
        List {
            // //// 履歴
            Section {
                ScrollView {
                    // //// 配列のデータが0以上なら履歴表示
                    let gameArray = decodeIntArray(from: sympho.gameArrayData)
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
                                let bonusArray = decodeStringArray(from: sympho.bonusArrayData)
                                if bonusArray.indices.contains(viewIndex) {
                                    Text("\(bonusArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: sympho.triggerArrayData)
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
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        if sympho.minusCheck {
                            let gameArray = decodeIntArray(from: sympho.gameArrayData)
                            if gameArray.count > 0 {
                                sympho.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    }, label: {
                        if sympho.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    })
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: sympho.minusCheck))
                    .sheet(isPresented: $isShowDataInputView, content: {
                        symphoSubViewDataInput(sympho: sympho)
                            .presentationDetents([.medium])
                    })
                    Spacer()
                }
                // //// 結果
                // AT初当り
                HStack {
                    unitResultCount2Line(title: "AT初当り回数", color: .grayBack, count: $sympho.atCount)
                    unitResultRatioDenomination2Line(title: "AT初当り確率", color: .grayBack, count: $sympho.atCount, bigNumber: $sympho.playGame, numberofDicimal: 0)
                }
                // 最終決戦
                HStack {
                    unitResultCount2Line(title: "最終決戦 回数", color: .grayBack, count: $sympho.czSaishuCount)
                    unitResultRatioDenomination2Line(title: "最終決戦 確率", color: .grayBack, count: $sympho.czSaishuCount, bigNumber: $sympho.playGame, numberofDicimal: 0)
                }
                // 参考情報
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・通常時のモードは3種類。主にAT終了時に移行。",
                            textBody2: "・高設定ほど天国移行、天国ループ率が優遇されているらしい。下記設定1の数値以上に天国が確認できればチャンス",
                            textBody3: "・ATでの獲得枚数が100枚以下の場合は前回のモード不問で天国移行が優遇されるため勘違いしないよう注意",
//                            image1: Image("symphoMode"),
//                            image2: Image("symphoModeChange")
                            tableView: AnyView(symphoTableMode())
                        )
                    )
                )
                unitLinkButton(
                    title: "AT,最終決戦 初当りについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "AT,最終決戦初当りについて",
                            textBody1: "・AT初当り確率に設定差",
                            textBody2: "・特に高確中チェリーでの当選に設定差あり。チェリーからの当選が多いほど良挙動。",
                            textBody3: "・小役3連(リプレイ除く)で音符が降ってくる演出が出ることがあり、内部的にギアフラグモード移行の可能性あるのではとの噂あり。ギアフラグモードによってギアフラグ時の当選確率が変わる。高設定ほどギアフラグモードが良挙動するとの噂あり",
                            textBody4: "・CZ 最終決戦の出現率に設定差あり。複数回確認でければ大チャンスか",
//                            image1: Image("symphoAtHit"),
//                            image2: Image("symphoCherryHit")
                            tableView: AnyView(symphoTableFirstHit())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(symphoView95Ci(sympho: sympho, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                unitHeaderHistoryColumns(column2: "ゲーム数", column3: "種類", column4: "当選契機")
            }
//            unitClearScrollSection(spaceHeight: 250)
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シンフォギア 正義の歌",
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
        .navigationTitle("AT初当り履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $sympho.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: sympho.resetHistory)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// ビュー：データインプット画面
// /////////////////////////
struct symphoSubViewDataInput: View {
    @ObservedObject var sympho: Symphogear
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $sympho.inputGame)
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
                // サークルピッカー横並び
                HStack {
                    unitPickerCircleString(title: "種類", selected: $sympho.selectedBonus, selectList: sympho.selectListBonus)
                    // //// AT時の表示
                    if sympho.selectedBonus == "AT" {
                        unitPickerCircleString(title: "当選契機", selected: $sympho.selectedAtTrigger, selectList: sympho.selectListAtTrigger)
                    }
                    // //// 現在時の表示
                    else {
                        unitPickerCircleString(title: "当選契機", selected: $sympho.selectedCurrentTrigger, selectList: sympho.selectListCurrentTrigger)
                    }
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        if sympho.selectedBonus == "AT" {
                            sympho.addDataHistoryAt()
                        } else {
                            sympho.addDataHistoryCurrent()
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
    symphoViewHistory(sympho: Symphogear())
}
