//
//  kaijiTableZawaKokaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct kaijiTableZawaKokaku: View {
    @ObservedObject var kaiji = Kaiji()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ざわ高確移行率",
                percentList: kaiji.zawaKokakuRatio
            )
        }
    }
}

#Preview {
    kaijiTableZawaKokaku()
}
