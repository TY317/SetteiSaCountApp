//
//  mrJugSubViewTableRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI

struct mrJugSubViewTableRatio: View {
    @ObservedObject var mrJug = MrJug()
    
    var body: some View {
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
        .padding(.trailing)
    }
}

#Preview {
    mrJugSubViewTableRatio()
}
