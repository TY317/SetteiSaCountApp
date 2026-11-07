//
//  seiyaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var seiya: Seiya
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
        "虹",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数設定示唆",
        "偶数設定示唆",
        "設定2以上濃厚",
        "設定4以上濃厚",
        "設定6濃厚",
    ]

    var body: some View {
        List {
            // レア役時のPUSHランプ
            Section {
                Text("・レア役成立時にPUSHボタンでランプ、ボタン色が変化")
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
                    bigNumber: $seiya.lampCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $seiya.minusCheck) {
                        seiya.lampSumFunc()
                    }
            } header: {
                Text("ランプ色")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingLamp(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $seiya.lampCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.seiyaMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
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
                unitButtonMinusCheck(minusCheck: $seiya.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: seiya.resetLamp)
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

    private func bindingLamp(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $seiya.lampCount1
        case self.selectList[1]: return $seiya.lampCount2
        case self.selectList[2]: return $seiya.lampCount3
        case self.selectList[3]: return $seiya.lampCount4
        case self.selectList[4]: return $seiya.lampCount5
        case self.selectList[5]: return $seiya.lampCount6
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
        default: return .gray
        }
    }
}

#Preview {
    seiyaViewEnding(
        seiya: Seiya(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
