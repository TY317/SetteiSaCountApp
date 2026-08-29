//
//  sao2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct sao2ViewFirstHit: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
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
            // 初当り
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $sao2.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // カウントボタン横並び
                HStack {
                    // CZ
                    unitCountButtonVerticalDenominate(
                        title: "CZ",
                        count: $sao2.firstHitCountCz,
                        color: .personalSummerLightPurple,
                        bigNumber: $sao2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $sao2.minusCheck
                    )
                    // AT
                    unitCountButtonVerticalDenominate(
                        title: "AT",
                        count: $sao2.firstHitCountAt,
                        color: .personalSummerLightRed,
                        bigNumber: $sao2.normalGame,
                        numberofDicimal: 0,
                        minusBool: $sao2.minusCheck
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: sao2.ratioFirstHitCz
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: sao2.ratioFirstHitAt
                        )
                    }
                }
                
                // 参考情報）AT直撃発生率
                unitLinkButtonViewBuilder(sheetTitle: "AT直撃発生率") {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("・GGOモード詩乃での直撃実質発生率")
                            Text("・ウルティマチェリー、ロングフリーズ、Pt特化中7停止、引き戻し、AT天井以外でのAT直撃はGGOモード詩乃契機での当選が濃厚")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "AT直撃発生率",
                                denominateList: [18091.8, 14160.5, 14390.8, 8498.0, 4723.3, 3417.5]
                            )
                        }
                    }
                }
                .popoverTip(tipVer450Sao2Chokugeki())
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        sao2View95Ci(
                            sao2: sao2,
                            selection: 6,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    sao2ViewBayes(
                        sao2: sao2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
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
                unitButtonMinusCheck(minusCheck: $sao2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetFirstHit)
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
    sao2ViewFirstHit(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
