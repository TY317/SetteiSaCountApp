//
//  dropkickViewTuc.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickViewTuc: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var dropkick: Dropkick
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

    @State var selectedItem: String = "芽依"
    let selectList: [String] = [
        "芽依",
        "遊佐＆氷ちゃん",
        "キョンキョン＆ランラン",
        "ぴの＆ぽぽろん",
        "ペルセポネ2世",
        "リエール＆ペルセポネ1世",
        "エキュート＆アトレ",
    ]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "奇数示唆 強",
        "偶数示唆 強",
        "高設定示唆",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // シール種類選択
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
                    count: bindingTucSeal(item: self.selectedItem),
                    bigNumber: $dropkick.tucSealCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $dropkick.minusCheck) {
                        dropkick.tucSealSumFunc()
                    }
            } header: {
                Text("シール種類選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingTucSeal(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $dropkick.tucSealCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.dropkickMenuTucBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("TUC")
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
                unitButtonMinusCheck(minusCheck: $dropkick.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: dropkick.resetTucSeal)
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

    private func bindingTucSeal(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $dropkick.tucSealCount1
        case self.selectList[1]: return $dropkick.tucSealCount2
        case self.selectList[2]: return $dropkick.tucSealCount3
        case self.selectList[3]: return $dropkick.tucSealCount4
        case self.selectList[4]: return $dropkick.tucSealCount5
        case self.selectList[5]: return $dropkick.tucSealCount6
        case self.selectList[6]: return $dropkick.tucSealCount7
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
        case self.selectList[5]: return .orange
        case self.selectList[6]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    dropkickViewTuc(
        dropkick: Dropkick(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
