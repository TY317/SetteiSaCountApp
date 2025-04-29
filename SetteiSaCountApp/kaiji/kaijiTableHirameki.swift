//
//  kaijiTableHirameki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiTableHirameki: View {
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "青",
                percentList: kaiji.ratioHiramekiBlue
            )
            unitTablePercent(
                columTitle: "黄",
                percentList: kaiji.ratioHiramekiYellow
            )
            unitTablePercent(
                columTitle: "緑",
                percentList: kaiji.ratioHiramekiGreen
            )
            unitTablePercent(
                columTitle: "赤",
                percentList: kaiji.ratioHiramekiRed
            )
        }
    }
}

#Preview {
    kaijiTableHirameki(kaiji: Kaiji())
}
