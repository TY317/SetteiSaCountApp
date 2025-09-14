//
//  mrJugSubViewTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI

struct mrJugSubViewTableRatio: View {
//    @ObservedObject var mrJug = MrJug()
    @ObservedObject var mrJug: MrJug
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ぶどう",
                    denominateList: mrJug.denominateListBell,
                    numberofDicimal: 2
                )
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: mrJug.denominateListBigSum
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: mrJug.denominateListRegSum
                )
                unitTableDenominate(
                    columTitle: "ﾎﾞﾅ合算",
                    denominateList: mrJug.denominateListBonusSum
                )
            }
//            .padding(.trailing)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "単独BIG",
                    denominateList: mrJug.denominateListBigAlone
                )
                unitTableDenominate(
                    columTitle: "🍒BIG",
                    denominateList: mrJug.denominateListBigCherry
                )
                unitTableDenominate(
                    columTitle: "単独REG",
                    denominateList: mrJug.denominateListRegAlone
                )
                unitTableDenominate(
                    columTitle: "🍒REG",
                    denominateList: mrJug.denominateListRegCherry
                )
            }
        }
    }
}

#Preview {
    mrJugSubViewTableRatio(mrJug: MrJug())
}
