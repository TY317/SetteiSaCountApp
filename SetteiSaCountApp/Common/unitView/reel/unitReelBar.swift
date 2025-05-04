//
//  unitReelBar.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelBar: View {
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.black)
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
    unitReelBar()
}
