//
//  toloveruTableDokidokiPt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveruTableDokidokiPt: View {
    var body: some View {
        VStack {
            Text("[内部状態]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常",
                        "高確",
                        "超高確"
                    ]
                )
                unitTableString(
                    columTitle: "獲得量",
                    stringList: [
                        "1pt以上",
                        "10pt以上",
                        "75pt以上"
                    ]
                )
            }
            .padding(.bottom)
            Text("[どきどき高確]")
                .font(.title2)
            Text("※上記内部状態ごとの抽選に追加で獲得")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "どきどき高確中"
                    ]
                )
                unitTableString(
                    columTitle: "獲得量",
                    stringList: [
                        "＋10pt以上"
                    ]
                )
            }
            .padding(.bottom)
            Text("[にゃんにゃんコピーくん]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "アイテム所持中"
                    ],
                    lineList: [2]
                )
                unitTableString(
                    columTitle: "獲得量",
                    stringList: [
                        "チャンス目成立時の獲得pt倍増"
                    ],
                    maxWidth: 200,
                    lineList: [2]
                )
            }
            .padding(.bottom)
            Text("[複合チャンス目]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "複合チャンス目"
                    ],
                    lineList: [2]
                )
                unitTableString(
                    columTitle: "獲得量",
                    stringList: [
                        "10pt以上\n(超高確時は75pt以上)"
                    ],
                    maxWidth: 300,
                    lineList: [2],
                    contentFont: .body
                )
            }
        }
    }
}

#Preview {
    toloveruTableDokidokiPt()
        .padding(.horizontal)
}
