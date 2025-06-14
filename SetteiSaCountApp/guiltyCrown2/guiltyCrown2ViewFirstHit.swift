//
//  guiltyCrown2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2ViewFirstHit: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    
    var body: some View {
        List {
            Section {
                Text("現在値はユニメモを確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                guiltyCrown2TableFirstHit(
                                    guiltyCrown2: guiltyCrown2
                                )
                            )
                        )
                    )
                )
                // 参考情報）スイカ契機のボーナス
                unitLinkButton(
                    title: "🍉契機のボーナス当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "🍉契機のボーナス当選",
                            textBody1: "・🍉契機の同時当選に設定差あり",
                            textBody2: "・特に弱🍉契機の赤異色の設定差が大きいらしい",
                        )
                    )
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    guiltyCrown2ViewFirstHit(
        guiltyCrown2: GuiltyCrown2()
    )
}
