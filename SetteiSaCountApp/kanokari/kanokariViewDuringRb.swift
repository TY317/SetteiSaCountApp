//
//  kanokariViewDuringRb.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewDuringRb: View {
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
    @State var selectedItem: String = "コスプレ無し"
    let selectList: [String] = [
        "コスプレ無し",
        "5人目千鶴がコスプレ",
        "4人目墨からコスプレ",
        "3人目瑠夏からコスプレ",
        "2人目麻美からコスプレ",
        "2人目麻美から水着",
        "4人目墨のみ水着",
        "5人目千鶴のみ水着",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "高設定濃厚(水着4人)",
        "高設定濃厚(墨水着)",
        "高設定濃厚(千鶴水着)",
    ]

    var body: some View {
        List {
            // シナリオ選択
            Section {
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
                    count: bindingCharaSenario(item: self.selectedItem),
                    bigNumber: $kanokari.charaSenarioCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $kanokari.minusCheck) {
                        kanokari.charaSenarioSumFunc()
                    }
            } header: {
                Text("シナリオ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCharaSenario(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $kanokari.charaSenarioCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuDuringRbBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("RB中")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetCharaSenario)
            }
        }
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        case self.selectList[7]: return self.sisaList[7]
        default: return "???"
        }
    }

    private func bindingCharaSenario(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $kanokari.charaSenarioCount1
        case self.selectList[1]: return $kanokari.charaSenarioCount2
        case self.selectList[2]: return $kanokari.charaSenarioCount3
        case self.selectList[3]: return $kanokari.charaSenarioCount4
        case self.selectList[4]: return $kanokari.charaSenarioCount5
        case self.selectList[5]: return $kanokari.charaSenarioCount6
        case self.selectList[6]: return $kanokari.charaSenarioCount7
        case self.selectList[7]: return $kanokari.charaSenarioCount8
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .yellow
        case self.selectList[3]: return .green
        case self.selectList[4]: return .red
        case self.selectList[5]: return .brown
        case self.selectList[6]: return .orange
        case self.selectList[7]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    kanokariViewDuringRb(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
