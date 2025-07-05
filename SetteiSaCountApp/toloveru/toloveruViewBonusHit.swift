//
//  toloveruViewBonusHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI

struct toloveruViewBonusHit: View {
//    @ObservedObject var toloveru = Toloveru()
    @ObservedObject var toloveru: Toloveru
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                unitLinkButton(
                    title: "初当たり確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当たり確率",
//                            image1: Image("toloveruBonusHit")
                            tableView: AnyView(toloveruTableFirstHit())
                        )
                    )
                )
                unitLinkButton(title: "規定ゲーム数での当選について", exview: AnyView(unitExView5body2image(title: "規定ゲーム数当選について", textBody1: "・高設定は250G、650Gの規定ゲーム数で当たりやすいとの噂あり", textBody2: "・150G、450Gでの規定ゲーム数当選は設定5以上の可能性期待大との噂あり")))
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるダークネス",
                screenClass: screenClass
            )
        }
            .navigationTitle("楽園計画 初当たり")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("楽園計画 初当たり")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toloveruViewBonusHit(toloveru: Toloveru())
}
