//
//  goeva2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var goeva2: Goeva2
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

    @State var selectedItem: String = "笑えばいいと思うよ"
    let selectList: [String] = [
        "笑えばいいと思うよ",
        "風呂は命の洗濯よ",
        "いい匂い 他人の匂いのするエヴァも悪くない",
        "グーテン・モルゲン",
        "ニンニクラーメン チャーシュー抜き",
        "大人はさ、ズルいくらいがちょうどいいんだ",
        "もうすぐ会えるな ユイ",
        "ありがとう 君に会えて嬉しかったよ",
    ]
    let sisaList: [String] = [
        "奇数示唆",
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
            // ボイス
            Section {
                Text("・レア役成立時にPUSHボタンでボイス発生")
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
                    bigNumber: $goeva2.voiceCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $goeva2.minusCheck) {
                        goeva2.voiceSumFunc()
                    }
            } header: {
                Text("ボイス")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingVoice(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $goeva2.voiceCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goeva2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
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
                unitButtonMinusCheck(minusCheck: $goeva2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: goeva2.resetVoice)
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
        case self.selectList[0]: return $goeva2.voiceCount1
        case self.selectList[1]: return $goeva2.voiceCount2
        case self.selectList[2]: return $goeva2.voiceCount3
        case self.selectList[3]: return $goeva2.voiceCount4
        case self.selectList[4]: return $goeva2.voiceCount5
        case self.selectList[5]: return $goeva2.voiceCount6
        case self.selectList[6]: return $goeva2.voiceCount7
        case self.selectList[7]: return $goeva2.voiceCount8
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
        case self.selectList[5]: return .orange
        case self.selectList[6]: return .pink
        case self.selectList[7]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    goeva2ViewEnding(
        goeva2: Goeva2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
