//
//  bioViewAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct bioViewAt: View {
//    @ObservedObject var ver370: Ver370
    @ObservedObject var bio: Bio
    @State var isShowAlert = false
    var body: some View {
        List {
            // //// 中段揃い時のインフェクション当選
            Section {
                // カウントボタン横並び
                HStack {
                    // ハズレ
                    unitCountButtonWithoutRatioWithFunc(
                        title: "ハズレ",
                        count: $bio.infectionCountMiss,
                        color: .personalSummerLightBlue,
                        minusBool: $bio.minusCheck) {
                            bio.infectionSumFunc()
                        }
                    // 当選
                    unitCountButtonWithoutRatioWithFunc(
                        title: "当選",
                        count: $bio.infectionCountHit,
                        color: .personalSummerLightRed,
                        minusBool: $bio.minusCheck) {
                            bio.infectionSumFunc()
                        }
                }
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "インフェクション当選率",
                    count: $bio.infectionCountHit,
                    bigNumber: $bio.infectionCountSum,
                    numberofDicimal: 0
                )
                // 参考情報）インフェクション当選率
                unitLinkButtonViewBuilder(sheetTitle: "中段7揃い時の当選率") {
                    VStack {
                        Text("・中段7揃いからのインフェクション当選に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        Text("[インフェクション当選率]")
                            .font(.title2)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "中段揃い",
                                percentList: bio.ratioInfection
                            )
                            unitTablePercent(
                                columTitle: "斜め揃い",
                                percentList: [100],
                                lineList: [6],
                                colorList: [.white],
                            )
                        }
                    }
                }
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        bioView95Ci(
                            bio: bio,
                            selection: 3,
                        )
                    )
                )
            } header: {
                Text("中段7揃い時のインフェクション当選")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver370.bioMenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        .navigationTitle("AT開始時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $bio.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: bio.resetAt)
                }
            }
        }
    }
}

#Preview {
    bioViewAt(
//        ver370: Ver370(),
        bio: Bio(),
    )
}
