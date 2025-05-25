//
//  mt5ViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/20.
//

import SwiftUI


// ////////////////////////
// ビュー：メインビュー
// ////////////////////////
struct mt5ViewHistory: View {
//    @ObservedObject var mt5 = Mt5()
    @ObservedObject var mt5: Mt5
    @State var isShowAlert = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var scrollViewHeight = 300.0
    
    var body: some View {
        //        NavigationView {
        List {
            // 周期履歴表示
            Section {
                ScrollView {
                    let shukiArray = decodeStringArray(from: mt5.mt5ShukiArrayData)
                    // //// 配列が0以上なら履歴表示
                    if shukiArray.count > 0 {
                        ForEach(shukiArray.indices, id: \.self) { index in
                            let viewIndex = shukiArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // 周期
                                if shukiArray.indices.contains(viewIndex) {
                                    Text("\(shukiArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // Pt
                                let ptArray = decodeStringArray(from: mt5.mt5PtArrayData)
                                if ptArray.indices.contains(viewIndex) {
                                    Text("\(ptArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: mt5.mt5TriggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    if triggerArray[viewIndex].contains("直撃"){
                                        Text("\(triggerArray[viewIndex])")
                                            .font(.footnote)
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        Text("\(triggerArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                // 結果
                                let resultArray = decodeStringArray(from: mt5.mt5ResultArrayData)
                                if resultArray.indices.contains(viewIndex) {
                                    Text("\(resultArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
                        
                    }
                    // //// 配列が0なら履歴なし表示
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
                        if mt5.minusCheck {
                            let shukiArray = decodeStringArray(from: mt5.mt5ShukiArrayData)
                            if shukiArray.count > 0 {
                                mt5.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    }, label: {
                        if mt5.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    })
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: mt5.minusCheck))
                    .sheet(isPresented: $isShowDataInputView, content: {
                        mt5HistoryDataInputView(mt5: mt5)
                        //                                .presentationDetents([.medium])
                    })
                    Spacer()
                }
                
                // 参考情報へのリンク
                unitLinkButton(title: "周期、モードについて", exview: AnyView(mt5ExViewMode()))
            } header: {
                unitHeaderHistoryColumns(column2: "周期", column3: "Pt", column4: "当選契機", column5: "結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
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
            // 向きに応じてビュー高さを設定
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = 150
            } else {
                self.scrollViewHeight = 300
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
                // 向きに応じてビュー高さを設定
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = 150
                } else {
                    self.scrollViewHeight = 300
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("周期履歴")
        .navigationBarTitleDisplayMode(.inline)
        
        // //// ツールバーボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスボタン
                    unitButtonMinusCheck(minusCheck:$mt5.minusCheck)
                    // データリセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.historyReset, message: "このページのデータをリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
        //        }
        //        .navigationTitle("周期履歴")
        //        .navigationBarTitleDisplayMode(.inline)
        //
        //        // //// ツールバーボタン
        //        .toolbar {
        //            ToolbarItem(placement: .automatic) {
        //                HStack {
        //                    // マイナスボタン
        //                    unitButtonMinusCheck(minusCheck:$mt5.minusCheck)
        //                    // データリセットボタン
        //                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.historyReset, message: "このページのデータをリセットします")
        //                }
        //            }
        //        }
    }
}


// //////////////////////////
// ビュー：データインプット用画面
// //////////////////////////
struct mt5HistoryDataInputView: View {
    @ObservedObject var mt5: Mt5
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // //// 周期とPtのサークルピッカー
                HStack {
                    unitPickerCircleString(title: "周期", selected: $mt5.selectedShuki, selectList: mt5.selectListShuki)
                    unitPickerCircleString(title: "Pt", selected: $mt5.selectedPt, selectList: mt5.selectListPt)
                }
                // //// 当選契機と結果のサークルピッカー
                HStack {
                    unitPickerCircleString(title: "当選契機", selected: $mt5.selectedTrigger, selectList: mt5.selectListTrigger)
                    unitPickerCircleString(title: "結果", selected: $mt5.selectedResult, selectList: mt5.selectListResult)
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        mt5.addDatatoHistory()
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
//        .navigationTitle("履歴登録")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                Button(action: {
//                    dismiss()
//                }, label: {
//                    Text("閉じる")
//                        .fontWeight(.bold)
//                })
//            }
//        }
    }
}


// //////////////////////////
// ビュー：参考情報　初当たり、モードについて
// //////////////////////////
struct mt5ExViewMode: View {
    var body: some View {
        unitExView5body2image(title: "周期・モードについて", textBody1: "・高設定は3周期以上ハマりにくい。低設定は5,6周期に簡単にいく", textBody2: "・高設定ほど222ptが選ばれやすい。666ptが選ばれるとマイナスポイント", textBody3: "・弱レア役での直撃は設定4以上確定。直撃時は大体バイブなど、かなり強い演出が伴う", textBody4: "・モードB以上の示唆は300Gくらい回せば結構出る。出なければAの可能性高い", textBody5: "・通常のモードはA・B・天国の３種類", image1: Image("mt5Mode"), image2: Image("mt5ModeEnshutu"))
    }
}


#Preview {
    mt5ViewHistory(mt5: Mt5())
}
