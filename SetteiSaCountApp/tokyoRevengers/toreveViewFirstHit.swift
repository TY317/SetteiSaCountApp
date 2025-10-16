//
//  toreveViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/04.
//

import SwiftUI

struct toreveViewFirstHit: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var toreve: Toreve
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
    
    var body: some View {
        List {
            Section {
                // 注意書き
                Text("マイスロを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $toreve.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // MidNightMode
                unitTextFieldNumberInputWithUnit(
                    title: "ミッドナイトモード",
                    inputValue: $toreve.czCountMidNight
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.czCountMidNight) { oldValue, newValue in
                    toreve.firstHitSumFunc()
                }
                // 綺咲陰謀
                unitTextFieldNumberInputWithUnit(
                    title: "稀咲陰謀",
                    inputValue: $toreve.czCountKisaki
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.czCountKisaki) { oldValue, newValue in
                    toreve.firstHitSumFunc()
                }
                // 東卍チャンス
                unitTextFieldNumberInputWithUnit(
                    title: "東卍チャンス",
                    inputValue: $toreve.tomanChallengeCount
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.tomanChallengeCount) { oldValue, newValue in
                    toreve.firstHitSumFunc()
                }
                // 東卍ラッシュ
                unitTextFieldNumberInputWithUnit(
                    title: "東卍ラッシュ",
                    inputValue: $toreve.tomanRushCount
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.tomanRushCount) { oldValue, newValue in
                    toreve.firstHitSumFunc()
                }
                
                // //// 確率結果
                // CZ
                HStack {
                    // ミッドナイトモード
                    unitResultRatioDenomination2Line(
                        title: "ﾐｯﾄﾞﾅｲﾄﾓｰﾄﾞ",
                        count: $toreve.czCountMidNight,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 綺咲陰謀
                    unitResultRatioDenomination2Line(
                        title: "稀咲陰謀",
                        count: $toreve.czCountKisaki,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // CZ合算
                    unitResultRatioDenomination2Line(
                        title: "CZ合算",
                        count: $toreve.czCountSum,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                // 初当り
                HStack {
                    // 東卍チャンス
                    unitResultRatioDenomination2Line(
                        title: "東卍チャンス",
                        count: $toreve.tomanChallengeCount,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 東卍ラッシュ
                    unitResultRatioDenomination2Line(
                        title: "東卍ラッシュ",
                        count: $toreve.tomanRushCount,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 初当り
                    unitResultRatioDenomination2Line(
                        title: "初当り",
                        count: $toreve.firstHitCount,
                        bigNumber: $toreve.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率", linkText: "初当り確率") {
                    toreveTableFirstHit(toreve: toreve)
                }
//                .popoverTip(tipVer3100ToreveKisaki())
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        toreveView95Ci(
                            toreve: toreve,
                            selection: 1,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    toreveViewBayes(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.toreveMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
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
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetFirstHit)
                }
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
    toreveViewFirstHit(
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
