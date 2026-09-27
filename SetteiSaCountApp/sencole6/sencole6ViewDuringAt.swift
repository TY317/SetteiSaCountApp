//
//  sencole6ViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/02.
//

import SwiftUI

struct sencole6ViewDuringAt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var sencole6: Sencole6
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
    
    let imageNameList: [String] = [
        "sencole6TobiraScreen1",
        "sencole6TobiraScreen2",
        "sencole6TobiraScreen3",
        "sencole6TobiraScreen4",
    ]
    let upperBeltTextList: [String] = [
        "謙信",
        "水着2人",
        "6人",
        "デフォルメ集合",
    ]
    let lowerBeltTextList: [String] = [
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let indexList: [Int] = [0,1,2,3,]
    
    var body: some View {
        List {
            // ---- 天魔一閃 上乗せ枚数
            Section {
                // 300枚
                unitResultRatioPercent2Line(
                    title: "300枚",
                    count: $sencole6.tenmaIssenCount300,
                    bigNumber: $sencole6.tenmaIssenCountSum,
                    numberofDicimal: 1
                )
                .popoverTip(tipVer480Sencole6TenmaIssen())

                // 550枚
                unitResultRatioPercent2Line(
                    title: "550枚",
                    count: $sencole6.tenmaIssenCount550,
                    bigNumber: $sencole6.tenmaIssenCountSum,
                    numberofDicimal: 1
                )

                // 800枚
                unitResultRatioPercent2Line(
                    title: "800枚",
                    count: $sencole6.tenmaIssenCount800,
                    bigNumber: $sencole6.tenmaIssenCountSum,
                    numberofDicimal: 1
                )

                // 1050枚
                unitResultRatioPercent2Line(
                    title: "1050枚",
                    count: $sencole6.tenmaIssenCount1050,
                    bigNumber: $sencole6.tenmaIssenCountSum,
                    numberofDicimal: 0
                )

                // 参考情報）天魔一閃 上乗せ枚数
                unitLinkButtonViewBuilder(sheetTitle: "天魔一閃 上乗せ枚数") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "300枚",
                            percentList: sencole6.ratioTenmaIssen300,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "550枚",
                            percentList: sencole6.ratioTenmaIssen550,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "800枚",
                            percentList: sencole6.ratioTenmaIssen800,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "1050枚",
                            percentList: sencole6.ratioTenmaIssen1050,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 300枚
                        unitCountButtonWithoutRatioWithFunc(
                            title: "300枚",
                            count: $sencole6.tenmaIssenCount300,
                            color: .personalSummerLightBlue,
                            minusBool: $sencole6.minusCheck) {
                                sencole6.tenmaIssenSumFunc()
                            }
                        // 550枚
                        unitCountButtonWithoutRatioWithFunc(
                            title: "550枚",
                            count: $sencole6.tenmaIssenCount550,
                            color: .personalSpringLightYellow,
                            minusBool: $sencole6.minusCheck) {
                                sencole6.tenmaIssenSumFunc()
                            }
                        // 800枚
                        unitCountButtonWithoutRatioWithFunc(
                            title: "800枚",
                            count: $sencole6.tenmaIssenCount800,
                            color: .personalSummerLightGreen,
                            minusBool: $sencole6.minusCheck) {
                                sencole6.tenmaIssenSumFunc()
                            }
                        // 1050枚
                        unitCountButtonWithoutRatioWithFunc(
                            title: "1050枚",
                            count: $sencole6.tenmaIssenCount1050,
                            color: .personalSummerLightRed,
                            minusBool: $sencole6.minusCheck) {
                                sencole6.tenmaIssenSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            sencole6View95Ci(
                                sencole6: sencole6,
                                selection: 3,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        sencole6ViewBayes(
                            sencole6: sencole6,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("天魔一閃 上乗せ枚数")
            }

            // セット開始画面
            Section {
                Text("下記画面はいずれもシナリオ12かつ特定設定以上濃厚")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                unitScreenOnlyDisplay(
                                    image: Image(self.imageNameList[index]),
                                    upperBeltText: self.upperBeltTextList[index],
                                    lowerBeltText: self.lowerBeltTextList[index],
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
            } header: {
                Text("セット開始画面")
            }
            
            // ７揃い停止系
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "特殊停止形での示唆") {
                    sencole6TableSevenLine()
                }
            } header: {
                Text("7揃い停止形")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sencole6MenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sencole6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
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
                unitButtonMinusCheck(minusCheck: $sencole6.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sencole6.resetDuringAt)
            }
        }
    }
}

#Preview {
    sencole6ViewDuringAt(
        sencole6: Sencole6(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
