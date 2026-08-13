//
//  dropkickTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/13.
//

import SwiftUI

struct dropkickTableMode: View {
    let lineList: [Int] = [1,1,2,2,]
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・規定G数到達でボーナス当選を抽選")
                Text("・あらかじめ5回先のモードが決まっている")
                Text("・基本的にボーナス当選で次回モードへ移行")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "特殊",
                        "天国A",
                        "天国B",
                    ],
                    maxWidth: 80,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "200,400,600Gのゾーンがチャンス",
                        "100,300,500Gのゾーンがチャンス",
                        "100,300,500Gのゾーンがチャンス\n下2桁が50Gのゾーンで当選の可能性あり",
                        "基本的にゲーム数当選は天井までなし\n次回は特殊or天国Bへ移行",
                        "天井が99G",
                        "次回 天国A or 天国Bへ移行",
                    ],
                    maxWidth: 300,
                    lineList: self.lineList,
                )
            }
        }
    }
}

#Preview {
    dropkickTableMode()
        .padding(.horizontal)
}
