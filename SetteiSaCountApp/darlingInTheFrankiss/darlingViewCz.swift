//
//  darlingViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct darlingViewCz: View {
    @ObservedObject var ver380: Ver380
    @ObservedObject var darling: Darling
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
    @State var lazyVGridCount: Int = 3
    @State var isShowAlert = false
    let titleList: [String] = ["白","青","黄","緑","赤"]
    
    var body: some View {
        List {
            // //// 初期レベル
            Section {
                // カウントボタン横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5,
                        alignment: .center,
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    ForEach(self.titleList.indices, id: \.self) { index in
                        unitCountButtonPercentWithFunc(
                            title: self.titleList[index],
                            count: bindingCount(index: index),
                            color: buttonColor(index: index),
                            bigNumber: $darling.czLevelCountSum,
                            numberofDicimal: 1,
                            minusBool: $darling.minusCheck) {
                                darling.czLevelCountSumFunc()
                            }
                            .padding(.bottom)
                    }
                }
                // 参考情報）初期レベル振分け
                unitLinkButtonViewBuilder(sheetTitle: "初期レベル振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "白",
                            percentList: darling.ratioCzLevelWhite,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "青",
                            percentList: darling.ratioCzLevelBlue,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "黄",
                            percentList: darling.ratioCzLevelYellow,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "緑",
                            percentList: darling.ratioCzLevelGreen,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "赤",
                            percentList: darling.ratioCzLevelRed,
                            numberofDicimal: 1,
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        darlingView95Ci(
                            darling: darling,
                            selection: 6,
                        )
                    )
                )
            } header: {
                Text("初期レベル カウント")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver380.darlingMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
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
        .navigationTitle("CZ 開始時の初期レベル")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $darling.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetCz)
                }
            }
        }
    }
    func bindingCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return darling.$czLevelCountWhite
        case 1: return darling.$czLevelCountBlue
        case 2: return darling.$czLevelCountYellow
        case 3: return darling.$czLevelCountGreen
        case 4: return darling.$czLevelCountRed
        default: return .constant(0)
        }
     }
    
    func buttonColor(index: Int) -> Color {
        switch index {
        case 0: return .grayBack
        case 1: return .personalSummerLightBlue
        case 2: return .personalSpringLightYellow
        case 3: return .personalSummerLightGreen
        case 4: return .personalSummerLightRed
        default: return .grayBack
        }
    }
}

#Preview {
    darlingViewCz(
        ver380: Ver380(),
        darling: Darling(),
    )
}
