//
//  unitButtonSubmitLabel.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct unitButtonSubmitLabel: View {
    var minusCheck: Bool
    var body: some View {
        HStack {
            Spacer()
            if self.minusCheck == false {
                Text("登録")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
            } else {
                Text("1行削除")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.red)
            }
            Spacer()
        }
    }
}

#Preview {
    unitButtonSubmitLabel(
        minusCheck: false
    )
}
