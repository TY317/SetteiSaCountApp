//
//  reSwordViewFranChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordViewFranChara: View {
    @ObservedObject var reSword: ReSword
    var body: some View {
        List {
            Section {
                VStack {
                    Text("キャラ種類で設定を示唆")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("文字や背景の色に要注目")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                Text("詳細調査中")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title2)
                    .fontWeight(.bold)
            } header: {
                Text("キャラ紹介")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("フランボーナス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    reSwordViewFranChara(
        reSword: ReSword(),
    )
}
