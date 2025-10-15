//
//  newOni3ViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/12.
//

import SwiftUI

struct newOni3ViewBonus: View {
    @ObservedObject var newOni3: NewOni3
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            Section {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "ボイスキャラ",
                        stringList: [
                            "茜",
                            "蒼鬼",
                            "オールキャスト",
                        ],
                        maxWidth: 120,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "蒼剣ボーナスのデフォルト",
                            "真蒼剣ボーナスのデフォルト",
                            "高設定示唆",
                        ],
                        maxWidth: 250,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("ナビボイス")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("蒼剣ボーナス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    newOni3ViewBonus(
        newOni3: NewOni3(),
    )
    .environmentObject(commonVar())
}
