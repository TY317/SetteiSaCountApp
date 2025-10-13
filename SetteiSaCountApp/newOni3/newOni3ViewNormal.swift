//
//  newOni3ViewNormal.swift
//  SetteiSaCountApp
//
//  newOni3ted by 横田徹 on 2025/10/05.
//

import SwiftUI

struct newOni3ViewNormal: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButtonViewBuilder(
                    sheetTitle: "レア役停止形",
                    linkText: "レア役停止形",
                ) {
                    newOni3TableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// 高確移行率
            Section {
                // 注意書き
                Text("鬼斬りチャージ非当選の弱🍒、弱🍉からの高確移行をカウント\n完全に見抜けないと思いますがメモ代わりにご利用下さい")
                    .foregroundColor(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 弱チェリー
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍒",
                        count: $newOni3.kokakuCountJakuCherry,
                        color: .personalSummerLightRed,
                        minusBool: $newOni3.minusCheck) {
                            newOni3.kokakuCountJakuSumCalc()
                        }
                    // 弱チェリー
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍉",
                        count: $newOni3.kokakuCountJakuSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $newOni3.minusCheck) {
                            newOni3.kokakuCountJakuSumCalc()
                        }
                    // 高確移行
                    unitCountButtonVerticalWithoutRatio(
                        title: "高確移行",
                        count: $newOni3.kokakuCountIkou,
                        color: .personalSummerLightPurple,
                        minusBool: $newOni3.minusCheck
                    )
                }
                // 確率算出
                unitResultRatioPercent2Line(
                    title: "高確移行率",
                    count: $newOni3.kokakuCountIkou,
                    bigNumber: $newOni3.kokakuCountJakuSum,
                    numberofDicimal: 0
                )
                // 参考情報）高確移行率
                unitLinkButtonViewBuilder(sheetTitle: "高確移行率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "弱レア役",
                            percentList: newOni3.ratioKokaku,
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        newOni3View95Ci(
                            newOni3: newOni3,
                            selection: 1,
                        )
                    )
                )
            } header: {
                Text("高確移行率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetNormal)
            }
//            ToolbarItem(placement: .keyboard) {
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        isFocused = false
//                    }, label: {
//                        Text("完了")
//                            .fontWeight(.bold)
//                    })
//                }
//            }
        }
    }
}

#Preview {
    newOni3ViewNormal(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
