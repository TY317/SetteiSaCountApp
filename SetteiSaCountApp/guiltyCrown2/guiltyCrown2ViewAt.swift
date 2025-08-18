//
//  guiltyCrown2ViewAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct guiltyCrown2ViewAt: View {
//    @ObservedObject var ver360: Ver360
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    
    var body: some View {
        List {
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "四度目の黙示録ストック") {
                    VStack {
                        Text("・AT中はセット開始時に四度目の黙示録ストック抽選が内部的に行われる")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・当選時はAT終了後にストックを消費して四度目の黙示録へ突入する")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・ストックは1個まで")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "ストック当選",
                                percentList: [0.8,0.9,1.1,1.3,1.5,1.6],
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
            } header: {
                Text("四度目の黙示録ストック抽選")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver360.guiltyCrown2MenuAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    guiltyCrown2ViewAt(
//        ver360: Ver360(),
        guiltyCrown2: GuiltyCrown2(),
    )
}
