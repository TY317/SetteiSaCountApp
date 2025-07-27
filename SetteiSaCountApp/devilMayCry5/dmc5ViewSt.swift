//
//  dmc5ViewSt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import SwiftUI

struct dmc5ViewSt: View {
    @ObservedObject var ver352: Ver352
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // カウントボタン横並び
                HStack {
                    // 赤
                    unitCountButtonPercentWithFunc(
                        title: "赤",
                        count: $dmc5.stEmblemCountRed,
                        color: .personalSummerLightRed,
                        bigNumber: $dmc5.stEmblemCountColorSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck) {
                            dmc5.stEmblemCountSumFunc()
                        }
                    // 金
                    unitCountButtonPercentWithFunc(
                        title: "金",
                        count: $dmc5.stEmblemCountGold,
                        color: .orange,
                        bigNumber: $dmc5.stEmblemCountColorSum,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck) {
                            dmc5.stEmblemCountSumFunc()
                        }
                }
                // //// 参考情報）エンブレム種別
                unitLinkButtonViewBuilder(sheetTitle: "開始時のエンブレム種別") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "赤",
                            percentList: dmc5.ratioStEmblemRed
                        )
                        unitTablePercent(
                            columTitle: "金",
                            percentList: dmc5.ratioStEmblemGold
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 9,
                        )
                    )
                )
            } header: {
                Text("エンブレム種別")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver352.dmc5MenuStBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ST")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetSt)
                }
            }
        }
    }
}

#Preview {
    dmc5ViewSt(
        ver352: Ver352(),
        dmc5: Dmc5(),
    )
}
