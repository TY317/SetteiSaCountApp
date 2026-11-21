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

            // エピソード映像
            Section {
                // 参考情報）エピソードの出現順
                unitLinkButtonViewBuilder(sheetTitle: "エピソードでの示唆") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("・エピソードはエンディング1回につき1つで、順番は初回のエンディング移行時に決まる")
                            Text("・3種類すべてが出るまで再抽選されず、通常時を挟んでも順番は引き継がれる")
                            Text("・過去のエピソードはメニュー画面のエンディング履歴で確認できる")
                            Text("・特殊エピソードは毎回発生を抽選し、出現すれば特定の設定が濃厚")
                        }
                        VStack {
                            Text("[通常エピソード 順番での示唆]")
                                .font(.title3)
                            HStack(spacing: 0) {
                                unitTableString(
                                    columTitle: "1回目→2回目→3回目",
                                    stringList: [
                                        "二人のゲンドウ\n→奪われた3式機龍\n→真相に近づく男",
                                        "二人のゲンドウ\n→真相に近づく男\n→奪われた3式機龍",
                                        "奪われた3式機龍\n→二人のゲンドウ\n→真相に近づく男",
                                        "奪われた3式機龍\n→真相に近づく男\n→二人のゲンドウ",
                                        "真相に近づく男\n→二人のゲンドウ\n→奪われた3式機龍",
                                        "真相に近づく男\n→奪われた3式機龍\n→二人のゲンドウ",
                                    ],
                                    maxWidth: 200,
                                    lineList: [3,3,3,3,3,3],
                                    contentFont: .subheadline,
                                )
                                unitTableString(
                                    columTitle: "示唆",
                                    stringList: [
                                        "奇数示唆",
                                        "奇数かつ高設定示唆 弱",
                                        "偶数示唆",
                                        "偶数かつ高設定示唆 弱",
                                        "奇数かつ高設定示唆 強",
                                        "偶数かつ高設定示唆 強",
                                    ],
                                    maxWidth: 150,
                                    lineList: [3,3,3,3,3,3],
                                    contentFont: .subheadline,
                                )
                            }
                        }
                        VStack {
                            Text("[特殊エピソード]")
                                .font(.title3)
                            HStack(spacing: 0) {
                                unitTableString(
                                    columTitle: "",
                                    stringList: [
                                        "ひとときの休暇",
                                        "大花火大会",
                                        "救いし者、渚カヲル",
                                    ],
                                    maxWidth: 200,
                                    lineList: [1,1,2],
                                )
                                unitTableString(
                                    columTitle: "示唆",
                                    stringList: [
                                        "偶数設定濃厚",
                                        "設定4以上濃厚",
                                        "設定6濃厚",
                                    ],
                                    maxWidth: 150,
                                    lineList: [1,1,2],
                                )
                            }
                        }
                    }
                }
                .popoverTip(tipVer4120Goeva2Episode())
            } header: {
                Text("エピソード映像")
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
