//
//  enenTableModeMorning.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct enenTableModeMorning: View {
    var body: some View {
        VStack {
            Text("・朝イチ専用のモードがあり設定変更後は天国を含む4種類のいずれかへ移行")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("・天井到達時はボーナスor灰焔騎士団に当選")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[天井,前兆タイミング テーブル]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [88,150,250,350,450,550,650])
                unitTableString(
                    columTitle: "朝イチA",
                    stringList: [
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
                    columTitle: "朝イチB",
                    stringList: [
                        "前兆!?",
                        "-",
                        "前兆!?",
                        "-",
                        "-",
                        "天井",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "朝イチC",
                    stringList: [
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
                    columTitle: "天国",
                    stringList: [
                        "天井",
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
            Text("[テーブル振り分け 設定変更後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "朝イチA",
                    percentList: [53,53,53,52,52]
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [1],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [11],
                    lineList: [5],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [35,35,35,36,36]
                )
            }
        }
    }
}

#Preview {
    enenTableModeMorning()
        .padding(.horizontal)
}
