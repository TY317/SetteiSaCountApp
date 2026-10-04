//
//  mhrsbViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var mhrsb: Mhrsb
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
    @State var selectedItem: String = "青"
    let selectList: [String] = [
        "青",
        "黄",
        "緑",
        "赤",
        "銅",
        "銀",
        "金",
        "紅葉柄",
        "虹",
    ]
    let sisaList: [String] = [
        "奇数設定期待度UP",
        "偶数設定期待度UP",
        "高設定期待度UP（弱）",
        "高設定期待度UP（強）",
        "設定2以上濃厚",
        "設定3以上濃厚",
        "設定4以上濃厚",
        "設定5以上濃厚",
        "設定6濃厚",
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
                    count: bindingEnding(item: self.selectedItem),
                    bigNumber: $mhrsb.endingCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $mhrsb.minusCheck) {
                        mhrsb.endingSumFunc()
                    }
            } header: {
                Text("ランプ色選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingEnding(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $mhrsb.endingCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mhrsbMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
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
                unitButtonMinusCheck(minusCheck: $mhrsb.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhrsb.resetEnding)
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
        case self.selectList[8]: return self.sisaList[8]
        default: return "???"
        }
    }

    private func bindingEnding(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $mhrsb.endingCount1
        case self.selectList[1]: return $mhrsb.endingCount2
        case self.selectList[2]: return $mhrsb.endingCount3
        case self.selectList[3]: return $mhrsb.endingCount4
        case self.selectList[4]: return $mhrsb.endingCount5
        case self.selectList[5]: return $mhrsb.endingCount6
        case self.selectList[6]: return $mhrsb.endingCount7
        case self.selectList[7]: return $mhrsb.endingCount8
        case self.selectList[8]: return $mhrsb.endingCount9
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .green
        case self.selectList[3]: return .red
        case self.selectList[4]: return .brown
        case self.selectList[5]: return .gray
        case self.selectList[6]: return .orange
        case self.selectList[7]: return .pink
        case self.selectList[8]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    mhrsbViewEnding(
        mhrsb: Mhrsb(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
