//
//  bioRe3ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3ViewNormal: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    let items: [String] = ["弱🍒・🍉","チャンス目・強🍒",]
    @State var selectedItem: String = "弱🍒・🍉"
    
    var body: some View {
        List {
            // 小役関連
            Section {
                // 確率結果
                HStack {
                    // 弱レア→CZ
                    unitResultRatioPercent2Line(
                        title: "弱レア→CZ",
                        count: $bioRe3.jakuRareCountCzHit,
                        bigNumber: $bioRe3.jakuRareCountKoyakuSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 強レア→CZ
                    unitResultRatioPercent2Line(
                        title: "強レア→CZ",
                        count: $bioRe3.kyoRareCountCzHit,
                        bigNumber: $bioRe3.kyoRareCountKoyakuSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 強レア→AT
                    unitResultRatioPercent2Line(
                        title: "強レア→AT",
                        count: $bioRe3.kyoRareCountAtHit,
                        bigNumber: $bioRe3.kyoRareCountKoyakuSum,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 直撃率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ,AT直撃率") {
                    bioRe3TableKoyakuHit(bioRe3: bioRe3)
                }
                
                // レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    bioRe3TableKoyakuPattern()
                }
                
                // 注意書き
                unitLabelCautionText {
                    Text("・滞在モードごとに直撃率が異なるため、サンプル取りやすい通常モードのレア役のみカウントを推奨")
                }
                
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.items, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                
                // カウントボタン横並び
                HStack {
                    // 弱レア役
                    if self.selectedItem == self.items[0] {
                        // 弱🍒
                        unitCountButtonWithoutRatioWithFunc(
                            title: "弱🍒",
                            count: $bioRe3.jakuRareCountJakuCherry,
                            color: .personalSummerLightRed,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                        // 🍉
                        unitCountButtonWithoutRatioWithFunc(
                            title: "🍉",
                            count: $bioRe3.jakuRareCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                        // CZ直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ直撃",
                            count: $bioRe3.jakuRareCountCzHit,
                            color: .personalSummerLightPurple,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                    }
                    // 強レア役
                    else {
                        // チャンス目
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ﾁｬﾝｽ目",
                            count: $bioRe3.kyoRareCountChance,
                            color: .yellow,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                        // 強🍒
                        unitCountButtonWithoutRatioWithFunc(
                            title: "強🍒",
                            count: $bioRe3.kyoRareCountKyoCherry,
                            color: .red,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                        // CZ直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "CZ直撃",
                            count: $bioRe3.kyoRareCountCzHit,
                            color: .purple,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                        // AT直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "AT直撃",
                            count: $bioRe3.kyoRareCountAtHit,
                            color: .blue,
                            minusBool: $bioRe3.minusCheck) {
                                bioRe3.koyakuCountSumFunc()
                            }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bioRe3View95Ci(
                            bioRe3: bioRe3,
                            selection: 3,
                        )
                    )
                )
            } header: {
                Text("レア役からの直撃")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    bioRe3ViewNormal(
        bioRe3: BioRe3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
