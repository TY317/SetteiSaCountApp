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
            // 1回目のキャラ選択
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
                    count: bindingChara(item: self.selectedItem),
                    bigNumber: $karakuri2.charaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $karakuri2.minusCheck) {
                        karakuri2.charaSumFunc()
                    }
            } header: {
                Text("1回目のキャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $karakuri2.charaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetChara)
            }
        }
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
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
