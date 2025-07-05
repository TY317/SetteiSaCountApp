//
//  kaguyaSamaTableFujiwaraComment.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct kaguyaSamaTableFujiwaraComment: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "衣装",
                stringList: [
                    "制服",
                    "ラブ探偵",
                    "体操着",
                ],
                maxWidth: 60,
                lineList: [13,4,4],
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "セリフ",
                stringList: [
                    "わぁ!",
                    "おーい!",
                    "ちゅ♡",
                    "いえーい!",
                    "るんるん♪",
                    "ドーンだYO!",
                    "しゃららーん\n（左回り）",
                    "しゃららーん\n（右回り）",
                    "うえ〜ん",
                    "やったー!",
                    "どこだ!どこだ!",
                    "う〜ん・・",
                    "もおおお!",
                    "やれやれ・・",
                    "こうです!",
                ],
                maxWidth: 100,
                lineList: [1,1,1,1,1,2,2,2,2,2,1,1,2,1,1],
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "チャンス目示唆 弱",
                    "チャンス目示唆 中",
                    "チャンス目示唆 強",
                    "チャンス目示唆 弱",
                    "チャンス目示唆 強",
                    "チャンス目濃厚\n当該ゲームでの本前兆移行濃厚",
                    "チャンス目3回以内に本前兆到達のチャンス",
                    "チャンス目3回以内に本前兆到達のチャンス\nかつ5回以内に本前兆濃厚",
                    "チャンス目3回以内に本前兆濃厚\nただし、当該ゲームのチャンス目は含まない",
                    "チャンス目2回以内に本前兆濃厚\nただし、当該ゲームのチャンス目は含まない",
                    "チャンス目示唆 中",
                    "チャンス目示唆 中",
                    "チャンス目2回以内に本前兆濃厚\nただし、当該ゲームのチャンス目は含まない",
                    "チャンス目示唆 中",
                    "チャンス目示唆 中",
                ],
                maxWidth: 200,
                lineList: [1,1,1,1,1,2,2,2,2,2,1,1,2,1,1],
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    kaguyaSamaTableFujiwaraComment()
        .padding(.horizontal)
}
