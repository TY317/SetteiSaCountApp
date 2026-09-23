//
//  takosloViewDuringBt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloViewDuringBt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var takoslo: Takoslo
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
            // ---- リプレイ＋タコゲーム同時当選
            Section {
                // 参考情報）リプレイ＋タコゲーム同時当選確率
                unitLinkButtonViewBuilder(sheetTitle: "リプレイ＋タコゲーム同時当選確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "同時当選",
                            denominateList: takoslo.ratioReplayTacoGame,
                            numberofDicimal: 0,
                        )
                    }
                }
            } header: {
                Text("リプレイ＋タコゲーム同時当選")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.takosloMenuDuringBtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BT中")
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
    takosloViewDuringBt(
        takoslo: Takoslo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
