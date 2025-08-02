//
//  unitReelWhiteBar.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct unitReelWhiteBar: View {
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 3)
                                .padding(5)
//                    Rectangle()
//                        .foregroundStyle(Color.black)
//                        .cornerRadius(8)
//                        .padding(5)
                    Text("BAR")
                        .foregroundStyle(Color.secondary)
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
    }
}

#Preview {
    unitReelWhiteBar()
}
