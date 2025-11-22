//
//  creaTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaTableKoyakuRatio: View {
    @ObservedObject var crea: Crea
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "🔔",
                    denominateList: crea.ratioKoyakuBell,
                    numberofDicimal: 2,
                )
                unitTableDenominate(
                    columTitle: "チャンス目",
                    denominateList: crea.ratioKoyakuChance,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "🍒",
                    denominateList: crea.ratioKoyakuCherry,
                    numberofDicimal: 1,
                )
                
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "🍉",
                    denominateList: crea.ratioKoyakuSuika,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "滑り🍉",
                    denominateList: crea.ratioKoyakuSuberiSuika,
                    numberofDicimal: 0,
                )
                unitTableDenominate(
                    columTitle: "ピラミッド",
                    denominateList: crea.ratioKoyakuPylamid,
                    numberofDicimal: 0,
                )
            }
        }
    }
}

#Preview {
    creaTableKoyakuRatio(
        crea: Crea(),
    )
    .padding(.horizontal)
}
