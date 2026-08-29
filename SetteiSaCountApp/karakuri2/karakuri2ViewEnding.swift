//
//  karakuri2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct karakuri2ViewEnding: View {
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

    @State var selectedItem: String = "白"
    let selectList: [String] = [
        "白",
        "青",
        "黄",
        "緑",
        "赤",
        "紫",
        "虹",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定2 以上示唆",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // ランプ色選択
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
                    count: bindingLampColor(item: self.selectedItem),
                    bigNumber: $karakuri2.lampColorCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $karakuri2.minusCheck) {
                        karakuri2.lampColorSumFunc()
                    }
            } header: {
                Text("ランプ色選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingLampColor(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $karakuri2.lampColorCountSum
                    )
                }
                // 参考情報）ランプ色振分け
                unitLinkButtonViewBuilder(sheetTitle: "ランプ色振分け") {
                    karakuri2TableLampColor(karakuri2: karakuri2)
                }

                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    karakuri2ViewBayes(
                        karakuri2: karakuri2,
                    )
                }
            } header: {
                Text("カウント結果")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.karakuri2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
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
                unitButtonMinusCheck(minusCheck: $karakuri2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetLampColor)
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
        default: return "???"
        }
    }

    private func bindingLampColor(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $karakuri2.lampColorCount1
        case self.selectList[1]: return $karakuri2.lampColorCount2
        case self.selectList[2]: return $karakuri2.lampColorCount3
        case self.selectList[3]: return $karakuri2.lampColorCount4
        case self.selectList[4]: return $karakuri2.lampColorCount5
        case self.selectList[5]: return $karakuri2.lampColorCount6
        case self.selectList[6]: return $karakuri2.lampColorCount7
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
        case self.selectList[5]: return .purple
        case self.selectList[6]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    karakuri2ViewEnding(
        karakuri2: Karakuri2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
