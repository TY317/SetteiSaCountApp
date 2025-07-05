//
//  kaijiViewTonegawaRush.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/02.
//

import SwiftUI

struct kaijiViewTonegawaRush: View {
//    @ObservedObject var ver300: Ver300
    @ObservedObject var kaiji: Kaiji
//    @State var isShowAlert: Bool = false
//    let imageNameList: [String] = [
//        
//    ]
//    @State var selectedImageName: String = ""
    
    var body: some View {
        List {
            Section {
                Text("ST再セット時の画面で高設定を示唆するものがある")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // パターン1
//                        VStack(spacing: 0) {
//                            ZStack {
//                                Rectangle()
//                                    .frame(height: 20)
//                                    .foregroundStyle(Color.white)
//                                Text("パターン1")
//                                    .font(.body)
//                                    .fontWeight(.bold)
//                            }
//                            Image("kaijiTonegawaRushDefault1")
//                                .resizable()
//                                .scaledToFit()
//                            ZStack {
//                                Rectangle()
//                                    .frame(height: 20)
//                                    .foregroundStyle(Color.white)
//                                Text("デフォルト")
//                                    .font(.body)
//                                    .fontWeight(.bold)
//                            }
//                        }
                        unitScreenOnlyDisplay(
                            image: Image("kaijiTonegawaRushDefault1"),
                            upperBeltText: "パターン1",
                            lowerBeltText: "デフォルト"
                        )
                        // パターン2
                        unitScreenOnlyDisplay(
                            image: Image("kaijiTonegawaRushDefault2"),
                            upperBeltText: "パターン2",
                            lowerBeltText: "デフォルト"
                        )
                        // パターン3
                        unitScreenOnlyDisplay(
                            image: Image("kaijiTonegawaRushHigh"),
                            upperBeltText: "パターン3",
                            lowerBeltText: "高設定示唆"
                        )
                    }
                }
                .frame(height: 120)
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "回胴黙示録カイジ 狂宴",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver300.kaijiMenuTonegawaRushBadgeStatus != "none" {
//                ver300.kaijiMenuTonegawaRushBadgeStatus = "none"
//            }
//        }
        .navigationTitle("トネガワラッシュ中の画面示唆")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kaijiViewTonegawaRush(
//        ver300: Ver300(),
        kaiji: Kaiji()
    )
}
