//
//  commonViewEnteriseTrophy.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/13.
//

import SwiftUI

struct commonViewEnteriseTrophy: View {
    @State var textBodyBeforeImage1: String?
    @State var textBodyBeforeImage2: String?
    @State var textBodyAfterImage1: String?
    @State var textBodyAfterImage2: String?
    @State var textColor: Color = .secondary
    let trophyColor: [String] = [
        "銅",
        "銀",
        "金",
        "紅葉柄",
        "虹"
    ]
    let trophySisa: [String] = [
        "設定1 否定",
        "設定3 以上",
        "設定4 以上",
        "設定5 以上",
        "設定6 濃厚"
    ]
    
    var body: some View {
        List {
            if let textBodyBeforeImage1 = textBodyBeforeImage1 {
                Text(textBodyBeforeImage1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            if let textBodyBeforeImage2 = textBodyBeforeImage2 {
                Text(textBodyBeforeImage2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            HStack(spacing: 0) {
                Spacer()
                unitTableString(
                    columTitle: "トロフィー色",
                    stringList: self.trophyColor
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: self.trophySisa
                )
                Spacer()
            }
            if let textBodyAfterImage1 = textBodyAfterImage1 {
                Text(textBodyAfterImage1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
            if let textBodyAfterImage2 = textBodyAfterImage2 {
                Text(textBodyAfterImage2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(self.textColor)
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンタトロフィー")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    commonViewEnteriseTrophy()
}
