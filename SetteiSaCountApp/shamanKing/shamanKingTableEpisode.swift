//
//  shamanKingTableEpisode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableEpisode: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "エピソードボーナス振分け",
                percentList: [0.4,0.4,0.8,1.6,2.0,2.7],
                numberofDicimal: 1,
                maxWidth: 230,
                titleFont: .body
            )
        }
    }
}

#Preview {
    shamanKingTableEpisode()
}
