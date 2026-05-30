//
//  godKisekiViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiViewFirstHit: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
            // 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $godKiseki.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // AT
//                    unitCountButtonVerticalDenominate(
//                        title: "AT",
//                        count: $godKiseki.firstHitCountAt,
//                        color: .personalSummerLightRed,
//                        bigNumber: $godKiseki.normalGame,
//                        numberofDicimal: 0,
//                        minusBool: $godKiseki.minusCheck
//                    )
                    unitCountButtonVerticalWithoutRatio(
                        title: "AT",
                        count: $godKiseki.firstHitCountAt,
                        color: .personalSummerLightRed,
                        minusBool: $godKiseki.minusCheck
                    )
                    
                    // 昇格Z-ZONE
                    unitCountButtonVerticalWithoutRatio(
                        title: "昇格Z-ZONE",
                        count: $godKiseki.riseZzoneCount,
                        color: .personalSummerLightPurple,
                        minusBool: $godKiseki.minusCheck
                    )
                    .popoverTip(tipVer3270GodKisekiZzoneRise())
                }
                
                // 確率結果
                HStack {
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT初当り",
                        count: $godKiseki.firstHitCountAt,
                        bigNumber: $godKiseki.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 昇格率
                    unitResultRatioPercent2Line(
                        title: "Z-ZONE昇格率",
                        count: $godKiseki.riseZzoneCount,
                        bigNumber: $godKiseki.firstHitCountAt,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: godKiseki.ratioFirstHitAt
                        )
                    }
                }
                
                // 参考情報）GG当選時のZ-ZONE昇格率
                unitLinkButtonViewBuilder(sheetTitle: "GG当選時のZ-ZONE昇格率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "Z-ZONE昇格",
                            percentList: godKiseki.ratioRiseZzone
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        godKisekiView95Ci(
                            godKiseki: godKiseki,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    godKisekiViewBayes(
                        godKiseki: godKiseki,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $godKiseki.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: godKiseki.resetFirstHit)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    godKisekiViewFirstHit(
        godKiseki: GodKiseki(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
