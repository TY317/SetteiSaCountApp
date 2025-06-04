//
//  mhrViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/28.
//

import SwiftUI

struct mhrViewHistory: View {
//    @ObservedObject var mhr = Mhr()
    @ObservedObject var mhr: Mhr
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            // //// ライズゾーンカウント
            Section {
                unitCountButtonVerticalWithoutRatio(
                    title: "ライズゾーン初当り",
                    count: $mhr.riseZoneCount,
                    color: .personalSummerLightBlue,
                    minusBool: $mhr.minusCheck
                )
                // 参考情報リンク
                unitLinkButton(
                    title: "ライズゾーン実質初当り確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ライズゾーン実質初当り確率",
//                            image1: Image("mhrRiseZone")
                            tableView: AnyView(mhrTableRiseZone())
                        )
                    )
                )
            } header: {
                Text("ライズゾーン初当り回数")
            }
//            .popoverTip(tipVer180MhrRiseZoneCountAdd())
            
            // //// アイルーだるま落とし規定回数のカウント
            Section {
                HStack {
                    // 80回以下
                    unitCountButtonVerticalPercent(
                        title: "80回以下",
                        count: $mhr.airuCountUnder80,
                        color: .personalSummerLightRed,
                        bigNumber: $mhr.airuCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                    // 120回以上
                    unitCountButtonVerticalPercent(
                        title: "120回以上",
                        count: $mhr.airuCountOver120,
                        color: .personalSummerLightBlue,
                        bigNumber: $mhr.airuCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "規定リプレイ回数の振り分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定リプレイ回数振り分け",
                            textBody1: "・アイルーだるま落としまでの規定リプレイ回数振り分けに設定差あり",
                            textBody2: "・40,80回がより設定差大きいため、本アプリでは80回以下と120回以上の2種類に分けてカウントできるようにしました",
//                            image1: Image("mhrAiruSumRatio"),
//                            image2: Image("mhrAiruRatioDetail")
                            tableView: AnyView(mhrTableKiteiReplay())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 3)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("アイルーだるま落とし規定回数")
            }
//            .popoverTip(tipVer200MhrAiruAdd())
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: mhr.gameArrayData)
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
                                // 当選周期
                                let cycleArray = decodeStringArray(from: mhr.cycleArrayData)
                                if cycleArray.indices.contains(viewIndex) {
                                    Text("\(cycleArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: mhr.triggerArrayData)
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
                    Button {
                        if mhr.minusCheck {
                            let gameArray = decodeIntArray(from: mhr.gameArrayData)
                            if gameArray.count > 0 {
                                mhr.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if mhr.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: mhr.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        mhrSubViewDataInput(mhr: mhr)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "規定ポイントについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定ポイントについて",
                            textBody1: "・4種類のモードで規定カムラポイントを管理",
                            textBody2: "・クエスト当選を契機にモード移行。モードDへ到達するまで転落はない",
//                            image1: Image("mhrPtMode"),
//                            image2Title: "モードごとのゾーン期待度",
//                            image2: Image("mhrPtZone")
                            tableView: AnyView(mhrTableKiteiPt())
                        )
                    )
                )
                unitLinkButton(
                    title: "クエストテーブルについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "クエストテーブルについて",
                            textBody1: "・4種類のテーブルでクエスト（周期）の期待度を管理",
                            textBody2: "・テーブルはATを契機に再抽選。天国移行まで転落はない",
                            textBody3: "・天国中にCZや直撃でボーナス当選した場合、次回も天国濃厚となる",
//                            image1: Image("mhrTable"),
//                            image2Title: "テーブルごとの周期期待度",
//                            image2: Image("mhrTableZone")
                            tableView: AnyView(mhrTableQuestTable())
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(
                    column2: "実ゲーム数",
                    column3: "当選周期",
                    column4: "当選契機"
                )
            }
            
            // //// AT初当り
            Section {
                HStack {
                    // 通常ゲーム数
                    unitResultCount2Line(
                        title: "通常G数",
                        color: .grayBack,
                        count: $mhr.playGameSum,
                        spacerBool: false
                    )
                    // 初当り回数
                    unitResultCount2Line(
                        title: "AT回数",
                        count: $mhr.atHitCount,
                        spacerBool: false
                    )
                    // 初当り確率
                    unitResultRatioDenomination2Line(
                        title: "AT確率",
                        count: $mhr.atHitCount,
                        bigNumber: $mhr.playGameSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "AT初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "AT初当り確率",
//                            image1: Image("mhrAtHitRatio")
                            tableView: AnyView(mhrTableAtFirstHit())
                        )
                    )
                )
                // レア役からの直撃確率
                unitLinkButton(
                    title: "レア役からの直撃確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役からの直撃確率",
                            textBody1: "・レア役からの直撃確率に設定差あり",
                            textBody2: "・強レア役は現実的に起こりうる数値。複数回確認できれば高設定に期待してもいいかも",
//                            image1: Image("mhrRareHitRatio")
                            tableView: AnyView(mhrTableRareDirectHit())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("AT初当り")
            }
            
            // //// ライズゾーン初当り確率
            Section {
                // 確率表示
                unitResultRatioDenomination2Line(
                    title: "ライズゾーン確率",
                    count: $mhr.riseZoneCount,
                    bigNumber: $mhr.playGameSum,
                    numberofDicimal: 1
                )
                // 参考情報リンク
                unitLinkButton(
                    title: "ライズゾーン実質初当り確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ライズゾーン実質初当り確率",
//                            image1: Image("mhrRiseZone")
                            tableView: AnyView(mhrTableRizeZoneRatio())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 2)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ライズゾーン初当り確率")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンスターハンター ライズ",
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
        .navigationTitle("AT初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $mhr.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: mhr.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////////
// ビュー：データインプット画面
// ///////////////////////////
struct mhrSubViewDataInput: View {
    @ObservedObject var mhr: Mhr
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $mhr.inputGame)
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
                    // 当選周期
                    unitPickerCircleString(
                        title: "当選周期",
                        selected: $mhr.selectedCycle,
                        selectList: mhr.selectListCycle
                    )
                    // 当選契機
                    unitPickerCircleString(
                        title: "当選契機",
                        selected: $mhr.selectedTrigger,
                        selectList: mhr.selectListTrigger
                    )
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        mhr.addDataHistory()
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
    mhrViewHistory(mhr: Mhr())
}
