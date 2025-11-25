//
//  vvv2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2ViewNormal: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    vvv2TableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// マギウスマークでの示唆
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "マギウスマークの数") {
                    VStack {
                        Text("・周期のマップに表示されるマギウスマークの数が4個以上あれば設定示唆！？")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: ["4個","5個","6個"],
                                maxWidth: 100,
                            )
                            unitTableString(
                                columTitle: "示唆",
                                stringList: [
                                    "天国＋設定4以上濃厚",
                                    "天国＋設定5以上濃厚",
                                    "天国＋設定6濃厚",
                                ],
                                maxWidth: 200,
                            )
                        }
                    }
                }
                unitLinkButtonViewBuilder(sheetTitle: "サブ液晶の機体") {
                    VStack(alignment: .leading) {
                        Text("・サブ液晶の機体がヴァルヴレイヴ以外であれば設定示唆")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: ["バッフェ(無人)","バッフェ(有人)",]
                            )
                            unitTableString(
                                columTitle: "示唆",
                                stringList: [
                                    "奇数示唆",
                                    "偶数示唆",
                                ]
                            )
                        }
//                        Text("・バッフェの期待度は無人＜有人の順となる")
                    }
                }
            } header: {
                Text("設定示唆演出")
//                    .popoverTip(tipVer3130vvv2Normal())
            }
            
            // //// モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    vvv2TableMode()
                }
                .popoverTip(tipVer3131vvv2Mode())
                unitLinkButtonViewBuilder(sheetTitle: "モード移行率") {
                    vvv2TableModeMove()
                }
                unitLinkButtonViewBuilder(sheetTitle: "マリエモード") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・ボーナス当選時に革命ボーナス＆マリエ覚醒スタートとなるマリエモードが存在")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "マリエモード示唆演出",
                                stringList: [
                                    "マリエ 紫セリフ",
                                    "赤アイキャッチ\nロゴ＋ヴァルヴレイヴ"
                                ],
                                maxWidth: 300,
                                lineList: [1,2],
                            )
                        }
                    }
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    vvv2ViewNormal(
        vvv2: Vvv2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
