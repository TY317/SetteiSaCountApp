//
//  imJugExTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct imJugExTableRatio: View {
    @ObservedObject var imJugEx = ImJugEx()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ぶどう",
                denominateList: [6.02,6.02,6.02,6.02,6.02,5.78],
                numberofDicimal: 2
            )
            unitTableDenominate(
                columTitle: "BIG",
                denominateList: [273,270,270,259,259,255]
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: [440,400,331,315,255,255]
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: [169,161,149,142,129,128]
            )
        }
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "単独REG",
                denominateList: [630,575,475,449,364,364]
            )
            unitTableDenominate(
                columTitle: "🍒REG",
                denominateList: [1456,1311,1092,1057,851,851]
            )
        }
        .padding(.top)
    }
}

#Preview {
    imJugExTableRatio()
}
