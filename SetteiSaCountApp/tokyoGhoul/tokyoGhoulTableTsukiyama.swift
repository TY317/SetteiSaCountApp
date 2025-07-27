//
//  tokyoGhoulTableTsukiyama.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/21.
//

import SwiftUI

struct tokyoGhoulTableTsukiyama: View {
    let lineList: [Int] = [2,2,2,2,2,2,2]
    var body: some View {
        VStack {
            Text("[残りG数示唆の詳細]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "", stringList: [
                        "心配しなくとも最悪の事態にはならないだろう",
                        "1時35分に下記の場所で待っている",
                        "2時46分に下記の場所で待っている",
                        "喰うか喰われるかは君次第だ",
                        "3時までに僕のもとにきてくれ",
                        "2時までに僕のもとにきてくれ",
                        "今すぐ僕のもとにきてくれ",
                    ],
                    maxWidth: 200,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "天井否定期待度アップ",
                        "100G or 300G or 500GでのCZ当選 期待度アップ",
                        "200G or 400G or 600GでのCZ当選 期待度アップ",
                        "浅いG数 or 天井付近でのCZ当選 期待度アップ",
                        "300G以内にCZ当選濃厚",
                        "200G以内にCZ当選濃厚",
                        "100G以内にCZ当選濃厚",
                    ],
                    maxWidth: 200,
                    lineList: self.lineList,
                )
            }
        }
    }
}

#Preview {
    tokyoGhoulTableTsukiyama()
        .padding(.horizontal)
}
