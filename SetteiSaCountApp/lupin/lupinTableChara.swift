//
//  lupinTableChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct lupinTableChara: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ルパン",
                        "次元",
                        "五エ門",
                        "不二子"
                    ],
                    maxWidth: 100
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "設定2,3,4,6示唆",
                        "設定1,3,5,6示唆",
                        "設定6 示唆"
                    ],
                    maxWidth: 200
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ルパン",
                        "次元",
                        "五エ門",
                        "不二子"
                    ],
                    maxWidth: 80,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [94.3,1.5,4.1,0.1],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: [94.3,4.1,1.5,0.1],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: [90.6,3.3,5.1,1.0],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: [85.3,11.2,2.5,1.0],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: [85.4,1.6,12.0,1.0],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: [82.5,7.1,7.1,3.1],
                    numberofDicimal: 1,
                    titleFont: .subheadline,
                    contentFont: .subheadline
                )
            }
        }
    }
}

#Preview {
    lupinTableChara()
        .padding(.horizontal)
}
