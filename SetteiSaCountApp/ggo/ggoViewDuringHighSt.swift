//
//  ggoViewDuringHighSt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoViewDuringHighSt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ggo: Ggo
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
            // 開始画面
            Section {
                Text("・クライマックスバトルの開始画面が青背景以外だと何らかの設定示唆になる！？")
            } header: {
                Text("クライマックスバトル 開始画面")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ggoMenuDuringHighStBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("上位ST中")
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
    ggoViewDuringHighSt(
        ggo: Ggo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
