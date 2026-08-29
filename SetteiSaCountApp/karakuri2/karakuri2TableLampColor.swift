//
//  karakuri2TableLampColor.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct karakuri2TableLampColor: View {
    @ObservedObject var karakuri2: Karakuri2
    let colorList: [String] = [
        "白",
        "青",
        "黄",
        "緑",
        "赤",
        "紫",
        "虹",
    ]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・レア役成立の次ゲームのMAX BETを押すとランプ色が変化")
                Text("・エンディング中に押し順ミスすると白しか出なくなるため注意")
                Text("・下記振り分けは弱レア役時の数値。強レア役時は確定系の振り分けが5〜3％にアップ")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.colorList,
                    maxWidth: 80,
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: settingList(index: 0),
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: settingList(index: 1),
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: settingList(index: 2),
                    maxWidth: 65,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.colorList,
                    maxWidth: 80,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: settingList(index: 3),
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: settingList(index: 4),
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: settingList(index: 5),
                    maxWidth: 65,
                )
            }
        }
    }
    // 指定した設定の7色分の振分けを返す（colorList の並びと対応）
    private func settingList(index: Int) -> [Double] {
        [
            karakuri2.ratioLampColorWhite[index],
            karakuri2.ratioLampColorBlue[index],
            karakuri2.ratioLampColorYellow[index],
            karakuri2.ratioLampColorGreen[index],
            karakuri2.ratioLampColorRed[index],
            karakuri2.ratioLampColorPurple[index],
            karakuri2.ratioLampColorRainbow[index],
        ]
    }
}

#Preview {
    karakuri2TableLampColor(
        karakuri2: Karakuri2(),
    )
    .padding(.horizontal)
}
