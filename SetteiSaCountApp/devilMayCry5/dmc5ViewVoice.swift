//
//  dmc5ViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/02.
//

import SwiftUI
import TipKit

struct dmc5ViewVoice: View {
//    @ObservedObject var ver352: Ver352
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    
    var body: some View {
//        TipView(tipVer352Dmc5Emblem())
        List {
            // //// エンブレム点灯
            Section {
                // カウントボタン横並び
                HStack {
                    // 2個
                    unitCountButtonPercentWithFunc(
                        title: "2個点灯",
                        count: $dmc5.premiumStEmblemCount2,
                        color: .personalSummerLightGreen,
                        bigNumber: $dmc5.premiumStEmblemCountSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.premiumStEmblemCountSumFunc
                    )
                    // 3個
                    unitCountButtonPercentWithFunc(
                        title: "3個点灯",
                        count: $dmc5.premiumStEmblemCount3,
                        color: .personalSummerLightRed,
                        bigNumber: $dmc5.premiumStEmblemCountSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.premiumStEmblemCountSumFunc
                    )
                }
                
                // 参考情報）エンブレム点灯個数
                unitLinkButtonViewBuilder(sheetTitle: "エンブレム点灯個数") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "2個点灯",
                            percentList: dmc5.ratioEmblem2
                        )
                        unitTablePercent(
                            columTitle: "3個点灯",
                            percentList: dmc5.ratioEmblem3
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 7,
                        )
                    )
                )
            } header: {
                Text("エンブレム点灯個数")
//                    .popoverTip(tipVer352Dmc5Emblem())
            }
            
            // //// エンブレムの種類
            Section {
                // カウントボタン横並び
                HStack {
                    // 赤
                    unitCountButtonPercentWithFunc(
                        title: "赤",
                        count: $dmc5.premiumStEmblemCountRed,
                        color: .personalSummerLightRed,
                        bigNumber: $dmc5.premiumStEmblemCountColorSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck) {
                            dmc5.premiumStEmblemCountSumFunc()
                        }
                    // 金
                    unitCountButtonPercentWithFunc(
                        title: "金",
                        count: $dmc5.premiumStEmblemCountGold,
                        color: .orange,
                        bigNumber: $dmc5.premiumStEmblemCountColorSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck) {
                            dmc5.premiumStEmblemCountSumFunc()
                        }
                }
                // //// 参考情報）エンブレム種別
                unitLinkButtonViewBuilder(sheetTitle: "開始時のエンブレム種別") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "赤",
                            percentList: [
                                dmc5.ratioPremiumEmblemRed[0],
                                dmc5.ratioPremiumEmblemRed[1],
                                dmc5.ratioPremiumEmblemRed[3],
                            ],
                            lineList: [1,2,3],
                        )
                        unitTablePercent(
                            columTitle: "金",
                            percentList: [
                                dmc5.ratioPremiumEmblemGold[0],
                                dmc5.ratioPremiumEmblemGold[1],
                                dmc5.ratioPremiumEmblemGold[3],
                            ],
                            lineList: [1,2,3],
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 8,
                        )
                    )
                )
            } header: {
                Text("エンブレム種別")
            }
            
            Section {
                Text("上位STでバージルに勝利した際に発生するセリフに設定示唆パターンあり。設定示唆セリフは金文字で表示される。")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                HStack(spacing: 0) {
                    Spacer()
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "1点リードだ！",
                            "2点リードだ！",
                            "3点リードだ！",
                            "4点リードだ！",
                            "5点リードだ！",
                            "6点リードだ！"
                        ],
                        contentFont: .body
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "デフォルト",
                            "設定2 以上濃厚",
                            "設定3 以上濃厚",
                            "設定4 以上濃厚",
                            "設定5 以上濃厚",
                            "設定6 以上濃厚"
                        ],
                        contentFont: .body
                    )
                    Spacer()
                }
            } header: {
                Text("勝利時のセリフ")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver352.dmc5MenuPremiumStBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("上位ST")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetPremiumSt)
                }
            }
        }
    }
}

#Preview {
    dmc5ViewVoice(
//        ver352: Ver352(),
        dmc5: Dmc5()
    )
}
