//
//  mhrViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/28.
//

import SwiftUI

struct mhrViewHistory: View {
    @EnvironmentObject var common: commonVar
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
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var selectedMode: String = "モードA"
    let modeList: [String] = ["モードA","モードB","モードC","モードD",]
    @State var selectedTable: String = "テーブルA"
    let tableList: [String] = ["テーブルA","テーブルB","テーブルC","テーブルD",]
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
                            tableView: AnyView(mhrTableRizeZoneRatio())
                        )
                    )
                )
            } header: {
                Text("ライズゾーン初当り回数")
            }
            
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
                            tableView: AnyView(mhrTableKiteiReplay())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 3)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mhrViewBayes(
                        mhr: mhr,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("アイルーだるま落とし規定回数")
            }
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
                unitLinkButtonViewBuilder(sheetTitle: "規定ポイント") {
                    VStack(alignment: .center) {
                        VStack {
                            Text("・4種類のモードで規定カムラポイントを管理")
                            Text("・クエスト当選を契機にモード移行。モードDへ到達するまで転落はない")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        mhrTableKiteiPt()
                            .padding(.vertical)
                        Text("[滞在モードごとの移行率]")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Picker("", selection: self.$selectedMode) {
                            ForEach(self.modeList, id: \.self) { mode in
                                Text(mode)
                            }
                        }
                        .pickerStyle(.segmented)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            if self.selectedMode == self.modeList[0] {
                                unitTablePercent(
                                    columTitle: "モードAへ",
                                    percentList: [50,48.8,47.7,40.6,35.9,34.3]
                                )
                                unitTablePercent(
                                    columTitle: "モードBへ",
                                    percentList: [40.6],
                                    lineList: [6],
                                    colorList: [.white]
                                )
                                unitTablePercent(
                                    columTitle: "モードCへ",
                                    percentList: [6.3,7,7.8,14.1,18,18.8],
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "モードDへ",
                                    percentList: [3.1,3.5,3.9,4.7,5.5,6.3],
                                    numberofDicimal: 1,
                                )
                            } else if self.selectedMode == self.modeList[1] {
                                unitTablePercent(
                                    columTitle: "モードAへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "モードBへ",
                                    percentList: [50,49.6,49.2,47.7,44.5,43.8],
                                )
                                unitTablePercent(
                                    columTitle: "モードCへ",
                                    percentList: [43.8],
                                    lineList: [6],
                                    colorList: [.white],
                                )
                                unitTablePercent(
                                    columTitle: "モードDへ",
                                    percentList: [6.3,6.6,7,8.5,11.7,12.4],
                                    numberofDicimal: 1,
                                )
                            } else if self.selectedMode == self.modeList[2] {
                                unitTablePercent(
                                    columTitle: "モードAへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "モードBへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "モードCへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "モードDへ",
                                    percentList: [100],
                                    lineList: [6],
                                    colorList: [.white],
                                )
                            } else {
                                unitTablePercent(
                                    columTitle: "モードAへ",
                                    percentList: [50,46.5,43,35.9,32,30.4]
                                )
                                unitTablePercent(
                                    columTitle: "モードBへ",
                                    percentList: [34.4],
                                    lineList: [6],
                                    colorList: [.white]
                                )
                                unitTablePercent(
                                    columTitle: "モードCへ",
                                    percentList: [3.1,3.5,3.9,4.7,5.5,6.3],
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "モードDへ",
                                    percentList: [12.5,15.6,18.7,25,28.1,28.9],
                                    numberofDicimal: 0,
                                )
                            }
                        }
                    }
                }
