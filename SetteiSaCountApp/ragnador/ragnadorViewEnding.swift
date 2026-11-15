//
//  ragnadorViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewEnding: View {
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

    @State var selectedItem: String = "よしっ！"
    let selectList: [String] = [
        "よしっ！",
        "協力いたします！",
        "ここは私にお任せください！",
        "見えそうで…見えない、でしょ？フフッ、ずっと気にしてて",
        "イヅナちゃんと同じくらい、あなたイイ線いってますよ",
        "特別な日なので、日頃の感謝を改めて伝えたかったのです",
        "終わったらみんなでパーチーですそぉ〜",
        "一緒に歩んできた時間が、私の宝物です",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // ボイス選択
            Section {
                Text("・レア役成立時にサブ液晶タッチでボイスが発生")
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
                    count: bindingVoice(item: self.selectedItem),
                    bigNumber: $ragnador.voiceCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $ragnador.minusCheck) {
                        ragnador.voiceSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingVoice(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $ragnador.voiceCountSum
                    )
                }

                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    ragnadorViewBayes(
                        ragnador: ragnador,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ragnadorMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
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
                unitButtonMinusCheck(minusCheck: $ragnador.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ragnador.resetVoice)
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

    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $ragnador.voiceCount1
        case self.selectList[1]: return $ragnador.voiceCount2
        case self.selectList[2]: return $ragnador.voiceCount3
        case self.selectList[3]: return $ragnador.voiceCount4
        case self.selectList[4]: return $ragnador.voiceCount5
        case self.selectList[5]: return $ragnador.voiceCount6
        case self.selectList[6]: return $ragnador.voiceCount7
        case self.selectList[7]: return $ragnador.voiceCount8
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .green
        case self.selectList[3]: return .orange
        case self.selectList[4]: return .brown
        case self.selectList[5]: return .blue
        case self.selectList[6]: return .red
        case self.selectList[7]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    ragnadorViewEnding(
        ragnador: Ragnador(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
