//
//  inuyashaTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct inuyashaTableKoyakuRatio: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "弱🍒",
                    denominateList: [69.3,68.7,67.3,65.9,64.6,64.0],
                    numberofDicimal: 1
                )
                unitTableDenominate(
                    columTitle: "強🍒",
                    denominateList: [819,762,728,683,655,630]
                )
                unitTableDenominate(
                    columTitle: "🍉",
                    denominateList: [100,98.6,96.4,92.3,88.0,87.4]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ﾁｬﾝｽ目A",
                    denominateList: [655,655,630,607,565,546]
//                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "ﾁｬﾝｽ目B",
                    denominateList: [780,745,728,697,630,618]
                )
                unitTableDenominate(
                    columTitle: "レア役合算",
                    denominateList: [35.1,34.6,33.8,32.7,31.5,31.1],
                    numberofDicimal: 1
                )
            }
        }
    }
}

#Preview {
    inuyashaTableKoyakuRatio()
        .padding(.horizontal)
}
