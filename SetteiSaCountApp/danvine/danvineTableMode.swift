//
//  danvineTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableMode: View {
    let contentFont: Font = .body
    let titleFont: Font = .body
    let maxwidth: CGFloat = 65
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "種類",
                        "移行契機",
                        "特徴"
                    ],
                    maxWidth: 100,
                    lineList: [1,2,3],
                    contentFont: .body,
                    colorList: [
                        .columnTitle,
                        .columnTitle,
                        .columnTitle
                    ],
                    contentTextColorList: [
                        .white,
                        .white,
                        .white
                    ]
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常 ＜ 高確 ＜ 超高確 ＜ 極高確",
                        "・赤オーラ役\n・ボーナス,ST終了後の抽選",
                        "・上位ほどｵｰﾗ役成立時のﾎﾟｲﾝﾄが優遇\n・極高確中は全役でﾎﾞｰﾅｽ直撃抽選"
                    ],
                    maxWidth: 300,
                    lineList: [1,2,3],
                    contentFont: .body
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "赤オーラ役",
                        "青オーラ役",
                        "紫オーラ役"
                    ],
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "通常",
                    stringList: [
                        "1pt",
                        "3pt",
                        "1pt"
                    ],
                    maxWidth: self.maxwidth,
                    titleFont: self.titleFont,
                    contentFont: self.contentFont
                )
                unitTableString(
                    columTitle: "高確",
                    stringList: [
                        "1pt",
                        "5pt",
                        "1pt"
                    ],
                    maxWidth: self.maxwidth,
                    titleFont: self.titleFont,
                    contentFont: self.contentFont
                )
                unitTableString(
                    columTitle: "超高確",
                    stringList: [
                        "1pt",
                        "7pt",
                        "1pt"
                    ],
                    maxWidth: self.maxwidth,
                    titleFont: self.titleFont,
                    contentFont: self.contentFont
                )
                unitTableString(
                    columTitle: "極高確",
                    stringList: [
                        "大ﾁｬﾝｽ"
                    ],
                    maxWidth: self.maxwidth,
                    lineList: [3],
                    titleFont: self.titleFont,
                    contentFont: self.contentFont
                )
            }
        }
    }
}

#Preview {
    danvineTableMode()
        .padding(.horizontal)
}
