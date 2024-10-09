//
//  toloveruViewEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI

struct toloveruViewEndScreen: View {
    var body: some View {
//        NavigationView {
            List {
                Image("toloveruEndScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationTitle("ST終了画面")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("ST終了画面")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toloveruViewEndScreen()
}
