//
//  izaBanchoTableCzEffect.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/05.
//

import SwiftUI

struct izaBanchoTableCzEffect: View {
    @ObservedObject var izaBancho: IzaBancho
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "青",
                    percentList: izaBancho.ratioCzEffectBlue,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "黄",
                    percentList: izaBancho.ratioCzEffectYellow,
                    numberofDicimal: 0,
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "なし",
                    percentList: [25],
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "緑",
                    percentList: [33],
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "赤",
                    percentList: [80],
                    lineList: [6],
                    colorList: [.white],
                )
                unitTableString(
                    columTitle: "虹",
                    stringList: ["AT+番長ボーナス濃厚"],
                    lineList: [6],
                    contentFont: .body,
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    izaBanchoTableCzEffect(
        izaBancho: IzaBancho(),
    )
    .padding(.horizontal)
}
