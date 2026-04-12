//
//  akudamaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/06.
//

import SwiftUI

struct akudamaViewFirstHit: View {
    @ObservedObject var akudama: Akudama
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
            // ---- 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $akudama.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // CZ
                    unitCountButtonWithoutRatioWithFunc(
                        title: "CZ",
                        count: $akudama.firstHitCz,
                        color: .personalSummerLightPurple,
                        minusBool: $akudama.minusCheck) {
                            akudama.bonusSumFunc()
                        }
                    
                    // アクダマボーナス
                    unitCountButtonWithoutRatioWithFunc(
                        title: "アクダマ",
                        count: $akudama.firstHitAkudama,
                        color: .personalSummerLightBlue,
                        minusBool: $akudama.minusCheck) {
                            akudama.bonusSumFunc()
                        }
                    
                    // エピソードボーナス
                    unitCountButtonWithoutRatioWithFunc(
                        title: "エピボ",
                        count: $akudama.firstHitEpisode,
                        color: .personalSummerLightGreen,
                        minusBool: $akudama.minusCheck) {
                            akudama.bonusSumFunc()
                        }
                    
                    // AT
                    unitCountButtonWithoutRatioWithFunc(
                        title: "AT",
                        count: $akudama.firstHitAt,
                        color: .personalSummerLightRed,
                        minusBool: $akudama.minusCheck) {
                            akudama.bonusSumFunc()
                        }
                }
                
                // 確率結果
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $akudama.firstHitCz,
                        bigNumber: $akudama.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    
                    // ボーナス
                    unitResultRatioDenomination2Line(
                        title: "ボーナス",
                        count: $akudama.firstHitBonusSum,
                        bigNumber: $akudama.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $akudama.firstHitAt,
                        bigNumber: $akudama.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: akudama.ratioFirstHitCz
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス",
                            denominateList: akudama.ratioFirstHitBonus
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: akudama.ratioFirstHitAt
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        akudamaView95Ci(
                            akudama: akudama,
                            selection: 2,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    akudamaViewBayes(
                        akudama: akudama,
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
        .resetBadgeOnAppear($common.akudamaMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
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
                unitButtonMinusCheck(minusCheck: $akudama.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: akudama.resetFirstHit)
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
    akudamaViewFirstHit(
        akudama: Akudama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
