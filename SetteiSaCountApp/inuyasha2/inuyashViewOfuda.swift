//
//  inuyashViewOfuda.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/19.
//

import SwiftUI

struct inuyashViewOfuda: View {
    var body: some View {
        List {
            Text("紫文字のお札の内容で設定を示唆する場合がある")
                .foregroundStyle(Color.secondary)
//            Image("inuyashaOfuda")
//                .resizable()
//                .scaledToFit()
            HStack {
                Spacer()
                inuyashaTableOfuda()
                Spacer()
            }
        }
        .navigationTitle("お札演出での示唆")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    inuyashViewOfuda()
}
