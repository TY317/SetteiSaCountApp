//
//  ragnadorViewEndVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewEndVoice: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ragnador: Ragnador
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

    @State var selectedItem: String = "油断せずにいきましょう！"
    // ピッカーの選択肢（ボイス9種）
    let selectList: [String] = [
        "油断せずにいきましょう！",
        "拳で語り合おうじゃあねぇか！",
        "邪魔するやつ、嫌い",
        "焼き尽くして差し上げますわ",
        "まいります！",
        "勝負はここからです！",
        "本気でいかせていただきます！",
        "私にまだこんな力が眠っていたなんて…！",
        "私があなたの刃となりましょう！",
    ]
    // 選択中のボイスの示唆（ピッカー直下に表示）
    let sisaList: [String] = [
        "デフォルト",
        "次回白虎以上",
        "次回玄武以上",
        "次回朱雀濃厚",
        "高設定示唆",
        "次回白虎以上＋高設定示唆",
        "次回玄武以上＋高設定示唆",
        "次回朱雀濃厚＋高設定示唆",
        "次回・次々回朱雀＋高設定示唆",
    ]
    // 各ボイスのカウント先（0:デフォルト 1:テーブル示唆 2:高設定示唆）
    let categoryIndexList: [Int] = [0, 1, 1, 1, 2, 2, 2, 2, 2]
    // カウント結果の分類（3行）
    let categoryList: [String] = [
        "デフォルト",
        "テーブル示唆",
        "高設定示唆",
    ]

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

                // //// 示唆＆登録ボタン（示唆はボイスごと、カウントは分類ごと）
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingCategory(index: categoryIndex(item: self.selectedItem)),
                    bigNumber: $ragnador.endVoiceCountSum,
                    flushColor: categoryColor(index: categoryIndex(item: self.selectedItem)),
                    minusCheck: $ragnador.minusCheck) {
                        ragnador.endVoiceSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }

            // カウント結果
            Section {
                ForEach(self.categoryList.indices, id: \.self) { index in
                    unitResultCountListPercent(
                        title: self.categoryList[index],
                        count: bindingCategory(index: index),
                        flashColor: categoryColor(index: index),
                        bigNumber: $ragnador.endVoiceCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ragnadorMenuEndVoiceBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ,AT終了時のボイス")
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
                unitButtonMinusCheck(minusCheck: $ragnador.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ragnador.resetEndVoice)
            }
        }
    }

    // 選択中ボイスの示唆文言
    private func sisaText(item: String) -> String {
        guard let index = self.selectList.firstIndex(of: item),
              self.sisaList.indices.contains(index) else { return "???" }
        return self.sisaList[index]
    }

    // ボイス → カウント先の分類
    private func categoryIndex(item: String) -> Int {
        guard let index = self.selectList.firstIndex(of: item),
              self.categoryIndexList.indices.contains(index) else { return 0 }
        return self.categoryIndexList[index]
    }

    private func bindingCategory(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $ragnador.endVoiceCount1
        case 1: return $ragnador.endVoiceCount2
        case 2: return $ragnador.endVoiceCount3
        default: return .constant(0)
        }
    }

    private func categoryColor(index: Int) -> Color {
        switch index {
        case 0: return .gray
        case 1: return .blue
        case 2: return .red
        default: return .gray
        }
    }
}

#Preview {
    ragnadorViewEndVoice(
        ragnador: Ragnador(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
