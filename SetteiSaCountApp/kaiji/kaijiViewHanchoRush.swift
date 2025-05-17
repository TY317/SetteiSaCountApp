//
//  kaijiViewHanchoRush.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/02.
//

import SwiftUI

struct kaijiViewHanchoRush: View {
//    @ObservedObject var ver300: Ver300
    @ObservedObject var kaiji: Kaiji
    
    var body: some View {
        List {
            Section {
                Text("ST再セット時の画面で高設定を示唆するものがある")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // パターン1
                        unitScreenOnlyDisplay(
                            image: Image("kaijiHanchoRushDefault1"),
                            upperBeltText: "パターン1",
                            lowerBeltText: "デフォルト"
                        )
                        // パターン2
                        unitScreenOnlyDisplay(
                            image: Image("kaijiHanchoRushDefault2"),
                            upperBeltText: "パターン2",
                            lowerBeltText: "デフォルト"
                        )
                        // パターン3
                        unitScreenOnlyDisplay(
                            image: Image("kaijiHanchoRushHigh"),
                            upperBeltText: "パターン3",
                            lowerBeltText: "高設定示唆"
                        )
                    }
                }
                .frame(height: 120)
            }
        }
//        .onAppear {
//            if ver300.kaijiMenuHanchoRushBadgeStatus != "none" {
//                ver300.kaijiMenuHanchoRushBadgeStatus = "none"
//            }
//        }
        .navigationTitle("ハンチョウラッシュ中の画面示唆")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kaijiViewHanchoRush(
//        ver300: Ver300(),
        kaiji: Kaiji()
    )
}
