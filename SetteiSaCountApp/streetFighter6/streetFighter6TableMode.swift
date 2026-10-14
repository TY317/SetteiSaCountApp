//
//  streetFighter6TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/10/11.
//

import SwiftUI

struct streetFighter6TableMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・4種類のモードでFB当選までの規定ゲーム数を管理")
                Text("・天井ゲーム数は実ゲーム数ではなく、加算も含めた液晶表示")
            }
            // モードの特徴
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "モード",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "天国",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "1000G",
                        "900G",
                        "800G",
                        "200G",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "次回は通常B以上濃厚",
                        "次回は通常C以上に期待",
                        "次回天国に期待",
                        "早いFB当選濃厚",
                    ],
                    maxWidth: 250,
                )
            }
            // 規定ゲーム数ごとの期待度
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [100,200,300,400,500,600,700,800,900,1000])
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "-",
                        "△",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "-",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "-",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
        }
    }
}

#Preview {
    streetFighter6TableMode()
        .padding(.horizontal)
}
