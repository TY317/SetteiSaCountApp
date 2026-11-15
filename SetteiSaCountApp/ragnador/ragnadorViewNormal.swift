//
//  ragnadorViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewNormal: View {
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

    // レア役からのCZ・AT当選率
    let rareStateItems: [String] = ["通常", "高確"]
    @State var selectedRareState: String = "通常"
    // 設定差のある役だけ（高確の極チャンス目はCZ・ATとも設定差なし）
    let rareRoleItemsNormal: [String] = ["🍉", "ﾁｬﾝｽ目", "強🍒", "極ﾁｬﾝｽ目"]
    let rareRoleItemsHigh: [String] = ["🍉", "ﾁｬﾝｽ目", "強🍒"]
    @State var selectedRareRole: String = "ﾁｬﾝｽ目"

    var body: some View {
        List {
            // ---- 弱チェリーの状態昇格率
            Section {
                HStack {
                    // 高確以上
                    unitResultRatioPercent2Line(
                        title: "高確移行",
                        count: $ragnador.weakCherryUpCountHighOver,
                        bigNumber: $ragnador.weakCherryCount,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 超高確
                    unitResultRatioPercent2Line(
                        title: "超高確移行",
                        count: $ragnador.weakCherryUpCountSuperHigh,
                        bigNumber: $ragnador.weakCherryCount,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）弱チェリーの状態昇格率
                unitLinkButtonViewBuilder(sheetTitle: "弱チェリーでの状態昇格率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "昇格なし",
                            percentList: ragnador.ratioWeakCherryUpNone,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "高確",
                            percentList: ragnador.ratioWeakCherryUpHigh,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "超高確",
                            percentList: ragnador.ratioWeakCherryUpSuperHigh,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    Text("・通常状態での弱🍒がカウント対象")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン横並び
                    HStack {
                        // 弱チェリー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "弱🍒成立",
                            count: $ragnador.weakCherryCount,
                            color: .personalSummerLightRed,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                        // 高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "高確",
                            count: $ragnador.weakCherryUpCountHigh,
                            color: .personalSummerLightGreen,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                        // 超高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "超高確",
                            count: $ragnador.weakCherryUpCountSuperHigh,
                            color: .personalSummerLightPurple,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ragnadorView95Ci(
                                ragnador: ragnador,
                                selection: 1,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("弱チェリーでの状態昇格率")
            }
            
            // ---- レア役からのCZ・AT当選率
            Section {
                // 状態の選択
                Picker("", selection: self.$selectedRareState) {
                    ForEach(self.rareStateItems, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
//                .listRowBackground(Color.clear)

                // 確率結果（上段：CZ当選率／下段：AT当選率。設定差のあるものだけ）
                if self.selectedRareState == self.rareStateItems[0] {
                    VStack {
                        Text("[CZ当選率]")
                        HStack {
                            unitResultRatioPercent2Line(
                                title: "ﾁｬﾝｽ目",
                                count: $ragnador.rareCzCountNormalChance,
                                bigNumber: $ragnador.rareCountNormalChance,
                                numberofDicimal: 0,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "強🍒",
                                count: $ragnador.rareCzCountNormalKyo,
                                bigNumber: $ragnador.rareCountNormalKyo,
                                numberofDicimal: 0,
                                spacerBool: false,
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text("[AT当選率]")
                        HStack {
                            unitResultRatioPercent2Line(
                                title: "🍉",
                                count: $ragnador.rareAtCountNormalSuika,
                                bigNumber: $ragnador.rareCountNormalSuika,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "ﾁｬﾝｽ目",
                                count: $ragnador.rareAtCountNormalChance,
                                bigNumber: $ragnador.rareCountNormalChance,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "強🍒",
                                count: $ragnador.rareAtCountNormalKyo,
                                bigNumber: $ragnador.rareCountNormalKyo,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "極ﾁｬﾝｽ目",
                                count: $ragnador.rareAtCountNormalGoku,
                                bigNumber: $ragnador.rareCountNormalGoku,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    VStack {
                        Text("[CZ当選率]")
                        HStack {
                            unitResultRatioPercent2Line(
                                title: "ﾁｬﾝｽ目",
                                count: $ragnador.rareCzCountHighChance,
                                bigNumber: $ragnador.rareCountHighChance,
                                numberofDicimal: 0,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "強🍒",
                                count: $ragnador.rareCzCountHighKyo,
                                bigNumber: $ragnador.rareCountHighKyo,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    VStack {
                        Text("[AT当選率]")
                        HStack {
                            unitResultRatioPercent2Line(
                                title: "🍉",
                                count: $ragnador.rareAtCountHighSuika,
                                bigNumber: $ragnador.rareCountHighSuika,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "ﾁｬﾝｽ目",
                                count: $ragnador.rareAtCountHighChance,
                                bigNumber: $ragnador.rareCountHighChance,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                            unitResultRatioPercent2Line(
                                title: "強🍒",
                                count: $ragnador.rareAtCountHighKyo,
                                bigNumber: $ragnador.rareCountHighKyo,
                                numberofDicimal: 1,
                                spacerBool: false,
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                // 参考情報）レア役からのCZ・AT当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ・AT当選率") {
                    ragnadorTableRareHit()
                }

                // カウント
                DisclosureGroup {
                    // レア役の選択
                    Picker("", selection: self.$selectedRareRole) {
                        ForEach(self.rareRoleItems(), id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び（選択中の状態・役で設定差のあるものだけ）
                    HStack {
                        // 成立
                        if let count = self.rareBinding(kind: 0) {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "\(self.selectedRareRole)成立",
                                count: count,
                                color: .personalSummerLightBlue,
                                minusBool: $ragnador.minusCheck) {
                                }
                        }
                        // CZ当選
                        if let count = self.rareBinding(kind: 1) {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ当選",
                                count: count,
                                color: .personalSummerLightGreen,
                                minusBool: $ragnador.minusCheck) {
                                }
                        }
                        // AT当選
                        if let count = self.rareBinding(kind: 2) {
                            unitCountButtonWithoutRatioWithFunc(
                                title: "AT当選",
                                count: count,
                                color: .personalSummerLightRed,
                                minusBool: $ragnador.minusCheck) {
                                }
                        }
                    }
                    // 状態・役の切替でボタンを作り直す
                    .id(self.selectedRareState + self.selectedRareRole)

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ragnadorView95Ci(
                                ragnador: ragnador,
                                selection: self.rare95CiTag(),
                            )
                        )
                    )
                    // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                    .id(self.rare95CiTag())

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からのCZ・AT当選率")
            }
            // 高確へ切り替えたとき、高確に無い役（極チャンス目）が選ばれていたら戻す
            .onChange(of: self.selectedRareState) { _, _ in
                if !self.rareRoleItems().contains(self.selectedRareRole) {
                    self.selectedRareRole = self.rareRoleItems()[1]
                }
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    ragnadorTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ragnadorMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: ragnador.resetNormal)
            }
        }
    }

    // //// レア役からのCZ・AT当選率：選択中の状態のレア役一覧
    private func rareRoleItems() -> [String] {
        return self.selectedRareState == self.rareStateItems[0] ? self.rareRoleItemsNormal : self.rareRoleItemsHigh
    }

    // //// 選択中の状態・役のカウント変数（kind 0:成立 1:CZ当選 2:AT当選）。設定差が無いものは nil
    private func rareBinding(kind: Int) -> Binding<Int>? {
        let isNormal = self.selectedRareState == self.rareStateItems[0]
        switch (isNormal, self.selectedRareRole, kind) {
        // 通常
        case (true, "🍉", 0): return $ragnador.rareCountNormalSuika
        case (true, "🍉", 2): return $ragnador.rareAtCountNormalSuika
        case (true, "ﾁｬﾝｽ目", 0): return $ragnador.rareCountNormalChance
        case (true, "ﾁｬﾝｽ目", 1): return $ragnador.rareCzCountNormalChance
        case (true, "ﾁｬﾝｽ目", 2): return $ragnador.rareAtCountNormalChance
        case (true, "強🍒", 0): return $ragnador.rareCountNormalKyo
        case (true, "強🍒", 1): return $ragnador.rareCzCountNormalKyo
        case (true, "強🍒", 2): return $ragnador.rareAtCountNormalKyo
        case (true, "極ﾁｬﾝｽ目", 0): return $ragnador.rareCountNormalGoku
        case (true, "極ﾁｬﾝｽ目", 2): return $ragnador.rareAtCountNormalGoku
        // 高確
        case (false, "🍉", 0): return $ragnador.rareCountHighSuika
        case (false, "🍉", 2): return $ragnador.rareAtCountHighSuika
        case (false, "ﾁｬﾝｽ目", 0): return $ragnador.rareCountHighChance
        case (false, "ﾁｬﾝｽ目", 1): return $ragnador.rareCzCountHighChance
        case (false, "ﾁｬﾝｽ目", 2): return $ragnador.rareAtCountHighChance
        case (false, "強🍒", 0): return $ragnador.rareCountHighKyo
        case (false, "強🍒", 1): return $ragnador.rareCzCountHighKyo
        case (false, "強🍒", 2): return $ragnador.rareAtCountHighKyo
        default: return nil
        }
    }

    // //// 選択中の状態・役の95Ciタグ（CZのカウントがあればCZ、無ければAT）
    private func rare95CiTag() -> Int {
        let isNormal = self.selectedRareState == self.rareStateItems[0]
        switch (isNormal, self.selectedRareRole) {
        case (true, "ﾁｬﾝｽ目"): return 3
        case (true, "強🍒"): return 4
        case (true, "極ﾁｬﾝｽ目"): return 9
        case (true, "🍉"): return 6
        case (false, "ﾁｬﾝｽ目"): return 10
        case (false, "強🍒"): return 11
        case (false, "🍉"): return 12
        default: return 3
        }
    }
}


// ///////////////////////
// 参考情報）レア役からのCZ・AT当選率（通常中／高確中を切り替えて表示）
// ///////////////////////
struct ragnadorTableRareHit: View {
    let stateItems: [String] = ["通常中", "高確中"]
    @State var selectedState: String = "通常中"

    var body: some View {
        VStack(spacing: 15) {
            Picker("", selection: self.$selectedState) {
                ForEach(self.stateItems, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)

            if self.selectedState == self.stateItems[0] {
                VStack(spacing: 5) {
                    Text("CZ当選率")
                        .font(.headline)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercentVer2(
                            columTitle: "弱🍒",
                            percentList: [0.4],
                            numberofDicimal: 1,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "🍉",
                            percentList: [0],
                            numberofDicimal: 0,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "ﾁｬﾝｽ目",
                            percentList: [19.9,21.1,22.3,23.4],
                            numberofDicimal: 0,
                            lineList: [1,1,1,3],
                        )
                        unitTablePercentVer2(
                            columTitle: "強🍒",
                            percentList: [32.8,35.2,37.5,43.0],
                            numberofDicimal: 0,
                            lineList: [1,1,1,3],
                        )
                        unitTablePercentVer2(
                            columTitle: "極ﾁｬﾝｽ目",
                            percentList: [99.6,99.2,98.8],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                    }
                }
                VStack(spacing: 5) {
                    Text("AT当選率")
                        .font(.headline)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercentVer2(
                            columTitle: "弱🍒",
                            percentList: [0],
                            numberofDicimal: 0,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "🍉",
                            percentList: [0.4,0.8,1.2],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                        unitTablePercentVer2(
                            columTitle: "ﾁｬﾝｽ目",
                            percentList: [0.4,0.8,1.2],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                        unitTablePercentVer2(
                            columTitle: "強🍒",
                            percentList: [0.4,0.8,1.6,2.0,2.3],
                            numberofDicimal: 1,
                            lineList: [2,1,1,1,1],
                        )
                        unitTablePercentVer2(
                            columTitle: "極ﾁｬﾝｽ目",
                            percentList: [0.4,0.8,1.2],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                    }
                }
            } else {
                VStack(spacing: 5) {
                    Text("CZ当選率")
                        .font(.headline)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercentVer2(
                            columTitle: "弱🍒",
                            percentList: [0.4],
                            numberofDicimal: 1,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "🍉",
                            percentList: [9.8],
                            numberofDicimal: 1,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "ﾁｬﾝｽ目",
                            percentList: [39.8,41.4,43.0,54.7],
                            numberofDicimal: 0,
                            lineList: [1,1,1,3],
                        )
                        unitTablePercentVer2(
                            columTitle: "強🍒",
                            percentList: [65.6,66.4,68.8,73.4,75.0,76.6],
                            numberofDicimal: 1,
                            lineList: [1,1,1,1,1,1],
                        )
                        unitTablePercentVer2(
                            columTitle: "極ﾁｬﾝｽ目",
                            percentList: [87.5],
                            numberofDicimal: 0,
                            lineList: [6],
                        )
                    }
                }
                VStack(spacing: 5) {
                    Text("AT当選率")
                        .font(.headline)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercentVer2(
                            columTitle: "弱🍒",
                            percentList: [0],
                            numberofDicimal: 0,
                            lineList: [6],
                        )
                        unitTablePercentVer2(
                            columTitle: "🍉",
                            percentList: [0.4,0.8,1.2],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                        unitTablePercentVer2(
                            columTitle: "ﾁｬﾝｽ目",
                            percentList: [0.4,0.8,1.2],
                            numberofDicimal: 1,
                            lineList: [3,1,2],
                        )
                        unitTablePercentVer2(
                            columTitle: "強🍒",
                            percentList: [0.4,0.8,1.6,2.0,2.3],
                            numberofDicimal: 1,
                            lineList: [2,1,1,1,1],
                        )
                        unitTablePercentVer2(
                            columTitle: "極ﾁｬﾝｽ目",
                            percentList: [12.5],
                            numberofDicimal: 0,
                            lineList: [6],
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ragnadorViewNormal(
        ragnador: Ragnador(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
