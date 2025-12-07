//
//  bakemonoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/07.
//

import SwiftUI

struct bakemonoViewFirstHit: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
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
            Section {
                // 注意書き
                Text("マイスロを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $bakemono.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // MidNightMode
                unitTextFieldNumberInputWithUnit(
                    title: "AT初当り",
                    inputValue: $bakemono.firstHitCountAt,
                )
                .focused(self.$isFocused)
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "AT初当り",
                    count: $bakemono.firstHitCountAt,
                    bigNumber: $bakemono.normalGame,
                    numberofDicimal: 0
                )
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "AT初当り",
                            denominateList: bakemono.ratioAtFirstHit
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bakemonoView95Ci(
                            bakemono: bakemono,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    bakemonoViewBayes(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
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
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $bakemono.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bakemono.resetFirstHit)
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
    bakemonoViewFirstHit(
        bakemono: Bakemono(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
