//
//  shamanKingViewKokkuri.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/26.
//

import SwiftUI

struct shamanKingViewKokkuri: View {
    var body: some View {
        List {
            Text("占いで示す文字の中に設定を示唆するものがある")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            Image("shamanKingTamao")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("たまおのコックリさん占い")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shamanKingViewKokkuri()
}
