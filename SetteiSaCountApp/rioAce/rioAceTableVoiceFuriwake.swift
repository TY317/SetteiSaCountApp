//
//  rioAceTableVoiceFuriwake.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/04.
//

import SwiftUI

struct rioAceTableVoiceFuriwake: View {
    @ObservedObject var rioAce: RioAce
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "デフォルト",
                        "高設定示唆 弱",
                        "高設定示唆 中",
                        "高設定示唆 強",
                        "設定4 以上濃厚",
                    ]
                )
                ForEach(0..<3) { i in
                    unitTablePercent(
                        columTitle: "設定\(i+1)",
                        percentList: [
                            rioAce.ratioVoiceDefault[i],
                            rioAce.ratioVoiceHighJaku[i],
                            rioAce.ratioVoiceHighChu[i],
                            rioAce.ratioVoiceHighKyo[i],
                            rioAce.ratioVoiceOver4[i],
                        ],
                        maxWidth: 70,
                    )
                }
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "デフォルト",
                        "高設定示唆 弱",
                        "高設定示唆 中",
                        "高設定示唆 強",
                        "設定4 以上濃厚",
                    ]
                )
                ForEach(3..<6) { i in
                    unitTablePercent(
                        columTitle: "設定\(i+1)",
                        percentList: [
                            rioAce.ratioVoiceDefault[i],
                            rioAce.ratioVoiceHighJaku[i],
                            rioAce.ratioVoiceHighChu[i],
                            rioAce.ratioVoiceHighKyo[i],
                            rioAce.ratioVoiceOver4[i],
                        ],
                        maxWidth: 70,
                    )
                }
            }
        }
    }
}

#Preview {
    rioAceTableVoiceFuriwake(
        rioAce: RioAce(),
    )
    .padding(.horizontal)
}
