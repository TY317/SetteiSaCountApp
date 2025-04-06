//
//  shamanKingTableKokakuMove.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableKokakuMove: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "弱🍒＆🍉からの\nｼｬｰﾏﾝﾎﾞｰﾅｽ高確移行率",
                percentList: [3.9,4.3,5.1,6.6,8.2,10.2],
                numberofDicimal: 1,
                maxWidth: 200,
                titleLine: 2,
                titleFont: .body
            )
        }
    }
}

#Preview {
    shamanKingTableKokakuMove()
}
