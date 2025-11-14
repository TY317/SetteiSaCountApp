//
//  vvv2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI
import TipKit

struct vvv2ViewFirstHit: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        TipView(tipVer3130vvv2FirstHit())
        List {
            // //// 初当り確率
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    VStack {
                        Text("・CZには設定差がなく、初当りも微差しかない")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,4,5,6])
                            unitTableDenominate(
                                columTitle: "CZ",
                                denominateList: [324],
                                lineList: [5],
                                colorList: [.white],
                            )
                            unitTableDenominate(
                                columTitle: "初当り",
                                denominateList: [476,473,464,459,456]
                            )
                        }
                    }
                }
                
                // 参考情報）AT直撃
                unitLinkButtonViewBuilder(sheetTitle: "BAR揃いからのAT直撃") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・通常時or電脳ゾーン中のBAR揃いはルーンドライブ or AT直撃が濃厚となる")
                            Text("・高設定ほどAT直撃の振分けが優遇される")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,4,5,6])
                            unitTablePercent(
                                columTitle: "AT直撃",
                                percentList: [3,4,5,6,7]
                            )
                        }
                    }
                }
            } header: {
                Text("初当り")
            }
            
            // //// BR振分け
            Section {
                Text("今作も高設定ほど革命比率が高くなる")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 革命
                    unitCountButtonPercentWithFunc(
                        title: "革命orAT直撃",
                        count: $vvv2.bonusCountKakumei,
                        color: .personalSummerLightRed,
                        bigNumber: $vvv2.bonusCountSum,
                        numberofDicimal: 0,
                        minusBool: $vvv2.minusCheck) {
                            vvv2.bonusCountSum = vvv2.bonusCountKakumei + vvv2.bonusCountKessen
                        }
                    // 革命
                    unitCountButtonPercentWithFunc(
                        title: "決戦",
                        count: $vvv2.bonusCountKessen,
                        color: .personalSummerLightBlue,
                        bigNumber: $vvv2.bonusCountSum,
                        numberofDicimal: 0,
                        minusBool: $vvv2.minusCheck) {
                            vvv2.bonusCountSum = vvv2.bonusCountKakumei + vvv2.bonusCountKessen
                        }
                }
                
                // 振分け確率
                unitLinkButtonViewBuilder(sheetTitle: "振分け確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,4,5,6])
                        unitTablePercent(
                            columTitle: "革命orAT直撃",
                            percentList: vvv2.ratioKakumeiRatio,
                        )
                        unitTablePercent(
                            columTitle: "決戦",
                            percentList: vvv2.ratioKessenRatio,
                        )
                    }
                }
            } header: {
                Text("革命・決戦 振分け")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $vvv2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vvv2.resetFirstHit)
            }
        }
    }
}

#Preview {
    vvv2ViewFirstHit(
        vvv2: Vvv2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
