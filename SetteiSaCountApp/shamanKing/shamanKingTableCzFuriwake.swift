//
//  shamanKingTableCzFuriwake.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct shamanKingTableCzFuriwake: View {
    @ObservedObject var shamanKing = ShamanKing()
    
    var body: some View {
        VStack {
            Text("[憑依ポイント0〜595Pt]")
                .font(.title2)
                .fontWeight(.bold)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "道蓮",
                    percentList: shamanKing.ratioCzFuriwakeUnder600Ren
                )
                unitTablePercent(
                    columTitle: "道潤",
                    percentList: shamanKing.ratioCzFuriwakeUnder600Jun
                )
                unitTablePercent(
                    columTitle: "竜之介",
                    percentList: shamanKing.ratioCzFuriwakeUnder600Ryunosuke,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "たまお",
                    percentList: shamanKing.ratioCzFuriwakeUnder600Kokkuri,
                    numberofDicimal: 1
                )
            }
        }
//        .padding(.horizontal)
        .padding(.bottom)
        Text("[憑依ポイント600〜1000Pt]")
            .font(.title2)
            .fontWeight(.bold)
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "道蓮",
                percentList: shamanKing.ratioCzFuriwakeOver600Ren
            )
            unitTablePercent(
                columTitle: "道潤",
                percentList: shamanKing.ratioCzFuriwakeOver600Jun
            )
            unitTablePercent(
                columTitle: "竜之介",
                percentList: shamanKing.ratioCzFuriwakeOver600Ryunosuke,
                numberofDicimal: 1
            )
            unitTablePercent(
                columTitle: "たまお",
                percentList: shamanKing.ratioCzFuriwakeOver600Kokkuri,
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    shamanKingTableCzFuriwake()
}
