//
//  idolMasterTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterTableFirstHit: View {
    @ObservedObject var idolMaster: IdolMaster
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ",
                denominateList: idolMaster.ratioCz
            )
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: idolMaster.ratioBonus
            )
        }
    }
}

#Preview {
    idolMasterTableFirstHit(idolMaster: IdolMaster())
}
