//
//  hokutoViewMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/07.
//

import SwiftUI

struct hokutoViewMode: View {
    var body: some View {
        NavigationView {
            List {
                Image("hokutoMode")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .navigationTitle("モード示唆演出")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    hokutoViewMode()
}
