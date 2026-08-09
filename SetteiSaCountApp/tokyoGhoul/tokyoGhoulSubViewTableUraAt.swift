//
//  tokyoGhoulSubViewTableUraAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct tokyoGhoulSubViewTableUraAt: View {
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @ObservedObject var tokyoGhoul: TokyoGhoul
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "裏AT振分け",
                    percentList: tokyoGhoul.ratioUraAt,
                    numberofDicimal: 1
                )
            }
            VStack {
                Text("[規定ゲーム数での当選時 裏AT突入率]")
                    .font(.title3)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "100G以内",
                        percentList: [3.2,3.5,3.9,4.4,4.9,5.1],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "200G以内",
                        percentList: [3.0,3.3,3.7,4.1,4.5,4.8],
                        numberofDicimal: 1,
                    )
                }
            }
        }
    }
}

#Preview {
    tokyoGhoulSubViewTableUraAt(tokyoGhoul: TokyoGhoul())
        .padding(.horizontal)
}
