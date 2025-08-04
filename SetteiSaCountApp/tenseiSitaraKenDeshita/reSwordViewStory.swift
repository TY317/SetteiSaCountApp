//
//  reSwordViewStory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordViewStory: View {
    @ObservedObject var reSword: ReSword
    
    var body: some View {
        List {
            // //// 寸胴演出
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "寸胴カレー演出") {
                    VStack {
                        Text("・甘口、辛口、中辛の組み合わせで設定を示唆する場合がある")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: [
                                    "中辛×3個",
                                    "辛口×3個",
                                    "甘口×3個",
                                ]
                            )
                            unitTableString(
                                columTitle: "示唆",
                                stringList: [
                                    "デフォルト",
                                    "チャンスアップ",
                                    "設定2 以上濃厚",
                                ]
                            )
                        }
                    }
                }
            } header: {
                Text("寸胴カレー演出")
            }
            
            // //// ストーリー紹介
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "ストーリ紹介") {
                    VStack {
                        Text("・X転剣ボーナス中にストーリー紹介が発生")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・ストーリー種類は全12話")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・話数の数字が大きいほど高設定の期待度UP")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            } header: {
                Text("ストーリー紹介")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    reSwordViewStory(
        reSword: ReSword(),
    )
}
