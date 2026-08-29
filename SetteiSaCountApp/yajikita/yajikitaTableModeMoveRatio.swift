//
//  yajikitaTableModeMoveRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/17.
//

import SwiftUI

struct yajikitaTableModeMoveRatio: View {
    var body: some View {
        VStack {
            Text("[設定1の移行率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常Aへ",
                        "通常Bへ",
                        "特殊Aへ",
                        "特殊Bへ",
                        "天国Aへ",
                        "天国Bへ",
                    ],
                    titleLine: 2,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "設定変更後",
                    percentList: [0,37.5,50,12.5,0,0],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "有利区間\nリセット後",
                    percentList: [0,0,100,0,0,0],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .caption,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常A\n滞在時",
                    percentList: [31.3,43.8,0,18.8,4.7,1.6],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "通常B\n滞在時",
                    percentList: [32.8,32,0,16.4,15.6,3.1],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常Aへ",
                        "通常Bへ",
                        "特殊Aへ",
                        "特殊Bへ",
                        "天国Aへ",
                        "天国Bへ",
                    ],
                    titleLine: 2,
                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "特殊A\n滞在時",
                    percentList: [41.4,30.5,0,18.8,7.8,1.6],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "特殊B\n滞在時",
                    percentList: [0,0,0,0,90.6,9.4],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .caption,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "天国A\n滞在時",
                    percentList: [31.3,43.8,0,18.8,4.7,1.6],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
                unitTablePercent(
                    columTitle: "天国B\n滞在時",
                    percentList: [0,0,0,0,50,50],
                    numberofDicimal: 1,
                    titleLine: 2,
                    titleFont: .subheadline,
//                    contentFont: .subheadline,
                )
            }
        }
    }
}

#Preview {
    yajikitaTableModeMoveRatio()
        .padding(.horizontal)
}
