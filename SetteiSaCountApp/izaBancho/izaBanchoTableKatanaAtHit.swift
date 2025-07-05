//
//  izaBanchoTableKatanaAtHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/05.
//

import SwiftUI

struct izaBanchoTableKatanaAtHit: View {
    var body: some View {
        VStack {
            Text("[レベル1 CZ,AT当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "CZ",
                    percentList: [30.1],
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "AT",
                    percentList: [3.1,3.5,3.5,3.9,3.5,4.3],
                    numberofDicimal: 1,
                )
            }
            .padding(.bottom)
            Text("[レベル2 CZ,AT当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "CZ",
                    percentList: [46.9],
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "AT",
                    percentList: [3.1,3.5,3.5,3.9,3.5,4.3],
                    numberofDicimal: 1,
                )
            }
            .padding(.bottom)
            Text("[レベル3 CZ,AT当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "CZ",
                    percentList: [87.5],
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "AT",
                    percentList: [12.5],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white]
                )
            }
        }
    }
}

#Preview {
    izaBanchoTableKatanaAtHit()
}
