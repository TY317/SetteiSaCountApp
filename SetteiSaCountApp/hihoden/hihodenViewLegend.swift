//
//  hihodenViewLegend.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/20.
//

import SwiftUI

struct hihodenViewLegend: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "BIG後"
    let selectList: [String] = ["BIG後", "REG後"]
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
            // ボーナス後の伝説モード移行
            Section {
                // 注意書き
                Text("完璧に見抜くのは難しいですがメモ代わりとしてご利用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // BIG
                if self.selectedItem == self.selectList[0] {
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $hihoden.legendCountBigNone,
                            color: .personalSummerLightRed,
                            minusBool: $hihoden.minusCheck) {
                                hihoden.legendSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $hihoden.legendCountBigHit,
                            color: .red,
                            minusBool: $hihoden.minusCheck) {
                                hihoden.legendSumFunc()
                            }
                    }
                }
                // REG
                else {
                    HStack {
                        // 移行なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行なし",
                            count: $hihoden.legendCountRegNone,
                            color: .personalSummerLightBlue,
                            minusBool: $hihoden.minusCheck) {
                                hihoden.legendSumFunc()
                            }
                        // 移行あり
                        unitCountButtonWithoutRatioWithFunc(
                            title: "移行あり",
                            count: $hihoden.legendCountRegHit,
                            color: .blue,
                            minusBool: $hihoden.minusCheck) {
                                hihoden.legendSumFunc()
                            }
                    }
                }
                
                // 確率結果
                HStack {
                    unitResultRatioPercent2Line(
                        title: "BIG後",
                        count: $hihoden.legendCountBigHit,
                        bigNumber: $hihoden.legendCountBigSum,
                        numberofDicimal: 0
                    )
                    unitResultRatioPercent2Line(
                        title: "REG後",
                        count: $hihoden.legendCountRegHit,
                        bigNumber: $hihoden.legendCountRegSum,
                        numberofDicimal: 0
                    )
                }
                
                // 参考情報）移行率
                unitLinkButtonViewBuilder(sheetTitle: "伝説モード移行率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・ショートとロングの2種類があり")
                            Text("・偶数設定は伝説モードに移行しやすく、ショートの割合が多い")
                            Text("・奇数設定は初当りが重い代わりに、ロングに入りやすい")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "BIG後",
                                percentList: hihoden.ratioLegendAfterBig
                            )
                            unitTablePercent(
                                columTitle: "REG後",
                                percentList: hihoden.ratioLegendAfterReg
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 5,
                        )
                    )
                )
            } header: {
                Text("ボーナス後の伝説モード移行")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuLegendBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
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
        .navigationTitle("伝説モード")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hihoden.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hihoden.resetLegend)
            }
        }
    }
}

#Preview {
    hihodenViewLegend(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
