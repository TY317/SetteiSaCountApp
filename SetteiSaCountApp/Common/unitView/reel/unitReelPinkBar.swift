//
//  unitReelPinkBar.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct unitReelPinkBar: View {
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.pinkBar)
                        .cornerRadius(8)
                        .padding(5)
                    Text("BAR")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
    }
}

#Preview {
    unitReelPinkBar()
}
