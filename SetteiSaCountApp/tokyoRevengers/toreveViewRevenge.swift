//
//  toreveViewRevenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewRevenge: View {
    @ObservedObject var toreve: Toreve
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("・前兆やAT終了後などの引き戻し")
                    Text("・高設定ほど発生確率が高い")
                }
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "決戦前夜終了後",
                            "東卍チャンス終了後",
                            "東卍ラッシュ終了後",
                            "リベンジチャンス終了後",
                            "天上天下唯我独尊終了後",
                        ],
                        maxWidth: 200,
                    )
                    unitTableString(
                        columTitle: "復帰先",
                        stringList: [
                            "東卍ラッシュへ",
                            "東卍ラッシュ\nバーストへ",
                        ],
                        lineList: [3,2],
                    )
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("リベンジ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewRevenge(
        toreve: Toreve(),
    )
}
