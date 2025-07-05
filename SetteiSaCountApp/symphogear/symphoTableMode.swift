//
//  symphoTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/15.
//

import SwiftUI

struct symphoTableMode: View {
    let lineList: [Int] = [1,2,1]
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "モード",
                    stringList: [
                        "通常",
                        "天国準備",
                        "天国",
                    ],
                    maxWidth: 100,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "基本モード",
                        "次回天国準備以上\n(転落なし)",
                        "100G以内にAT当選"
                    ],
                    maxWidth: 200,
                    lineList: self.lineList,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "777G+α",
                        "777G+α",
                        "100G以内",
                    ],
                    maxWidth: 100,
                    lineList: self.lineList,
                )
            }
            .padding(.bottom)
            Text("[AT終了時(設定1、獲得100枚超)]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常へ",
                        "天国準備へ",
                        "天国へ",
                    ],
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "通常滞在時",
                    percentList: [84,8,8],
                    maxWidth: 80,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "天国準備\n滞在時",
                    percentList: [0,58,42],
                    maxWidth: 80,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "天国滞在時",
                    percentList: [76,4,20],
                    maxWidth: 80,
                    titleLine: 2,
                )
            }
            .padding(.bottom)
            Text("[AT終了時(設定1、獲得100枚以下)]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常へ",
                        "天国準備へ",
                        "天国へ",
                    ],
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "通常滞在時",
                    percentList: [-1,-1,42],
                    maxWidth: 80,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "天国準備\n滞在時",
                    percentList: [0,-1,42],
                    maxWidth: 80,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "天国滞在時",
                    percentList: [-1,-1,42],
                    maxWidth: 80,
                    titleLine: 2,
                )
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    symphoTableMode()
        .padding(.horizontal)
}
