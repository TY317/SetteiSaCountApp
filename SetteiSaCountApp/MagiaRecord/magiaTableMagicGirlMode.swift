//
//  magiaTableMagicGirlMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/10.
//

import SwiftUI

struct magiaTableMagicGirlMode: View {
    @ObservedObject var magia: Magia
    var body: some View {
        VStack {
            Text("[AT終了後の移行抽選]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "いろは",
                    percentList: magia.ratioMgmTransferIroha,
                    titleFont: .subheadline,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "やちよ",
                    percentList: magia.ratioMgmTransferYachiyo,
                    numberofDicimal: 1,
                    lineList: [1,2,2,1],
                    titleFont: .subheadline,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "鶴乃",
                    percentList: magia.ratioMgmTransferTsuruno,
                    numberofDicimal: 1,
                    lineList: [2,2,2],
                    titleFont: .subheadline,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "さな",
                    percentList: magia.ratioMgmTransferSana,
                    numberofDicimal: 1,
                    lineList: [1,2,2,1],
                    titleFont: .subheadline,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "ﾌｪﾘｼｱ",
                    percentList: magia.ratioMgmTransferFerishia,
                    numberofDicimal: 1,
                    lineList: [2,2,2],
                    titleFont: .subheadline,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "黒江",
                    percentList: magia.ratioMgmTransferKuroe,
                    numberofDicimal: 1,
                    lineList: [2,1,1,1,1],
                    titleFont: .subheadline,
                    contentFont: .body
                )
            }
            .padding(.bottom)
            Text("[いろはからの昇格抽選]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "いろは",
                    percentList: magia.ratioMgmRisingIroha,
                    lineList: [2,1,1,1,1],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "やちよ",
                    percentList: magia.ratioMgmRisingYachiyo,
                    numberofDicimal: 1,
                    lineList: [3,2,1],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "鶴乃",
                    percentList: magia.ratioMgmRisingTsuruno,
                    numberofDicimal: 1,
                    lineList: [2,2,2],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "さな",
                    percentList: magia.ratioMgmRisingSana,
                    numberofDicimal: 1,
                    lineList: [3,2,1],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "ﾌｪﾘｼｱ",
                    percentList: magia.ratioMgmRisingFerishia,
                    numberofDicimal: 1,
                    lineList: [2,2,2],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "黒江",
                    percentList: magia.ratioMgmRisingKuroe,
                    numberofDicimal: 1,
                    lineList: [2,1,1,1,1],
                    titleFont: .subheadline,
                    contentFont: .body,
                    colorList: [.white,.tableBlue,.white,.tableBlue,.white]
                )
            }
        }
    }
}

#Preview {
    magiaTableMagicGirlMode(
        magia: Magia()
    )
    .padding(.horizontal)
}
