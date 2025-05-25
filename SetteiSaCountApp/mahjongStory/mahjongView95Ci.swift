//
//  mahjongView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/16.
//

import SwiftUI

struct mahjongView95Ci: View {
    var body: some View {
        List {
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "麻雀物語",
                screenClass: screenClass
            )
        }
    }
}

#Preview {
    mahjongView95Ci()
}
