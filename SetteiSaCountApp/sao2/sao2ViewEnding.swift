//
//  sao2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct sao2ViewEnding: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
    @State var selectedItem: String = "キリト"
    let selectList: [String] = [
        "キリト",
        "シノン",
        "リズベット",
        "シリカ",
        "銃士X",
        "アスナ",
        "詩乃",
        "シノン＆キリト",
    ]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "奇数示唆 強",
        "偶数示唆 強",
        "高設定示唆",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // ミニキャラ選択
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
                    count: bindingMiniChara(item: self.selectedItem),
                    bigNumber: $sao2.miniCharaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $sao2.minusCheck) {
                        sao2.miniCharaSumFunc()
                    }
            } header: {
                Text("ミニキャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingMiniChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $sao2.miniCharaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
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
                unitButtonMinusCheck(minusCheck: $sao2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetMiniChara)
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

    private func bindingMiniChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $sao2.miniCharaCount1
        case self.selectList[1]: return $sao2.miniCharaCount2
        case self.selectList[2]: return $sao2.miniCharaCount3
        case self.selectList[3]: return $sao2.miniCharaCount4
        case self.selectList[4]: return $sao2.miniCharaCount5
        case self.selectList[5]: return $sao2.miniCharaCount6
        case self.selectList[6]: return $sao2.miniCharaCount7
        case self.selectList[7]: return $sao2.miniCharaCount8
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .blue
        case self.selectList[3]: return .yellow
        case self.selectList[4]: return .green
        case self.selectList[5]: return .red
        case self.selectList[6]: return .orange
        case self.selectList[7]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    sao2ViewEnding(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
