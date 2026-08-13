//
//  streetFighter6ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var streetFighter6: StreetFighter6
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

    @State var selectedItem: String = "ワッツアップ"
    let selectList: [String] = [
        "ワッツアップ",
        "チェケラー",
        "プチョヘンザ",
        "イッツソークール",
        "シゴロー",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定4 以上濃厚",
    ]

    var body: some View {
        List {
            // ボイス選択
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
                    count: bindingEnding(item: self.selectedItem),
                    bigNumber: $streetFighter6.endingCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $streetFighter6.minusCheck) {
                        streetFighter6.endingSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingEnding(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $streetFighter6.endingCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.streetFighter6MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
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
                unitButtonMinusCheck(minusCheck: $streetFighter6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: streetFighter6.resetEnding)
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
        default: return "???"
        }
    }

    private func bindingEnding(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $streetFighter6.endingCount1
        case self.selectList[1]: return $streetFighter6.endingCount2
        case self.selectList[2]: return $streetFighter6.endingCount3
        case self.selectList[3]: return $streetFighter6.endingCount4
        case self.selectList[4]: return $streetFighter6.endingCount5
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .yellow
        case self.selectList[3]: return .red
        case self.selectList[4]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    streetFighter6ViewEnding(
        streetFighter6: StreetFighter6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
