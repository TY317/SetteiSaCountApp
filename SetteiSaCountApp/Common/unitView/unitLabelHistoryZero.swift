//
//  unitLabelHistoryZero.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct unitLabelHistoryZero: View {
    var body: some View {
        HStack {
            Spacer()
            Text("履歴なし")
                .font(.title)
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    unitLabelHistoryZero()
}
