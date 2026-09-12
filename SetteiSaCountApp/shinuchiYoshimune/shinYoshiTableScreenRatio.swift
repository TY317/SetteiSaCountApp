//
//  shinYoshiTableScreenRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct shinYoshiTableScreenRatio: View {
    @ObservedObject var shinYoshi: ShinYoshi
    let screenList: [String] = [
        "新月",
        "三日月",
        "満月",
        "大岡越前",
        "柳生",
        "大奥",
        "吉宗",
    ]
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.screenList,
                    maxWidth: 90,
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: settingList(index: 0),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: settingList(index: 1),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: settingList(index: 2),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: self.screenList,
                    maxWidth: 90,
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: settingList(index: 3),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: settingList(index: 4),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: settingList(index: 5),
                    numberofDicimal: 0,
                    maxWidth: 65,
                )
            }
        }
    }
    // 指定した設定の7画面分の出現率を返す（screenList の並びと対応）
    private func settingList(index: Int) -> [Double] {
        [
            shinYoshi.ratioScreenShingetsu[index],
            shinYoshi.ratioScreenMikazuki[index],
            shinYoshi.ratioScreenMangetsu[index],
            shinYoshi.ratioScreenOoka[index],
            shinYoshi.ratioScreenYagyu[index],
            shinYoshi.ratioScreenOoku[index],
            shinYoshi.ratioScreenYoshimune[index],
        ]
    }
}

#Preview {
    shinYoshiTableScreenRatio(
        shinYoshi: ShinYoshi(),
    )
    .padding(.horizontal)
}
