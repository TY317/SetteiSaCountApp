//
//  rioAceViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceViewNormal: View {
    @ObservedObject var rioAce: RioAce
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
            // 規定リプレイからの当選
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "ハワードゲーム当選",
                    count: $rioAce.kiteiReplayHit,
                    bigNumber: $rioAce.kiteiReplay,
                    numberofDicimal: 0
                )
                
                // 参考情報）ハワードゲーム当選率
                unitLinkButtonViewBuilder(sheetTitle: "ハワードゲーム当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "ハワードゲーム当選",
                            percentList: rioAce.ratioKiteiReplayHit
                        )
                    }
                }
                
                // カウントボタン横並び
                DisclosureGroup {
                    HStack {
                        // 規定回数到達
                        unitCountButtonWithoutRatioWithFunc(
                            title: "規定回数到達",
                            count: $rioAce.kiteiReplay,
                            color: .personalSummerLightBlue,
                            minusBool: $rioAce.minusCheck) {
                                
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $rioAce.kiteiReplayHit,
                            color: .blue,
                            minusBool: $rioAce.minusCheck) {
                                
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            rioAceView95Ci(
                                rioAce: rioAce,
                                selection: 4,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        rioAceViewBayes(
                            rioAce: rioAce,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("規定リプレイからの当選")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
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
                unitButtonMinusCheck(minusCheck: $rioAce.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rioAce.resetNormal)
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
    rioAceViewNormal(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
