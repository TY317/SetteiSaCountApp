//
//  bioRe3ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3ViewFirstHit: View {
    @ObservedObject var bioRe3: BioRe3
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
            // 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $bioRe3.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // AT
                    unitCountButtonVerticalDenominate(
                        title: "AT",
                        count: $bioRe3.firstHitCountAt,
                        color: .personalSummerLightRed,
                        bigNumber: $bioRe3.normalGame,
                        numberofDicimal: 0,
                        minusBool: $bioRe3.minusCheck
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: bioRe3.ratioFirstHitAt
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bioRe3View95Ci(
                            bioRe3: bioRe3,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bioRe3ViewBayes(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
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
                unitButtonMinusCheck(minusCheck: $bioRe3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bioRe3.resetFirstHit)
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
    bioRe3ViewFirstHit(
        bioRe3: BioRe3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
