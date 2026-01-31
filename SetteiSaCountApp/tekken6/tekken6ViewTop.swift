//
//  tekken6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import SwiftUI

struct tekken6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var tekken6 = Tekken6()
    @State var isShowAlert: Bool = false
    @StateObject var tekken6Memory1 = Tekken6Memory1()
    @StateObject var tekken6Memory2 = Tekken6Memory2()
    @StateObject var tekken6Memory3 = Tekken6Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: tekken6.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: tekken6ViewNormal(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.tekken6MenuNormalBadge,
                        )
                    }
                    
                    // 通常時
                    NavigationLink(destination: tekken6ViewFirstHit(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.tekken6MenuFirstHitBadge,
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: tekken6ViewScreen(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT中",
                            badgeStatus: common.tekken6MenuScreenBadge,
                        )
                    }
                    
                    // 引き戻し
                    NavigationLink(destination: tekken6ViewBack(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "引き戻し",
                            badgeStatus: common.tekken6MenuBackBadge,
                        )
                    }
                    
                    // ケロットトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: tekken6View95Ci(
                    tekken6: tekken6,
                    selection: 5,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: tekken6ViewBayes(
                    tekken6: tekken6,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.tekken6MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4913")
                
                // コピーライト
                unitSectionCopyright {
                    Text("TEKKEN™Series & ©Bandai Namco Entertainment Inc.")
                    Text("©Bandai Namco Sevens Inc.")
                    Text("©YAMASA")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(tekken6SubViewLoadMemory(
                    tekken6: tekken6,
                    tekken6Memory1: tekken6Memory1,
                    tekken6Memory2: tekken6Memory2,
                    tekken6Memory3: tekken6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(tekken6SubViewSaveMemory(
                    tekken6: tekken6,
                    tekken6Memory1: tekken6Memory1,
                    tekken6Memory2: tekken6Memory2,
                    tekken6Memory3: tekken6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: tekken6.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct tekken6SubViewSaveMemory: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var tekken6Memory1: Tekken6Memory1
    @ObservedObject var tekken6Memory2: Tekken6Memory2
    @ObservedObject var tekken6Memory3: Tekken6Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: tekken6.machineName,
            selectedMemory: $tekken6.selectedMemory,
            memoMemory1: $tekken6Memory1.memo,
            dateDoubleMemory1: $tekken6Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $tekken6Memory2.memo,
            dateDoubleMemory2: $tekken6Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $tekken6Memory3.memo,
            dateDoubleMemory3: $tekken6Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        tekken6Memory1.normalGame = tekken6.normalGame
        tekken6Memory1.firstHitCountCz = tekken6.firstHitCountCz
        tekken6Memory1.firstHitCountBonusBlue = tekken6.firstHitCountBonusBlue
        tekken6Memory1.firstHitCountBonusRed = tekken6.firstHitCountBonusRed
        tekken6Memory1.firstHitCountBonusSum = tekken6.firstHitCountBonusSum
        tekken6Memory1.firstHitCountAt = tekken6.firstHitCountAt
        tekken6Memory1.backCountHit = tekken6.backCountHit
        tekken6Memory1.backCountMiss = tekken6.backCountMiss
        tekken6Memory1.backCountSum = tekken6.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6Memory1.rareDirectCountJakuCherry = tekken6.rareDirectCountJakuCherry
        tekken6Memory1.rareDirectCountSuika = tekken6.rareDirectCountSuika
        tekken6Memory1.rareDirectCountChance = tekken6.rareDirectCountChance
        tekken6Memory1.rareDirectCountJakuSum = tekken6.rareDirectCountJakuSum
        tekken6Memory1.rareDirectCountJakuHit = tekken6.rareDirectCountJakuHit
        tekken6Memory1.rareDirectCountKyoCherry = tekken6.rareDirectCountKyoCherry
        tekken6Memory1.rareDirectCountKyoHit = tekken6.rareDirectCountKyoHit
    }
    func saveMemory2() {
        tekken6Memory2.normalGame = tekken6.normalGame
        tekken6Memory2.firstHitCountCz = tekken6.firstHitCountCz
        tekken6Memory2.firstHitCountBonusBlue = tekken6.firstHitCountBonusBlue
        tekken6Memory2.firstHitCountBonusRed = tekken6.firstHitCountBonusRed
        tekken6Memory2.firstHitCountBonusSum = tekken6.firstHitCountBonusSum
        tekken6Memory2.firstHitCountAt = tekken6.firstHitCountAt
        tekken6Memory2.backCountHit = tekken6.backCountHit
        tekken6Memory2.backCountMiss = tekken6.backCountMiss
        tekken6Memory2.backCountSum = tekken6.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6Memory2.rareDirectCountJakuCherry = tekken6.rareDirectCountJakuCherry
        tekken6Memory2.rareDirectCountSuika = tekken6.rareDirectCountSuika
        tekken6Memory2.rareDirectCountChance = tekken6.rareDirectCountChance
        tekken6Memory2.rareDirectCountJakuSum = tekken6.rareDirectCountJakuSum
        tekken6Memory2.rareDirectCountJakuHit = tekken6.rareDirectCountJakuHit
        tekken6Memory2.rareDirectCountKyoCherry = tekken6.rareDirectCountKyoCherry
        tekken6Memory2.rareDirectCountKyoHit = tekken6.rareDirectCountKyoHit
    }
    func saveMemory3() {
        tekken6Memory3.normalGame = tekken6.normalGame
        tekken6Memory3.firstHitCountCz = tekken6.firstHitCountCz
        tekken6Memory3.firstHitCountBonusBlue = tekken6.firstHitCountBonusBlue
        tekken6Memory3.firstHitCountBonusRed = tekken6.firstHitCountBonusRed
        tekken6Memory3.firstHitCountBonusSum = tekken6.firstHitCountBonusSum
        tekken6Memory3.firstHitCountAt = tekken6.firstHitCountAt
        tekken6Memory3.backCountHit = tekken6.backCountHit
        tekken6Memory3.backCountMiss = tekken6.backCountMiss
        tekken6Memory3.backCountSum = tekken6.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6Memory3.rareDirectCountJakuCherry = tekken6.rareDirectCountJakuCherry
        tekken6Memory3.rareDirectCountSuika = tekken6.rareDirectCountSuika
        tekken6Memory3.rareDirectCountChance = tekken6.rareDirectCountChance
        tekken6Memory3.rareDirectCountJakuSum = tekken6.rareDirectCountJakuSum
        tekken6Memory3.rareDirectCountJakuHit = tekken6.rareDirectCountJakuHit
        tekken6Memory3.rareDirectCountKyoCherry = tekken6.rareDirectCountKyoCherry
        tekken6Memory3.rareDirectCountKyoHit = tekken6.rareDirectCountKyoHit
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct tekken6SubViewLoadMemory: View {
    @ObservedObject var tekken6: Tekken6
    @ObservedObject var tekken6Memory1: Tekken6Memory1
    @ObservedObject var tekken6Memory2: Tekken6Memory2
    @ObservedObject var tekken6Memory3: Tekken6Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: tekken6.machineName,
            selectedMemory: $tekken6.selectedMemory,
            memoMemory1: tekken6Memory1.memo,
            dateDoubleMemory1: tekken6Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: tekken6Memory2.memo,
            dateDoubleMemory2: tekken6Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: tekken6Memory3.memo,
            dateDoubleMemory3: tekken6Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        tekken6.normalGame = tekken6Memory1.normalGame
        tekken6.firstHitCountCz = tekken6Memory1.firstHitCountCz
        tekken6.firstHitCountBonusBlue = tekken6Memory1.firstHitCountBonusBlue
        tekken6.firstHitCountBonusRed = tekken6Memory1.firstHitCountBonusRed
        tekken6.firstHitCountBonusSum = tekken6Memory1.firstHitCountBonusSum
        tekken6.firstHitCountAt = tekken6Memory1.firstHitCountAt
        tekken6.backCountHit = tekken6Memory1.backCountHit
        tekken6.backCountMiss = tekken6Memory1.backCountMiss
        tekken6.backCountSum = tekken6Memory1.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6.rareDirectCountJakuCherry = tekken6Memory1.rareDirectCountJakuCherry
        tekken6.rareDirectCountSuika = tekken6Memory1.rareDirectCountSuika
        tekken6.rareDirectCountChance = tekken6Memory1.rareDirectCountChance
        tekken6.rareDirectCountJakuSum = tekken6Memory1.rareDirectCountJakuSum
        tekken6.rareDirectCountJakuHit = tekken6Memory1.rareDirectCountJakuHit
        tekken6.rareDirectCountKyoCherry = tekken6Memory1.rareDirectCountKyoCherry
        tekken6.rareDirectCountKyoHit = tekken6Memory1.rareDirectCountKyoHit
    }
    func loadMemory2() {
        tekken6.normalGame = tekken6Memory2.normalGame
        tekken6.firstHitCountCz = tekken6Memory2.firstHitCountCz
        tekken6.firstHitCountBonusBlue = tekken6Memory2.firstHitCountBonusBlue
        tekken6.firstHitCountBonusRed = tekken6Memory2.firstHitCountBonusRed
        tekken6.firstHitCountBonusSum = tekken6Memory2.firstHitCountBonusSum
        tekken6.firstHitCountAt = tekken6Memory2.firstHitCountAt
        tekken6.backCountHit = tekken6Memory2.backCountHit
        tekken6.backCountMiss = tekken6Memory2.backCountMiss
        tekken6.backCountSum = tekken6Memory2.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6.rareDirectCountJakuCherry = tekken6Memory2.rareDirectCountJakuCherry
        tekken6.rareDirectCountSuika = tekken6Memory2.rareDirectCountSuika
        tekken6.rareDirectCountChance = tekken6Memory2.rareDirectCountChance
        tekken6.rareDirectCountJakuSum = tekken6Memory2.rareDirectCountJakuSum
        tekken6.rareDirectCountJakuHit = tekken6Memory2.rareDirectCountJakuHit
        tekken6.rareDirectCountKyoCherry = tekken6Memory2.rareDirectCountKyoCherry
        tekken6.rareDirectCountKyoHit = tekken6Memory2.rareDirectCountKyoHit
    }
    func loadMemory3() {
        tekken6.normalGame = tekken6Memory3.normalGame
        tekken6.firstHitCountCz = tekken6Memory3.firstHitCountCz
        tekken6.firstHitCountBonusBlue = tekken6Memory3.firstHitCountBonusBlue
        tekken6.firstHitCountBonusRed = tekken6Memory3.firstHitCountBonusRed
        tekken6.firstHitCountBonusSum = tekken6Memory3.firstHitCountBonusSum
        tekken6.firstHitCountAt = tekken6Memory3.firstHitCountAt
        tekken6.backCountHit = tekken6Memory3.backCountHit
        tekken6.backCountMiss = tekken6Memory3.backCountMiss
        tekken6.backCountSum = tekken6Memory3.backCountSum
        
        // -------
        // ver3.18.0で追加
        // -------
        tekken6.rareDirectCountJakuCherry = tekken6Memory3.rareDirectCountJakuCherry
        tekken6.rareDirectCountSuika = tekken6Memory3.rareDirectCountSuika
        tekken6.rareDirectCountChance = tekken6Memory3.rareDirectCountChance
        tekken6.rareDirectCountJakuSum = tekken6Memory3.rareDirectCountJakuSum
        tekken6.rareDirectCountJakuHit = tekken6Memory3.rareDirectCountJakuHit
        tekken6.rareDirectCountKyoCherry = tekken6Memory3.rareDirectCountKyoCherry
        tekken6.rareDirectCountKyoHit = tekken6Memory3.rareDirectCountKyoHit
    }
}

#Preview {
    tekken6ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
