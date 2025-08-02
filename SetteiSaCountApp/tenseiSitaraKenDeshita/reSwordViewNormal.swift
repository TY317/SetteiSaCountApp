//
//  reSwordViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordViewNormal: View {
    @ObservedObject var reSword: ReSword
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系", linkText: "レア役停止系") {
                    reSwordTableKoyakuPattern()
                }
                // レア役の役割
                unitLinkButtonViewBuilder(sheetTitle: "レア役の役割") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "🍒",
                                "🍉・チャンス目"
                            ],
                            lineList: [1,2],
                            contentFont: .body,
                            colorList: [.white,.white],
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "CZ抽選＆CZ高確抽選",
                                "ボーナス抽選＆ボーナス高確抽選"
                            ],
                            maxWidth: 200,
                            lineList: [1,2],
                            contentFont: .body,
                            colorList: [.white,.white],
                        )
                    }
                }
            } header: {
                Text("小役")
            }
            
            // //// モード
            Section {
                // 内部モード
                unitLinkButtonViewBuilder(sheetTitle: "内部モード") {
                    VStack {
                        Text("・5種類の内部モードで各種抽選を管理")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "通常",
                                "CZ高確",
                                "ボーナス高確",
                                "ダブル高確\n(CZ＆ボーナス高確)",
                                "超高確\n(CZ＆ボーナス超高確)",
                            ],
                            maxWidth: 200,
                            lineList: [1,1,1,2,2]
                        )
                    }
                }
                // 規定ゲーム数モード
                unitLinkButtonViewBuilder(sheetTitle: "規定ゲーム数モード") {
                    VStack {
                        Text("・100Gごとに内部モード移行を抽選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・天井到達でAT当選濃厚のCZに当選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: [
                                    "モードA",
                                    "モードB",
                                    "モードC",
                                    "天国",
                                    "超天国",
                                ]
                            )
                            unitTableString(
                                columTitle: "天井",
                                stringList: [
                                    "970G",
                                    "600G",
                                    "300G",
                                    "100G",
                                    "100G",
                                ]
                            )
                        }
                    }
                }
            } header: {
                Text("モード")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    reSwordViewNormal(
        reSword: ReSword(),
    )
}
