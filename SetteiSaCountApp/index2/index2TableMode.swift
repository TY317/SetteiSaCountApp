//
//  index2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/03.
//

import SwiftUI

struct index2TableMode: View {
    let lineList: [Int] = [2,1,1,1,2,]
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・5つのモードで規定G数を管理")
                Text("・内部的に3つ先までのモードが決まっている")
                Text("・CZ失敗orAT終了後にモード移行＆3つ先のモードを抽選")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "朝一",
                        "通常A",
                        "通常B",
                        "天国準備",
                        "天国",
                    ],
                    maxWidth: 100,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "設定変更時専用\nCZ,AT当選時の次回天国移行が優遇",
                        "30%以上で通常B以上へ移行",
                        "約50%で天国準備or天国へ移行",
                        "約50%で天国へ移行",
                        "約25%で天国ループ\n約20%で天国準備へ",
                    ],
                    maxWidth: 300,
                    lineList: self.lineList,
                )
            }
            
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [50,100,150,200,300,400,500,600,700,800])
                unitTableZoneKitai(
                    columTitle: "朝一",
                    kitaiList: [0,2,0,10,-1,-1,-1,-1,-1,-1,]
                )
                unitTableZoneKitai(
                    columTitle: "通常A",
                    kitaiList: [0,2,0,3,0,2,0,2,0,10,]
                )
                unitTableZoneKitai(
                    columTitle: "通常B",
                    kitaiList: [0,2,0,0,2,0,3,0,10,-1,]
                )
                unitTableZoneKitai(
                    columTitle: "天国準備",
                    kitaiList: [0,1,2,3,2,3,2,2,2,10,]
                )
                unitTableZoneKitai(
                    columTitle: "天国",
                    kitaiList: [1,10,-1,-1,-1,-1,-1,-1,-1,-1,]
                )
            }
        }
    }
}




#Preview {
    index2TableMode()
        .padding(.horizontal)
}
