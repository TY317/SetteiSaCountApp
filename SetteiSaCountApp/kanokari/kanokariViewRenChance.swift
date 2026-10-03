//
//  kanokariViewRenChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewRenChance: View {
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
    @State var selectedItem: String = "麻美→瑠夏→墨→千鶴"
    let selectList: [String] = [
        "麻美→瑠夏→墨→千鶴",
        "瑠夏→墨→千鶴→麻美",
        "墨→千鶴→麻美→瑠夏",
        "千鶴→麻美→瑠夏→墨",
    ]
    let sisaList: [String] = [
        "偶数示唆",
        "奇数示唆",
        "偶数示唆",
        "奇数示唆",
    ]
    // カウント結果は示唆ごと（偶数／奇数）にまとめて表示する。各示唆の代表の選択肢
    var resultItemList: [String] {
        [self.selectList[0], self.selectList[1]]
    }

    var body: some View {
        List {
            // キャラ選択
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・4人攻略後は基本的に次のシナリオが選ばれるため、初回シナリオのみカウント対象")
                    Text("・攻略後に同じシナリオが連続で選ばれたら設定5以上濃厚")
                }
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
                    count: bindingKoryakuChara(item: self.selectedItem),
                    bigNumber: $kanokari.koryakuCharaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $kanokari.minusCheck) {
                        kanokari.koryakuCharaSumFunc()
                    }
            } header: {
                Text("キャラ順選択")
            }

            // カウント結果
            Section {
                ForEach(self.resultItemList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingKoryakuChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $kanokari.koryakuCharaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuRenChanceBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("1Gレンチャンス")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetKoryakuChara)
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

    // 偶数示唆の選択肢は Count1、奇数示唆の選択肢は Count2 にまとめてカウントする
    private func bindingKoryakuChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0], self.selectList[2]: return $kanokari.koryakuCharaCount1
        case self.selectList[1], self.selectList[3]: return $kanokari.koryakuCharaCount2
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0], self.selectList[2]: return .yellow
        case self.selectList[1], self.selectList[3]: return .blue
        default: return .gray
        }
    }
}

#Preview {
    kanokariViewRenChance(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
