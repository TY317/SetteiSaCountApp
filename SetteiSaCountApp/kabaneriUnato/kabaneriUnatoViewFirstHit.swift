//
//  kabaneriUnatoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/01.
//

import SwiftUI

struct kabaneriUnatoViewFirstHit: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // ---- 初当り
            Section {
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: kabaneriUnato.ratioFirstHitCz
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス",
                            denominateList: kabaneriUnato.ratioFirstHitBonus
                        )
                        unitTableDenominate(
                            columTitle: "ST",
                            denominateList: kabaneriUnato.ratioFirstHitSt
                        )
                    }
                }
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                // //// マイナスチェック
//                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
//            }
//            ToolbarItem(placement: .automatic) {
//                // /// リセット
//                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetFirstHit)
//            }
//            
//            ToolbarItem(placement: .keyboard) {
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        isFocused = false
//                    }, label: {
//                        Text("完了")
//                            .fontWeight(.bold)
//                    })
//                }
//            }
//        }
    }
}

#Preview {
    kabaneriUnatoViewFirstHit(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
