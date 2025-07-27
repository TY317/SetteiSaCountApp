//
//  magiaViewEpisode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/24.
//

import SwiftUI

struct magiaViewEpisode: View {
    @ObservedObject var ver352: Ver352
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
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
    let charaName: [String] = ["やちよ","鶴乃","さな","フェリシア","黒江"]
    let colorList: [Color] = [
        .personalSpringLightYellow,
        .personalSummerLightBlue,
        .personalSummerLightGreen,
        .personalSummerLightPurple,
        .gray
    ]
    
    var body: some View {
        List {
            // //// エピソードキャラカウント
            Section {
                Text("黒江チャレンジ成功時は黒江エピソード確定となるためカウントから除外")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    ForEach(self.charaName.indices, id: \.self) { index in
                        unitCountButtonPercentWithFunc(
                            title: self.charaName[index],
                            count: bindingForCount(index: index),
                            color: self.colorList[index],
                            bigNumber: $magia.episodeCountSum,
                            numberofDicimal: 0,
                            minusBool: $magia.minusCheck,
                            action: magia.episodeSumFunc
                        )
                        .padding(.bottom)
                    }
                }
                // //// 参考情報）エピソード種類
                unitLinkButtonViewBuilder(sheetTitle: "エピソード振り分け") {
                    VStack {
                        VStack {
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: self.charaName[0],
                                    percentList: magia.ratioEpisodeYachiyo
                                )
                                unitTablePercent(
                                    columTitle: self.charaName[1],
                                    percentList: magia.ratioEpisodeTsuruno
                                )
                                unitTablePercent(
                                    columTitle: self.charaName[2],
                                    percentList: magia.ratioEpisodeSana
                                )
                            }
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: self.charaName[3],
                                    percentList: magia.ratioEpisodeFerishia
                                )
                                unitTablePercent(
                                    columTitle: self.charaName[4],
                                    percentList: magia.ratioEpisodeKuroe,
                                    numberofDicimal: 1
                                )
                            }
                        }
                    }
                }
            } header: {
                Text("エピソード種類")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver352.magiaMenuEpisodeBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
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
        .navigationTitle("エピソードボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetEpisode)
                }
            }
        }
    }
    func bindingForCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $magia.episodeCountYachiyo
        case 1: return $magia.episodeCountTsuruno
        case 2: return $magia.episodeCountSana
        case 3: return $magia.episodeCountFerishia
        case 4: return $magia.episodeCountKuroe
        default: return .constant(0)
        }
    }
}

#Preview {
    magiaViewEpisode(
        ver352: Ver352(),
        magia: Magia(),
    )
}
