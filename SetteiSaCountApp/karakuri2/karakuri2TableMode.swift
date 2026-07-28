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
                    maxWidth: 100,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [-100,-100,0.9,15.7,0.8,16.3,0.8,12.5,0.8,15.4,0.6,22.9,13.3],
                    numberofDicimal: 1,
                    maxWidth: self.maxW,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [-100,-100,12.6,0.9,18.7,0.9,28.8,1.3,36.8,-100,-100,-100,-100,],
                    numberofDicimal: 1,
                    maxWidth: self.maxW,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [-100,-100,0.9,15.7,0.8,16.3,0.8,12.5,0.8,15.4,0.6,22.9,13.3],
                    numberofDicimal: 1,
                    maxWidth: self.maxW,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常D",
                    percentList: [-100,-100,8.3,0.9,11.5,0.9,16.1,1.6,25,1.4,20.3,0.6,13.3,],
                    numberofDicimal: 1,
                    maxWidth: self.maxW,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [15.2,84.8,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,],
                    numberofDicimal: 1,
                    maxWidth: self.maxW,
                    contentFont: .subheadline,
                )
//                unitTableString(
//                    columTitle: "通常A",
//                    stringList: [
//                        "grayOut",
//                        "grayOut",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "天井",
//                    ],
//                    maxWidth: self.maxW,
//                )
//                unitTableString(
//                    columTitle: "通常B",
//                    stringList: [
//                        "grayOut",
//                        "grayOut",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ],
//                    maxWidth: self.maxW,
//                )
//                unitTableString(
//                    columTitle: "通常C",
//                    stringList: [
//                        "grayOut",
//                        "grayOut",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "天井",
//                    ],
//                    maxWidth: self.maxW,
//                )
//                unitTableString(
//                    columTitle: "通常D",
//                    stringList: [
//                        "grayOut",
//                        "grayOut",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "◎",
//                        "△",
//                        "天井",
//                    ],
//                    maxWidth: self.maxW,
//                )
//                unitTableString(
//                    columTitle: "天国",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ],
//                    maxWidth: self.maxW,
//                )
            }
        }
    }
}

#Preview {
    karakuri2TableMode()
        .padding(.horizontal)
}
