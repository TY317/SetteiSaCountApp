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
            HStack(spacing: 0) {
                Spacer()
                unitTableString(
                    columTitle: "",
                    stringList: ["偶数","終日","ろく"],
                    maxWidth: 100
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: ["偶数示唆","設定4 以上濃厚", "設定6 濃厚"],
                    maxWidth: 180
                )
                Spacer()
            }
//            Image("shamanKingTamao")
//                .resizable()
//                .scaledToFit()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シャーマンキング",
                screenClass: screenClass
            )
        }
        .navigationTitle("たまおのコックリさん占い")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shamanKingViewKokkuri()
}
