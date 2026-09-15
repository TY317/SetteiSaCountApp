//
//  gareiViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewCz: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var garei: Garei
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

    var body: some View {
        List {
            // ---- 乱撃突入率
            Section {
                // 突入率
                unitResultRatioPercent2Line(
                    title: "突入率",
                    count: $garei.czRangekiCountHit,
                    bigNumber: $garei.czRangekiCountSum,
                    numberofDicimal: 1
                )
                
                // 参考情報）乱撃突入率
                unitLinkButtonViewBuilder(sheetTitle: "乱撃突入率") {
                    Text("・超自然災害モード突入時の乱撃突入率に設定差あり")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "乱撃突入率",
                            percentList: garei.ratioCzRangeki,
                            numberofDicimal: 1,
                        )
                    }
                }
                
                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 突入なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入なし",
                            count: $garei.czRangekiCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $garei.minusCheck) {
                                garei.rangekiSumFunc()
                            }
                        // 突入
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入あり",
                            count: $garei.czRangekiCountHit,
                            color: .personalSummerLightPurple,
                            minusBool: $garei.minusCheck) {
                                garei.rangekiSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            gareiView95Ci(
                                garei: garei,
                                selection: 13,
                            )
                        )
                    )
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("乱撃突入率")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gareiMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
    }
}

#Preview {
    gareiViewCz(
        garei: Garei(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
