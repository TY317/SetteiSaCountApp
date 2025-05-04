//
//  unitReelColumn.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelColumn<Upper: View, Middle: View, Lower: View>: View {
    var upper: Upper
    var middle: Middle
    var lower: Lower
    
    var body: some View {
        VStack(spacing: 0) {
            self.upper
            self.middle
            self.lower
        }
    }
}

#Preview {
    unitReelColumn(
        upper: unitReelReplay(),
        middle: unitReelBar(),
        lower: unitReelText(textBody: "🍒")
    )
}
