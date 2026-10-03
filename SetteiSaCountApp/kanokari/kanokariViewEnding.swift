//
//  kanokariViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewEnding: View {
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
    @State var selectedItem: String = "あがる〜"
    let selectList: [String] = [
        "あがる〜",
        "彼女はいりまーす",
        "ふんっふんっ",
        "今は恋人、遠慮しない",
        "あれー嫉妬させちゃった？",
        "私が一番好きだもん",
        "私もいるから",
        "もう恋なんてしないって決めてるんだから",
        "なんだか少しお酒の味",
        "今日は私がおもてなし",
        "私どんな顔してたかな",
    ]
    // 各ボイスの示唆（sisaList のインデックス）。デフォルトの4ボイスは同じカウントにまとめる
    let voiceSisaIndex: [Int] = [0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaColorList: [Color] = [.gray, .yellow, .green, .red, .brown, .orange, .gray, .purple]

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
                let sisaIndex = self.sisaIndex(item: self.selectedItem)
                unitCountSubmitWithResult(
                    title: self.sisaList[sisaIndex],
                    count: bindingEndingVoice(sisaIndex: sisaIndex),
                    bigNumber: $kanokari.endingVoiceCountSum,
                    flushColor: self.sisaColorList[sisaIndex],
                    minusCheck: $kanokari.minusCheck) {
                        kanokari.endingVoiceSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }

            // カウント結果
            Section {
                ForEach(self.sisaList.indices, id: \.self) { index in
                    unitResultCountListPercent(
                        title: self.sisaList[index],
                        count: bindingEndingVoice(sisaIndex: index),
                        flashColor: self.sisaColorList[index],
                        bigNumber: $kanokari.endingVoiceCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
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
                unitButtonMinusCheck(minusCheck: $kanokari.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetEndingVoice)
            }
        }
    }

    // //// 選択したボイスの示唆（sisaList のインデックス）
    private func sisaIndex(item: String) -> Int {
        guard let index = self.selectList.firstIndex(of: item) else { return 0 }
        return self.voiceSisaIndex[index]
    }

    private func bindingEndingVoice(sisaIndex: Int) -> Binding<Int> {
        switch sisaIndex {
        case 0: return $kanokari.endingVoiceCount1
        case 1: return $kanokari.endingVoiceCount2
        case 2: return $kanokari.endingVoiceCount3
        case 3: return $kanokari.endingVoiceCount4
        case 4: return $kanokari.endingVoiceCount5
        case 5: return $kanokari.endingVoiceCount6
        case 6: return $kanokari.endingVoiceCount7
        case 7: return $kanokari.endingVoiceCount8
        default: return .constant(0)
        }
    }
}

#Preview {
    kanokariViewEnding(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
