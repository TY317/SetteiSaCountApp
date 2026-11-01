//
//  goeva2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var goeva2: Goeva2
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
            // ---- キャラ別セリフ
            Section {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "キャラ",
                        stringList: ["シンジ", "アスカ", "ミサト", "ゲンドウ", "カヲル"],
                        maxWidth: 80,
                        lineList: [1,1,1,2,2],
                    )
                    unitTableString(
                        columTitle: "セリフ",
                        stringList: [
                            "笑えばいいと思うよ",
                            "グーテン・モルゲン",
                            "風呂は命の洗濯よ",
                            "もうすぐ会えるな\nユイ",
                            "ありがとう\n君に会えて嬉しかったよ",
                        ],
                        maxWidth: 200,
                        lineList: [1,1,1,2,2],
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: ["調査中"],
                        maxWidth: 70,
                        lineList: [7],
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("キャラ別セリフ")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.goeva2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
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
    goeva2ViewEnding(
        goeva2: Goeva2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
