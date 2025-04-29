//
//  arifureSubViewTableChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct arifureSubViewTableChara: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    let lineList1: [Int] = [1,1,1,1,1,1,2,2]
    let contentWidth: CGFloat = 80
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(columTitle: "", stringList: arifure.charaIndex, lineList: self.lineList1, contentFont: .subheadline)
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: arifure.ratioCharaSetting1,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: arifure.ratioCharaSetting2,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: arifure.ratioCharaSetting3,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
            }
            HStack(spacing: 0) {
                unitTableString(columTitle: "", stringList: arifure.charaIndex, lineList: self.lineList1, contentFont: .subheadline)
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: arifure.ratioCharaSetting4,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: arifure.ratioCharaSetting5,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: arifure.ratioCharaSetting6,
                    aboutBool: true,
                    maxWidth: self.contentWidth,
                    lineList: self.lineList1
                )
            }
            .padding(.top)
        }
    }
}

#Preview {
    arifureSubViewTableChara(arifure: Arifure())
}
