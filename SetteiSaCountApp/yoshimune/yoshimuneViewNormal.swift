//
//  yoshimuneViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneViewNormal: View {
//    @ObservedObject var ver360: Ver360
    var body: some View {
        List {
            // //// 共通俵
            Section {
                // //// 注意書き
                Text("現在値は大都吉宗CITYで確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// 参考情報）共通俵
                unitLinkButtonViewBuilder(sheetTitle: "共通俵") {
                    VStack {
                        Text("・斜めに揃う共通俵に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "共通俵",
                                denominateList: [819.2,744.7,682.7,585.1,512.0,455.1]
                            )
                        }
                    }
                }
            } header: {
                Text("共通俵")
//                    .popoverTip(tipVer360YoshimuneCommonTawara())
            }
            
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "レア役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役停止形",
                            image1: Image("yoshimuneKoyakuPattern")
                        )
                    )
                )
            } header: {
                Text("レア役")
            }
            
            // //// モード
            Section {
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・5つのモードで規定G数を管理。対象は液晶G数で実G数ではないため注意",
                            textBody2: "・ボーナス当選時に次回モードを抽選",
                            tableView: AnyView(yoshimuneTableMode())
                        )
                    )
                )
                unitLinkButton(
                    title: "モード示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "モード示唆",
                            textBody1: "・前兆タイミングや演出でモード示唆する場合あり",
                            tableView: AnyView(yoshimuneTableModeSisa())
                        )
                    )
                )
                unitLinkButton(
                    title: "鷹狩りモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "鷹狩りモード",
                            textBody1: "・高確率以降時に鷹狩りに変換する抽選を管理するモード(5種類)",
                            textBody2: "・有利区間移行時に抽選され鷹狩り当選まで転落なし",
                            textBody3: "・通常時の押し順ナビ、高確率後の連続演出失敗時、REG開始時に昇格抽選"
                        )
                    )
                )
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver360.yoshimuneMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "吉宗",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    yoshimuneViewNormal(
//        ver360: Ver360(),
    )
}
