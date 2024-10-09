//
//  mt5ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/26.
//

import SwiftUI

struct mt5ViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                Text("レア役成立時にサブ液晶のセリフとランプで設定を示唆")
                Image("mt5EndingSisa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("mt5EndingAnalysis")
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
    mt5ViewEnding()
}
