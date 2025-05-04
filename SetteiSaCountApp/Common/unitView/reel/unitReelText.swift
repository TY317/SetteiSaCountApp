//
//  unitReelText.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelText: View {
    var textBody: String
    var textFont: Font = .title
    var textColor: Color = .black
    var xmarkBool: Bool = false
    var xmarkColor: Color = .red
    
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    Text(self.textBody)
                        .font(self.textFont)
                        .fontWeight(.bold)
                        .foregroundColor(self.textColor)
                    if self.xmarkBool {
                        Image(systemName: "xmark")
                            .resizable()
                            .padding(5)
                            .foregroundStyle(self.xmarkColor)
//                            .fontWeight(.bold)
                    }
                }
            }
    }
}

#Preview {
    unitReelText(
        textBody: "🍒",
        xmarkBool: false
    )
}
