//
//  karakuri2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/07.
//

import SwiftUI

struct karakuri2TableMode: View {
    let maxW: CGFloat = 45
    
    var body: some View {
        VStack(spacing: 20) {
            Text("・5種類のモードで規定ゲーム数や当選先を管理")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "通常D",
                        "天国",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "100の位 偶数がチャンス",
                        "100の位 奇数がチャンス",
                        "ゲーム数到達でAT濃厚",
                        "ゲーム数到達で劇場ジャッジ濃厚",
                        "100G以内の当選濃厚",
                    ],
                    maxWidth: 250,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1-50G",
                        "51-100G",
                        "101-200G",
                        "201-300G",
                        "301-400G",
                        "401-500G",
                        "501-600G",
                        "601-700G",
                        "701-800G",
                        "801-900G",
                        "901-1000G",
                        "1001-1100G",
                        "1101-",
                    ],
                    maxWidth: 110,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "grayOut",
                        "grayOut",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "天井",
                    ],
                    maxWidth: self.maxW,
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "grayOut",
                        "grayOut",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ],
                    maxWidth: self.maxW,
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "grayOut",
                        "grayOut",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "天井",
                    ],
                    maxWidth: self.maxW,
                )
                unitTableString(
                    columTitle: "通常D",
                    stringList: [
                        "grayOut",
                        "grayOut",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                    ],
                    maxWidth: self.maxW,
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
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ],
                    maxWidth: self.maxW,
                )
            }
        }
    }
}

#Preview {
    karakuri2TableMode()
        .padding(.horizontal)
}
