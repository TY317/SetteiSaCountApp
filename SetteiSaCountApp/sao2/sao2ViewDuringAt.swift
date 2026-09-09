//
//  sao2ViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct sao2ViewDuringAt: View {
    @ObservedObject var sao2: Sao2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    var body: some View {
        List {

            // ---- AT開始時のステージ
            Section {
                // 荒野ステージ率
                HStack {
                    unitResultRatioPercent2Line(
                        title: "荒野",
                        count: $sao2.startStageCountHit,
                        bigNumber: $sao2.startStageCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    unitResultRatioPercent2Line(
                        title: "バギー",
                        count: $sao2.startStageCountMiss,
                        bigNumber: $sao2.startStageCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)

                // 参考情報）AT開始時のステージ
                unitLinkButtonViewBuilder(sheetTitle: "AT開始時のステージ") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "荒野",
                            percentList: sao2.ratioStartStageKouya
                        )
                        unitTablePercent(
                            columTitle: "バギー",
                            percentList: sao2.ratioStartStageBuggy
                        )
                    }
                }
                .popoverTip(tipVer460Sao2StartStage())

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // 荒野
                        unitCountButtonWithoutRatioWithFunc(
                            title: "荒野",
                            count: $sao2.startStageCountHit,
                            color: .personalSummerLightBlue,
                            minusBool: $sao2.minusCheck) {
                                sao2.startStageSumFunc()
                            }
                        // バギー
                        unitCountButtonWithoutRatioWithFunc(
                            title: "バギー",
                            count: $sao2.startStageCountMiss,
                            color: .personalSpringLightYellow,
                            minusBool: $sao2.minusCheck) {
                                sao2.startStageSumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            sao2View95Ci(
                                sao2: sao2,
                                selection: 8,
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
                Text("AT開始時のステージ")
            }
            
            // ---- デスガン選択率
            Section {
                Text("・スナイパーチャンス１・２戦目でのデスガン選択率は設定5優遇")
            } header: {
                Text("デスガン選択率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.sao2MenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sao2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $sao2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sao2.resetDuringAt)
            }
        }
    }
}

#Preview {
    sao2ViewDuringAt(
        sao2: Sao2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
