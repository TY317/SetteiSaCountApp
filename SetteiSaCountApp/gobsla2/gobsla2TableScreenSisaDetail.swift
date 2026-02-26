//
//  gobsla2TableScreenSisaDetail.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/25.
//

import SwiftUI

struct gobsla2TableScreenSisaDetail: View {
    var body: some View {
        VStack {
            Text("・次回の規定兜ptを示唆")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "示唆①",
                        "示唆②",
                        "示唆③",
                        "示唆④",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "浅いptのチャンス",
                        "60pt以内のチャンス",
                        "30pt以内のチャンス",
                        "10pt濃厚",
                    ],
                    maxWidth: 200,
                )
            }
        }
    }
}

#Preview {
    gobsla2TableScreenSisaDetail()
        .padding(.horizontal)
}
