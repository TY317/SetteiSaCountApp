//
//  toreveTableRevengeZenya.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/10.
//

import SwiftUI

struct toreveTableRevengeZenya: View {
    @ObservedObject var toreve: Toreve
    var body: some View {
        VStack(alignment: .leading) {
            Text("・3,4,5周期目スルー時のノイズ状態移行率に設定差あり")
            Text("・ノイズ状態移行時はフェイクとフリーズがあり、振り分けは１：１")
            VStack (alignment: .center) {
                Text("[3,4周期目スルー時]")
                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "ノイズなし",
                        percentList: toreve.ratioRevengeZenya34NoizeNone,
                        numberofDicimal: 1
                    )
                    unitTablePercent(
                        columTitle: "ノイズあり",
                        percentList: toreve.ratioRevengeZenya34NoizeHit,
                        numberofDicimal: 1
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
            VStack (alignment: .center) {
                Text("[5周期目スルー時]")
                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "ノイズなし",
                        percentList: toreve.ratioRevengeZenya5NoizeNone,
                        numberofDicimal: 1
                    )
                    unitTablePercent(
                        columTitle: "ノイズあり",
                        percentList: toreve.ratioRevengeZenya5NoizeHit,
                        numberofDicimal: 1
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
    }
}

#Preview {
    toreveTableRevengeZenya(
        toreve: Toreve(),
    )
    .padding(.horizontal)
}
