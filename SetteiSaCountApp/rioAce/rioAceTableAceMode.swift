//
//  rioAceTableAceMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/23.
//

import SwiftUI

struct rioAceTableAceMode: View {
    let lineList: [Int] = [2,2,2,2,2]
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("・滞在時は通常時を有利に進められる")
                Text("・モンキーのライバルモードのようなもの")
                Text("・サブ液晶左上にチップ表示でエースモード滞在濃厚")
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "モード",
                    stringList: [
                        "ナヴィ\n(青髪の人)",
                        "テイル\n(褐色の人)",
                        "ヴィヴィアン＆メリッサ\n(金髪の人＆メガネの人)",
                        "アリス\n(銀髪の人)",
                        "ノワール\n(ヘッドフォンの人)",
                    ],
                    maxWidth: 200,
                    lineList: self.lineList
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "天井が300Gor500Gに短縮",
                        "規定ゲーム数到達ごとに50%以上でノワールルームに当選",
                        "レア役成立時のノワールルーム当選率アップ",
                        "ノワールルーム当選時の約50%で「のわーるるーむ」に当選",
                        "次回の初当りがATに変化",
                    ],
                    maxWidth: 200,
                    lineList: self.lineList
                )
            }
        }
    }
}

#Preview {
    rioAceTableAceMode()
        .padding(.horizontal)
}
