//
//  tokyoGhoulSubViewTableGedanReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct tokyoGhoulSubViewTableGedanReplay: View {
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @ObservedObject var tokyoGhoul: TokyoGhoul
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "下段リプレイ",
                    denominateList: tokyoGhoul.ratioGedanReplay
                )
            }
        }
    }
}

#Preview {
    tokyoGhoulSubViewTableGedanReplay(tokyoGhoul: TokyoGhoul())
}
