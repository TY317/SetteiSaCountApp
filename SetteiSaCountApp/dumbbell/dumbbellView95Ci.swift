//
//  dumbbellView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/04.
//

import SwiftUI

struct dumbbellView95Ci: View {
    @ObservedObject var dumbbell = Dumbbell()
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            // ボーナス初当り回数
            unitListSection95Ci(
                grafTitle: "ボーナス初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $dumbbell.bonusCountSum,
                        bigNumber: $dumbbell.playGameSum,
                        setting1Denominate: 591,
                        setting2Denominate: 576,
                        setting3Denominate: 546,
                        setting4Denominate: 532,
                        setting5Denominate: 512,
                        setting6Denominate: 504
                    )
                )
            )
            .tag(1)
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    dumbbellView95Ci()
}
