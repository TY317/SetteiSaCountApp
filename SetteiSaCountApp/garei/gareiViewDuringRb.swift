//
//  gareiViewDuringRb.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewDuringRb: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var garei: Garei
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

    @State var selectedItem: String = "男性キャラ(青)"
    let selectList: [String] = [
        "男性キャラ(青)",
        "女性キャラ(赤)",
        "諫山黄泉(紫)",
        "諫山冥(紫)",
        "三途川カズヒロ(金)",
        "1000ちゃん",
    ]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // ---- キャラ選択
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
                    bigNumber: $garei.charaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $garei.minusCheck) {
                        garei.charaSumFunc()
                    }
            } header: {
                Text("キャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $garei.charaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuDuringRbBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("RB")
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
                unitButtonMinusCheck(minusCheck: $garei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: garei.resetChara)
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
        default: return "???"
        }
    }

    private func bindingChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $garei.charaCount1
        case self.selectList[1]: return $garei.charaCount2
        case self.selectList[2]: return $garei.charaCount3
        case self.selectList[3]: return $garei.charaCount4
        case self.selectList[4]: return $garei.charaCount5
        case self.selectList[5]: return $garei.charaCount6
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .red
        case self.selectList[2]: return .purple
        case self.selectList[3]: return .purple
        case self.selectList[4]: return .orange
        case self.selectList[5]: return .blue
        default: return .gray
        }
    }
}

#Preview {
    gareiViewDuringRb(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
