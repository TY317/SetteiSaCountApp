//
//  evaYakusokuViewBtMovie.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/02.
//

import SwiftUI

struct evaYakusokuViewBtMovie: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        List {
            Text("・BT中のBAR表示時かつ内部的に赤7成立時が対象\n・中リール中段にBARビタ押し成功すると、4コマ滑りで赤7が停止し、ムービーが流れる\n・ムービーの種類で設定を示唆")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ムービー種類",
                    stringList: [
                        "第3新東京市",
                        "ミサト＆リツコ",
                        "リリス",
                        "ゲンドウ",
                        "加持",
                        "カヲル",
                    ],
                    maxWidth: 200,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "高設定示唆 弱",
                        "高設定示唆 強",
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚",
                    ],
                    maxWidth: 200,
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BT ビタ押し成功時のムービー")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    evaYakusokuViewBtMovie(
        evaYakusoku: EvaYakusoku(),
    )
}
