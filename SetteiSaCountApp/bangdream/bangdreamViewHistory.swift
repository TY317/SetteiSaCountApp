//
//  bangdreamViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/07.
//

import SwiftUI

struct bangdreamViewHistory: View {
//    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdream: Bangdream
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 50.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 50.0
    
    var body: some View {
        List {
            // //// 履歴
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let cycleArray = decodeStringArray(from: bangdream.cycleArrayData)
                    if cycleArray.count > 0 {
                        ForEach(cycleArray.indices, id: \.self) { index in
                            let viewIndex = cycleArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // 当選周期
                                if cycleArray.indices.contains(viewIndex) {
                                    Text("\(cycleArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: bangdream.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
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
                        if bangdream.minusCheck {
                            let cycleArray = decodeStringArray(from: bangdream.cycleArrayData)
                            if cycleArray.count > 0 {
                                bangdream.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if bangdream.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: bangdream.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        bangdreamSubViewDataInput(bangdream: bangdream)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ST初当たり確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ST初当たり確率",
                            textBody1: "・STの初当たり確率に設定差あり",
                            textBody2: "・現在値は打-WINで確認可能",
                            textBody3: "・直撃、ポイント特化ゾーン関連の確率には設定差ないとのことなので、高設定ほど早い周期で当たると考えられる",
                            textBody4: "・1周期の平均は62G（前兆含まず）なので、設定1で平均5.3周期、設定6で平均4.4周期程度になる計算",
//                            image1: Image("bangdreamStHit")
                            tableView: AnyView(bangdreamTableFirstHit())
                        )
                    )
                )
                
            } header: {
                unitHeaderHistoryColumns(column2: "当選周期", column3: "当選契機")
            }
            
            // //// 周期当選確率
            Section {
                HStack {
                    // 周期到達回数
                    unitResultCount2Line(title: "周期到達回数", color: .grayBack, count: $bangdream.storyCountSum)
                    // 周期当選確率
                    unitResultRatioPercent2Line(title: "周期当選確率", color: .grayBack, count: $bangdream.cycleHitCountSum, bigNumber: $bangdream.storyCountSum, numberofDicimal: 0)
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "周期到達時の当選確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "周期到達時の当選確率",
                            textBody1: "・ALL設定バトル動画で「周期毎のストーリーステージ期待度」に設定差があると発表",
                            textBody2: "・赤ディスクや黒ディスクも含めた当選率なのか？詳細の説明はなし",
                            textBody3: "・このアプリではひとまず 周期での当選回数 ÷ ストーリーステージ到達回数を参考として表示します",
//                            image1: Image("bangdreamCycleHitRatio")
                            tableView: AnyView(bangdreamTableCycleRatio())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(bangdreamView95Ci(bangdream: bangdream, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("周期当選確率")
            }
            
            // //// モードの概要と示唆の情報
            Section {
                // モード概要
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・通常時は6つのモードで周期天井を管理",
                            textBody2: "・設定変更時やSTやれなかった時に天井短縮あり",
//                            image1: Image("bangdreamMode")
                            tableView: AnyView(bangdreamTableMode())
                        )
                    )
                )
                // 1周期目のバンドによる示唆
                unitLinkButton(
                    title: "示唆：1周期目のバンド",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "1周期目のバンドによる示唆",
                            textBody1: "・ST終了後の1周期目に選ばれるバンドでモードを示唆",
//                            image1: Image("bangdreamModeBand")
                            tableView: AnyView(bangdreamTableCycle1Band())
                        )
                    )
                )
                // 同一バンド連続によるしさ
                unitLinkButton(title: "示唆：同一バンド連続", exview: AnyView(unitExView5body2image(title: "同一バンド連続による示唆", textBody1: "・バンドの移行順（セットリスト）によってモードを示唆", textBody2: "・基本は決まった順番で移行していくが、同一バンドが連続するとモードの示唆となる", image1: Image("bangdreamSetlist"))))
                // セリフ
                unitLinkButton(
                    title: "示唆：ST・前兆後のセリフ",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ST・前兆後のセリフによる示唆",
                            textBody1: "・ST終了後1G目、通常時の前兆終了1G目にPUSHボタンを押すとセリフが発生",
                            textBody2: "・セリフの内容で残り周期数を示唆",
//                            image1: Image("bangdreamVoice")
                            tableView: AnyView(bangdreamTableVoice())
                        )
                    )
                )
            } header: {
                Text("通常時のモード")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バンドリ!",
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
        .navigationTitle("ST初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $bangdream.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: bangdream.resetHistory)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// データインプットビュー
// /////////////////////////
struct bangdreamSubViewDataInput: View {
    @ObservedObject var bangdream: Bangdream
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            List {
                // //// サークルピッカー横並び
                HStack {
                    // 当選周期
                    unitPickerCircleString(title: "当選周期", selected: $bangdream.selectedCycle, selectList: bangdream.selectListCycle)
                    // 当選契機
                    unitPickerCircleString(title: "当選契機", selected: $bangdream.selectedTrigger, selectList: bangdream.selectListTrigger)
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        bangdream.addDataHistory()
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

#Preview {
    bangdreamViewHistory(bangdream: Bangdream())
}
