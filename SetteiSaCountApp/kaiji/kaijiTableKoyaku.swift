//
//  kaijiTableKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct kaijiTableKoyaku: View {
    @ObservedObject var kaiji = Kaiji()
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "🍉",
                denominateList: kaiji.ratioKoyakuSuika,
                contentFont: .body
            )
            unitTableDenominate(
                columTitle: "🍒",
                denominateList: kaiji.ratioKoyakuJakuCherry,
                contentFont: .body
            )
            unitTableDenominate(
                columTitle: "ﾁｬﾝｽ目",
                denominateList: kaiji.ratioKoyakuJakuChance,
                titleFont: .body,
                contentFont: .body
            )
            unitTableDenominate(
                columTitle: "強🍒",
                denominateList: kaiji.ratioKoyakuKyoCherry,
                contentFont: .body
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: kaiji.ratioKoyakuSum,
                numberofDicimal: 1,
                contentFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    kaijiTableKoyaku()
}
