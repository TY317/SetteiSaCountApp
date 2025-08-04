//
//  reSwordViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordViewCz: View {
    @ObservedObject var reSword: ReSword
    var body: some View {
        List {
            // //// 色ごとの突破率
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "色ごとのAT当選率") {
                    VStack {
                        Text("・青、黄アイコンでのAT当選率に設定差あり")
                    }
                }
            } header: {
                Text("色ごとの当選率")
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
        .navigationTitle("CZ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    reSwordViewCz(
        reSword: ReSword(),
    )
}
