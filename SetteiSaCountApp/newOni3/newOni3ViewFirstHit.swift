//
//  newOni3ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/11.
//

import SwiftUI

struct newOni3ViewFirstHit: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
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
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $newOni3.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // AT
                unitTextFieldNumberInputWithUnit(
                    title: "AT",
                    inputValue: $newOni3.firstHitCountAt
                )
                .focused(self.$isFocused)
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "AT",
                    count: $newOni3.firstHitCountAt,
                    bigNumber: $newOni3.normalGame,
                    numberofDicimal: 0
                )
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: newOni3.ratioFirstHitAt
                        )
                    }
                }
                
                // 参考情報）AT裏モード移行率
                unitLinkButtonViewBuilder(sheetTitle: "AT裏モード移行率") {
                    VStack(alignment: .leading) {
                        Text("・AT突入時に抽選")
                        Text("・リーチ目確率が1/7774 → 1/299にアップ")
                        Text("・初回ボーナス後に通常に移行")
                    }
                    .padding(.bottom)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "裏モード移行",
                            percentList: [8.2,8.6,9,10.2,11.3,11.7],
                            numberofDicimal: 1,
                        )
                    }
                }
                .popoverTip(tipVer3220newOni3UraMode())
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        newOni3View95Ci(
                            newOni3: newOni3,
                            selection: 2,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    newOni3ViewBayes(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.newOni3MenuFirstHitBadge)
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                // //// マイナスチェック
//                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
//            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetFirstHit)
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
    newOni3ViewFirstHit(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
