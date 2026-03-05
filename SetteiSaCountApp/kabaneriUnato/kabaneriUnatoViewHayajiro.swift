//
//  kabaneriUnatoViewHayajiro.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/05.
//

import SwiftUI

struct kabaneriUnatoViewHayajiro: View {
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
    
    var body: some View {
        List {
            // ---- 3000pt獲得率
            Section {
                // カウントボタン横並び
                HStack {
                    // 3000pt以外
                    unitCountButtonPercentWithFunc(
                        title: "3000pt以外",
                        count: $kabaneriUnato.hayajiroCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $kabaneriUnato.hayajiroCountSum,
                        numberofDicimal: 0,
                        minusBool: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.hayajiroSumFunc()
                        }
                    // 3000pt
                    unitCountButtonPercentWithFunc(
                        title: "3000pt",
                        count: $kabaneriUnato.hayajiroCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $kabaneriUnato.hayajiroCountSum,
                        numberofDicimal: 0,
                        minusBool: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.hayajiroSumFunc()
                        }
                }
                
                // 参考情報）3000pt振分け
                unitLinkButtonViewBuilder(sheetTitle: "単チャンス目 3000pt振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "単チャンス目 3000pt",
                            percentList: kabaneriUnato.ratioHayajiro3000,
                            numberofDicimal: 1,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kabaneriUnatoView95Ci(
                            kabaneriUnato: kabaneriUnato,
                            selection: 2
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kabaneriUnatoViewBayes(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("単チャンス目 3000pt")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuHayajiroBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("駿城ボーナス")
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetHayajiro)
            }
        }
    }
}

#Preview {
    kabaneriUnatoViewHayajiro(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
