//
//  arifureSubViewTableAtEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct arifureSubViewTableAtEndScreen: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    
    var body: some View {
        VStack {
            Text("[トータルG数 2000以下]")
                .fontWeight(.bold)
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: arifure.atEndScreenIndex,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: arifure.ratioAtEndScreenSetting1,
                    aboutBool: true
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: arifure.ratioAtEndScreenSetting2,
                    aboutBool: true
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: arifure.ratioAtEndScreenSetting3,
                    aboutBool: true
                )
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: arifure.atEndScreenIndex,
                    contentFont: .subheadline
                )
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: arifure.ratioAtEndScreenSetting4,
                    aboutBool: true
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: arifure.ratioAtEndScreenSetting5,
                    aboutBool: true
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: arifure.ratioAtEndScreenSetting6,
                    aboutBool: true
                )
            }
            .padding(.top)
        }
    }
}

#Preview {
    arifureSubViewTableAtEndScreen(arifure: Arifure())
}
