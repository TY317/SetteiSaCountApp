//
//  shamanKingViewQualify.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/25.
//

import SwiftUI

struct shamanKingViewQualify: View {
    @ObservedObject var shamanKing: ShamanKing
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @State var isShowAlert = false
    @State var selectedItem: String = "ファウスト"
    let itemList: [String] = ["ファウスト", "道蓮"]
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
            // //// 対戦相手ごとの撃破率
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // 注意書き
                VStack(alignment: .leading){
                    Text("・OS役：オーバーソウル停止役、オーバーソウル揃い役")
                    Text("・1〜6G目が対象")
                }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // カウントボタン横並び
                // ファウスト
                if self.selectedItem == self.itemList[0] {
                    HStack {
                        // OS役成立
                        unitCountButtonVerticalWithoutRatio(
                            title: "OS役成立",
                            count: $shamanKing.qualifyCountFaustOS,
                            color: .personalSummerLightBlue,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 撃破
                        unitCountButtonVerticalWithoutRatio(
                            title: "OS役での撃破",
                            count: $shamanKing.qualifyCountFaustHit,
                            color: .blue,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // 道蓮
                else {
                    HStack {
                        // OS役成立
                        unitCountButtonVerticalWithoutRatio(
                            title: "OS役成立",
                            count: $shamanKing.qualifyCountRenOS,
                            color: .personalSummerLightGreen,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 撃破
                        unitCountButtonVerticalWithoutRatio(
                            title: "OS役での撃破",
                            count: $shamanKing.qualifyCountRenHit,
                            color: .green,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                
                // 撃破率結果
                HStack {
                    // ファウスト
                    unitResultRatioPercent2Line(
                        title: "ファウスト 撃破率",
                        count: $shamanKing.qualifyCountFaustHit,
                        bigNumber: $shamanKing.qualifyCountFaustOS,
                        numberofDicimal: 0
                    )
                    // ファウスト
                    unitResultRatioPercent2Line(
                        title: "道蓮 撃破率",
                        count: $shamanKing.qualifyCountRenHit,
                        bigNumber: $shamanKing.qualifyCountRenOS,
                        numberofDicimal: 0
                    )
                }
                
                // 参考情報）対戦相手ごとの撃破率
                unitLinkButtonViewBuilder(sheetTitle: "対戦相手ごとの撃破率") {
                    shamanKingTableQualify(shamanKing: shamanKing)
                }
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        shamanKingView95Ci(
                            shamanKing: shamanKing,
                            selection: 12,
                        )
                    )
                )
            } header: {
                Text("対戦相手ごとの撃破率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shamanKingMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shamanKing.machineName,
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
        .navigationTitle("シャーマンファイト予選")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $shamanKing.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // リセットボタン
                unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetQualify)
            }
        }
    }
}

#Preview {
    shamanKingViewQualify(
        shamanKing: ShamanKing(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
