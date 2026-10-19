//
//  kanokariViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kanokari: Kanokari
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
    // ゾーンの選択
    let zoneGameList: [String] = ["100G", "300G"]
    @State var zoneGameSelected: String = "100G"
    let zone300List: [String] = ["100G当選後", "100Gスルー後"]
    @State var zone300Selected: String = "100G当選後"
    // 0＝100G、1＝300G（100G当選後）、2＝300G（100Gスルー後）
    var zoneIndex: Int {
        if self.zoneGameSelected == self.zoneGameList[0] {
            return 0
        }
        return 1 + (self.zone300List.firstIndex(of: self.zone300Selected) ?? 0)
    }
    var body: some View {
        List {
            // ---- ゾーンでのCZ当選率（かのかりBONUS後）
            Section {
                // 確率横並び
                HStack {
                    // 100G
                    unitResultRatioPercent2Line(
                        title: "100G",
                        count: $kanokari.zone100CountHit,
                        bigNumber: $kanokari.zone100CountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 300G 当選後
                    unitResultRatioPercent2Line(
                        title: "300G(100G当選後)",
                        count: $kanokari.zone300AtariCountHit,
                        bigNumber: $kanokari.zone300AtariCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 300G スルー後
                    unitResultRatioPercent2Line(
                        title: "300G(100Gスルー後)",
                        count: $kanokari.zone300ThroughCountHit,
                        bigNumber: $kanokari.zone300ThroughCountSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .popoverTip(tipVer491KanokariZone())

                // 参考情報）ゾーンでのCZ当選率（独自算出）
                unitLinkButtonViewBuilder(sheetTitle: "ゾーンでのCZ当選率（独自算出）") {
                    VStack(alignment: .leading) {
                        Text("・当アプリによる独自算出の参考値です")
                        Text("・かのかりBONUS後のモード振分けと、各モードのゾーンでのCZ当選率から算出")
                        Text("・300Gは100Gの結果からモードの見込みを補正して算出（100Gで当選するとモードB・Cの可能性が上がり、スルーするとモードCは否定される）")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex(titleLine: 2)
                        unitTablePercent(
                            columTitle: "100G",
                            percentList: kanokari.ratioZone100,
                            numberofDicimal: 0,
                            titleLine: 2,
                        )
                        unitTablePercent(
                            columTitle: "300G\n100G当選後",
                            percentList: kanokari.ratioZone300Atari,
                            numberofDicimal: 1,
                            titleLine: 2,
                        )
                        unitTablePercent(
                            columTitle: "300G\n100Gスルー後",
                            percentList: kanokari.ratioZone300Through,
                            numberofDicimal: 1,
                            titleLine: 2,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・かのかりBONUS後、1Gレンチャンス終了後のみカウント")
                        Text("・ゾーン到達前に当選した場合、そのゾーンはカウントしない")
                        Text("・300Gは、その手前の100Gで当選したかどうかで選択")
                        Text("・100Gをカウントしていない場合は300Gもカウントしない")
                    }
                    // セグメントピッカー
                    Picker("", selection: self.$zoneGameSelected) {
                        ForEach(self.zoneGameList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    // 300Gのときは100Gの結果を選択
                    if self.zoneGameSelected == self.zoneGameList[1] {
                        Picker("", selection: self.$zone300Selected) {
                            ForEach(self.zone300List, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    // カウントボタン横並び
                    HStack {
                        if self.zoneIndex == 0 {
                            // CZ当選なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選なし",
                                count: $kanokari.zone100CountMiss,
                                color: .personalSummerLightRed,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone100SumFunc()
                                }
                            // CZ当選あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選あり",
                                count: $kanokari.zone100CountHit,
                                color: .red,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone100SumFunc()
                                }
                        }
                        else if self.zoneIndex == 1 {
                            // CZ当選なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選なし",
                                count: $kanokari.zone300AtariCountMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone300AtariSumFunc()
                                }
                            // CZ当選あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選あり",
                                count: $kanokari.zone300AtariCountHit,
                                color: .blue,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone300AtariSumFunc()
                                }
                        }
                        else if self.zoneIndex == 2 {
                            // CZ当選なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選なし",
                                count: $kanokari.zone300ThroughCountMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone300ThroughSumFunc()
                                }
                            // CZ当選あり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選あり",
                                count: $kanokari.zone300ThroughCountHit,
                                color: .green,
                                minusBool: $kanokari.minusCheck) {
                                    kanokari.zone300ThroughSumFunc()
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kanokariView95Ci(
                                kanokari: kanokari,
                                selection: 14 + self.zoneIndex,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kanokariViewBayes(
                            kanokari: kanokari,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("ゾーンでのCZ当選率（かのかりBONUS後）")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    kanokariTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- モード
            Section {
                // 参考情報）かのかりBONUS後のモード振分け
                unitLinkButtonViewBuilder(sheetTitle: "かのかりBONUS後のモード振分け") {
                    VStack(alignment: .leading) {
                        Text("・かのかりBONUS後（1Gレンチャンス終了後も同様）のモード振分け")
                        Text("・高設定ほどモードB・Cが選ばれやすく、100G・300GでのCZ当選に期待できる")
                        Text("・設定変更後・REG後のモード移行は設定差なし")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "モードA",
                            percentList: kanokari.ratioModeA,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "モードB",
                            percentList: kanokari.ratioModeB,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "モードC",
                            percentList: kanokari.ratioModeC,
                            numberofDicimal: 1,
                        )
                    }
                }

                // 参考情報）抽選タイミングごとのモード分布
                unitLinkButtonViewBuilder(sheetTitle: "モード移行期待度") {
                    kanokariTableModeMove()
                }

                // 参考情報）モードごとのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "ゲーム数 CZ当選率テーブル") {
                    kanokariTableModeTable()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
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
                unitButtonMinusCheck(minusCheck: $kanokari.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetNormal)
            }
        }
    }
}

#Preview {
    kanokariViewNormal(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
