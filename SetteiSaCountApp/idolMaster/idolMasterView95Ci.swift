//
//  idolMasterView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterView95Ci: View {
    var body: some View {
        List {
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイドルマスター ミリオンライブ！",
                screenClass: screenClass
            )
        }
    }
}

#Preview {
    idolMasterView95Ci()
}
