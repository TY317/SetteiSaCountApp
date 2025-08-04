//
//  watakonViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/09.
//

import SwiftUI

struct watakonViewBonusScreen: View {
//    @ObservedObject var ver351: Ver351
    @ObservedObject var watakon: Watakon
    
    var body: some View {
        List {
            Text("ボーナス終了画面でモードを示唆")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "日本家屋＋桜",
                        "昼間・市街地",
                        "夕方・大きな屋敷",
                        "日没・街の景色",
                        "大きな桜の木",
                    ],
                    maxWidth: 200,
                    lineList: [1,1,2,1,1],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "通常B以上 示唆",
                        "通常B以上 濃厚\n通常Cに期待",
                        "通常C以上 濃厚",
                        "天国以上 濃厚",
                    ],
                    maxWidth: 200,
                    lineList: [1,1,2,1,1],
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver351.watakonMenuBonusScreenBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: watakon.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    watakonViewBonusScreen(
//        ver351: Ver351(),
        watakon: Watakon(),
    )
}
