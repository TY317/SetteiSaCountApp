//
//  gareiViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewEnding: View {
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

    @State var selectedItem: String = "点灯ナシ"
    let selectList: [String] = [
        "点灯ナシ",
        "青",
        "黄",
        "緑",
        "赤",
        "紫",
        "三途河カラー",
        "カラフル",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "奇数＆高設定示唆",
        "偶数＆高設定示唆",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // ---- 殺生石ランプ
            Section {
                // 説明書き
                Text("レア役入賞後にPUSHボタンを押すと、殺生石役物で設定示唆")
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
                    count: bindingLamp(item: self.selectedItem),
                    bigNumber: $garei.lampCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $garei.minusCheck) {
                        garei.lampSumFunc()
                    }
            } header: {
                Text("殺生石ランプ")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingLamp(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $garei.lampCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
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
                unitButtonMinusCheck(minusCheck: $garei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: garei.resetLamp)
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

    private func bindingLamp(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $garei.lampCount1
        case self.selectList[1]: return $garei.lampCount2
        case self.selectList[2]: return $garei.lampCount3
        case self.selectList[3]: return $garei.lampCount4
        case self.selectList[4]: return $garei.lampCount5
        case self.selectList[5]: return $garei.lampCount6
        case self.selectList[6]: return $garei.lampCount7
        case self.selectList[7]: return $garei.lampCount8
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
        case self.selectList[7]: return .pink
        default: return .gray
        }
    }
}

#Preview {
    gareiViewEnding(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
