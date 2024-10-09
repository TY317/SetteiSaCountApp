//
//  symphoViewGearv.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/19.
//

import SwiftUI

struct symphoViewGearv: View {
    var body: some View {
//        NavigationView {
            List {
                Text("クリスのギアVアタックで赤PUSH連打中の枚数表示で設定示唆パターンあり")
                Image("symphoGearV")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationTitle("ギアVアタック中の示唆")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("ギアVアタック中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    symphoViewGearv()
}
