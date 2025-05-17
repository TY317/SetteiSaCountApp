//
//  magiaTableSuikaCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaTableSuikaCz: View {
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    var body: some View {
        VStack {
            Text("[魔法少女モード：さな 以外]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(
                    titleLine: 2
                )
                unitTablePercent(
                    columTitle: "マギア\nチャレンジ",
                    percentList: magia.ratioSuikaCz,
                    titleLine: 2
                )
                unitTablePercent(
                    columTitle: "黒江\nチャレンジ",
                    percentList: magia.ratioCzKuroeNegateSana,
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [3,3]
                )
            }
            .padding(.bottom)
            Text("[魔法少女モード：さな]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(
                    titleLine: 2
                )
                unitTablePercent(
                    columTitle: "マギア\nチャレンジ",
                    percentList: magia.ratioCzMagiaSana,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "黒江\nチャレンジ",
                    percentList: magia.ratioCzKuroeSana,
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white]
                )
            }
        }
    }
}

#Preview {
    magiaTableSuikaCz(magia: Magia())
        .padding(.horizontal)
}
