//
//  mushotenViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewDuringAt: View {
    @ObservedObject var mushoten: Mushoten
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
    
    let imageNameList: [String] = [
        "mushotenRoundScreen1",
        "mushotenRoundScreen2",
        "mushotenRoundScreen3",
        "mushotenRoundScreen4",
    ]
    let upperBeltTextList: [String] = [
        "ヒロイン3人",
        "ヒトガミ",
        "前世の男",
        "オルステッド",
    ]
    let lowerBeltTextList: [String] = [
        "V1個以上＋偶数濃厚",
        "V1個以上＋4以上濃厚",
        "V1個以上＋5以上濃厚",
        "V1個以上＋6濃厚",
    ]
    let indexList: [Int] = [0,1,2,3]
    var body: some View {
        List {
            // 画面情報のみ
            Section {
                Text("赤背景画面はVストック1個以上かつ特定設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン
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
                Text("ラウンド開始画面")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mushotenViewDuringAt(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
