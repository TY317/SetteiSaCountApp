//
//  sao2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct sao2ViewNormal: View {
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
    let items: [String] = ["低確 🍉", "低確 強🍒", "高確 強🍒"]
    @State var selectedItem: String = "低確 🍉"
    
    var body: some View {
        List {
            // 小役関連
            Section {
                // 確率横並び
                VStack {
                    HStack {
                        // 低確中🍉からのSC
                        unitResultRatioPercent2Line(
                            title: "低確🍉→SC",
                            count: $sao2.lowSuikaCountShootingHit,
                            bigNumber: $sao2.lowSuikaCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 強🍒からのCZ
                        unitResultRatioPercent2Line(
                            title: "低確強🍒→CZ",
                            count: $sao2.kyoCherryCountCzHit,
                            bigNumber: $sao2.kyoCherryCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                        // 高確強🍒からのCZ
                        unitResultRatioPercent2Line(
                            title: "高確強🍒→CZ",
                            count: $sao2.highKyoCherryCountCzHit,
                            bigNumber: $sao2.highKyoCherryCount,
                            numberofDicimal: 0,
                            spacerBool: false,
                            titelFont: .subheadline,
                        )
                    }
                    Text("※ SC：シューティングチャージ")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）小役からの当選率
                unitLinkButtonViewBuilder(sheetTitle: "小役からの当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "低確 🍉→SC",
                            percentList: sao2.ratioLowSuikaShooting
                        )
                        unitTablePercent(
                            columTitle: "低確 強🍒→CZ",
                            percentList: sao2.ratioKyoCherryCz
                        )
                        unitTablePercent(
                            columTitle: "高確 強🍒→CZ",
                            percentList: sao2.ratioHighKyoCherryCz
                        )
                    }
                }
                // レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    sao2TableKoyakuPattern()
                }
                
                // カウント
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // 低確🍉
                        if self.selectedItem == self.items[0] {
                            // 低確スイカ
                            unitCountButtonVerticalWithoutRatio(
                                title: "低確🍉",
                                count: $sao2.lowSuikaCount,
                                color: .personalSummerLightGreen,
                                minusBool: $sao2.minusCheck
                            )
                            // SC当選
                            unitCountButtonVerticalWithoutRatio(
                                title: "SC当選",
                                count: $sao2.lowSuikaCountShootingHit,
                                color: .green,
                                minusBool: $sao2.minusCheck
                            )
                        }
                        // 低確強チェリー
                        else if self.selectedItem == self.items[1] {
                            // 低確 強🍒
                            unitCountButtonVerticalWithoutRatio(
                                title: "低確 強🍒",
                                count: $sao2.kyoCherryCount,
                                color: .personalSummerLightRed,
                                minusBool: $sao2.minusCheck
                            )
                            // CZ当選
                            unitCountButtonVerticalWithoutRatio(
                                title: "CZ当選",
                                count: $sao2.kyoCherryCountCzHit,
                                color: .red,
                                minusBool: $sao2.minusCheck
                            )
                        }
                        // 高確強チェリー
                        else {
                            // 高確 強🍒
                            unitCountButtonVerticalWithoutRatio(
                                title: "高確 強🍒",
                                count: $sao2.highKyoCherryCount,
                                color: .personalSummerLightPurple,
                                minusBool: $sao2.minusCheck
                            )
                            // CZ当選
                            unitCountButtonVerticalWithoutRatio(
                                title: "CZ当選",
                                count: $sao2.highKyoCherryCountCzHit,
                                color: .purple,
                                minusBool: $sao2.minusCheck
                            )
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            sao2View95Ci(
                                sao2: sao2,
                                selection: 2,
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
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("小役からの当選")
            }
            
            // ---- 通常モード
            Section {
                // 規定G数モード
                unitLinkButtonViewBuilder(sheetTitle: "通常モード") {
                    sao2TableMode()
                }
            } header: {
                Text("通常モード")
            }
            
            // ---- GGOモード
            Section {
                // GGOモード
                unitLinkButtonViewBuilder(sheetTitle: "GGOモード") {
                    sao2TableGGOMode()
                }
                // 移行りつ
                unitLinkButtonViewBuilder(sheetTitle: "GGOモード滞在率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "滞在率",
                            percentList: sao2.ratioGgoMode
                        )
                    }
                }
            } header: {
                Text("GGOモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetNormal)
            }
        }
    }
}

#Preview {
    sao2ViewNormal(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
