//
//  tokyoGhoulTableReplayAtHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/12.
//

import SwiftUI

struct tokyoGhoulTableReplayAtHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "リプレイからのAT直撃",
                denominateList: [28460.6,24453.5,18093.0,12019.5,8615.4,7036.8],
                maxWidth: 250,
            )
        }
    }
}

#Preview {
    tokyoGhoulTableReplayAtHit()
}
