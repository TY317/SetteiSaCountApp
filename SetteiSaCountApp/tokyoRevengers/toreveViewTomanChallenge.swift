//
//  toreveViewTomanChallenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewTomanChallenge: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    @State var selectedSegment: String = "卍目・弱レア役"
    let segmentList: [String] = ["卍目・弱レア役", "チャンス目", "強🍒"]
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 2
    
    var body: some View {
        List {
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { koyaku in
                        Text(koyaku)
                    }
                }
                .pickerStyle(.segmented)
                // カウントボタン横並び
                // 卍目、弱レア役
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "小役成立",
                            count: $toreve.atRiseCountManji,
                            color: .personalSummerLightGreen,
                            minusBool: $toreve.minusCheck
                        )
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "AT昇格",
                            count: $toreve.atRiseCountManjiRise,
                            color: .green,
                            minusBool: $toreve.minusCheck
                        )
                    }
                }
                // チャンス目
                else if self.selectedSegment == self.segmentList[1] {
                    HStack {
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "小役成立",
                            count: $toreve.atRiseCountChance,
                            color: .personalSummerLightPurple,
                            minusBool: $toreve.minusCheck
                        )
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "AT昇格",
                            count: $toreve.atRiseCountChanceRise,
                            color: .purple,
                            minusBool: $toreve.minusCheck
                        )
                    }
                }
                // 強チェリー
                else {
                    HStack {
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "小役成立",
                            count: $toreve.atRiseCountKyoCherry,
                            color: .personalSummerLightRed,
                            minusBool: $toreve.minusCheck
                        )
                        // 小役カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "AT昇格",
                            count: $toreve.atRiseCountKyoCherryRise,
                            color: .red,
                            minusBool: $toreve.minusCheck
                        )
                    }
                }
                // 確率横並び
                HStack {
                    // 卍目
                    unitResultRatioPercent2Line(
                        title: self.segmentList[0],
                        count: $toreve.atRiseCountManjiRise,
                        bigNumber: $toreve.atRiseCountManji,
                        numberofDicimal: 0,
                        spacerBool: false,
                        titelFont: .subheadline,
                    )
                    // チャンス目
                    unitResultRatioPercent2Line(
                        title: self.segmentList[1],
                        count: $toreve.atRiseCountChanceRise,
                        bigNumber: $toreve.atRiseCountChance,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 強チェリー
                    unitResultRatioPercent2Line(
                        title: self.segmentList[2],
                        count: $toreve.atRiseCountKyoCherryRise,
                        bigNumber: $toreve.atRiseCountKyoCherry,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                // 参考情報）AT昇格率
                unitLinkButtonViewBuilder(sheetTitle: "AT昇格率") {
                    VStack {
                        Text("・レア役から東卍アタック、AT、上位AT、ロングフリーズに当選する可能性あるが、設定差があるのはATのみ")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "卍目・弱レア役",
                                percentList: toreve.ratioAtRiseManji,
                                titleFont: .subheadline,
                            )
                            unitTablePercent(
                                columTitle: "チャンス目",
                                percentList: toreve.ratioAtRiseChance
                            )
                            unitTablePercent(
                                columTitle: "強🍒",
                                percentList: toreve.ratioAtRiseKyoCherry
                            )
                        }
                    }
                }
//                Text("・東卍チャンス中の東卍ラッシュ当選（昇格？）は高設定ほど優遇されている\n・弱めのレア役から東卍ラッシュに当選すれば高設定の期待度アップ")
            } header: {
                Text("AT昇格率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
//            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.toreveMenuTomanChallengeBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
        .navigationTitle("東卍チャンス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetTomanChance)
                }
            }
        }
    }
}

#Preview {
    toreveViewTomanChallenge(
        ver391: Ver391(),
        toreve: Toreve(),
    )
}
