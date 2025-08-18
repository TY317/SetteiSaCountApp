//
//  enenTableModeNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct enenTableModeNormal: View {
    var body: some View {
        VStack {
            Text("・ボーナス終了後は4種類いずれかのモードへ移行")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("・天井到達時はボーナスor灰焔騎士団に当選")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[天井,前兆タイミング テーブル]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [88,150,250,350,450,550,650,750,850])
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "前兆!?",
                        "-",
                        "前兆!?",
                        "-",
                        "-",
                        "前兆!?",
                        "-",
                        "-",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "前兆!?",
                        "-",
                        "-",
                        "前兆!?",
                        "-",
                        "-",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "-",
                        "前兆!?",
                        "-",
                        "-",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
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
            Text("※ 150Gは100Gの場合あり")
                .foregroundStyle(Color.secondary)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[テーブル振り分け ボーナス終了後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [64,63,63,63,63]
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [6],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [6],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [24,25,25,25,26]
                )
            }
            .padding(.bottom)
            Text("[テーブル振り分け 有利切断後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [19],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [15],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [44,44,43,43,43]
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [22,22,23,23,23]
                )
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    ScrollView {
        enenTableModeNormal()
            .padding(.horizontal)
    }
}
