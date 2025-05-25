//
//  rezero2ViewWatch.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/01.
//

import SwiftUI

struct rezero2ViewWatch: View {
    var body: some View {
        List {
            Text("・設定変更後など特定のタイミングで移行する菜月家ステージでの時計演出で設定を示唆する場合あり")
            Text("・アナログ時計とセリフで表示されるためわかりやすいが、見逃さないよう注意。")
            Image("rezero2Watch")
                .resizable()
                .scaledToFit()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "Re:ゼロ season2",
                screenClass: screenClass
            )
        }
        .navigationTitle("菜月家ステージでの時計演出")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    rezero2ViewWatch()
}
