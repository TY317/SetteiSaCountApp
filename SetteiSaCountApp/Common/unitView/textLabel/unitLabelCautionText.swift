//
//  unitLabelCautionText.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct unitLabelCautionText<destination: View>: View {
    var textColor: Color = .secondary
    var textFont: Font = .caption
    @ViewBuilder var destination: () -> destination
    var body: some View {
        // 注意書き
        HStack {
            Text("⚠️")
            VStack(alignment: .leading) {
                self.destination()
            }
            .foregroundStyle(self.textColor)
            .font(self.textFont)
        }
    }
}

#Preview {
    unitLabelCautionText() {
        Text("test")
    }
}
