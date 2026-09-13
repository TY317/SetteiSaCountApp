//
//  aobutaViewDuringSt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaViewDuringSt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var aobuta: Aobuta
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
            // ---- 開始時の思春期症候群
            Section {
                // 思春期症候群 発生率
                unitResultRatioPercent2Line(
                    title: "思春期症候群 発生率",
                    count: $aobuta.syndromeCountHit,
                    bigNumber: $aobuta.syndromeCountSum,
                    numberofDicimal: 1
                )

                // 参考情報）開始時の思春期症候群
                unitLinkButtonViewBuilder(sheetTitle: "開始時の思春期症候群") {
                    VStack(alignment: .leading) {
                        Text("・ST開始時に思春期症候群を持っていなければ付与抽選")
                        Text("・上位ST中は必ず症候群が発生するためカウントから除外")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [2,3,4,5,6])
                        unitTablePercent(
                            columTitle: "発生率",
                            percentList: aobuta.ratioSyndrome,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    unitLabelCautionText {
                        Text("・上位ST中は必ず症候群が発生するためカウントから除外")
                    }
                    // カウントボタン横並び
                    HStack {
                        // なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "なし",
                            count: $aobuta.syndromeCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $aobuta.minusCheck) {
                                aobuta.syndromeSumFunc()
                            }
                        // あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "あり",
                            count: $aobuta.syndromeCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $aobuta.minusCheck) {
                                aobuta.syndromeSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            aobutaView95Ci(
                                aobuta: aobuta,
                                selection: 3,
                            )
                        )
                    )
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("開始時の思春期症候群")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.aobutaMenuDuringStBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ST中")
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
                unitButtonMinusCheck(minusCheck: $aobuta.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: aobuta.resetDuringSt)
            }
        }
    }
}

#Preview {
    aobutaViewDuringSt(
        aobuta: Aobuta(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
