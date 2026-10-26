//
//  mhrsbViewBzScenario.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewBzScenario: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var mhrsb: Mhrsb
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    // シナリオ推測で表示するAT区間（-1＝最新の区間）
    @State var selectedIntervalIndex: Int = -1

    var body: some View {
        List {
            // ---- 履歴登録
            Section {
                // AT間CZ回数
                unitPickerMenuIntToString(
                    title: "AT間CZ",
                    selectedInt: $mhrsb.bzSelectedCzNumber,
                    selectList: Array(1...mhrsb.bzMaxCzCount),
                    unitText: "回目"
                )
                // CZ種類
                unitPickerMenuString(
                    title: "CZ種類",
                    selected: $mhrsb.bzSelectedCzKind,
                    selectlist: mhrsb.bzCzKindList
                )
                // 1個目のアイコン（BZのみ）
                if mhrsb.bzSelectedCzKind == mhrsb.bzCzKindList[0] {
                    VStack(alignment: .trailing, spacing: 2) {
                        unitPickerMenuString(
                            title: "1個目のアイコン",
                            selected: $mhrsb.bzSelectedIcon,
                            selectlist: mhrsb.bzTableIconList
                        )
                        Text("アイコンテーブル：テーブル\(mhrsb.bzSelectedTable)")
                            .font(.caption)
                            .foregroundStyle(Color.secondary)
                    }
                }
                // AT当落
                unitPickerMenuString(
                    title: "AT当落",
                    selected: $mhrsb.bzSelectedAt,
                    selectlist: mhrsb.bzAtResultList
                )
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if mhrsb.minusCheck {
                        mhrsb.removeLastBzHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        mhrsb.addBzHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    self.selectedIntervalIndex = -1
                } label: {
                    unitButtonSubmitLabel(minusCheck: mhrsb.minusCheck)
                }
            } header: {
                HStack {
                    Text("CZ結果登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "CZ結果登録",
                            textBody1: "・CZに当選したら、AT間何回目のCZか・CZの種類・BZの1個目のアイコン・AT当落を選んで登録してください",
                            textBody2: "・AT当選で登録すると、次の登録はAT間CZ1回目に戻ります",
                            textBody3: "・CZ以外（天井など）でATに当選した場合や、途中から打ち始めた場合は、AT間CZの回数を合わせて登録してください（メニュー画面で確認できます）",
                        )
                    }
                }
            }

            // ---- 履歴表示
            Section {
                ScrollView {
                    let numberArray = decodeIntArray(from: mhrsb.bzCzNumberArrayData)
                    let kindArray = decodeStringArray(from: mhrsb.bzCzKindArrayData)
                    let tableArray = decodeIntArray(from: mhrsb.bzTableArrayData)
                    let atArray = decodeStringArray(from: mhrsb.bzAtArrayData)
                    let startFlagList = mhrsb.bzIntervalStartFlagList
                    // //// 配列のデータ数が0以上なら履歴表示（新しい順）
                    if numberArray.count > 0 {
                        ForEach(numberArray.indices, id: \.self) { index in
                            let viewIndex = numberArray.count - index - 1
                            HStack {
                                // AT間CZ
                                Text("\(numberArray[viewIndex])回目")
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                                // CZ種類
                                Text(kindArray.indices.contains(viewIndex) ? kindArray[viewIndex] : "")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                    .frame(maxWidth: .infinity)
                                // テーブル
                                let table = tableArray.indices.contains(viewIndex) ? tableArray[viewIndex] : 0
                                Text(table > 0 ? "テーブル\(table)" : "ー")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                    .frame(maxWidth: .infinity)
                                // AT
                                Text(atArray.indices.contains(viewIndex) ? atArray[viewIndex] : "")
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity)
                            }
                            // AT区間の区切りは赤線
                            if startFlagList.indices.contains(viewIndex) && startFlagList[viewIndex] {
                                Divider()
                                    .overlay(Color.red)
                            } else {
                                Divider()
                            }
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
                    column2: "AT間CZ",
                    column3: "CZ種類",
                    column4: "テーブル",
                    column5: "AT",
                )
            }

            // ---- シナリオE以上選択率
            Section {
                let validCount = mhrsb.bzValidIntervalList.count
                // 推定シナリオE以上選択率
                unitResultRatioPercent2Line(
                    title: "推定シナリオE以上選択率",
                    count: .constant(Int((mhrsb.bzEstimatedOverECount * 1000).rounded())),
                    bigNumber: .constant(validCount * 1000),
                    numberofDicimal: 1
                )
                Text(String(format: "AT区間 %d区間中、推定 %.1f区間がシナリオE以上", validCount, mhrsb.bzEstimatedOverECount))
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                    .frame(maxWidth: .infinity)

                // 参考情報）シナリオE以上選択率
                unitLinkButtonViewBuilder(sheetTitle: "BZシナリオE以上選択率") {
                    VStack(alignment: .leading) {
                        Text("・高設定ほどシナリオE以上が選ばれやすい")
                        Text("・推定値は、記録したアイコンテーブルの並びから求めた区間ごとの「E以上だった見込み」を合計して、区間数で割った目安（独自算出）")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "E以上",
                            percentList: [14.1,16.4,18.8,22.6,26.6,30.6],
                            numberofDicimal: 1,
                        )
                    }
                }

                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mhrsbViewBayes(
                        mhrsb: mhrsb,
                    )
                }

                // シナリオ推測
                DisclosureGroup {
                    let intervalList = mhrsb.bzAllIntervalList
                    if intervalList.isEmpty {
                        Text("履歴なし")
                            .foregroundStyle(Color.secondary)
                    } else {
                        let lastIndex = intervalList.count - 1
                        let currentIndex = (0...lastIndex).contains(self.selectedIntervalIndex) ? self.selectedIntervalIndex : lastIndex
                        let interval = intervalList[currentIndex]
                        // AT区間の選択
                        Picker("AT区間", selection: Binding(
                            get: { currentIndex },
                            set: { self.selectedIntervalIndex = $0 }
                        )) {
                            ForEach(intervalList.indices, id: \.self) { index in
                                Text(intervalTitle(index: index, lastIndex: lastIndex))
                                    .tag(index)
                            }
                        }
                        .pickerStyle(.menu)

                        if !mhrsb.bzIsPossible(interval: interval) {
                            Text("どのシナリオでもあり得ない並びです。AT当落やAT間CZの回数を確認してください（この区間は判別に使いません）")
                                .font(.caption)
                                .foregroundStyle(Color.red)
                        } else {
                            let posterior = mhrsb.bzScenarioPosterior(interval: interval)
                            ForEach(mhrsb.bzScenarioNameList.indices, id: \.self) { scenario in
                                HStack {
                                    Text("シナリオ\(mhrsb.bzScenarioNameList[scenario])")
                                    Spacer()
                                    Text(String(format: "%.1f%%", posterior[scenario] * 100))
                                }
                                .font(.subheadline)
                            }
                            HStack {
                                Text("シナリオE以上")
                                Spacer()
                                Text(String(format: "%.1f%%", mhrsb.bzOverEProbability(interval: interval) * 100))
                            }
                            .fontWeight(.bold)
                            // 次のCZのBZレベルの見込み（最新の区間がAT当選前のときだけ）
                            if currentIndex == lastIndex && mhrsb.bzIsLastIntervalOpen && mhrsb.bzNextCzNumber <= mhrsb.bzMaxCzCount {
                                let forecast = mhrsb.bzNextLevelForecast(interval: interval)
                                VStack(alignment: .leading) {
                                    Text("次（AT間CZ\(mhrsb.bzNextCzNumber)回目）のBZレベルの見込み")
                                        .font(.subheadline)
                                    HStack {
                                        ForEach(mhrsb.bzLevelNameList.indices, id: \.self) { level in
                                            Text("\(mhrsb.bzLevelNameList[level]) \(String(format: "%.0f%%", forecast[level] * 100))")
                                                .font(.caption)
                                                .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            }
                        }
                        Text("・全設定平均のシナリオ選択率を前提にした目安（独自算出）")
                            .font(.caption)
                            .foregroundStyle(Color.secondary)
                    }
                } label: {
                    Text("シナリオ推測")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("シナリオE以上選択率")
            }

            // ---- 詳しい解析情報
            Section {
                DisclosureGroup {
                    // 設定判別の考え方
                    unitLinkButtonViewBuilder(sheetTitle: "設定判別の考え方") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("・BZシナリオ（A〜I）は設定変更時と（上位）AT終了時に抽選され、高設定ほどシナリオE以上が選ばれやすい（設定1：14.1%〜設定6：30.6%）")
                            Text("・BZレベル（LOW／MID／HI／SP）はシナリオとAT間のCZ回数で決まり、アイコンテーブルはBZレベルから抽選される（テーブルの振分けに設定差なし）")
                            Text("・アイコンテーブルはBZの1個目のアイコンで判別できる")
                            Text("・AT区間ごとに、記録したテーブルの並びが各シナリオで起きる確率を求め、設定ごとのシナリオ選択率で重みづけして設定期待値に反映する")
                            Text("・同じAT区間のCZは同じシナリオから出ているため、区間単位で計算する（CZごとに独立に数えると判別材料を多く見積もってしまう）")
                            Text("・シナリオ推測と推定E以上選択率は、全設定平均のシナリオ選択率を前提にした目安")
                            Text("・アイルー福引もCZ回数に含める前提（公式な明記なし）。BZ成功率の設定差（設定2以上は未判明）は考慮していない")
                            Text("・当アプリによる独自算出の参考値です")
                        }
                    }

                    // シナリオ選択率
                    unitLinkButtonViewBuilder(sheetTitle: "BZシナリオ選択率") {
                        VStack(spacing: 20) {
                            ForEach([[0, 1, 2], [3, 4, 5]], id: \.self) { settingGroup in
                                HStack(spacing: 0) {
                                    unitTableString(
                                        columTitle: "シナリオ",
                                        stringList: mhrsb.bzScenarioNameList,
                                    )
                                    ForEach(settingGroup, id: \.self) { setting in
                                        unitTablePercent(
                                            columTitle: "設定\(setting + 1)",
                                            percentList: mhrsb.ratioBzScenario.map { $0[setting] },
                                            numberofDicimal: 1,
                                            maxWidth: 70,
                                        )
                                    }
                                }
                            }
                        }
                    }

                    // シナリオ別のBZレベル
                    unitLinkButtonViewBuilder(sheetTitle: "BZシナリオ別のBZレベル") {
                        VStack(spacing: 20) {
                            ForEach([[0, 1, 2], [3, 4, 5], [6, 7, 8]], id: \.self) { scenarioGroup in
                                HStack(spacing: 0) {
                                    unitTableString(
                                        columTitle: "CZ回数",
                                        stringList: (1...mhrsb.bzMaxCzCount).map { "\($0)回目" },
                                    )
                                    ForEach(scenarioGroup, id: \.self) { scenario in
                                        unitTableString(
                                            columTitle: mhrsb.bzScenarioNameList[scenario],
                                            stringList: (0..<mhrsb.bzMaxCzCount).map { index in
                                                let levelList = mhrsb.bzScenarioLevelList[scenario]
                                                return index < levelList.count ? mhrsb.bzLevelNameList[levelList[index]] : "-"
                                            },
                                            maxWidth: 70,
                                        )
                                    }
                                }
                            }
                        }
                    }

                    // BZレベル別のアイコンテーブル振分け
                    unitLinkButtonViewBuilder(sheetTitle: "BZレベル別のアイコンテーブル振分け") {
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "テーブル",
                                stringList: mhrsb.bzTableIconList.indices.map { "\($0 + 1)：\(mhrsb.bzTableIconList[$0])" },
                                maxWidth: 170,
                                contentFont: .caption,
                            )
                            ForEach(mhrsb.bzLevelNameList.indices, id: \.self) { level in
                                unitTablePercent(
                                    columTitle: mhrsb.bzLevelNameList[level],
                                    percentList: mhrsb.ratioBzLevelTable[level],
                                    numberofDicimal: 1,
                                    maxWidth: 60,
                                )
                            }
                        }
                    }

                    // CZ回数別のアイコンテーブル実質出現率
                    unitLinkButtonViewBuilder(sheetTitle: "CZ回数別のテーブル実質出現率", detent: .large) {
                        mhrsbSubViewBzTableRatio(mhrsb: mhrsb)
                    }
                } label: {
                    Text("詳しい解析情報")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("参考情報")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mhrsbMenuBzScenarioBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BZシナリオ")
        .navigationBarTitleDisplayMode(.inline)
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $mhrsb.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhrsb.resetBzScenario)
            }
        }
    }

    // シナリオ推測のAT区間の表示名
    private func intervalTitle(index: Int, lastIndex: Int) -> String {
        if index == lastIndex && mhrsb.bzIsLastIntervalOpen {
            return "区間\(index + 1)（現在）"
        }
        return "区間\(index + 1)"
    }
}

