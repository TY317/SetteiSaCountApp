//
//  symphoViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/19.
//

import SwiftUI

struct symphoViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                Text("エンディング中　レア役成立時のリール上部のランプ色で設定を示唆")
                Image("symphoEnding1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("symphoEnding2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("symphoEnding3")
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
    symphoViewEnding()
}
