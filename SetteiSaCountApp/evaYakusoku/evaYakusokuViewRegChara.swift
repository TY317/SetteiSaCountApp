//
//  evaYakusokuViewRegChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/02.
//

import SwiftUI

struct evaYakusokuViewRegChara: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        List {
            Section {
                Text("詳細調査中")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "1人目から赤背景",
                            "4人目までにゲンドウ、冬月が出現",
                            "ペンペン",
                            "カヲル",
                        ],
                        maxWidth: 200,
                        lineList: [1,2,2,1]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "高設定の期待UP",
                            "高設定の期待UP",
                            "何人目に出てくるかが重要!?(炎炎のまもるくんに近い!?)",
                            "設定6 濃厚",
                        ],
                        maxWidth: 200,
                        lineList: [1,2,2,1]
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG中のキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    evaYakusokuViewRegChara(
        evaYakusoku: EvaYakusoku(),
    )
}
