//
//  karakuriTableMakuai.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct karakuriTableMakuai: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTableDenominate(
                columTitle: "🍉契機の幕間チャンス",
                denominateList: [3000,-1,-1,-1,1000],
                maxWidth: 250,
            )
        }
    }
}

#Preview {
    karakuriTableMakuai()
}
