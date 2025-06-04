//
//  dmc5ViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/02.
//

import SwiftUI

struct dmc5ViewVoice: View {
    @ObservedObject var dmc5: Dmc5
    var body: some View {
        List {
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
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("上位ST中のセリフ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    dmc5ViewVoice(
        dmc5: Dmc5()
    )
}
