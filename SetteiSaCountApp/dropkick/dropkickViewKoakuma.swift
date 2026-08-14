//
//  dropkickViewKoakuma.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickViewKoakuma: View {
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

    @State var selectedItem: String = "邪神ちゃん"
    let selectList: [String] = [
        "邪神ちゃん",
        "ゆりね",
        "ミノス",
        "ぺこら",
        "メデューサ",
        "ペルセポネ2世",
        "氷ちゃん",
        "遊佐",
        "キョンキョン",
        "ランラン",
        "ぴの",
        "ぽぽろん",
        "芽依",
        "リエール",
        "ペルセポネ1世",
        "エキュート",
        "アトレ",
        "邪神ちゃんジャスティス",
        "邪神ちゃんファイター",
        "邪神ちゃんコマンダー",
        "邪神ちゃんエスプ",
        "邪神ちゃんジーニアス",
        "パーフェクト邪神ちゃん",
        "悪魔コスゆりね",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定1 否定",
        "設定2 否定",
        "設定3 否定",
        "設定3 以上濃厚",
        "設定1・3否定",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]

    var body: some View {
        List {
            // キャラ選択
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
                    count: bindingChara(sisa: sisaText(item: self.selectedItem)),
                    bigNumber: $dropkick.charaCountSum,
                    flushColor: flushColor(sisa: sisaText(item: self.selectedItem)),
                    minusCheck: $dropkick.minusCheck) {
                        dropkick.charaSumFunc()
                    }
            } header: {
                Text("キャラ選択")
            }

            // カウント結果
            Section {
                ForEach(self.sisaList, id: \.self) { sisa in
                    unitResultCountListPercent(
                        title: sisa,
                        count: bindingChara(sisa: sisa),
                        flashColor: flushColor(sisa: sisa),
                        bigNumber: $dropkick.charaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.dropkickMenuKoakumaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("小悪魔ボーナス")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: dropkick.resetChara)
            }
        }
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[0]
        case self.selectList[2]: return self.sisaList[1]
        case self.selectList[3]: return self.sisaList[1]
        case self.selectList[4]: return self.sisaList[2]
        case self.selectList[5]: return self.sisaList[2]
        case self.selectList[6]: return self.sisaList[0]
        case self.selectList[7]: return self.sisaList[0]
        case self.selectList[8]: return self.sisaList[1]
        case self.selectList[9]: return self.sisaList[1]
        case self.selectList[10]: return self.sisaList[2]
        case self.selectList[11]: return self.sisaList[2]
        case self.selectList[12]: return self.sisaList[3]
        case self.selectList[13]: return self.sisaList[3]
        case self.selectList[14]: return self.sisaList[3]
        case self.selectList[15]: return self.sisaList[4]
        case self.selectList[16]: return self.sisaList[4]
        case self.selectList[17]: return self.sisaList[5]
        case self.selectList[18]: return self.sisaList[6]
        case self.selectList[19]: return self.sisaList[7]
        case self.selectList[20]: return self.sisaList[8]
        case self.selectList[21]: return self.sisaList[9]
        case self.selectList[22]: return self.sisaList[10]
        case self.selectList[23]: return self.sisaList[11]
        default: return "???"
        }
    }

    private func bindingChara(sisa: String) -> Binding<Int> {
        switch sisa {
        case self.sisaList[0]: return $dropkick.charaCount1
        case self.sisaList[1]: return $dropkick.charaCount2
        case self.sisaList[2]: return $dropkick.charaCount3
        case self.sisaList[3]: return $dropkick.charaCount4
        case self.sisaList[4]: return $dropkick.charaCount5
        case self.sisaList[5]: return $dropkick.charaCount6
        case self.sisaList[6]: return $dropkick.charaCount7
        case self.sisaList[7]: return $dropkick.charaCount8
        case self.sisaList[8]: return $dropkick.charaCount9
        case self.sisaList[9]: return $dropkick.charaCount10
        case self.sisaList[10]: return $dropkick.charaCount11
        case self.sisaList[11]: return $dropkick.charaCount12
        default: return .constant(0)
        }
    }

    private func flushColor(sisa: String) -> Color {
        switch sisa {
        case self.sisaList[0]: return .gray
        case self.sisaList[1]: return .blue
        case self.sisaList[2]: return .yellow
        case self.sisaList[3]: return .green
        case self.sisaList[4]: return .red
        case self.sisaList[5]: return .brown
        case self.sisaList[6]: return .cyan
        case self.sisaList[7]: return .yellow
        case self.sisaList[8]: return .gray
        case self.sisaList[9]: return .yellow
        case self.sisaList[10]: return .orange
        case self.sisaList[11]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    dropkickViewKoakuma(
        dropkick: Dropkick(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
