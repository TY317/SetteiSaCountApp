//
//  toreveViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewNormal: View {
    @ObservedObject var toreve: Toreve
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系", linkText: "レア役停止系") {
                    toreveTableKoyakuPattern()
                }
                // 参考情報）中段🍒確率
                unitLinkButtonViewBuilder(sheetTitle: "中段🍒確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "中段🍒",
                            denominateList: [16384,13107.2,10922.7],
                            lineList: [3,2,1],
                            colorList: [.white, .tableBlue, .white],
                        )
                    }
                }
            } header: {
                Text("レア役")
            }
            
            // //// 内部状態
            Section {
                // 参考情報）内部状態
                unitLinkButtonViewBuilder(sheetTitle: "内部状態") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "種類",
                                "昇格契機",
                                "高確恩恵",
                            ],
                            maxWidth: 100,
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "通常・高確の2種類",
                                "主に🍉、弱🍒、卍目",
                                "東卍アクセル、CZ当選が優遇",
                            ],
                            maxWidth: 250,
                        )
                    }
                }
            } header: {
                Text("内部状態")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewNormal(
        toreve: Toreve(),
    )
}
