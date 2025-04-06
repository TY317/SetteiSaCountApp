//
//  arifureTableCzMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct arifureTableCzMode: View {
    var body: some View {
        VStack {
            Text("[CZモードごとの期待度テーブル]")
                .font(.title2)
            ZStack {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: ["100G", "300G", "500G", "700G", "900G"]
                    )
                    unitTableString(
                        columTitle: "モードA",
                        stringList: ["△","◯","△","×","×"]
                    )
                    unitTableString(
                        columTitle: "モードB",
                        stringList: ["△","△","◯","◎","×"]
                    )
                    unitTableString(
                        columTitle: "モードC",
                        stringList: ["△","◎","◯","◯","△"]
                    )
                }
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 29)
                        .foregroundStyle(Color.clear)
                    Rectangle()
                        .frame(height: 29)
                        .foregroundStyle(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                                .stroke(Color.red, lineWidth: 4) // 黒色の線を追加
                        )
                    Spacer()
                }
                .frame(height: 174)
            }
            .padding(.bottom)
            Text("[期待度記号ごとのCZ当選率]")
                .font(.title2)
            ZStack {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "×",
                        percentList: [5,6,7,10,11,21],
                        aboutBool: true
                    )
                    ZStack {
                        unitTablePercent(
                            columTitle: "△",
                            percentList: [21,21,23,29,33,40],
                            aboutBool: true
                        )
//                        Rectangle()
//                            .frame(height: 203)
//                            .foregroundStyle(Color.clear)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 0) // 四角の輪郭
//                                    .stroke(Color.red, lineWidth: 5) // 黒色の線を追加
//                            )
                    }
                    unitTablePercent(
                        columTitle: "◯",
                        percentList: [33,33,36,41,45,53],
                        aboutBool: true
                    )
                    unitTablePercent(
                        columTitle: "◎",
                        percentList: [80],
                        aboutBool: true,
                        lineList: [6]
                    )
                }
                HStack(spacing: 0) {
                    Rectangle()
                        .frame(maxWidth: 55.0)
                        .foregroundStyle(Color.clear)
                    Rectangle()
                        .frame(maxWidth: 150.0)
                        .foregroundStyle(Color.clear)
                    Rectangle()
                        .frame(maxWidth: 150.0)
                        .foregroundStyle(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                                .stroke(Color.red, lineWidth: 4) // 黒色の線を追加
                        )
                    Rectangle()
                        .frame(maxWidth: 150.0)
                        .foregroundStyle(Color.clear)
                    Rectangle()
                        .frame(maxWidth: 150.0)
                        .foregroundStyle(Color.clear)
                }
                .frame(height: 203)
            }
        }
//        .padding(.horizontal)
    }
}

#Preview {
    arifureTableCzMode()
}
