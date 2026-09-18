//
//  aobutaViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaViewCz: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var aobuta: Aobuta
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

    // 選択中の小役（キャラごとに種類数が違うので添字で保持）
    @State var selectedKoyakuIndex: Int = 0
    // キャラごとの小役一覧（並びは Class の selectListCzChara と対応）
    let koyakuList: [[String]] = [
        ["リプレイ", "🔔", "🍒", "ﾁｬﾝｽ目"],
        ["リプレイ", "🔔", "🍉/🍒", "ﾁｬﾝｽ目"],
        ["リプレイ", "🔔", "🍉", "ﾁｬﾝｽ目"],
        ["リプレイ", "🔔", "🍉", "🍒"],
        ["リプレイ", "🔔"],
        ["リプレイ", "🔔"],
    ]
    // 参考情報の表示文字列（設定2〜6。設定4以上は「〜以上」表記のため文字列で保持）
    let ratioTextList: [[[String]]] = [
            [
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約8%", "約10%", "16%以上", "16%以上", "16%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約61%", "約62%", "66%以上", "66%以上", "66%以上"],
            ],
            [
                ["約8%", "約10%", "20%以上", "20%以上", "20%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約61%", "約62%", "66%以上", "66%以上", "66%以上"],
            ],
            [
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約8%", "約10%", "16%以上", "16%以上", "16%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約61%", "約62%", "66%以上", "66%以上", "66%以上"],
            ],
            [
                ["約67%", "約68%", "70%以上", "70%以上", "70%以上"],
                ["約8%", "約10%", "16%以上", "16%以上", "16%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
            ],
            [
                ["約51%", "約52%", "55%以上", "55%以上", "55%以上"],
                ["約51%", "約52%", "55%以上", "55%以上", "55%以上"],
            ],
            [
                ["約41%", "約42%", "50%以上", "50%以上", "50%以上"],
                ["約8%", "約10%", "10%以上", "10%以上", "10%以上"],
            ],
    ]
    // 選択中キャラの添字
    var charaIndex: Int {
        self.aobuta.selectListCzChara.firstIndex(of: self.aobuta.selectedCzChara) ?? 0
    }

    var body: some View {
        List {
            // ---- 後半最終ゲームの当選率
            Section {
                Text("・キャラごとに設定差のある小役種類、確率が異なります\nキャラを選択してカウントして下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // キャラ（不可思議モード）選択
                unitPickerMenuString(
                    title: "キャラ",
                    selected: $aobuta.selectedCzChara,
                    selectlist: aobuta.selectListCzChara
                )
                .onChange(of: aobuta.selectedCzChara) {
                    // キャラを変えると小役の種類が変わるので先頭に戻す
                    self.selectedKoyakuIndex = 0
                }

                // 小役ごとの当選率
                HStack {
                    ForEach(self.koyakuList[self.charaIndex].indices, id: \.self) { index in
                        unitResultRatioPercent2Line(
                            title: self.koyakuList[self.charaIndex][index],
                            count: bindingHit(self.charaIndex, index),
                            bigNumber: bindingSum(self.charaIndex, index),
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // キャラごとに行のidentityを分ける（切替時のフラッシュ誤発火防止）
                        .id("\(self.aobuta.selectedCzChara)-\(index)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）後半最終ゲームの当選率
                unitLinkButtonViewBuilder(sheetTitle: "後半最終ゲーム 小役別当選率") {
                    VStack(spacing: 20) {
//                        VStack(alignment: .leading) {
//                            Text("・\(self.aobuta.selectedCzChara)での後半最終ゲーム ボーナス当選率")
//                        }
//                        .foregroundStyle(Color.secondary)
//                        .font(.caption)
                        Text("[\(self.aobuta.selectedCzChara)]")
                            .font(.title2)
                            .fontWeight(.bold)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [2,3,4,5,6])
                            ForEach(self.koyakuList[self.charaIndex].indices, id: \.self) { index in
                                unitTableString(
                                    columTitle: self.koyakuList[self.charaIndex][index],
                                    stringList: self.ratioTextList[self.charaIndex][index],
                                    maxWidth: 90,
                                    titleFont: .subheadline,
                                    contentFont: .subheadline,
                                )
                            }
                        }
                    }
                }

                // カウント
                DisclosureGroup {
                    // 小役セグメントピッカー
                    Picker("", selection: self.$selectedKoyakuIndex) {
                        ForEach(self.koyakuList[self.charaIndex].indices, id: \.self) { index in
                            Text(self.koyakuList[self.charaIndex][index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        // 失敗
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: bindingMiss(self.charaIndex, self.selectedKoyakuIndex),
                            color: missColor(self.charaIndex, self.selectedKoyakuIndex),
                            minusBool: $aobuta.minusCheck) {
                                aobuta.czSumFunc()
                            }
                        // 成功
                        unitCountButtonWithoutRatioWithFunc(
                            title: "成功",
                            count: bindingHit(self.charaIndex, self.selectedKoyakuIndex),
                            color: hitColor(self.charaIndex, self.selectedKoyakuIndex),
                            minusBool: $aobuta.minusCheck) {
                                aobuta.czSumFunc()
                            }
                    }
                    // 小役ごとにボタンのidentityを分ける
                    // （unitCountButtonWithoutRatioWithFunc の title/color は @State のため、
                    //   identityを変えないと切替時に色やラベルが更新されない）
                    .id("\(self.aobuta.selectedCzChara)-\(self.selectedKoyakuIndex)")
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("後半最終ゲーム 小役別当選率")
            }

            // ---- 咲太ポイント
            Section {
                // 参考情報）咲太ポイント解放確率
                unitLinkButtonViewBuilder(sheetTitle: "咲太ポイント解放確率") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("・解放されるのはCZ開始時")
                            Text("・咲太ポイントMAXの実質出現確率に設定差")
                        }
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [2,3,4,5,6])
                            unitTableDenominate(
                                columTitle: "解放確率",
                                denominateList: aobuta.ratioCzSakutaPoint,
                                numberofDicimal: 0,
                            )
                        }
                    }
                }
            } header: {
                Text("咲太ポイント(穢れ)")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.aobutaMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
                unitButtonMinusCheck(minusCheck: $aobuta.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: aobuta.resetCz)
            }
        }
    }

    // キャラ×小役 → カウント変数のマッピング
    func bindingMiss(_ chara: Int, _ koyaku: Int) -> Binding<Int> {
        switch (chara, koyaku) {
        case (0, 0): return $aobuta.czKogaReplayCountMiss
        case (0, 1): return $aobuta.czKogaBellCountMiss
        case (0, 2): return $aobuta.czKogaCherryCountMiss
        case (0, 3): return $aobuta.czKogaChanceCountMiss
        case (1, 0): return $aobuta.czNodokaReplayCountMiss
        case (1, 1): return $aobuta.czNodokaBellCountMiss
        case (1, 2): return $aobuta.czNodokaSuikaCherryCountMiss
        case (1, 3): return $aobuta.czNodokaChanceCountMiss
        case (2, 0): return $aobuta.czRioReplayCountMiss
        case (2, 1): return $aobuta.czRioBellCountMiss
        case (2, 2): return $aobuta.czRioSuikaCountMiss
        case (2, 3): return $aobuta.czRioChanceCountMiss
        case (3, 0): return $aobuta.czMaiReplayCountMiss
        case (3, 1): return $aobuta.czMaiBellCountMiss
        case (3, 2): return $aobuta.czMaiSuikaCountMiss
        case (3, 3): return $aobuta.czMaiCherryCountMiss
        case (4, 0): return $aobuta.czKaedeReplayCountMiss
        case (4, 1): return $aobuta.czKaedeBellCountMiss
        case (5, 0): return $aobuta.czShokoReplayCountMiss
        case (5, 1): return $aobuta.czShokoBellCountMiss
        default: return .constant(0)
        }
    }

    func bindingHit(_ chara: Int, _ koyaku: Int) -> Binding<Int> {
        switch (chara, koyaku) {
        case (0, 0): return $aobuta.czKogaReplayCountHit
        case (0, 1): return $aobuta.czKogaBellCountHit
        case (0, 2): return $aobuta.czKogaCherryCountHit
        case (0, 3): return $aobuta.czKogaChanceCountHit
        case (1, 0): return $aobuta.czNodokaReplayCountHit
        case (1, 1): return $aobuta.czNodokaBellCountHit
        case (1, 2): return $aobuta.czNodokaSuikaCherryCountHit
        case (1, 3): return $aobuta.czNodokaChanceCountHit
        case (2, 0): return $aobuta.czRioReplayCountHit
        case (2, 1): return $aobuta.czRioBellCountHit
        case (2, 2): return $aobuta.czRioSuikaCountHit
        case (2, 3): return $aobuta.czRioChanceCountHit
        case (3, 0): return $aobuta.czMaiReplayCountHit
        case (3, 1): return $aobuta.czMaiBellCountHit
        case (3, 2): return $aobuta.czMaiSuikaCountHit
        case (3, 3): return $aobuta.czMaiCherryCountHit
        case (4, 0): return $aobuta.czKaedeReplayCountHit
        case (4, 1): return $aobuta.czKaedeBellCountHit
        case (5, 0): return $aobuta.czShokoReplayCountHit
        case (5, 1): return $aobuta.czShokoBellCountHit
        default: return .constant(0)
        }
    }

    func bindingSum(_ chara: Int, _ koyaku: Int) -> Binding<Int> {
        switch (chara, koyaku) {
        case (0, 0): return $aobuta.czKogaReplayCountSum
        case (0, 1): return $aobuta.czKogaBellCountSum
        case (0, 2): return $aobuta.czKogaCherryCountSum
        case (0, 3): return $aobuta.czKogaChanceCountSum
        case (1, 0): return $aobuta.czNodokaReplayCountSum
        case (1, 1): return $aobuta.czNodokaBellCountSum
        case (1, 2): return $aobuta.czNodokaSuikaCherryCountSum
        case (1, 3): return $aobuta.czNodokaChanceCountSum
        case (2, 0): return $aobuta.czRioReplayCountSum
        case (2, 1): return $aobuta.czRioBellCountSum
        case (2, 2): return $aobuta.czRioSuikaCountSum
        case (2, 3): return $aobuta.czRioChanceCountSum
        case (3, 0): return $aobuta.czMaiReplayCountSum
        case (3, 1): return $aobuta.czMaiBellCountSum
        case (3, 2): return $aobuta.czMaiSuikaCountSum
        case (3, 3): return $aobuta.czMaiCherryCountSum
        case (4, 0): return $aobuta.czKaedeReplayCountSum
        case (4, 1): return $aobuta.czKaedeBellCountSum
        case (5, 0): return $aobuta.czShokoReplayCountSum
        case (5, 1): return $aobuta.czShokoBellCountSum
        default: return .constant(0)
        }
    }

    // 小役ごとのボタン色（失敗＝personal系／成功＝通常色）
    func missColor(_ chara: Int, _ koyaku: Int) -> Color {
        let name = self.koyakuList[chara][koyaku]
        if name.contains("リプレイ") { return .personalSummerLightBlue }
        if name.contains("🔔") { return .personalSpringLightYellow }
        if name.contains("🍉") { return .personalSummerLightGreen }
        if name.contains("🍒") { return .personalSummerLightRed }
        if name.contains("ﾁｬﾝｽ目") { return .personalSummerLightPurple }
        return .gray
    }

    func hitColor(_ chara: Int, _ koyaku: Int) -> Color {
        let name = self.koyakuList[chara][koyaku]
        if name.contains("リプレイ") { return .blue }
        if name.contains("🔔") { return .yellow }
        if name.contains("🍉") { return .green }
        if name.contains("🍒") { return .red }
        if name.contains("ﾁｬﾝｽ目") { return .purple }
        return .gray
    }
}

#Preview {
    aobutaViewCz(
        aobuta: Aobuta(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
