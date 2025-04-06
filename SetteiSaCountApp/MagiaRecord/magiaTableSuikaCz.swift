//
//  magiaTableSuikaCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaTableSuikaCz: View {
    @ObservedObject var magia = Magia()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "CZ当選率",
                percentList: magia.ratioSuikaCz
            )
        }
    }
}

#Preview {
    magiaTableSuikaCz()
}
