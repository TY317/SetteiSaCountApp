//
//  akudamaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var akudama = Akudama()
    @State var isShowAlert: Bool = false
    @StateObject var akudamaMemory1 = AkudamaMemory1()
    @StateObject var akudamaMemory2 = AkudamaMemory2()
    @StateObject var akudamaMemory3 = AkudamaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    // 注意事項
//                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: akudama.machineName,
//                    )
//                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: akudamaViewNormal(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.akudamaMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: akudamaViewFirstHit(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.akudamaMenuFirstHitBadge,
                        )
                    }
                    
                    // ST終了画面
                    NavigationLink(destination: akudamaViewScreen(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ST終了画面",
                            badgeStatus: common.akudamaMenuScreenBadge,
                        )
                    }

                    // ST終了画面
                    NavigationLink(destination: akudamaViewEnding(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.akudamaMenuEndingBadge,
                        )
                    }
//
//                    // おみくじ
//                    NavigationLink(destination: akudamaViewOmikuji(
//                        akudama: akudama,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.akudamaMenuOmikujiBadge,
//                        )
//                    }
//
                    // サミートロフィー
                    NavigationLink(destination: commonViewKujiluckyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "クジラッキートロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: akudama.machineName,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: akudamaView95Ci(
                    akudama: akudama,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: akudamaViewBayes(
                    akudama: akudama,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.akudamaMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4956")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©ぴえろ・TooKyoGames／アクダマドライブ製作委員会")
                    Text("©SANYO BUSSAN CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.akudamaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(akudamaSubViewLoadMemory(
                    akudama: akudama,
                    akudamaMemory1: akudamaMemory1,
                    akudamaMemory2: akudamaMemory2,
                    akudamaMemory3: akudamaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(akudamaSubViewSaveMemory(
                    akudama: akudama,
                    akudamaMemory1: akudamaMemory1,
                    akudamaMemory2: akudamaMemory2,
                    akudamaMemory3: akudamaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: akudama.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct akudamaSubViewSaveMemory: View {
    @ObservedObject var akudama: Akudama
    @ObservedObject var akudamaMemory1: AkudamaMemory1
    @ObservedObject var akudamaMemory2: AkudamaMemory2
    @ObservedObject var akudamaMemory3: AkudamaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: akudama.machineName,
            selectedMemory: $akudama.selectedMemory,
            memoMemory1: $akudamaMemory1.memo,
            dateDoubleMemory1: $akudamaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $akudamaMemory2.memo,
            dateDoubleMemory2: $akudamaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $akudamaMemory3.memo,
            dateDoubleMemory3: $akudamaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        akudamaMemory1.ptCountFull = akudama.ptCountFull
        akudamaMemory1.ptCountCzHit = akudama.ptCountCzHit
        akudamaMemory1.firstHitCz = akudama.firstHitCz
        akudamaMemory1.firstHitEpisode = akudama.firstHitEpisode
        akudamaMemory1.firstHitAkudama = akudama.firstHitAkudama
        akudamaMemory1.firstHitAt = akudama.firstHitAt
        akudamaMemory1.firstHitBonusSum = akudama.firstHitBonusSum
        akudamaMemory1.normalGame = akudama.normalGame
        akudamaMemory1.screenCount1 = akudama.screenCount1
        akudamaMemory1.screenCount2 = akudama.screenCount2
        akudamaMemory1.screenCount3 = akudama.screenCount3
        akudamaMemory1.screenCount4 = akudama.screenCount4
        akudamaMemory1.screenCount5 = akudama.screenCount5
        akudamaMemory1.screenCount6 = akudama.screenCount6
        akudamaMemory1.screenCount7 = akudama.screenCount7
        akudamaMemory1.screenCount8 = akudama.screenCount8
        akudamaMemory1.screenCount9 = akudama.screenCount9
        akudamaMemory1.screenCountSum = akudama.screenCountSum
    }
    func saveMemory2() {
        akudamaMemory2.ptCountFull = akudama.ptCountFull
        akudamaMemory2.ptCountCzHit = akudama.ptCountCzHit
        akudamaMemory2.firstHitCz = akudama.firstHitCz
        akudamaMemory2.firstHitEpisode = akudama.firstHitEpisode
        akudamaMemory2.firstHitAkudama = akudama.firstHitAkudama
        akudamaMemory2.firstHitAt = akudama.firstHitAt
        akudamaMemory2.firstHitBonusSum = akudama.firstHitBonusSum
        akudamaMemory2.normalGame = akudama.normalGame
        akudamaMemory2.screenCount1 = akudama.screenCount1
        akudamaMemory2.screenCount2 = akudama.screenCount2
        akudamaMemory2.screenCount3 = akudama.screenCount3
        akudamaMemory2.screenCount4 = akudama.screenCount4
        akudamaMemory2.screenCount5 = akudama.screenCount5
        akudamaMemory2.screenCount6 = akudama.screenCount6
        akudamaMemory2.screenCount7 = akudama.screenCount7
        akudamaMemory2.screenCount8 = akudama.screenCount8
        akudamaMemory2.screenCount9 = akudama.screenCount9
        akudamaMemory2.screenCountSum = akudama.screenCountSum
    }
    func saveMemory3() {
        akudamaMemory3.ptCountFull = akudama.ptCountFull
        akudamaMemory3.ptCountCzHit = akudama.ptCountCzHit
        akudamaMemory3.firstHitCz = akudama.firstHitCz
        akudamaMemory3.firstHitEpisode = akudama.firstHitEpisode
        akudamaMemory3.firstHitAkudama = akudama.firstHitAkudama
        akudamaMemory3.firstHitAt = akudama.firstHitAt
        akudamaMemory3.firstHitBonusSum = akudama.firstHitBonusSum
        akudamaMemory3.normalGame = akudama.normalGame
        akudamaMemory3.screenCount1 = akudama.screenCount1
        akudamaMemory3.screenCount2 = akudama.screenCount2
        akudamaMemory3.screenCount3 = akudama.screenCount3
        akudamaMemory3.screenCount4 = akudama.screenCount4
        akudamaMemory3.screenCount5 = akudama.screenCount5
        akudamaMemory3.screenCount6 = akudama.screenCount6
        akudamaMemory3.screenCount7 = akudama.screenCount7
        akudamaMemory3.screenCount8 = akudama.screenCount8
        akudamaMemory3.screenCount9 = akudama.screenCount9
        akudamaMemory3.screenCountSum = akudama.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct akudamaSubViewLoadMemory: View {
    @ObservedObject var akudama: Akudama
    @ObservedObject var akudamaMemory1: AkudamaMemory1
    @ObservedObject var akudamaMemory2: AkudamaMemory2
    @ObservedObject var akudamaMemory3: AkudamaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: akudama.machineName,
            selectedMemory: $akudama.selectedMemory,
            memoMemory1: akudamaMemory1.memo,
            dateDoubleMemory1: akudamaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: akudamaMemory2.memo,
            dateDoubleMemory2: akudamaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: akudamaMemory3.memo,
            dateDoubleMemory3: akudamaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        akudama.ptCountFull = akudamaMemory1.ptCountFull
        akudama.ptCountCzHit = akudamaMemory1.ptCountCzHit
        akudama.firstHitCz = akudamaMemory1.firstHitCz
        akudama.firstHitEpisode = akudamaMemory1.firstHitEpisode
        akudama.firstHitAkudama = akudamaMemory1.firstHitAkudama
        akudama.firstHitAt = akudamaMemory1.firstHitAt
        akudama.firstHitBonusSum = akudamaMemory1.firstHitBonusSum
        akudama.normalGame = akudamaMemory1.normalGame
        akudama.screenCount1 = akudamaMemory1.screenCount1
        akudama.screenCount2 = akudamaMemory1.screenCount2
        akudama.screenCount3 = akudamaMemory1.screenCount3
        akudama.screenCount4 = akudamaMemory1.screenCount4
        akudama.screenCount5 = akudamaMemory1.screenCount5
        akudama.screenCount6 = akudamaMemory1.screenCount6
        akudama.screenCount7 = akudamaMemory1.screenCount7
        akudama.screenCount8 = akudamaMemory1.screenCount8
        akudama.screenCount9 = akudamaMemory1.screenCount9
        akudama.screenCountSum = akudamaMemory1.screenCountSum
    }
    func loadMemory2() {
        akudama.ptCountFull = akudamaMemory2.ptCountFull
        akudama.ptCountCzHit = akudamaMemory2.ptCountCzHit
        akudama.firstHitCz = akudamaMemory2.firstHitCz
        akudama.firstHitEpisode = akudamaMemory2.firstHitEpisode
        akudama.firstHitAkudama = akudamaMemory2.firstHitAkudama
        akudama.firstHitAt = akudamaMemory2.firstHitAt
        akudama.firstHitBonusSum = akudamaMemory2.firstHitBonusSum
        akudama.normalGame = akudamaMemory2.normalGame
        akudama.screenCount1 = akudamaMemory2.screenCount1
        akudama.screenCount2 = akudamaMemory2.screenCount2
        akudama.screenCount3 = akudamaMemory2.screenCount3
        akudama.screenCount4 = akudamaMemory2.screenCount4
        akudama.screenCount5 = akudamaMemory2.screenCount5
        akudama.screenCount6 = akudamaMemory2.screenCount6
        akudama.screenCount7 = akudamaMemory2.screenCount7
        akudama.screenCount8 = akudamaMemory2.screenCount8
        akudama.screenCount9 = akudamaMemory2.screenCount9
        akudama.screenCountSum = akudamaMemory2.screenCountSum
    }
    func loadMemory3() {
        akudama.ptCountFull = akudamaMemory3.ptCountFull
        akudama.ptCountCzHit = akudamaMemory3.ptCountCzHit
        akudama.firstHitCz = akudamaMemory3.firstHitCz
        akudama.firstHitEpisode = akudamaMemory3.firstHitEpisode
        akudama.firstHitAkudama = akudamaMemory3.firstHitAkudama
        akudama.firstHitAt = akudamaMemory3.firstHitAt
        akudama.firstHitBonusSum = akudamaMemory3.firstHitBonusSum
        akudama.normalGame = akudamaMemory3.normalGame
        akudama.screenCount1 = akudamaMemory3.screenCount1
        akudama.screenCount2 = akudamaMemory3.screenCount2
        akudama.screenCount3 = akudamaMemory3.screenCount3
        akudama.screenCount4 = akudamaMemory3.screenCount4
        akudama.screenCount5 = akudamaMemory3.screenCount5
        akudama.screenCount6 = akudamaMemory3.screenCount6
        akudama.screenCount7 = akudamaMemory3.screenCount7
        akudama.screenCount8 = akudamaMemory3.screenCount8
        akudama.screenCount9 = akudamaMemory3.screenCount9
        akudama.screenCountSum = akudamaMemory3.screenCountSum
    }
}

#Preview {
    akudamaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
