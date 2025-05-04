//
//  yoshimuneViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct yoshimuneTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("ボーナス初当りごとに入力して下さい。入力結果から\n・ボーナス初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct yoshimuneViewHistory: View {
    @ObservedObject var yoshimune: Yoshimune
//    @StateObject var yoshimune = Yoshimune()
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
//    @State var reloadTrigger: Bool = false
    
    var body: some View {
        List {
            // 履歴登録
            Section {
                // 実ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "実ゲーム数",
                    inputValue: $yoshimune.realGameInput,
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
                // 液晶ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $yoshimune.displayGameInput,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                // 当選契機
                unitPickerMenuString(
                    title: "当選契機",
                    selected: $yoshimune.selectedTrigger,
                    selectlist: yoshimune.selectListTrigger
                )
                // ボーナス種類
                unitPickerMenuString(
                    title: "ボーナス種類",
                    selected: $yoshimune.selectedBonusKind,
                    selectlist: yoshimune.selectListBonusKind
                )
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if yoshimune.minusCheck {
                        yoshimune.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
//                        self.reloadTrigger.toggle()
                    }
                    // 入っていなければデータ登録
                    else {
                        yoshimune.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
//                        self.reloadTrigger.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        if yoshimune.minusCheck == false {
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
            } footer: {
                Text("※ 小役解除＝レア役による直撃当選")
            }
            .popoverTip(yoshimuneTipHistoryInput())
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let realGameArray = decodeIntArray(from: yoshimune.realGameArrayData)
                    if realGameArray.count > 0 {
                        ForEach(realGameArray.indices, id: \.self) { index in
                            let viewIndex = realGameArray.count - index - 1
                            HStack {
                                // 実ゲーム数
                                if realGameArray.indices.contains(viewIndex) {
                                    Text("\(realGameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 液晶ゲーム数
                                let displayGameArray = decodeIntArray(from: yoshimune.displayGameArrayData)
                                if displayGameArray.indices.contains(viewIndex) {
                                    Text("\(displayGameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: yoshimune.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // ボーナス種類
                                let bonusKindArray = decodeStringArray(from: yoshimune.bonusKindArrayData)
                                if bonusKindArray.indices.contains(viewIndex) {
                                    Text("\(bonusKindArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
//                        .id(self.reloadTrigger)
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
                // //// 参考情報）モードについて
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・5つのモードで規定G数を管理。対象は液晶G数で実G数ではないため注意",
                            textBody2: "・ボーナス当選時に次回モードを抽選",
                            tableView: AnyView(yoshimuneTableMode())
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(
                    column1Bool: false,
                    column2: "実G数",
                    column3: "液晶G数",
                    column4: "当選契機",
                    column5: "種類"
                )
            }
            
            // //// 算出結果
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(yoshimune.realGameTotal)    G")
                        .foregroundStyle(Color.secondary)
                }
                // ボーナス確率
                unitResultRatioDenomination2Line(
                    title: "ボーナス初当り",
                    count: $yoshimune.bonusCountSum,
                    bigNumber: $yoshimune.realGameTotal,
                    numberofDicimal: 0
                )
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(yoshimuneTableFirstHit(yoshimune: yoshimune))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(yoshimuneView95Ci(yoshimune: yoshimune, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("集計結果")
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
        .navigationTitle("ボーナス初当り履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $yoshimune.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: yoshimune.resetHistory)
                }
            }
        }
    }
}

#Preview {
    yoshimuneViewHistory(yoshimune: Yoshimune())
}
