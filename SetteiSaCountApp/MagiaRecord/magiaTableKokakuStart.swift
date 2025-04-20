//
//  magiaTableKokakuStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/20.
//

import SwiftUI

struct magiaTableKokakuStart: View {
    @ObservedObject var magia = Magia()
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ビッグ後",
                    percentList: magia.ratioKokakuStartAfterBonusTotal
                )
                unitTablePercent(
                    columTitle: "AT後",
                    percentList: magia.ratioKokakuStartAfterAtTotal
                )
            }
            .padding(.bottom)
            
            Text("[ビッグ後の振り分け詳細]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "10G",
                    percentList: magia.ratioKokakuStartAfterBonus10G
                )
                unitTablePercent(
                    columTitle: "20G",
                    percentList: magia.ratioKokakuStartAfterBonus20G
                )
                unitTablePercent(
                    columTitle: "30G",
                    percentList: magia.ratioKokakuStartAfterBonus30G,
                    numberofDicimal: 1
                )
            }
            .padding(.bottom)
            
            Text("[AT後の振り分け詳細]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "10G",
                    percentList: magia.ratioKokakuStartAfterAt10G
                )
                unitTablePercent(
                    columTitle: "20G",
                    percentList: magia.ratioKokakuStartAfterAt20G,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "30G",
                    percentList: magia.ratioKokakuStartAfterAt30G,
                    numberofDicimal: 1
                )
            }
        }
//        .padding(.horizontal)
    }
}

#Preview {
    magiaTableKokakuStart()
}
