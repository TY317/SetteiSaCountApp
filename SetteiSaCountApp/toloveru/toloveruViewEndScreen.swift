//
//  toloveruViewEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI

struct toloveruViewEndScreen: View {
    var body: some View {
//        NavigationView {
            List {
                // 設定示唆となる画面
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 高設定示唆
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87Screen1"),
                            upperBeltText: "美柑",
                            lowerBeltText: "高設定示唆"
                        )
//                        // 設定5示唆
//                        unitScreenOnlyDisplay(
//                            image: Image("toloveru87Screen2"),
//                            upperBeltText: "メア",
//                            lowerBeltText: "設定5 示唆"
//                        )
                        // 設定3 以上
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87Screen3"),
                            upperBeltText: "吉スタンプ",
                            lowerBeltText: "設定3 以上濃厚"
                        )
                        // 設定4 以上
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87Screen4"),
                            upperBeltText: "良スタンプ",
                            lowerBeltText: "設定4 以上濃厚"
                        )
                        // 設定5 以上
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87Screen5"),
                            upperBeltText: "優スタンプ",
                            lowerBeltText: "設定5 以上濃厚"
                        )
                        // 設定6 以上
                        unitScreenOnlyDisplay(
                            image: Image("toloveru87Screen6"),
                            upperBeltText: "極スタンプ",
                            lowerBeltText: "設定6 濃厚"
                        )
                    }
                }
                .frame(height: 120)
//                Image("toloveruEndScreen")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるダークネス",
                screenClass: screenClass
            )
        }
            .navigationTitle("ST終了画面")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("ST終了画面")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toloveruViewEndScreen()
}
