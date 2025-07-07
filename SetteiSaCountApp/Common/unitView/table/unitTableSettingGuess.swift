//
//  unitTableSettingGuess.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/06.
//

import SwiftUI

struct unitTableSettingGuess: View {
    var settingList: [Double] = [1,2,3,4,5,6]
    var guessRatio: [Double]
    var body: some View {
        HStack(spacing: 0) {
            ForEach(self.settingList.indices, id: \.self) { index in
                let setting = Int(self.settingList[index])
                unitTablePercent(
                    columTitle: "設定\(setting)",
                    percentList: [self.guessRatio[index]],
                    titleFont: .subheadline,
                )
            }
        }
    }
}

#Preview {
    List {
        unitTableSettingGuess(
            guessRatio: [10,20,30,40,50,60]
        )
    }
}
