//
//  ggoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var ggo = Ggo()
    @State var isShowAlert: Bool = false
    @StateObject var ggoMemory1 = GgoMemory1()
    @StateObject var ggoMemory2 = GgoMemory2()
    @StateObject var ggoMemory3 = GgoMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ぱちログの利用を前提としています\n遊技前にぱちログを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: ggo.machineName,
                        titleFont: .subheadline,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: ggoViewNormal(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.ggoMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: ggoViewFirstHit(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.ggoMenuFirstHitBadge,
                        )
                    }

                    // 終了画面カード
                    NavigationLink(destination: ggoViewScreen(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面カード",
                            badgeStatus: common.ggoMenuScreenBadge,
                        )
                    }

                    // 上位ST中
                    NavigationLink(destination: ggoViewDuringHighSt(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "上位ST中",
                            badgeStatus: common.ggoMenuDuringHighStBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewTamachanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "玉ちゃんトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: ggo.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: ggoView95Ci(
                    ggo: ggo,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: ggoViewBayes(
                    ggo: ggo,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.ggoMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5073")

                // コピーライト
                unitSectionCopyright {
                    Text("©2023時雨沢恵一/KADOKAWA/GGO2 Project")
                    Text("©KYORAKU")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5073")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(ggoSubViewLoadMemory(
                    ggo: ggo,
                    ggoMemory1: ggoMemory1,
                    ggoMemory2: ggoMemory2,
                    ggoMemory3: ggoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(ggoSubViewSaveMemory(
                    ggo: ggo,
                    ggoMemory1: ggoMemory1,
                    ggoMemory2: ggoMemory2,
                    ggoMemory3: ggoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: ggo.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct ggoSubViewSaveMemory: View {
    @ObservedObject var ggo: Ggo
    @ObservedObject var ggoMemory1: GgoMemory1
    @ObservedObject var ggoMemory2: GgoMemory2
    @ObservedObject var ggoMemory3: GgoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: ggo.machineName,
            selectedMemory: $ggo.selectedMemory,
            memoMemory1: $ggoMemory1.memo,
            dateDoubleMemory1: $ggoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $ggoMemory2.memo,
            dateDoubleMemory2: $ggoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $ggoMemory3.memo,
            dateDoubleMemory3: $ggoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        ggoMemory1.modeHeavenCountMiss = ggo.modeHeavenCountMiss
        ggoMemory1.modeHeavenCountHit = ggo.modeHeavenCountHit
        ggoMemory1.modeHeavenCountSum = ggo.modeHeavenCountSum
        ggoMemory1.playGameSum = ggo.playGameSum
        ggoMemory1.firstHitCountBonus = ggo.firstHitCountBonus
        ggoMemory1.firstHitCountSt = ggo.firstHitCountSt
        ggoMemory1.firstHitInputMode = ggo.firstHitInputMode
        ggoMemory1.manualNormalGame = ggo.manualNormalGame
        ggoMemory1.manualFirstHitCountBig = ggo.manualFirstHitCountBig
        ggoMemory1.manualFirstHitCountReg = ggo.manualFirstHitCountReg
        ggoMemory1.manualFirstHitCountEpisode = ggo.manualFirstHitCountEpisode
        ggoMemory1.manualFirstHitCountSt = ggo.manualFirstHitCountSt
        ggoMemory1.gameArrayData = ggo.gameArrayData
        ggoMemory1.bonusKindArrayData = ggo.bonusKindArrayData
        ggoMemory1.stResultArrayData = ggo.stResultArrayData
    }
    func saveMemory2() {
        ggoMemory2.modeHeavenCountMiss = ggo.modeHeavenCountMiss
        ggoMemory2.modeHeavenCountHit = ggo.modeHeavenCountHit
        ggoMemory2.modeHeavenCountSum = ggo.modeHeavenCountSum
        ggoMemory2.playGameSum = ggo.playGameSum
        ggoMemory2.firstHitCountBonus = ggo.firstHitCountBonus
        ggoMemory2.firstHitCountSt = ggo.firstHitCountSt
        ggoMemory2.firstHitInputMode = ggo.firstHitInputMode
        ggoMemory2.manualNormalGame = ggo.manualNormalGame
        ggoMemory2.manualFirstHitCountBig = ggo.manualFirstHitCountBig
        ggoMemory2.manualFirstHitCountReg = ggo.manualFirstHitCountReg
        ggoMemory2.manualFirstHitCountEpisode = ggo.manualFirstHitCountEpisode
        ggoMemory2.manualFirstHitCountSt = ggo.manualFirstHitCountSt
        ggoMemory2.gameArrayData = ggo.gameArrayData
        ggoMemory2.bonusKindArrayData = ggo.bonusKindArrayData
        ggoMemory2.stResultArrayData = ggo.stResultArrayData
    }
    func saveMemory3() {
        ggoMemory3.modeHeavenCountMiss = ggo.modeHeavenCountMiss
        ggoMemory3.modeHeavenCountHit = ggo.modeHeavenCountHit
        ggoMemory3.modeHeavenCountSum = ggo.modeHeavenCountSum
        ggoMemory3.playGameSum = ggo.playGameSum
        ggoMemory3.firstHitCountBonus = ggo.firstHitCountBonus
        ggoMemory3.firstHitCountSt = ggo.firstHitCountSt
        ggoMemory3.firstHitInputMode = ggo.firstHitInputMode
        ggoMemory3.manualNormalGame = ggo.manualNormalGame
        ggoMemory3.manualFirstHitCountBig = ggo.manualFirstHitCountBig
        ggoMemory3.manualFirstHitCountReg = ggo.manualFirstHitCountReg
        ggoMemory3.manualFirstHitCountEpisode = ggo.manualFirstHitCountEpisode
        ggoMemory3.manualFirstHitCountSt = ggo.manualFirstHitCountSt
        ggoMemory3.gameArrayData = ggo.gameArrayData
        ggoMemory3.bonusKindArrayData = ggo.bonusKindArrayData
        ggoMemory3.stResultArrayData = ggo.stResultArrayData
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct ggoSubViewLoadMemory: View {
    @ObservedObject var ggo: Ggo
    @ObservedObject var ggoMemory1: GgoMemory1
    @ObservedObject var ggoMemory2: GgoMemory2
    @ObservedObject var ggoMemory3: GgoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: ggo.machineName,
            selectedMemory: $ggo.selectedMemory,
            memoMemory1: ggoMemory1.memo,
            dateDoubleMemory1: ggoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: ggoMemory2.memo,
            dateDoubleMemory2: ggoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: ggoMemory3.memo,
            dateDoubleMemory3: ggoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        ggo.modeHeavenCountMiss = ggoMemory1.modeHeavenCountMiss
        ggo.modeHeavenCountHit = ggoMemory1.modeHeavenCountHit
        ggo.modeHeavenCountSum = ggoMemory1.modeHeavenCountSum
        ggo.playGameSum = ggoMemory1.playGameSum
        ggo.firstHitCountBonus = ggoMemory1.firstHitCountBonus
        ggo.firstHitCountSt = ggoMemory1.firstHitCountSt
        ggo.firstHitInputMode = ggoMemory1.firstHitInputMode
        ggo.manualNormalGame = ggoMemory1.manualNormalGame
        ggo.manualFirstHitCountBig = ggoMemory1.manualFirstHitCountBig
        ggo.manualFirstHitCountReg = ggoMemory1.manualFirstHitCountReg
        ggo.manualFirstHitCountEpisode = ggoMemory1.manualFirstHitCountEpisode
        ggo.manualFirstHitCountSt = ggoMemory1.manualFirstHitCountSt
        let gameArrayDecoded = decodeIntArray(from: ggoMemory1.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ggo.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: ggoMemory1.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: ggo.bonusKindArrayKey)
        let stResultArrayDecoded = decodeStringArray(from: ggoMemory1.stResultArrayData)
        saveArray(stResultArrayDecoded, forKey: ggo.stResultArrayKey)
    }
    func loadMemory2() {
        ggo.modeHeavenCountMiss = ggoMemory2.modeHeavenCountMiss
        ggo.modeHeavenCountHit = ggoMemory2.modeHeavenCountHit
        ggo.modeHeavenCountSum = ggoMemory2.modeHeavenCountSum
        ggo.playGameSum = ggoMemory2.playGameSum
        ggo.firstHitCountBonus = ggoMemory2.firstHitCountBonus
        ggo.firstHitCountSt = ggoMemory2.firstHitCountSt
        ggo.firstHitInputMode = ggoMemory2.firstHitInputMode
        ggo.manualNormalGame = ggoMemory2.manualNormalGame
        ggo.manualFirstHitCountBig = ggoMemory2.manualFirstHitCountBig
        ggo.manualFirstHitCountReg = ggoMemory2.manualFirstHitCountReg
        ggo.manualFirstHitCountEpisode = ggoMemory2.manualFirstHitCountEpisode
        ggo.manualFirstHitCountSt = ggoMemory2.manualFirstHitCountSt
        let gameArrayDecoded = decodeIntArray(from: ggoMemory2.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ggo.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: ggoMemory2.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: ggo.bonusKindArrayKey)
        let stResultArrayDecoded = decodeStringArray(from: ggoMemory2.stResultArrayData)
        saveArray(stResultArrayDecoded, forKey: ggo.stResultArrayKey)
    }
    func loadMemory3() {
        ggo.modeHeavenCountMiss = ggoMemory3.modeHeavenCountMiss
        ggo.modeHeavenCountHit = ggoMemory3.modeHeavenCountHit
        ggo.modeHeavenCountSum = ggoMemory3.modeHeavenCountSum
        ggo.playGameSum = ggoMemory3.playGameSum
        ggo.firstHitCountBonus = ggoMemory3.firstHitCountBonus
        ggo.firstHitCountSt = ggoMemory3.firstHitCountSt
        ggo.firstHitInputMode = ggoMemory3.firstHitInputMode
        ggo.manualNormalGame = ggoMemory3.manualNormalGame
        ggo.manualFirstHitCountBig = ggoMemory3.manualFirstHitCountBig
        ggo.manualFirstHitCountReg = ggoMemory3.manualFirstHitCountReg
        ggo.manualFirstHitCountEpisode = ggoMemory3.manualFirstHitCountEpisode
        ggo.manualFirstHitCountSt = ggoMemory3.manualFirstHitCountSt
        let gameArrayDecoded = decodeIntArray(from: ggoMemory3.gameArrayData)
        saveArray(gameArrayDecoded, forKey: ggo.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: ggoMemory3.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: ggo.bonusKindArrayKey)
        let stResultArrayDecoded = decodeStringArray(from: ggoMemory3.stResultArrayData)
        saveArray(stResultArrayDecoded, forKey: ggo.stResultArrayKey)
    }
}

#Preview {
    ggoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
