//
//  hihodenViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import SwiftUI

struct hihodenViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hihoden = Hihoden()
    @State var isShowAlert: Bool = false
    @StateObject var hihodenMemory1 = HihodenMemory1()
    @StateObject var hihodenMemory2 = HihodenMemory2()
    @StateObject var hihodenMemory3 = HihodenMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hihoden.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hihodenViewNormal(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.hihodenMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: hihodenviewFirstHit(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.hihodenMenuFirstHitBadge,
                        )
                    }
                    
                    // ボーナス中
                    NavigationLink(destination: hihodenViewDuringBonus(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pyramid.fill",
                            textBody: "ボーナス中",
                            badgeStatus: common.hihodenMenuDuringBonusBadge,
                        )
                    }
                    
                    // 伝説モード
                    NavigationLink(destination: hihodenViewLegend(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "伝説モード",
                            badgeStatus: common.hihodenMenuLegendBadge,
                        )
                    }
                    
                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(imageSystemName: "trophy.fill", textBody: "コパンダトロフィー")
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hihodenView95Ci(
                    hihoden: hihoden,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hihodenViewBayes(
                    hihoden: hihoden,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hihodenMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4929")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(hihodenSubViewLoadMemory(
                    hihoden: hihoden,
                    hihodenMemory1: hihodenMemory1,
                    hihodenMemory2: hihodenMemory2,
                    hihodenMemory3: hihodenMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(hihodenSubViewSaveMemory(
                    hihoden: hihoden,
                    hihodenMemory1: hihodenMemory1,
                    hihodenMemory2: hihodenMemory2,
                    hihodenMemory3: hihodenMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hihoden.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct hihodenSubViewSaveMemory: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var hihodenMemory1: HihodenMemory1
    @ObservedObject var hihodenMemory2: HihodenMemory2
    @ObservedObject var hihodenMemory3: HihodenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: hihoden.machineName,
            selectedMemory: $hihoden.selectedMemory,
            memoMemory1: $hihodenMemory1.memo,
            dateDoubleMemory1: $hihodenMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hihodenMemory2.memo,
            dateDoubleMemory2: $hihodenMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hihodenMemory3.memo,
            dateDoubleMemory3: $hihodenMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hihodenMemory1.totalGame = hihoden.totalGame
        hihodenMemory1.koyakuCountCherry = hihoden.koyakuCountCherry
        hihodenMemory1.koyakuCountChance = hihoden.koyakuCountChance
        hihodenMemory1.chanceKokakuCount = hihoden.chanceKokakuCount
        hihodenMemory1.normalGame = hihoden.normalGame
        hihodenMemory1.firstHitCount = hihoden.firstHitCount
        hihodenMemory1.bonusGame = hihoden.bonusGame
        hihodenMemory1.bonusHazureCount = hihoden.bonusHazureCount
        hihodenMemory1.legendCountBigNone = hihoden.legendCountBigNone
        hihodenMemory1.legendCountBigHit = hihoden.legendCountBigHit
        hihodenMemory1.legendCountBigSum = hihoden.legendCountBigSum
        hihodenMemory1.legendCountRegNone = hihoden.legendCountRegNone
        hihodenMemory1.legendCountRegHit = hihoden.legendCountRegHit
        hihodenMemory1.legendCountRegSum = hihoden.legendCountRegSum
    }
    func saveMemory2() {
        hihodenMemory2.totalGame = hihoden.totalGame
        hihodenMemory2.koyakuCountCherry = hihoden.koyakuCountCherry
        hihodenMemory2.koyakuCountChance = hihoden.koyakuCountChance
        hihodenMemory2.chanceKokakuCount = hihoden.chanceKokakuCount
        hihodenMemory2.normalGame = hihoden.normalGame
        hihodenMemory2.firstHitCount = hihoden.firstHitCount
        hihodenMemory2.bonusGame = hihoden.bonusGame
        hihodenMemory2.bonusHazureCount = hihoden.bonusHazureCount
        hihodenMemory2.legendCountBigNone = hihoden.legendCountBigNone
        hihodenMemory2.legendCountBigHit = hihoden.legendCountBigHit
        hihodenMemory2.legendCountBigSum = hihoden.legendCountBigSum
        hihodenMemory2.legendCountRegNone = hihoden.legendCountRegNone
        hihodenMemory2.legendCountRegHit = hihoden.legendCountRegHit
        hihodenMemory2.legendCountRegSum = hihoden.legendCountRegSum
    }
    func saveMemory3() {
        hihodenMemory3.totalGame = hihoden.totalGame
        hihodenMemory3.koyakuCountCherry = hihoden.koyakuCountCherry
        hihodenMemory3.koyakuCountChance = hihoden.koyakuCountChance
        hihodenMemory3.chanceKokakuCount = hihoden.chanceKokakuCount
        hihodenMemory3.normalGame = hihoden.normalGame
        hihodenMemory3.firstHitCount = hihoden.firstHitCount
        hihodenMemory3.bonusGame = hihoden.bonusGame
        hihodenMemory3.bonusHazureCount = hihoden.bonusHazureCount
        hihodenMemory3.legendCountBigNone = hihoden.legendCountBigNone
        hihodenMemory3.legendCountBigHit = hihoden.legendCountBigHit
        hihodenMemory3.legendCountBigSum = hihoden.legendCountBigSum
        hihodenMemory3.legendCountRegNone = hihoden.legendCountRegNone
        hihodenMemory3.legendCountRegHit = hihoden.legendCountRegHit
        hihodenMemory3.legendCountRegSum = hihoden.legendCountRegSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct hihodenSubViewLoadMemory: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var hihodenMemory1: HihodenMemory1
    @ObservedObject var hihodenMemory2: HihodenMemory2
    @ObservedObject var hihodenMemory3: HihodenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: hihoden.machineName,
            selectedMemory: $hihoden.selectedMemory,
            memoMemory1: hihodenMemory1.memo,
            dateDoubleMemory1: hihodenMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hihodenMemory2.memo,
            dateDoubleMemory2: hihodenMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hihodenMemory3.memo,
            dateDoubleMemory3: hihodenMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        hihoden.totalGame = hihodenMemory1.totalGame
        hihoden.koyakuCountCherry = hihodenMemory1.koyakuCountCherry
        hihoden.koyakuCountChance = hihodenMemory1.koyakuCountChance
        hihoden.chanceKokakuCount = hihodenMemory1.chanceKokakuCount
        hihoden.normalGame = hihodenMemory1.normalGame
        hihoden.firstHitCount = hihodenMemory1.firstHitCount
        hihoden.bonusGame = hihodenMemory1.bonusGame
        hihoden.bonusHazureCount = hihodenMemory1.bonusHazureCount
        hihoden.legendCountBigNone = hihodenMemory1.legendCountBigNone
        hihoden.legendCountBigHit = hihodenMemory1.legendCountBigHit
        hihoden.legendCountBigSum = hihodenMemory1.legendCountBigSum
        hihoden.legendCountRegNone = hihodenMemory1.legendCountRegNone
        hihoden.legendCountRegHit = hihodenMemory1.legendCountRegHit
        hihoden.legendCountRegSum = hihodenMemory1.legendCountRegSum
    }
    func loadMemory2() {
        hihoden.totalGame = hihodenMemory2.totalGame
        hihoden.koyakuCountCherry = hihodenMemory2.koyakuCountCherry
        hihoden.koyakuCountChance = hihodenMemory2.koyakuCountChance
        hihoden.chanceKokakuCount = hihodenMemory2.chanceKokakuCount
        hihoden.normalGame = hihodenMemory2.normalGame
        hihoden.firstHitCount = hihodenMemory2.firstHitCount
        hihoden.bonusGame = hihodenMemory2.bonusGame
        hihoden.bonusHazureCount = hihodenMemory2.bonusHazureCount
        hihoden.legendCountBigNone = hihodenMemory2.legendCountBigNone
        hihoden.legendCountBigHit = hihodenMemory2.legendCountBigHit
        hihoden.legendCountBigSum = hihodenMemory2.legendCountBigSum
        hihoden.legendCountRegNone = hihodenMemory2.legendCountRegNone
        hihoden.legendCountRegHit = hihodenMemory2.legendCountRegHit
        hihoden.legendCountRegSum = hihodenMemory2.legendCountRegSum
    }
    func loadMemory3() {
        hihoden.totalGame = hihodenMemory3.totalGame
        hihoden.koyakuCountCherry = hihodenMemory3.koyakuCountCherry
        hihoden.koyakuCountChance = hihodenMemory3.koyakuCountChance
        hihoden.chanceKokakuCount = hihodenMemory3.chanceKokakuCount
        hihoden.normalGame = hihodenMemory3.normalGame
        hihoden.firstHitCount = hihodenMemory3.firstHitCount
        hihoden.bonusGame = hihodenMemory3.bonusGame
        hihoden.bonusHazureCount = hihodenMemory3.bonusHazureCount
        hihoden.legendCountBigNone = hihodenMemory3.legendCountBigNone
        hihoden.legendCountBigHit = hihodenMemory3.legendCountBigHit
        hihoden.legendCountBigSum = hihodenMemory3.legendCountBigSum
        hihoden.legendCountRegNone = hihodenMemory3.legendCountRegNone
        hihoden.legendCountRegHit = hihodenMemory3.legendCountRegHit
        hihoden.legendCountRegSum = hihodenMemory3.legendCountRegSum
    }
}

#Preview {
    hihodenViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
