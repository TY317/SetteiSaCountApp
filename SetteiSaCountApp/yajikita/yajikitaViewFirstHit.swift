//
//  yajikitaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct yajikitaViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var yajikita: Yajikita
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
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $yajikita.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // CZ
                unitCountButtonVerticalDenominate(
                    title: "CZ",
                    count: $yajikita.firstHitCountCz,
                    color: .personalSummerLightPurple,
                    bigNumber: $yajikita.normalGame,
                    numberofDicimal: 0,
                    minusBool: $yajikita.minusCheck
                )
                // AT
                unitCountButtonVerticalDenominate(
                    title: "AT",
                    count: $yajikita.firstHitCountAt,
                    color: .personalSummerLightRed,
                    bigNumber: $yajikita.normalGame,
                    numberofDicimal: 0,
                    minusBool: $yajikita.minusCheck
                )
            }

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "CZ",
                        denominateList: yajikita.ratioFirstHitCz
                    )
                    unitTableDenominate(
                        columTitle: "AT",
                        denominateList: yajikita.ratioFirstHitAt
                    )
                }
            }

            // //// 95%%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    yajikitaView95Ci(
                        yajikita: yajikita,
                        selection: 2,
                    )
                )
            )

            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                yajikitaViewBayes(
                    yajikita: yajikita,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.yajikitaMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: yajikita.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $yajikita.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: yajikita.resetFirstHit)
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
    yajikitaViewFirstHit(
        yajikita: Yajikita(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
