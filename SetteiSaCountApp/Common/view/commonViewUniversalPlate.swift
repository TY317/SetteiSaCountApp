//
//  commonViewUniversalPlate.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import SwiftUI

struct commonViewUniversalPlate: View {
    @State var textBodyBeforeImage1: String?
    @State var textBodyBeforeImage2: String?
    @State var textBodyAfterImage1: String?
    @State var textBodyAfterImage2: String?
    @State var textColor: Color = .secondary
    
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
            HStack {
                Spacer()
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "銅",
                            "銀",
                            "金",
                            "花火柄",
                            "虹"
                        ],
                        maxWidth: 120
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "設定2 以上濃厚",
                            "設定3 以上濃厚",
                            "設定4 以上濃厚",
                            "設定5 以上濃厚",
                            "設定6 濃厚"
                        ],
                        maxWidth: 180
                    )
                }
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
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "トロフィー",
                screenClass: screenClass
            )
        }
        .navigationTitle("ユニバプレート")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    commonViewUniversalPlate()
}
