//
//  mt5TableGekisoVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/22.
//

import SwiftUI

struct mt5TableGekisoVoice: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "波多野A",
                    percentList: [50,40,40,70,40]
                )
                unitTablePercent(
                    columTitle: "波多野B",
                    percentList: [50,60,60,30,60]
                )
            }
            .padding(.horizontal)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "青",
                        "黄",
                        "緑",
                        "赤",
                        "紫",
                    ],
                    maxWidth: 30,
                    lineList: [2,2,2,3,3],
                    contentFont: .body,
                    colorList: [
                        .tableBlue,
                        .tableYellow,
                        .tableGreen,
                        .tableRed,
                        .tablePurple,
                    ]
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "波多野A",
                        "波多野B",
                        "波多野",
                        "青島",
                        "波多野",
                        "ありさ",
                        "青島",
                        "榎木",
                        "榎木",
                        "澄",
                    ],
                    maxWidth: 60,
                    lineList: [1,1,1,1,1,1,2,1,2,1],
                    contentFont: .body,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableYellow,
                        .tableYellow,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tablePurple,
                        .tablePurple,
                    ]
                )
                unitTableString(
                    columTitle: "セリフ",
                    stringList: [
                        "落ち着くんだ憲二・・",
                        "この気配は!?",
                        "頑張れよ！",
                        "お互い頑張ろうね！",
                        "ここは負けられねぇ！",
                        "ここが勝負所よ！",
                        "ここからが本当の勝負よ！",
                        "おつかれ",
                        "これが艇王と呼ばれる私のレースだ！",
                        "憲ちゃん頑張って！",
                    ],
                    maxWidth: 150,
                    lineList: [1,1,1,1,1,1,2,1,2,1],
                    contentFont: .body,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableYellow,
                        .tableYellow,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tablePurple,
                        .tablePurple,
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト\n振り分けに設定差あり",
                        "通常B 期待度33%",
                        "通常B 期待度50%",
                        "通常B 以上",
                        "当該周期 AT期待度50%",
                        "通常B以上 +\n当該周期 AT期待度50%",
                        "偶数設定濃厚",
                        "設定4 以上濃厚",
                        "当該周期でAT濃厚",
                    ],
                    maxWidth: 150,
                    lineList: [2,1,1,1,1,2,1,2,1],
                    contentFont: .body,
                    colorList: [
                        .tableBlue,
                        .tableYellow,
                        .tableYellow,
                        .tableGreen,
                        .tableGreen,
                        .tableRed,
                        .tableRed,
                        .tablePurple,
                        .tablePurple,
                    ]
                )
            }
        }
    }
}

#Preview {
    mt5TableGekisoVoice()
        .padding(.horizontal)
}
