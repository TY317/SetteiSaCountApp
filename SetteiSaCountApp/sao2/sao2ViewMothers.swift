//
//  sao2ViewMothers.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct sao2ViewMothers: View {
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
        "ユウキ",
        "リズベット",
        "シリカ",
        "リーファ",
        "アスナ",
        "ユイ",
        "アスナ＆ユウキ",
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
            // キャラ選択
            Section {
                Text("レア役時に登場するミニキャラで設定を示唆")
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
                    count: bindingMotherMiniChara(item: self.selectedItem),
                    bigNumber: $sao2.motherMiniCharaCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $sao2.minusCheck) {
                        sao2.motherMiniCharaSumFunc()
                    }
            } header: {
                Text("ミニキャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingMotherMiniChara(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $sao2.motherMiniCharaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuMothersBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("マザーズ・ロザリオ")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetMotherMiniChara)
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

    private func bindingMotherMiniChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $sao2.motherMiniCharaCount1
        case self.selectList[1]: return $sao2.motherMiniCharaCount2
        case self.selectList[2]: return $sao2.motherMiniCharaCount3
        case self.selectList[3]: return $sao2.motherMiniCharaCount4
        case self.selectList[4]: return $sao2.motherMiniCharaCount5
        case self.selectList[5]: return $sao2.motherMiniCharaCount6
        case self.selectList[6]: return $sao2.motherMiniCharaCount7
        case self.selectList[7]: return $sao2.motherMiniCharaCount8
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
    sao2ViewMothers(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
