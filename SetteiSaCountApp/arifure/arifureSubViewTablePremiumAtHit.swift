//
//  arifureSubViewTablePremiumAtHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/17.
//

import SwiftUI

struct arifureSubViewTablePremiumAtHit: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(columTitle: "上位AT初当り", denominateList: arifure.ratioPremiumAtHit, aboutBool: true)
        }
    }
}

#Preview {
    arifureSubViewTablePremiumAtHit(arifure: Arifure())
}
