//
//  sevenSwordsTable250Hit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sevenSwordsTable250Hit: View {
    var body: some View {
        VStack {
            Text("[独自集計結果]")
                .font(.title2)
            HStack(spacing: 0) {
//                unitTableString(
//                    columTitle: "",
//                    stringList: ["集計結果"]
//                )
                unitTableString(
                    columTitle: "290G以降での当選",
                    stringList: ["398回\n(75%)"],
                    maxWidth: 250,
                    lineList: [2],
                    titleFont: .body
                )
                unitTableString(
                    columTitle: "250〜290Gでの当選",
                    stringList: ["136回\n(25%)"],
                    maxWidth: 250,
                    lineList: [2],
                    titleFont: .body
                )
            }
//            .padding(.horizontal)
            Text("　　　＜集計条件＞")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("　　　　　・朝イチの当選は除外")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("　　　　　・無作為に選んだ台で集計")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    sevenSwordsTable250Hit()
}
