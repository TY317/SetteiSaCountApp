//
//  karakuri2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import SwiftUI

struct karakuri2ViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var karakuri2: Karakuri2
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
            // レア役
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "強🍒からのCZ・AT当選",
                    count: $karakuri2.kyoCherryCountHit,
                    bigNumber: $karakuri2.kyoCherryCount,
                    numberofDicimal: 0,
                )
                .popoverTip(tipVer412Karakuri2Kyocherry())
                // 強🍒からのCZ・AT当選率
                unitLinkButtonViewBuilder(sheetTitle: "強🍒からのCZ・AT当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "通常滞在時",
                            percentList: karakuri2.ratioKyoCherryHit
                        )
                    }
                }
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    karakuri2TableKoyakuPattern()
                }
                
                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("通常滞在中の強🍒が対象です")
                    }
                    
                    // カウントボタン横並び
                    HStack {
                        // 強チェリー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "強🍒",
                            count: $karakuri2.kyoCherryCount,
                            color: .personalSummerLightRed,
                            minusBool: $karakuri2.minusCheck) {
                                
                            }
                        
                        // CZ・AT当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ・AT当選",
                            count: $karakuri2.kyoCherryCountHit,
                            color: .personalSummerLightPurple,
                            minusBool: $karakuri2.minusCheck) {
                                
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            karakuri2View95Ci(
                                karakuri2: karakuri2,
                                selection: 1,
                            )
                        )
                    )
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("通常 強🍒からの当選")
            }
            
            // モード
            Section {
                // モード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    karakuri2TableMode()
                }
//                .popoverTip(tipVer411Karakuri2Mode())
                
                // モード示唆演出
                unitLinkButtonViewBuilder(sheetTitle: "モード示唆演出") {
                    karakuri2TableModeSisa()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.karakuri2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                // //// マイナスチェック
//                unitButtonMinusCheck(minusCheck: $karakuri2.minusCheck)
//            }
//            ToolbarItem(placement: .automatic) {
//                // /// リセット
//                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetNormal)
//            }
//        }
    }
}

#Preview {
    karakuri2ViewNormal(
        karakuri2: Karakuri2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
