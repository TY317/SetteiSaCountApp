//
//  goevaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/29.
//

import SwiftUI

struct goevaViewEnding: View {
    var body: some View {
//        NavigationView {
            List {
                Text("レア役時のボイスで設定を示唆")
                goevaTableEndingVoice()
                    .frame(maxWidth: .infinity, alignment: .center)
//                Image("goevaEnding")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラvsエヴァンゲリオン",
                screenClass: screenClass
            )
        }
            .navigationTitle("エンディング中の示唆")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("エンディング中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    goevaViewEnding()
}
