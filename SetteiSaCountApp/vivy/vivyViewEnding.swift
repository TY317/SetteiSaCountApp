//
//  vivyViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var vivy: Vivy
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

    @State var selectedItem: String = "ヴィヴィ"
    let selectList: [String] = [
        "ヴィヴィ",
        "エリザベス",
        "エステラ",
        "グレイス",
        "オフィーリア",
        "マツモト",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "設定2 示唆",
        "設定3 示唆",
        "設定4 示唆",
        "設定5 示唆",
        "設定6 示唆",
    ]

    var body: some View {
        List {
            // ミニキャラ選択
            Section {
                Text("・共通🔔、レア役成立時にミニキャラ出現\n・1体のみ出現時のキャラ種類をカウント\n・複数体出現時は確定系となる")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
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
                    bigNumber: $vivy.charaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $vivy.minusCheck) {
                        vivy.charaSumFunc()
                    }
            } header: {
                Text("ミニキャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $vivy.charaCountSum
                    )
                }

                // 参考情報）キャラ数での示唆
                unitLinkButtonViewBuilder(sheetTitle: "キャラ数での示唆") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: ["1体", "2体", "3体", "4体", "5体", "6体"],
                            maxWidth: 80,
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "キャラの種類で設定を示唆",
                                "設定2 以上濃厚",
                                "設定3 以上濃厚",
                                "設定4 以上濃厚",
                                "設定5 以上濃厚",
                                "設定6 濃厚",
                            ],
                            maxWidth: 250,
                        )
                    }
                }

                // 参考情報）ミニキャラ1体の示唆
                unitLinkButtonViewBuilder(sheetTitle: "1体出現時の振分け") {
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "ヴィヴィ",
                                percentList: vivy.ratioChara1,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "エリザベス",
                                percentList: vivy.ratioChara2,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "エステラ",
                                percentList: vivy.ratioChara3,
                                numberofDicimal: 1,
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "グレイス",
                                percentList: vivy.ratioChara4,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "オフィーリア",
                                percentList: vivy.ratioChara5,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "マツモト",
                                percentList: vivy.ratioChara6,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }

                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        vivyView95Ci(
                            vivy: vivy,
                            selection: self.chara95CiTag(),
                        )
                    )
                )
                // Ci95viewは@Stateで初回の値を保持するので、選択が変わったら作り直す
                .id(self.chara95CiTag())
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vivyMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
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
                unitButtonMinusCheck(minusCheck: $vivy.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vivy.resetChara)
            }
        }
    }

    // ミニキャラの95Ciタグ（ピッカーで選択中のキャラ。ヴィヴィ＝9 〜 マツモト＝14）
    private func chara95CiTag() -> Int {
        let charaIndex = self.selectList.firstIndex(of: self.selectedItem) ?? 0
        return 9 + charaIndex
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        default: return "???"
        }
    }

    private func bindingChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $vivy.charaCount1
        case self.selectList[1]: return $vivy.charaCount2
        case self.selectList[2]: return $vivy.charaCount3
        case self.selectList[3]: return $vivy.charaCount4
        case self.selectList[4]: return $vivy.charaCount5
        case self.selectList[5]: return $vivy.charaCount6
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .red
        case self.selectList[1]: return .gray
        case self.selectList[2]: return .brown
        case self.selectList[3]: return .pink
        case self.selectList[4]: return .purple
        case self.selectList[5]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    vivyViewEnding(
        vivy: Vivy(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
