//
//  mushotenViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewNormal: View {
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
    
    var body: some View {
        List {
            // ----- レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    VStack(alignment: .leading) {
                        Text("・レア役はヒロイン役のみ")
                        Text("・いずれかのリールにヒロイン図柄停止し、小役揃いなければヒロイン役")
                        Text("・カバネリのチャンス目と同じ")
                    }
                }
            } header: {
                Text("レア役")
            }
            
            // ---- ヒトガミ空間の当選率
            Section {
                VStack(alignment: .leading) {
                    Text("・ヒトガミの空間での本前兆期待度に設定あり")
                    Text("・空間への移行回数と空間での当選回数から当選率を算出します")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 移行
                    unitCountButtonVerticalWithoutRatio(
                        title: "ステージ移行",
                        count: $mushoten.hitogamiCountMove,
                        color: .personalSummerLightGreen,
                        minusBool: $mushoten.minusCheck
                    )
                    // 当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "当選",
                        count: $mushoten.hitogamiCountHit,
                        color: .personalSummerLightRed,
                        minusBool: $mushoten.minusCheck
                    )
                }
                
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "当選率",
                    count: $mushoten.hitogamiCountHit,
                    bigNumber: $mushoten.hitogamiCountMove,
                    numberofDicimal: 0
                )
                
                // 参考情報）当選率
                unitLinkButtonViewBuilder(sheetTitle: "ヒトガミの空間 本前兆期待度") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "本前兆期待度",
                            percentList: mushoten.ratioHitogamiHit
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        mushotenView95Ci(
                            mushoten: mushoten,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    mushotenViewBayes(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ヒトガミの空間　当選率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
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
                unitButtonMinusCheck(minusCheck: $mushoten.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mushoten.resetNormal)
            }
        }
    }
}

#Preview {
    mushotenViewNormal(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
