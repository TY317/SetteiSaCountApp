//
//  seiyaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var seiya: Seiya
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
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    seiyaTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- 守護星座
            Section {
                // 参考情報）守護星座の加護一覧
                unitLinkButtonViewBuilder(sheetTitle: "守護星座の加護一覧") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・WHO ARE YOU？（CZ）当選まで維持される特殊なモード")
                            Text("・守護星座の種類に応じて展開を有利に進められる")
                            Text("・AT中にも存在し、Vゲットチャレンジまで継続する")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "守護星座",
                                stringList: ["星矢", "氷河", "瞬", "紫龍", "一輝"],
                                maxWidth: 70,
                                lineList: [2,2,3,3,3],
                                titleFont: .subheadline,
                            )
                            unitTableString(
                                columTitle: "示唆",
                                stringList: [
                                    "通常時・AT中共通\n周期到達ごとに規定周期短縮を抽選",
                                    "通常時・AT中共通\n小宇宙目停止時の獲得ポイント優遇",
                                    "通常時：弱🍒・小宇宙目からの\n高確移行率が優遇\nAT中：常に高確以上（夕方ステージ以上）濃厚",
                                    "通常時：🍉時のヒロインチャージや\n強CZ抽選が優遇\nAT中：🍉時のVストックチャレンジ当選率が優遇",
                                    "通常時：規定周期で当選するCZがATに変化\nAT中：規定周期で\n鳳凰Vゲットチャレンジを獲得",
                                ],
                                maxWidth: 300,
                                lineList: [2,2,3,3,3],
                                contentFont: .subheadline,
                            )
                        }
                    }
                }
            } header: {
                Text("守護星座")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.seiyaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $seiya.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: seiya.resetNormal)
            }
        }
    }
}

#Preview {
    seiyaViewNormal(
        seiya: Seiya(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
