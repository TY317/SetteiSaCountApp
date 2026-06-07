//
//  sao2ViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/06.
//

import SwiftUI

struct sao2ViewCz: View {
    @ObservedObject var sao2: Sao2
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
    let items: [String] = ["アイテム", "曠野の決闘",]
    @State var selectedItem: String = "アイテム"
    
    var body: some View {
        List {
            // ---- 失敗時のアイテム獲得
            Section {
                // 確率結果
                HStack {
                    // アイテム獲得率
                    unitResultRatioPercent2Line(
                        title: "アイテム獲得率",
                        count: $sao2.czItemCountHit,
                        bigNumber: $sao2.czItemCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    
                    // 決闘突入率
                    unitResultRatioPercent2Line(
                        title: "決闘突入率",
                        count: $sao2.czKettouCountHit,
                        bigNumber: $sao2.czKettouCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）アイテム獲得率
                unitLinkButtonViewBuilder(sheetTitle: "CZ失敗時 アイテム獲得率") {
                    Text("・CZ失敗の次ゲームにアイテム獲得する可能性あり")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "獲得率",
                            percentList: sao2.ratioCzItemGet
                        )
                    }
                }
                
                // 参考情報）アイテム獲得率
                unitLinkButtonViewBuilder(sheetTitle: "CZ失敗時 曠野の決闘 突入率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "突入率",
                            percentList: sao2.ratioCzKettouGet,
                            numberofDicimal: 1,
                        )
                    }
                }
                
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
                        // アイテム
                        if self.selectedItem == self.items[0] {
                            // 獲得なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "獲得なし",
                                count: $sao2.czItemCountMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $sao2.minusCheck) {
                                    sao2.czItemSumFunc()
                                }
                            // 獲得
                            unitCountButtonWithoutRatioWithFunc(
                                title: "獲得",
                                count: $sao2.czItemCountHit,
                                color: .green,
                                minusBool: $sao2.minusCheck) {
                                    sao2.czItemSumFunc()
                                }
                        }
                        // 決闘
                        else {
                            // 獲得なし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "突入なし",
                                count: $sao2.czKettouCountMiss,
                                color: .personalSummerLightRed,
                                minusBool: $sao2.minusCheck) {
                                    sao2.czKettouSumFunc()
                                }
                            // 獲得
                            unitCountButtonWithoutRatioWithFunc(
                                title: "突入",
                                count: $sao2.czKettouCountHit,
                                color: .red,
                                minusBool: $sao2.minusCheck) {
                                    sao2.czKettouSumFunc()
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            sao2View95Ci(
                                sao2: sao2,
                                selection: 4,
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
                Text("CZ失敗時")
            }
            
            // ---- 確定CZ
            Section {
                // 出現率
                unitLinkButtonViewBuilder(sheetTitle: "THE ENDモード出現率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "出現率",
                            denominateList: [20177.5,17579.1,17586.3,13784.5,11459,7077.2]
                        )
                    }
                }
                
                // 参考情報）強チャンス目からの出現
                unitLinkButtonViewBuilder(sheetTitle: "強チャンス目成立時の獲得率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "強チャンス目からの獲得",
                            percentList: [0.4,0.8,0.8,1.6,2.3,5.1],
                            numberofDicimal: 1,
                        )
                    }
                }
            } header: {
                Text("確定CZ (THE ENDモード)")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetCz)
            }
        }
    }
}

#Preview {
    sao2ViewCz(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
