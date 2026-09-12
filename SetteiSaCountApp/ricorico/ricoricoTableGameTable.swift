//
//  ricoricoTableGameTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/05.
//

import SwiftUI

struct ricoricoTableGameTable: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("・250GまでのCZ当選期待度は約90％")
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [
                    0,
                    50,
                    100,
                    150,
                    200,
                    250,
                    300,
                    350,
                    400,
                    450,
                    500,
                    550,
                    600,
                    650,
                    700,
                    750,
                    800,
                    850,
                ]
                )
                unitTableZoneKitai(
                    columTitle: "CZ",
                    kitaiList: [2,0,3,0,0,3,0,0,2,0,0,0,3,0,0,2,0,10])
                unitTableZoneKitai(
                    columTitle: "変換高確",
                    kitaiList: [0,3,0,3,0,0,20,0,0,3,0,0,0,2,0,0,0,0])
            }
        }
    }
}

#Preview {
    ricoricoTableGameTable()
}