// ///////////////////////
// CZ回数別のアイコンテーブル実質出現率
// ///////////////////////
struct mhrsbSubViewBzTableRatio: View {
    @ObservedObject var mhrsb: Mhrsb
    @State var selectedCzNumber: Int = 1

    var body: some View {
        VStack(alignment: .leading) {
            Text("・シナリオ選択率・シナリオ別のBZレベル・テーブル振分けから算出（独自算出）")
            Text("・そのCZ回数まで到達したときの、1個目のアイコンのテーブルの出現率")
        }
        Picker("", selection: self.$selectedCzNumber) {
            ForEach(1...mhrsb.bzMaxCzCount, id: \.self) { number in
                Text("\(number)回目").tag(number)
            }
        }
        .pickerStyle(.segmented)
        VStack(spacing: 20) {
            ForEach([[0, 1, 2], [3, 4, 5]], id: \.self) { settingGroup in
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "テーブル",
                        stringList: (1...mhrsb.bzTableIconList.count).map { "\($0)" },
                    )
                    ForEach(settingGroup, id: \.self) { setting in
                        unitTablePercent(
                            columTitle: "設定\(setting + 1)",
                            percentList: mhrsb.bzTableRatio(czNumber: self.selectedCzNumber, setting: setting),
                            numberofDicimal: 1,
                            maxWidth: 70,
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    mhrsbViewBzScenario(
        mhrsb: Mhrsb(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
