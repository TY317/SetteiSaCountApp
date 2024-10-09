//
//  goevaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/29.
//

import SwiftUI

struct goevaViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                Text("レア役時のボイスで設定を示唆")
                Image("goevaEnding")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationTitle("エンディング中の示唆")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("エンディング中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    goevaViewEnding()
}