//                .popoverTip(tipVer3110MhrMode())
//                unitLinkButton(
//                    title: "規定ポイントについて",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "規定ポイントについて",
//                            textBody1: "・4種類のモードで規定カムラポイントを管理",
//                            textBody2: "・クエスト当選を契機にモード移行。モードDへ到達するまで転落はない",
//                            tableView: AnyView(mhrTableKiteiPt())
//                        )
//                    )
//                )
                unitLinkButtonViewBuilder(sheetTitle: "クエストテーブル") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・4種類のテーブルでクエスト（周期）の期待度を管理")
                            Text("・テーブルはATを契機に再抽選。天国移行まで転落はない")
                            Text("・天国中にCZや直撃でボーナス当選した場合、次回も天国濃厚となる")
                        }
                        .padding(.bottom)
                        mhrTableQuestTable()
                            .padding(.bottom)
                        Text("[滞在テーブルごとの移行率]")
                            .font(.title2)
                        Picker("", selection: self.$selectedTable) {
                            ForEach(self.tableList, id: \.self) { table in
                                Text(table)
                            }
                        }
                        .pickerStyle(.segmented)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            if self.selectedTable == self.tableList[0] {
                                unitTablePercent(
                                    columTitle: "Aへ",
                                    percentList: [50,48.8,47.7,34,27.4,25]
                                )
                                unitTablePercent(
                                    columTitle: "Bへ",
                                    percentList: [22.7,23,23.4,23.8,24.2,25],
//                                    lineList: [6],
//                                    colorList: [.white]
                                )
                                unitTablePercent(
                                    columTitle: "Cへ",
                                    percentList: [7,7.4,7.8,18.8,24.2,25],
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "Dへ",
                                    percentList: [20.3,20.8,21.1,23.4,24.2,25],
//                                    numberofDicimal: 1,
                                )
                            } else if self.selectedTable == self.tableList[1] {
                                unitTablePercent(
                                    columTitle: "Aへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "Bへ",
                                    percentList: [50,49.2,48.4,39,35.2,33.6],
                                )
                                unitTablePercent(
                                    columTitle: "Cへ",
                                    percentList: [25,25.4,25.8,30.5,32.4,33.2],
//                                    lineList: [6],
//                                    colorList: [.white],
                                )
                                unitTablePercent(
                                    columTitle: "Dへ",
                                    percentList: [25,25.4,25.8,30.5,32.4,33.2],
//                                    numberofDicimal: 1,
                                )
                            } else if self.selectedTable == self.tableList[2] {
                                unitTablePercent(
                                    columTitle: "Aへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "Bへ",
                                    percentList: [0,0,0,0,0,0],
                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "Cへ",
                                    percentList: [25,24.6,24.2,22.3,20.7,19.9],
//                                    colorList: [.gray,.gray,.gray,.gray,.gray,.gray,]
                                )
                                unitTablePercent(
                                    columTitle: "Dへ",
                                    percentList: [75,75.4,75.8,77.7,79.3,80.1],
//                                    lineList: [6],
//                                    colorList: [.white],
                                )
                            } else {
                                unitTablePercent(
                                    columTitle: "Aへ",
                                    percentList: [50,49.2,48.4,36.8,31.7,30.1]
                                )
                                unitTablePercent(
                                    columTitle: "Bへ",
                                    percentList: [6.3,6.7,7.1,9.4,11.8,12.5],
                                    numberofDicimal: 1,
//                                    lineList: [6],
//                                    colorList: [.white]
                                )
                                unitTablePercent(
                                    columTitle: "Cへ",
                                    percentList: [6.3,6.7,7.1,16.4,19.1,20],
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "Dへ",
                                    percentList: [37.4],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white]
                                )
                            }
                        }
                    }
                }
//                unitLinkButton(
//                    title: "クエストテーブルについて",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "クエストテーブルについて",
//                            textBody1: "・4種類のテーブルでクエスト（周期）の期待度を管理",
//                            textBody2: "・テーブルはATを契機に再抽選。天国移行まで転落はない",
//                            textBody3: "・天国中にCZや直撃でボーナス当選した場合、次回も天国濃厚となる",
//                            tableView: AnyView(mhrTableQuestTable())
//                        )
//                    )
//                )
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
                            tableView: AnyView(mhrTableRareDirectHit())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 1)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mhrViewBayes(
                        mhr: mhr,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
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
                            tableView: AnyView(mhrTableRizeZoneRatio())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(mhrView95Ci(mhr: mhr, selection: 2)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mhrViewBayes(
                        mhr: mhr,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ライズゾーン初当り確率")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mhrMenuFirstHitBadge)
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
    mhrViewHistory(
        mhr: Mhr(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
