//
//  arifureSubViewTableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct arifureSubViewTableEnding: View {
    @ObservedObject var arifure = Arifure()
    let contentWidth: CGFloat = 70.0
    var body: some View {
        VStack {
            Text("[弱レア役成立時の振り分け]")
                .font(.title2)
                .fontWeight(.bold)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: arifure.endingIndex
//                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: arifure.ratioEndingSetting1,
                    maxWidth: self.contentWidth
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: arifure.ratioEndingSetting2,
                    maxWidth: self.contentWidth
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: arifure.ratioEndingSetting3,
                    maxWidth: self.contentWidth
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: arifure.endingIndex
//                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: arifure.ratioEndingSetting4,
                    maxWidth: self.contentWidth
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: arifure.ratioEndingSetting5,
                    maxWidth: self.contentWidth
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: arifure.ratioEndingSetting6,
                    maxWidth: self.contentWidth
                )
            }
            .padding(.top)
        }
    }
}

#Preview {
    arifureSubViewTableEnding()
}
