//
//  magiaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewFirstHit: View {
    @ObservedObject var magia = Magia()
    
    var body: some View {
        List {
            // //// 参考情報）初当り確率
            unitLinkButton(
                title: "初当り確率",
                exview: AnyView(
                    unitExView5body2image(
                        title: "初当り確率",
                        tableView: AnyView(magiaTableFirstHit())
                    )
                )
            )
        }
        .navigationTitle("ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewFirstHit()
}
