//
//  karakuri2ViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct karakuri2ViewDuringAt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var karakuri2: Karakuri2
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

    @State var selectedItem: String = "ミンシア"
    let selectList: [String] = [
        "ミンシア",
        "リーゼロッテ",
        "ヴィルマ",
        "ジョージ",
    ]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "奇数かつ高設定示唆",
        "偶数かつ高設定示唆",
    ]

    var body: some View {
        List {
            // ---- AT開始時のステージ
            Section {
                // 鳴海ステージ率
                unitResultRatioPercent2Line(
                    title: "鳴海ステージ率",
                    count: $karakuri2.startStageCountHit,
                    bigNumber: $karakuri2.startStageCountSum,
                    numberofDicimal: 0
                )

                // 参考情報）AT開始時のステージ
                unitLinkButtonViewBuilder(sheetTitle: "AT開始時のステージ") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "鳴海ステージ",
                            percentList: karakuri2.ratioStartStageNarumi
                        )
                        unitTablePercent(
                            columTitle: "勝ステージ",
                            percentList: karakuri2.ratioStartStageKatsu
                        )
                    }
                }
                .popoverTip(tipVer450Karakuri2StartStage())

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 勝ステージ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "勝ステージ",
                            count: $karakuri2.startStageCountMiss,
                            color: .personalSummerLightRed,
                            minusBool: $karakuri2.minusCheck) {
                                karakuri2.startStageSumFunc()
                            }
                        // 鳴海ステージ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "鳴海ステージ",
                            count: $karakuri2.startStageCountHit,
                            color: .personalSummerLightGreen,
                            minusBool: $karakuri2.minusCheck) {
                                karakuri2.startStageSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            karakuri2View95Ci(
                                karakuri2: karakuri2,
                                selection: 5,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        karakuri2ViewBayes(
                            karakuri2: karakuri2,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("AT開始時のステージ")
            }
            
            // 1回目のキャラ選択
            Section {
                // 確率結果
                HStack {
                    // 奇数示唆
                    unitResultRatioPercent2Line(
                        title: "奇数示唆合算",
                        count: $karakuri2.charaCountKisuSum,
                        bigNumber: $karakuri2.charaCountSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 偶数示唆
                    unitResultRatioPercent2Line(
                        title: "偶数示唆合算",
                        count: $karakuri2.charaCountGusuSum,
                        bigNumber: $karakuri2.charaCountSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）奇遇合算
                unitLinkButtonViewBuilder(sheetTitle: "キャラシナリオ振分け") {
                    karakuri2TableCharaSenario(karakuri2: karakuri2)
                }
                .popoverTip(tipVer450Karakuri2CharaSenario())
                
                DisclosureGroup {
                    // サークルピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.selectList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    // //// 示唆＆登録ボタン
                    unitCountSubmitWithResult(
                        title: sisaText(item: self.selectedItem),
                        count: bindingChara(item: self.selectedItem),
                        bigNumber: $karakuri2.charaCountSum,
                        flushColor: flushColor(item: self.selectedItem),
                        minusCheck: $karakuri2.minusCheck) {
                            karakuri2.charaSumFunc()
                        }
                    
                    // キャラシナリオ
                    unitLinkButtonViewBuilder(sheetTitle: "キャラシナリオ") {
                        karakuri2TableSenario()
                    }
                    
                    // スペース用の行
                    Text("")
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        .listRowSeparator(.hidden)
                    
                    // カウント結果
                    ForEach(self.selectList, id: \.self) { item in
                        unitResultCountListPercent(
                            title: sisaText(item: item),
                            count: bindingChara(item: item),
                            flashColor: flushColor(item: item),
                            bigNumber: $karakuri2.charaCountSum
                        )
                    }
                    
                    // 参考情報）奇遇合算
                    unitLinkButtonViewBuilder(sheetTitle: "キャラシナリオ振分け") {
                        karakuri2TableCharaSenario(karakuri2: karakuri2)
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            karakuri2View95Ci(
                                karakuri2: karakuri2,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        karakuri2ViewBayes(
                            karakuri2: karakuri2,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("激情ジャッジ キャラシナリオ")
            }
            
            // 踊れオリンピア
            Section {
                // 枚数表示
                unitLinkButtonViewBuilder(sheetTitle: "連打中の枚数表示") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "+20",
                                "+4",
                                "+6",
                            ],
                            maxWidth: 80,
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "設定2 以上濃厚",
                                "設定4 以上濃厚",
                                "設定6 濃厚",
                            ]
                        )
                    }
                }
            } header: {
                Text("踊れオリンピア")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.karakuri2MenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
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
                unitButtonMinusCheck(minusCheck: $karakuri2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetDuringAt)
            }
        }
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[3]
        case self.selectList[3]: return self.sisaList[2]
        default: return "???"
        }
    }

    private func bindingChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $karakuri2.charaCount1
        case self.selectList[1]: return $karakuri2.charaCount2
        case self.selectList[2]: return $karakuri2.charaCount3
        case self.selectList[3]: return $karakuri2.charaCount4
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .green
        case self.selectList[3]: return .red
        default: return .gray
        }
    }
}

#Preview {
    karakuri2ViewDuringAt(
        karakuri2: Karakuri2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
