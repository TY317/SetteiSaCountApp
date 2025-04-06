//
//  tokyoGhoulTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import SwiftUI

struct tokyoGhoulTableFirstHit: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "レミニセンス",
                    denominateList: [301,295,288,277,263,251],
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "大喰いの利世",
                    denominateList: [2079,1907,1723,1479,1227,1075],
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "CZ合算",
                    denominateList: [263,256,247,233,216,204]
                )
            }
//            .padding(.horizontal)
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "エピソードボーナス",
                    denominateList: [6620,5880,5115,4063,3167,2640],
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "AT",
                    denominateList: [394,381,357,326,291,261]
                )
            }
        }
    }
}

#Preview {
    tokyoGhoulTableFirstHit()
}
