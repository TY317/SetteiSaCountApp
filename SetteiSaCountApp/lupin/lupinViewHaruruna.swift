//
//  lupinViewHaruruna.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/12.
//

import SwiftUI

struct lupinViewHaruruna: View {
    var body: some View {
        List {
            Text("ハルルナPUSH演出が発生すれば、どのタイミングであっても成功濃厚、かつ設定4 以上濃厚")
                .foregroundStyle(Color.secondary)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ルパン3世 大航海者の秘宝",
                screenClass: screenClass
            )
        }
        .navigationTitle("ハルルナPUSH")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    lupinViewHaruruna()
}
