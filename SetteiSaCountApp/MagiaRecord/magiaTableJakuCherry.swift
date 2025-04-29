//
//  magiaTableJakuCherry.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaTableJakuCherry: View {
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "弱🍒",
                denominateList: magia.ratioJakuCherry,
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    magiaTableJakuCherry(magia: Magia())
}
