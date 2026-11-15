//
//  ragnadorViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var ragnador: Ragnador
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
            // ---- 弱チェリーの状態昇格率
            Section {
                HStack {
                    // 高確以上
                    unitResultRatioPercent2Line(
                        title: "高確移行",
                        count: $ragnador.weakCherryUpCountHighOver,
                        bigNumber: $ragnador.weakCherryCount,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 超高確
                    unitResultRatioPercent2Line(
                        title: "超高確移行",
                        count: $ragnador.weakCherryUpCountSuperHigh,
                        bigNumber: $ragnador.weakCherryCount,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）弱チェリーの状態昇格率
                unitLinkButtonViewBuilder(sheetTitle: "弱チェリーでの状態昇格率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "昇格なし",
                            percentList: ragnador.ratioWeakCherryUpNone,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "高確",
                            percentList: ragnador.ratioWeakCherryUpHigh,
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "超高確",
                            percentList: ragnador.ratioWeakCherryUpSuperHigh,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    Text("・通常状態での弱🍒がカウント対象")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン横並び
                    HStack {
                        // 弱チェリー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "弱🍒成立",
                            count: $ragnador.weakCherryCount,
                            color: .personalSummerLightRed,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                        // 高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "高確",
                            count: $ragnador.weakCherryUpCountHigh,
                            color: .personalSummerLightGreen,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                        // 超高確
                        unitCountButtonWithoutRatioWithFunc(
                            title: "超高確",
                            count: $ragnador.weakCherryUpCountSuperHigh,
                            color: .personalSummerLightPurple,
                            minusBool: $ragnador.minusCheck) {
                                ragnador.weakCherryUpSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            ragnadorView95Ci(
                                ragnador: ragnador,
                                selection: 1,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        ragnadorViewBayes(
                            ragnador: ragnador,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("弱チェリーでの状態昇格率")
            }
            
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    ragnadorTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.ragnadorMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
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
                unitButtonMinusCheck(minusCheck: $ragnador.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: ragnador.resetNormal)
            }
        }
    }
}

#Preview {
    ragnadorViewNormal(
        ragnador: Ragnador(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
