//
//  danvineTableKiteiPoint.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableKiteiPoint: View {
    let contentFont: Font = .body
    let titleFont: Font = .body
    let maxwidth: CGFloat = 65
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1pt",
                        "3pt",
                        "7pt",
                        "11pt",
                        "16pt",
                        "22pt",
                        "32pt",
                    ],
                    maxWidth: 100
                )
                unitTableString(
                    columTitle: "前兆期待度",
                    stringList: [
                        "△",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "◯",
                        "天井"
                    ]
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
    danvineTableKiteiPoint()
        .padding(.horizontal)
}
