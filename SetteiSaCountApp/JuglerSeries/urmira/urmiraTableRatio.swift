//
//  urmiraTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/01.
//

import SwiftUI

struct urmiraTableRatio: View {
    @ObservedObject var urmira: Urmira
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ぶどう",
                    denominateList: urmira.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "🍒",
                    denominateList: urmira.denominateListCherry,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: urmira.denominateListBigSum
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: urmira.denominateListRegSum
                )
                unitTableDenominate(
                    columTitle: "ﾎﾞﾅ合算",
                    denominateList: urmira.denominateListBonusSum
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "単独BIG",
                    denominateList: urmira.denominateListBigAlone
                )
                unitTableDenominate(
                    columTitle: "🍒BIG",
                    denominateList: urmira.denominateListBigCherry
                )
                unitTableDenominate(
                    columTitle: "単独REG",
                    denominateList: urmira.denominateListRegAlone
                )
                unitTableDenominate(
                    columTitle: "🍒REG",
                    denominateList: urmira.denominateListRegCherry
                )
            }
        }
    }
}

#Preview {
    urmiraTableRatio(
        urmira: Urmira(),
    )
}
