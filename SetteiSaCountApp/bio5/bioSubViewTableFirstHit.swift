//
//  bioSubViewTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/16.
//

import SwiftUI

struct bioSubViewTableFirstHit: View {
//    @ObservedObject var bio = Bio()
    @ObservedObject var bio: Bio
    var body: some View {
        VStack(spacing: 30.0) {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "CZ合算",
                    denominateList: bio.ratioCz
                )
                unitTableDenominate(
                    columTitle: "AT",
                    denominateList: bio.ratioAt
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ﾊﾟﾆｯｸｿﾞｰﾝ",
                    denominateList: bio.ratioPz
                )
                unitTableDenominate(
                    columTitle: "ｳｪｽｶｰｿﾞｰﾝ",
                    denominateList: bio.ratioWz
                )
            }
            
        }
    }
}

#Preview {
    bioSubViewTableFirstHit(bio: Bio())
}
