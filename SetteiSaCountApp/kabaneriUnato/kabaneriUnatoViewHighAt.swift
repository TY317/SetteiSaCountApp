//
//  kabaneriUnatoViewHighAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kabaneriUnatoViewHighAt: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
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
            // ---- 成功時の裏突入率
            Section {
                // 裏突入率
                unitResultRatioPercent2Line(
                    title: "裏突入率",
                    count: $kabaneriUnato.highAtCountHit,
                    bigNumber: $kabaneriUnato.highAtCountSum,
                    numberofDicimal: 1
                )

                // 参考情報）成功時の裏突入率
                unitLinkButtonViewBuilder(sheetTitle: "成功時の裏突入率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "裏突入率",
                            percentList: kabaneriUnato.ratioHighAt,
                            numberofDicimal: 1,
                        )
                    }
                }
                .popoverTip(tipVer460KabaneriUnatoHighAt())

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 真
                        unitCountButtonWithoutRatioWithFunc(
                            title: "真",
                            count: $kabaneriUnato.highAtCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $kabaneriUnato.minusCheck) {
                                kabaneriUnato.highAtSumFunc()
                            }
                        // 裏
                        unitCountButtonWithoutRatioWithFunc(
                            title: "裏",
                            count: $kabaneriUnato.highAtCountHit,
                            color: .personalSummerLightPurple,
                            minusBool: $kabaneriUnato.minusCheck) {
                                kabaneriUnato.highAtSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kabaneriUnatoView95Ci(
                                kabaneriUnato: kabaneriUnato,
                                selection: 6
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kabaneriUnatoViewBayes(
                            kabaneriUnato: kabaneriUnato,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("成功時の裏突入率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuHighAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("復讐の焔")
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
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetHighAt)
            }
        }
    }
}

#Preview {
    kabaneriUnatoViewHighAt(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
