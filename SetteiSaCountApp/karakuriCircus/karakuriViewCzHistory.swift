//
//  karakuriViewCzHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/29.
//

import SwiftUI

struct karakuriViewCzHistory: View {
//    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuri: Karakuri
    @State var isShowAlert = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    
    var body: some View {
        List {
            Section {
                ScrollView {
                    // //// 配列のデータが0以上なら履歴表示
                    let zoneArray = decodeStringArray(from: karakuri.zoneArrayData)
                    if zoneArray.count > 0 {
                        ForEach(zoneArray.indices, id: \.self) { index in
                            let viewIndex = zoneArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // ゲーム数ゾーン
                                if zoneArray.indices.contains(viewIndex) {
                                    Text(zoneArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: karakuri.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text(triggerArray[viewIndex])
                                        .font(.footnote)
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 終了画面
                                let endScreenArray = decodeStringArray(from: karakuri.screenArrayData)
                                if endScreenArray.indices.contains(viewIndex) {
                                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                                        Image(endScreenArray[viewIndex])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 70)
                                            .frame(maxWidth: .infinity)
                                    }
                                    else {
                                        Image(endScreenArray[viewIndex])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                    }
                                } else {
                                    Text("-")
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
                        if karakuri.minusCheck {
                            let zoneArray = decodeStringArray(from: karakuri.zoneArrayData)
                            if zoneArray.count > 0 {
                                karakuri.removeLastHistoryCz()
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if karakuri.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: karakuri.minusCheck))
                    .sheet(isPresented: $isShowDataInputView, content: {
                        karakuriSubViewDataInput(karakuri: karakuri)
//                            .presentationDetents([.medium])
                    })
                    Spacer()
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・通常時は4つのモードで管理",
                            textBody2: "・設定6はモードAと天国が4割弱ずつで残りがB,Cといった内訳らしい",
                            textBody3: "・設定6はモードAでも200Gが非常に強いらしい。天国割合も高いため、400のゾーンまでに当選する割合は70％程度あるらしい。1000Gを超える割合は5％程度らしいので、1000を超えたら黄色信号か。",
//                            image1: Image("karakuriMode")
                            tableView: AnyView(karakuriTableMode())
                        )
                    )
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "スポットライト演出の示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "スポットライト演出の示唆",
                            textBody1: "・からくりエピソード失敗後、CZ失敗後、AT終了後の画面転換時に発生するスポットライト演出の種類によって次の規定G数を示唆",
//                            image1: Image("karakuriSpotLight")
                            tableView: AnyView(karakuriTableSpotLight())
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(column2: "ゾーン", column3: "当選契機", column4: "示唆画面")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "からくりサーカス",
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
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
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
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("CZ初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetHistoryCz)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

// ///////////////////////////////
// ビュー：データインプットビュー
// ///////////////////////////////
struct karakuriSubViewDataInput: View {
    @ObservedObject var karakuri: Karakuri
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            List {
                // //// サークルピッカー横並び
                HStack {
                    // ゾーン
                    unitPickerCircleString(title: "液晶ゲーム数ゾーン", selected: $karakuri.selectedZone, selectList: karakuri.selectListZone)
                    // 当選契機
                    unitPickerCircleString(title: "当選契機", selected: $karakuri.selectedTrigger, selectList: karakuri.selectListTrigger)
                }
                // 示唆画面選択
                ScrollView(.horizontal) {
                    HStack {
                        // AT当選
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[10]), keyword: karakuri.selectListScreen[10], currentKeyword: $karakuri.selectedScreen)
                        // 鳴海単体
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[0]), keyword: karakuri.selectListScreen[0], currentKeyword: $karakuri.selectedScreen)
                            .popoverTip(tipUnitButtonScreenChoiceForDataInput())
                        // 勝単体
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[1]), keyword: karakuri.selectListScreen[1], currentKeyword: $karakuri.selectedScreen)
                        // しろがね単体
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[2]), keyword: karakuri.selectListScreen[2], currentKeyword: $karakuri.selectedScreen)
                        // 3人
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[3]), keyword: karakuri.selectListScreen[3], currentKeyword: $karakuri.selectedScreen)
                        // コロンビーヌ
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[4]), keyword: karakuri.selectListScreen[4], currentKeyword: $karakuri.selectedScreen)
                        // フェイスレス
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[5]), keyword: karakuri.selectListScreen[5], currentKeyword: $karakuri.selectedScreen)
                        // 銀色の女神
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[6]), keyword: karakuri.selectListScreen[6], currentKeyword: $karakuri.selectedScreen)
                        // リーゼ
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[7]), keyword: karakuri.selectListScreen[7], currentKeyword: $karakuri.selectedScreen)
                        // 腕
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[8]), keyword: karakuri.selectListScreen[8], currentKeyword: $karakuri.selectedScreen)
                        // ピエロ
                        unitButtonScreenChoiceForDataInput(image: Image(karakuri.selectListScreen[9]), keyword: karakuri.selectListScreen[9], currentKeyword: $karakuri.selectedScreen)
                    }
                }
                .frame(height: 120)
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        karakuri.addDataHistoryCz()
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
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

#Preview {
    karakuriViewCzHistory(karakuri: Karakuri())
}
