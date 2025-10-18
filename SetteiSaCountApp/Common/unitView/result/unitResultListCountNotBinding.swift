//
//  unitResultListCountNotBinding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct unitResultListCountNotBinding: View {
    var title: String
    var count: Int
    var unit: String = "回"
    var body: some View {
        HStack {
            Text(self.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(self.count)")
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.secondary)
            Text(self.unit)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    unitResultListCountNotBinding(
        title: "総ゲーム数",
        count: 2,
        unit: "G",
    )
}
