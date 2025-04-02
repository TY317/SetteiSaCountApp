//
//  kaguyaTableRed7Ratio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct kaguyaTableRed7Ratio: View {
    let lineNumberList: [Int] = [1, 1, 1, 1, 1, 2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["2連", "3連", "4連", "5連", "6連", "7連〜\n奇跡的相性"],
                lineList: self.lineNumberList
            )
            unitTablePercent(
                columTitle: "赤7比率",
                percentList: [2,3,12,18,19,36],
                aboutBool: true,
                lineList: self.lineNumberList
            )
        }
    }
}

#Preview {
    kaguyaTableRed7Ratio()
}
