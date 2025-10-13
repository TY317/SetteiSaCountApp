//
//  toreveViewCycle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct toreveViewCycle: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var toreve: Toreve
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    @State var selectedSegment: String = "モードA"
    let segmentList: [String] = ["モードA","モードB","チャンス","天国"]
    
    var body: some View {
        List {
            // //// 履歴登録
            Section {
                // 周期選択
                unitPickerMenuIntToString(
                    title: "周期",
                    selectedInt: toreve.$selectedCycle,
                    selectList: toreve.cycleList,
                    unitText: "周期"
                )
                // ポイント
                unitPickerMenuIntToString(
                    title: "ポイント",
                    selectedInt: $toreve.selectedPt,
                    selectList: toreve.ptList,
                    unitText: "pt台"
                )
                // 当選契機
                unitPickerMenuString(
                    title: "契機",
                    selected: $toreve.selectedTrigger,
                    selectlist: toreve.tirggerList
                )
                // 結果
                unitPickerMenuString(
                    title: "結果",
                    selected: $toreve.selectedResult,
                    selectlist: toreve.resultList
                )
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if toreve.minusCheck {
                        toreve.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        toreve.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    unitButtonSubmitLabel(minusCheck: toreve.minusCheck)
                }
            } header: {
                HStack {
                    Text("周期結果登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "周期結果登録",
                            textBody1: "各周期の結果メモとしてご利用下さい",
                        )
                    }
                }
            }
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let cycleArray = decodeIntArray(from: toreve.cycleArrayData)
                    if cycleArray.count > 0 {
                        ForEach(cycleArray.indices, id: \.self) { index in
                            let viewIndex = cycleArray.count - index - 1
                            HStack {
                                // 周期
                                Text("\(cycleArray[viewIndex])周期")
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                // ポイント
                                let ptArray = decodeIntArray(from: toreve.ptArrayData)
                                if ptArray.indices.contains(viewIndex) {
                                    Text("\(ptArray[viewIndex])pt台")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // 契機
                                let triggerArray = decodeStringArray(from: toreve.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text(triggerArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // 結果
                                let resultArray = decodeStringArray(from: toreve.resultArrayData)
                                if resultArray.indices.contains(viewIndex) {
                                    Text(resultArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
                    }
                    // //// 配列のデータ数が0なら履歴なしを表示
                    else {
                        unitLabelHistoryZero()
                    }
                }
                .frame(height: self.scrollViewHeight)
                
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "周期",
                    column3: "ポイント",
                    column4: "契機",
                    column5: "結果",
                )
            }
            
            // //// 周期モードの情報
            Section {
                // 周期モード
                unitLinkButtonViewBuilder(sheetTitle: "周期モード") {
                    VStack{
                        VStack(alignment: .leading) {
                            Text("・通常時、AT中は5種類のモードで周期を管理")
                            Text("・高設定ほど良いモードが選ばれやすいが、これだけで設定判別できるほどの大きな差はないとのこと")
                            Text("・通常時は東卍チャンス、東卍ラッシュ当選時に次回周期抽選")
                            Text("・AT中は東卍アタック当選時に次回周期抽選")
                            Text("・通常時からATへ移行時モードは再抽選されるがポイントは引き継がれる")
                            Text("・リベンジで引き戻した場合はモードも引き継ぎ")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: [
                                    "通常A",
                                    "通常B",
                                    "チャンス",
                                    "天国",
                                    "特殊",
                                ],
                                maxWidth: 100,
                                lineList: [1,2,2,2,4],
                            )
                            unitTableString(
                                columTitle: "特徴",
                                stringList: [
                                    "デフォルト",
                                    "・ポイント天井300\n・天国移行期待度50%",
                                    "・初当り時のAT期待度アップ\n・周期天井が3周期",
                                    "・初当り時のAT期待度アップ\n・周期天井が1周期",
                                    "・通常時：初当り時はAT濃厚\n・AT中：東卍アタックの1個目のアイコンがリベンジチャンス濃厚\n・ポイント振分けは500以外から均等",
                                ],
                                maxWidth: 250,
                                lineList: [1,2,2,2,4],
                                contentFont: .body,
                            )
                        }
                    }
                }
                // モード移行率
                unitLinkButtonViewBuilder(sheetTitle: "モード移行率") {
                    toreveTableModeRatio()
                }
                // ポイントの期待度テーブル
                unitLinkButtonViewBuilder(sheetTitle: "ポイントの期待度テーブル") {
                    toreveTablePtTable()
                }
                // 周期の期待度テーブル
                unitLinkButtonViewBuilder(sheetTitle: "周期の期待度テーブル") {
                    toreveTableCycleTable()
                }
                // ミニキャラセリフの示唆
                unitLinkButtonViewBuilder(sheetTitle: "ミニキャラセリフの示唆") {
                    toreveTableMiniChara()
                }
                // 初当たり時の振分け
                unitLinkButtonViewBuilder(sheetTitle: "初当たり時の振分け") {
                    VStack {
                        // セグメントピッカー
                        Picker("", selection: self.$selectedSegment) {
                            ForEach(self.segmentList, id: \.self) { mode in
                                Text(mode)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                        if self.selectedSegment == self.segmentList[0] {
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "東卍チャンス",
                                    percentList: toreve.ratioModeAChance
                                )
                                unitTablePercent(
                                    columTitle: "東卍ラッシュ",
                                    percentList: toreve.ratioModeARush
                                )
                            }
                        } else if self.selectedSegment == self.segmentList[1] {
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "東卍チャンス",
                                    percentList: toreve.ratioModeBChance
                                )
                                unitTablePercent(
                                    columTitle: "東卍ラッシュ",
                                    percentList: toreve.ratioModeBRush
                                )
                            }
                        } else if self.selectedSegment == self.segmentList[2] {
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "東卍チャンス",
                                    percentList: toreve.ratioChanceChance
                                )
                                unitTablePercent(
                                    columTitle: "東卍ラッシュ",
                                    percentList: toreve.ratioChanceRush
                                )
                            }
                        } else {
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "東卍チャンス",
                                    percentList: toreve.ratioHeavenChance
                                )
                                unitTablePercent(
                                    columTitle: "東卍ラッシュ",
                                    percentList: toreve.ratioHeavenRush
                                )
                            }
                        }
                    }
                }
            } header: {
                Text("周期モード")
                    .popoverTip(tipVer3110TorevePtTable())
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver391.toreveMenuCycleBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .navigationTitle("周期履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetHistory)
                }
            }
        }
    }
}

#Preview {
    toreveViewCycle(
        toreve: Toreve(),
    )
    .environmentObject(commonVar())
}
