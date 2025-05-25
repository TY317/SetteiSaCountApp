//
//  magiaViewStoryChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/20.
//

import SwiftUI
import TipKit

struct magiaViewStoryChara: View {
    @ObservedObject var ver310: Ver310
    
    var body: some View {
        TipView(tipVer310MagiaStoryChara())
        List {
            Section {
                Text("[キャラ紹介発生条件]\n　・ATのストーリーコンプリート後にストーリー当選\n　・エンブリオ・イブ覚醒中にストーリー当選")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                // //// シナリオ表
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "ｼﾅﾘｵ",
                        stringList: [
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7",
                            "8",
                            "9"
                        ],
                        maxWidth: 50,
                        lineList: [2,2,2,2,1,2,2,2,2],
                        titleFont: .subheadline,
                        colorList: [.white,.white,.white,.white,.tableBlue,.personalSummerLightRed,.personalSummerLightRed,.personalSummerLightRed,.personalSummerLightPurple]
                    )
                    unitTableString(
                        columTitle: "キャラ順",
                        stringList: [
                            "いろは→やちよ→鶴乃→フェリシア→さな",
                            "ももこ→レナ→かえで→みたま→黒江",
                            "灯花→ねむ→天音姉妹→みふゆ→アリナ",
                            "まどか→さやか→マミ→杏子→ほむら",
                            "ｼﾅﾘｵ1-4の逆順で登場",
                            "ももこ→やちよ→鶴乃→みふゆ→みたま",
                            "いろは→うい→灯花→ねむ→アリナ",
                            "まどか→さやか→マミ→杏子(4キャラのみ)",
                            "ｼﾅﾘｵ1-7のいずれかで最後に小さいキュウベエ"
                        ],
                        maxWidth: 180,
                        lineList: [2,2,2,2,1,2,2,2,2],
                        contentFont: .subheadline,
                        colorList: [.white,.white,.white,.white,.tableBlue,.personalSummerLightRed,.personalSummerLightRed,.personalSummerLightRed,.personalSummerLightPurple]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "デフォルト",
                            "高設定示唆 弱",
                            "高設定示唆 強",
                            "設定5\n以上濃厚"
                        ],
                        maxWidth: 100,
                        lineList: [8,1,6,2],
                        contentFont: .subheadline,
                        colorList: [.white,.tableBlue,.personalSummerLightRed,.personalSummerLightPurple]
                    )
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
        .onAppear {
            if ver310.magiaMenuStoryCharaBadgeStatus != "none" {
                ver310.magiaMenuStoryCharaBadgeStatus = "none"
            }
        }
        .navigationTitle("ストーリーのキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewStoryChara(
        ver310: Ver310()
    )
}
