//
//  ggoTableModeZone.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

// //// モードごとのゾーン期待度
// kitaiList：0=－　2=◯（ボーナス高確）　3=◎（ボーナス超高確）　30=★（天井までボーナス超高確）
struct ggoTableModeZone: View {
    // ゲーム数区間
    let gameList: [String] = [
        "51〜100G",
        "101〜150G",
        "151〜200G",
        "201〜250G",
        "251〜300G",
        "301〜350G",
        "351〜400G",
        "401〜450G",
        "451〜500G",
        "501〜550G",
        "551〜600G",
        "601〜650G",
        "651〜700G",
        "701〜750G",
        "751〜800G",
        "801〜850G",
        "851〜900G",
        "901〜950G",
        "951〜975G",
    ]

    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・◯：ボーナス高確")
                Text("・◎：ボーナス超高確")
                Text("・★：天井までボーナス超高確")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ゲーム数",
                    stringList: self.gameList,
                    maxWidth: 110,
                )
                unitTableZoneKitai(
                    columTitle: "通常A",
                    kitaiList: [0,2,0,0,0,2,0,0,0,2,0,0,0,3,0,0,0,2,30],
                    maxWidth: 70,
                )
                unitTableZoneKitai(
                    columTitle: "通常B",
                    kitaiList: [2,0,2,0,2,0,2,0,0,3,0,0,2,0,0,30,30,30,30],
                    maxWidth: 70,
                )
                unitTableZoneKitai(
                    columTitle: "チャンスA",
                    kitaiList: [0,2,0,2,0,2,0,2,0,3,0,0,0,30,30,30,30,30,30],
                    maxWidth: 70,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ゲーム数",
                    stringList: self.gameList,
                    maxWidth: 110,
                )
                unitTableZoneKitai(
                    columTitle: "チャンスB",
                    kitaiList: [2,0,2,0,2,0,3,0,0,30,30,30,30,30,30,30,30,30,30],
                    maxWidth: 70,
                )
                unitTableZoneKitai(
                    columTitle: "チャンスC",
                    kitaiList: [0,2,0,2,0,3,0,2,0,3,0,2,0,0,3,0,0,2,30],
                    maxWidth: 70,
                )
                unitTableZoneKitai(
                    columTitle: "天国",
                    kitaiList: [0,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30],
                    maxWidth: 70,
                )
            }
        }
    }
}


#Preview {
    ScrollView {
        ggoTableModeZone()
    }
    .padding(.horizontal)
}
