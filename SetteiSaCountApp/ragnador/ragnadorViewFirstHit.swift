//
//  ragnadorViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ragnador: Ragnador
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
    // テーブル推測で表示する区間（-1＝最新の区間）
    @State var selectedIntervalIndex: Int = -1
    var body: some View {
        List {
            // ---- 入力方式（セクションに入れず背景を透明にして上部に置く）
            Picker("", selection: $ragnador.firstHitInputMode) {
                ForEach(ragnador.firstHitInputModeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color.clear)

            // 履歴入力
            if ragnador.isHistoryInputMode {
                // ---- 履歴登録
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ゲーム数",
                        inputValue: $ragnador.inputGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)
                    // 種類
                    unitPickerMenuString(
                        title: "種類",
                        selected: $ragnador.selectedEntryKind,
                        selectlist: ragnador.entryKindList
                    )
                    // CZのときだけ敵
                    if ragnador.isCzEntry {
                        unitPickerMenuString(
                            title: "敵",
                            selected: $ragnador.selectedEnemy,
                            selectlist: ragnador.enemyList
                        )
                    }
                    // AT当否（直撃は当選固定）
                    if ragnador.isDirectEntry {
                        HStack {
                            Text("AT当否")
                            Spacer()
                            Text(ragnador.atResultList[1])
                                .foregroundStyle(Color.secondary)
                        }
                    } else {
                        unitPickerMenuString(
                            title: "AT当否",
                            selected: $ragnador.selectedAtResult,
                            selectlist: ragnador.atResultList
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // マイナスチェック入っていれば1行削除
                        if ragnador.minusCheck {
                            ragnador.removeLastHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // 入っていなければデータ登録
                        else {
                            ragnador.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    } label: {
                        unitButtonSubmitLabel(minusCheck: ragnador.minusCheck)
                    }
                } header: {
                    HStack {
                        Text("初当り登録")
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "初当り登録",
                                textBody1: "・CZ、直撃、天井などで初当りするごとに登録してください",
                                textBody2: "・CZのときは敵とAT当否を、天井・その他のときはAT当否を選んでください。直撃はAT当選として登録します",
                                textBody3: "・AT当選ごとに赤線でAT区間を区切って表示します",
                            )
                        }
                    }
                }

                // ---- 履歴表示
                Section {
                    ScrollView {
                        // //// 配列のデータ数が0以上なら履歴表示
                        let gameArray = decodeIntArray(from: ragnador.gameArrayData)
                        if gameArray.count > 0 {
                            let kindArray = decodeStringArray(from: ragnador.entryKindArrayData)
                            let enemyArray = decodeStringArray(from: ragnador.enemyArrayData)
                            let resultArray = decodeStringArray(from: ragnador.resultArrayData)
                            let atFlagList = ragnador.historyAtFlagList
                            ForEach(gameArray.indices, id: \.self) { index in
                                let viewIndex = gameArray.count - index - 1
                                HStack {
                                    // ゲーム数
                                    if gameArray.indices.contains(viewIndex) {
                                        Text("\(gameArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // 種類
                                    if kindArray.indices.contains(viewIndex) {
                                        Text(kindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // 敵
                                    if enemyArray.indices.contains(viewIndex) {
                                        Text(enemyArray[viewIndex].isEmpty ? "-" : enemyArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // 結果
                                    if resultArray.indices.contains(viewIndex) {
                                        Text(resultArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                // 新しい順に表示しているので、1つ古い行がAT当選なら区間の区切り（赤線）
                                if atFlagList.indices.contains(viewIndex - 1) && atFlagList[viewIndex - 1] {
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
                    
                    // CZ回数別の敵の実質出現率
                    unitLinkButtonViewBuilder(sheetTitle: "CZ回数別の敵の実質出現率", detent: .large) {
                        ragnadorSubViewEnemyEffectiveRatio(ragnador: ragnador)
                    }
                } header: {
                    unitHeaderHistoryColumnsWithoutTimes(
                        column2: "ゲーム数",
                        column3: "種類",
                        column4: "敵",
                        column5: "AT",
                    )
                }

                // ---- 集計結果
                Section {
                    // 通常ゲーム数
                    HStack {
                        Text("通常ゲーム数")
                        Spacer()
                        Text("\(ragnador.playGameSum)    G")
                            .foregroundStyle(Color.secondary)
                    }

                    // 確率横並び
                    HStack {
                        // CZ
                        unitResultRatioDenomination2Line(
                            title: "CZ",
                            count: $ragnador.firstHitCountCz,
                            bigNumber: $ragnador.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // AT
                        unitResultRatioDenomination2Line(
                            title: "AT",
                            count: $ragnador.firstHitCountAt,
                            bigNumber: $ragnador.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "CZ",
                                denominateList: ragnador.ratioFirstHitCz
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: ragnador.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ragnadorView95Ci(
                                ragnador: ragnador,
                                selection: 15,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }
                } header: {
                    Text("集計結果")
                }

                // ---- 敵選択テーブル
                Section {
                    // 最初のAT区間を計算に含めるか
                    unitToggleWithQuestion(enable: $ragnador.enemyIncludeFirstInterval, title: "最初のAT区間を含める") {
                        unitExView5body2image(
                            title: "最初のAT区間を含める",
                            textBody1: "・AT終了後から打ち始めた場合はONにしてください。最初のAT当選までのCZを、AT後の敵選択テーブルとして計算に含めます",
                            textBody2: "・朝一から打ち始めた場合や、AT終了後かどうか分からない場合はOFFにしてください。最初のAT当選までのCZは計算に使わず、その後のAT区間だけを使います",
                            textBody3: "・AT区間は、AT当選から次のAT当選までの区切りです（履歴の赤線）",
                        )
                    }
                    let atIntervalCount = ragnador.enemyAtIntervalList.count
                    // 推定テーブル7選択率
                    unitResultRatioPercent2Line(
                        title: "推定テーブル7選択率",
                        count: .constant(atIntervalCount > 0 ? Int((ragnador.enemyEstimatedTable7Ratio * 1000).rounded()) : 0),
                        bigNumber: .constant(atIntervalCount > 0 ? 1000 : 0),
                        numberofDicimal: 1
                    )
                    Text(String(format: "AT後 %d区間中、推定 %.1f区間がテーブル7", atIntervalCount, ragnador.enemyEstimatedTable7Count))
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity)
                    // 最初のAT区間の含め間違いなどで、あり得ない並びの区間がある場合
                    if ragnador.enemyHasInvalidInterval {
                        Text("・テーブル上あり得ない敵の並びの区間があるため、その区間は計算から除外しています。「最初のAT区間を含める」の設定や登録内容を確認してください")
                            .font(.caption)
                            .foregroundStyle(Color.red)
                    }

                    // 参考情報）AT後の敵選択テーブル
                    unitLinkButtonViewBuilder(sheetTitle: "テーブル7選択率") {
                        VStack(alignment: .leading) {
//                            Text("・AT終了後は、次回以降のCZの敵を決める敵選択テーブルを抽選")
//                            Text("・高設定ほど、1回目がチャンス・2回目が朱雀のテーブル7が選ばれやすい")
                            Text("・推定値は、登録したCZの敵の並びから求めた目安（独自算出）")
                            Text("・計測区間数に応じて内部的に補正をかけた数値で、区間が増えるほど台の記録に近づく")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "テーブル7",
                                percentList: ragnador.ratioEnemyTable7,
                                numberofDicimal: 1,
                            )
                        }
                    }

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }

                    // テーブル推測（区間ごと）
                    DisclosureGroup {
                        let intervalList = ragnador.enemyDisplayIntervalList
                        if intervalList.isEmpty {
                            Text("履歴なし")
                                .foregroundStyle(Color.secondary)
                        } else {
                            let lastIndex = intervalList.count - 1
                            let currentIndex = (0...lastIndex).contains(self.selectedIntervalIndex) ? self.selectedIntervalIndex : lastIndex
                            let interval = intervalList[currentIndex]
                            // 区間の選択
                            Picker("区間", selection: Binding(
                                get: { currentIndex },
                                set: { self.selectedIntervalIndex = $0 }
                            )) {
                                ForEach(intervalList.indices, id: \.self) { index in
                                    Text(intervalTitle(interval: intervalList[index], index: index))
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)

                            // 区間の敵の並び
                            Text(interval.enemies.isEmpty ? "CZなし" : interval.enemies.map { ragnador.enemyList[$0] }.joined(separator: " → "))
                                .font(.caption)
                                .foregroundStyle(Color.secondary)

                            if !ragnador.enemyIsPossible(interval: interval) {
                                Text("どのテーブルでもあり得ない並びです。「最初のAT区間を含める」の設定や登録内容を確認してください（この区間は判別に使いません）")
                                    .font(.caption)
                                    .foregroundStyle(Color.red)
                            } else {
                                let posterior = ragnador.enemyTablePosterior(interval: interval)
                                let nameList = ragnador.enemyTableNameList(interval: interval)
                                ForEach(posterior.indices, id: \.self) { table in
                                    HStack {
                                        Text(nameList[table])
                                        Spacer()
                                        Text(String(format: "%.1f%%", posterior[table] * 100))
                                    }
                                    .font(.subheadline)
                                    // AT後はテーブル7（設定差あり）を強調
                                    .fontWeight(interval.isAfterAt && table == 1 ? .bold : .regular)
                                }
                                // 次のCZの敵の見込み（現在の区間だけ）
                                if interval.isOpen {
                                    let forecast = ragnador.enemyNextForecast(interval: interval)
                                    VStack(alignment: .leading) {
                                        Text(interval.isAfterAt ? "次（AT後CZ\(interval.enemies.count + 1)回目）の敵の見込み" : "次（CZ\(interval.enemies.count + 1)回目）の敵の見込み")
                                            .font(.subheadline)
                                        HStack {
                                            ForEach(ragnador.enemyList.indices, id: \.self) { enemy in
                                                Text("\(ragnador.enemyList[enemy]) \(String(format: "%.0f%%", forecast[enemy] * 100))")
                                                    .font(.caption)
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                    }
                                }
                            }
                            Text("・推定テーブル7選択率を前提にした目安（独自算出）")
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                        }
                    } label: {
                        Text("テーブル推測")
                            .foregroundStyle(Color.blue)
                    }
                } header: {
                    Text("敵選択テーブル")
                }
            }
            // カウント入力
            else {
                Section {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "通常ゲーム数",
                        inputValue: $ragnador.manualNormalGame,
                        unitText: "Ｇ"
                    )
                    .focused($isFocused)

                    // カウントボタン横並び
                    HStack {
                        // CZ
                        unitCountButtonVerticalDenominate(
                            title: "CZ",
                            count: $ragnador.manualFirstHitCountCz,
                            color: .personalSummerLightBlue,
                            bigNumber: $ragnador.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ragnador.minusCheck
                        )
                        // AT
                        unitCountButtonVerticalDenominate(
                            title: "AT",
                            count: $ragnador.manualFirstHitCountAt,
                            color: .personalSummerLightRed,
                            bigNumber: $ragnador.manualNormalGame,
                            numberofDicimal: 0,
                            minusBool: $ragnador.minusCheck
                        )
                    }

                    // 参考情報）初当り確率
                    unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "CZ",
                                denominateList: ragnador.ratioFirstHitCz
                            )
                            unitTableDenominate(
                                columTitle: "AT",
                                denominateList: ragnador.ratioFirstHitAt
                            )
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ragnadorView95Ci(
                                ragnador: ragnador,
                                selection: 15,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }
                } header: {
                    Text("カウント")
                }
            }

            // ---- 敵選択テーブルの詳しい解析情報
            Section {
                DisclosureGroup {
                    // 設定判別の考え方
                    unitLinkButtonViewBuilder(sheetTitle: "設定判別の考え方") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("・CZの敵は、設定変更時とAT終了時に抽選される敵選択テーブルで決まる")
                            Text("・AT終了時はテーブル6〜10を抽選。高設定ほど、1回目がチャンス・2回目が朱雀のテーブル7が選ばれやすい（設定1：4.7%〜設定6：9.4%）")
                            Text("・テーブルはCZ回数ごとに、どの振り分けで敵を決めるかを持っている。通常の振り分けは高設定ほど玄武が出やすい")
                            Text("・AT区間（AT当選から次のAT当選まで）ごとに、記録した敵の並びが各テーブルで起きる確率を求め、設定ごとのテーブル選択率で重みづけして設定期待値に反映する")
                            Text("・同じAT区間のCZは同じテーブルから出ているため、区間単位で計算する（CZごとに独立に数えると判別材料を多く見積もってしまう）")
                            Text("・推定テーブル7選択率は、計測区間数に応じて内部的に補正をかけた目安。テーブル推測はこの推定値を前提にしている")
                            Text("・確定CZは計算に含めない")
                            Text("・当アプリによる独自算出の参考値です")
                        }
                    }

                    // 敵選択テーブル選択率
                    unitLinkButtonViewBuilder(sheetTitle: "敵選択テーブル選択率") {
                        ragnadorSubViewEnemyTableRatio(ragnador: ragnador)
                    }

                    // 敵選択テーブルの内容
                    unitLinkButtonViewBuilder(sheetTitle: "敵選択テーブル") {
                        ragnadorSubViewEnemyTableList(ragnador: ragnador)
                    }

                    // 敵の振り分け
                    unitLinkButtonViewBuilder(sheetTitle: "敵の振り分け") {
                        VStack(alignment: .leading) {
                            Text("・テーブルのCZ回数ごとに、下のどの振り分けで敵を決めるかが決まる")
                            Text("・通常の振り分けのみ設定差あり")
                        }
                        .padding(.bottom)
                        // 通常（設定差あり）
                        VStack {
                            Text("[通常の振分け]")
                                .font(.title2)
                            ForEach([[0, 1, 2], [3, 4, 5]], id: \.self) { settingGroup in
                                HStack(spacing: 0) {
                                    unitTableString(
                                        columTitle: "",
                                        stringList: ragnador.enemyList,
                                    )
                                    ForEach(settingGroup, id: \.self) { setting in
                                        unitTablePercent(
                                            columTitle: "設定\(setting + 1)",
                                            percentList: ragnador.enemyTypeRatio(type: 0, setting: setting).map { $0 * 100 },
                                            numberofDicimal: 1,
                                            maxWidth: 70,
                                        )
                                    }
                                }
                            }
                            .padding(.bottom)
                            Text("[通常以外の振分け]")
                                .font(.title2)
                            // 通常以外（設定差なし）
                            HStack(spacing: 0) {
                                unitTableString(
                                    columTitle: "",
                                    stringList: ragnador.enemyList,
                                )
                                ForEach(1..<ragnador.enemyTypeNameList.count, id: \.self) { type in
                                    unitTablePercent(
                                        columTitle: ragnador.enemyTypeNameList[type],
                                        percentList: ragnador.ratioEnemyTypeFixed[type],
                                        numberofDicimal: 1,
                                        maxWidth: 70,
                                        titleFont: .caption,
                                    )
                                }
                            }
                        }
                    }

                    // CZ回数別の敵の実質出現率
                    unitLinkButtonViewBuilder(sheetTitle: "CZ回数別の敵の実質出現率", detent: .large) {
                        ragnadorSubViewEnemyEffectiveRatio(ragnador: ragnador)
                    }
                } label: {
                    Text("詳しい解析情報")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("敵選択テーブルの参考情報")
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ragnadorMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $ragnador.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ragnador.resetFirstHit)
            }
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
    }
}

extension ragnadorViewFirstHit {
    // テーブル推測の区間の表示名
    func intervalTitle(interval: RagnadorEnemyInterval, index: Int) -> String {
        var noteList: [String] = []
        if index == 0 && ragnador.enemyIncludeFirstInterval {
            noteList.append("打ち始め")
        }
        if interval.isOpen {
            noteList.append("現在")
        }
        return noteList.isEmpty ? "区間\(index + 1)" : "区間\(index + 1)（\(noteList.joined(separator: "・"))）"
    }
}

// ///////////////////////
// 敵選択テーブルの内容（CZ回数ごとの振り分け）
// ///////////////////////
struct ragnadorSubViewEnemyTableContent: View {
    @ObservedObject var ragnador: Ragnador
    let tableNumberList: [Int]
    let typeListList: [[Int]]

    var body: some View {
        let czCount = typeListList.map { $0.count }.max() ?? 1
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "CZ",
                stringList: (1...czCount).map { "\($0)回目" },
            )
            ForEach(tableNumberList.indices, id: \.self) { index in
                unitTableString(
                    columTitle: "T\(tableNumberList[index])",
                    stringList: (0..<czCount).map { czIndex in
                        let typeList = typeListList[index]
                        return ragnador.enemyTypeNameList[typeList[min(czIndex, typeList.count - 1)]]
                    },
                    maxWidth: 60,
                    contentFont: .caption,
                )
            }
        }
    }
}

// ///////////////////////
// 敵選択テーブル選択率（AT後／設定変更後）
// ///////////////////////
struct ragnadorSubViewEnemyTableRatio: View {
    @ObservedObject var ragnador: Ragnador
    @State var selectedStart: String = "AT後"
    let startList: [String] = ["AT後", "設定変更後"]

    var body: some View {
        Picker("", selection: self.$selectedStart) {
            ForEach(self.startList, id: \.self) { start in
                Text(start)
            }
        }
        .pickerStyle(.segmented)
        if self.selectedStart == self.startList[0] {
            Text("・AT終了時にテーブル6〜10を抽選。高設定ほどテーブル7が選ばれやすい")
            VStack(spacing: 20) {
                ForEach([[0, 1, 2], [3, 4, 5]], id: \.self) { settingGroup in
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "テーブル",
                            stringList: (6...10).map { "\($0)" },
                        )
                        ForEach(settingGroup, id: \.self) { setting in
                            unitTablePercent(
                                columTitle: "設定\(setting + 1)",
                                percentList: ragnador.enemyTableAtPrior(table7: ragnador.ratioEnemyTable7[setting] / 100).map { $0 * 100 },
                                numberofDicimal: 1,
                                maxWidth: 70,
                            )
                        }
                    }
                }
            }
        } else {
            Text("・設定変更時にテーブル1〜5を抽選。選択率は全設定共通")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "テーブル",
                    stringList: (1...5).map { "\($0)" },
                )
                unitTablePercent(
                    columTitle: "選択率",
                    percentList: ragnador.ratioEnemyTableChange,
                    numberofDicimal: 1,
                )
            }
        }
    }
}

// ///////////////////////
// 敵選択テーブルの内容（AT後／設定変更後）
// ///////////////////////
struct ragnadorSubViewEnemyTableList: View {
    @ObservedObject var ragnador: Ragnador
    @State var selectedStart: String = "AT後"
    let startList: [String] = ["AT後", "設定変更後"]

    var body: some View {
        Picker("", selection: self.$selectedStart) {
            ForEach(self.startList, id: \.self) { start in
                Text(start)
            }
        }
        .pickerStyle(.segmented)
        if self.selectedStart == self.startList[0] {
            Text("・CZ回数ごとの敵の振り分け。6回目以降は6回目と同じ")
            ragnadorSubViewEnemyTableContent(
                ragnador: ragnador,
                tableNumberList: Array(6...10),
                typeListList: ragnador.enemyTableAtList,
            )
        } else {
            Text("・CZ回数ごとの敵の振り分け。3回目以降は3回目と同じ")
            ragnadorSubViewEnemyTableContent(
                ragnador: ragnador,
                tableNumberList: Array(1...5),
                typeListList: ragnador.enemyTableChangeList,
            )
        }
    }
}

// ///////////////////////
// CZ回数別の敵の実質出現率
// ///////////////////////
struct ragnadorSubViewEnemyEffectiveRatio: View {
    @ObservedObject var ragnador: Ragnador
    @State var selectedStart: String = "AT後"
    @State var selectedCzNumber: Int = 1
    let startList: [String] = ["AT後", "設定変更後"]

    var body: some View {
        let isAfterAt = self.selectedStart == self.startList[0]
        let maxCzNumber = isAfterAt ? 6 : 3
        let czNumber = min(self.selectedCzNumber, maxCzNumber)
        VStack(alignment: .leading) {
            Text("・テーブル選択率・テーブルの内容・敵の振り分けから算出（独自算出）")
            Text("・そのCZ回数まで到達したときの、敵の出現率")
            Text(isAfterAt ? "・6回目以降は6回目と同じ" : "・3回目以降は3回目と同じ")
        }
        Picker("", selection: self.$selectedStart) {
            ForEach(self.startList, id: \.self) { start in
                Text(start)
            }
        }
        .pickerStyle(.segmented)
        Picker("", selection: self.$selectedCzNumber) {
            ForEach(1...maxCzNumber, id: \.self) { number in
                Text("\(number)回目").tag(number)
            }
        }
        .pickerStyle(.segmented)
        VStack(spacing: 20) {
            ForEach([[0, 1, 2], [3, 4, 5]], id: \.self) { settingGroup in
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "敵",
                        stringList: ragnador.enemyList,
                    )
                    ForEach(settingGroup, id: \.self) { setting in
                        unitTablePercent(
                            columTitle: "設定\(setting + 1)",
                            percentList: ragnador.enemyEffectiveRatio(isAfterAt: isAfterAt, czNumber: czNumber, setting: setting),
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
    ragnadorViewFirstHit(
        ragnador: Ragnador(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
