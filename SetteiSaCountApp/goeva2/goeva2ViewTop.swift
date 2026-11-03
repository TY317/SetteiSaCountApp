//
//  goeva2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var goeva2 = Goeva2()
    @State var isShowAlert: Bool = false
    @StateObject var goeva2Memory1 = Goeva2Memory1()
    @StateObject var goeva2Memory2 = Goeva2Memory2()
    @StateObject var goeva2Memory3 = Goeva2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: goeva2ViewNormal(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.goeva2MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: goeva2ViewFirstHit(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.goeva2MenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: goeva2ViewScreen(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.goeva2MenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: goeva2ViewEnding(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.goeva2MenuEndingBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: goeva2.machineName,
                        titleFont: .title2,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: goeva2View95Ci(
                    goeva2: goeva2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: goeva2ViewBayes(
                    goeva2: goeva2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.goeva2MenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5119")

                // コピーライト
                unitSectionCopyright {
                    Text("©︎カラー")
                    Text("TM＆ ©︎ TOHO CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5119")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(goeva2SubViewLoadMemory(
                    goeva2: goeva2,
                    goeva2Memory1: goeva2Memory1,
                    goeva2Memory2: goeva2Memory2,
                    goeva2Memory3: goeva2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(goeva2SubViewSaveMemory(
                    goeva2: goeva2,
                    goeva2Memory1: goeva2Memory1,
                    goeva2Memory2: goeva2Memory2,
                    goeva2Memory3: goeva2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: goeva2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct goeva2SubViewSaveMemory: View {
    @ObservedObject var goeva2: Goeva2
    @ObservedObject var goeva2Memory1: Goeva2Memory1
    @ObservedObject var goeva2Memory2: Goeva2Memory2
    @ObservedObject var goeva2Memory3: Goeva2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: goeva2.machineName,
            selectedMemory: $goeva2.selectedMemory,
            memoMemory1: $goeva2Memory1.memo,
            dateDoubleMemory1: $goeva2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $goeva2Memory2.memo,
            dateDoubleMemory2: $goeva2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $goeva2Memory3.memo,
            dateDoubleMemory3: $goeva2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        goeva2Memory1.suikaCount = goeva2.suikaCount
        goeva2Memory1.suikaCzCount = goeva2.suikaCzCount
        goeva2Memory1.bonusNormalWeakCount = goeva2.bonusNormalWeakCount
        goeva2Memory1.bonusNormalWeakCountHit = goeva2.bonusNormalWeakCountHit
        goeva2Memory1.bonusNormalStrong1Count = goeva2.bonusNormalStrong1Count
        goeva2Memory1.bonusNormalStrong1CountHit = goeva2.bonusNormalStrong1CountHit
        goeva2Memory1.bonusNormalStrong2Count = goeva2.bonusNormalStrong2Count
        goeva2Memory1.bonusNormalStrong2CountHit = goeva2.bonusNormalStrong2CountHit
        goeva2Memory1.bonusHighWeakCount = goeva2.bonusHighWeakCount
        goeva2Memory1.bonusHighWeakCountHit = goeva2.bonusHighWeakCountHit
        goeva2Memory1.bonusHighStrong1Count = goeva2.bonusHighStrong1Count
        goeva2Memory1.bonusHighStrong1CountHit = goeva2.bonusHighStrong1CountHit
        goeva2Memory1.bonusHighStrong2Count = goeva2.bonusHighStrong2Count
        goeva2Memory1.bonusHighStrong2CountHit = goeva2.bonusHighStrong2CountHit
        goeva2Memory1.bonusSuperWeakCount = goeva2.bonusSuperWeakCount
        goeva2Memory1.bonusSuperWeakCountHit = goeva2.bonusSuperWeakCountHit
        goeva2Memory1.gameArrayData = goeva2.gameArrayData
        goeva2Memory1.bonusKindArrayData = goeva2.bonusKindArrayData
        goeva2Memory1.atResultArrayData = goeva2.atResultArrayData
        goeva2Memory1.playGameSum = goeva2.playGameSum
        goeva2Memory1.firstHitCountBonus = goeva2.firstHitCountBonus
        goeva2Memory1.firstHitCountAt = goeva2.firstHitCountAt
        goeva2Memory1.firstHitInputMode = goeva2.firstHitInputMode
        goeva2Memory1.manualNormalGame = goeva2.manualNormalGame
        goeva2Memory1.manualFirstHitCountEva = goeva2.manualFirstHitCountEva
        goeva2Memory1.manualFirstHitCountGodzilla = goeva2.manualFirstHitCountGodzilla
        goeva2Memory1.manualFirstHitCountAt = goeva2.manualFirstHitCountAt
        goeva2Memory1.screenCount1 = goeva2.screenCount1
        goeva2Memory1.screenCount2 = goeva2.screenCount2
        goeva2Memory1.screenCount3 = goeva2.screenCount3
        goeva2Memory1.screenCount4 = goeva2.screenCount4
        goeva2Memory1.screenCount5 = goeva2.screenCount5
        goeva2Memory1.screenCount6 = goeva2.screenCount6
        goeva2Memory1.screenCount7 = goeva2.screenCount7
        goeva2Memory1.screenCount8 = goeva2.screenCount8
        goeva2Memory1.screenCount9 = goeva2.screenCount9
        goeva2Memory1.screenCount10 = goeva2.screenCount10
        goeva2Memory1.screenCountSum = goeva2.screenCountSum
    }
    func saveMemory2() {
        goeva2Memory2.suikaCount = goeva2.suikaCount
        goeva2Memory2.suikaCzCount = goeva2.suikaCzCount
        goeva2Memory2.bonusNormalWeakCount = goeva2.bonusNormalWeakCount
        goeva2Memory2.bonusNormalWeakCountHit = goeva2.bonusNormalWeakCountHit
        goeva2Memory2.bonusNormalStrong1Count = goeva2.bonusNormalStrong1Count
        goeva2Memory2.bonusNormalStrong1CountHit = goeva2.bonusNormalStrong1CountHit
        goeva2Memory2.bonusNormalStrong2Count = goeva2.bonusNormalStrong2Count
        goeva2Memory2.bonusNormalStrong2CountHit = goeva2.bonusNormalStrong2CountHit
        goeva2Memory2.bonusHighWeakCount = goeva2.bonusHighWeakCount
        goeva2Memory2.bonusHighWeakCountHit = goeva2.bonusHighWeakCountHit
        goeva2Memory2.bonusHighStrong1Count = goeva2.bonusHighStrong1Count
        goeva2Memory2.bonusHighStrong1CountHit = goeva2.bonusHighStrong1CountHit
        goeva2Memory2.bonusHighStrong2Count = goeva2.bonusHighStrong2Count
        goeva2Memory2.bonusHighStrong2CountHit = goeva2.bonusHighStrong2CountHit
        goeva2Memory2.bonusSuperWeakCount = goeva2.bonusSuperWeakCount
        goeva2Memory2.bonusSuperWeakCountHit = goeva2.bonusSuperWeakCountHit
        goeva2Memory2.gameArrayData = goeva2.gameArrayData
        goeva2Memory2.bonusKindArrayData = goeva2.bonusKindArrayData
        goeva2Memory2.atResultArrayData = goeva2.atResultArrayData
        goeva2Memory2.playGameSum = goeva2.playGameSum
        goeva2Memory2.firstHitCountBonus = goeva2.firstHitCountBonus
        goeva2Memory2.firstHitCountAt = goeva2.firstHitCountAt
        goeva2Memory2.firstHitInputMode = goeva2.firstHitInputMode
        goeva2Memory2.manualNormalGame = goeva2.manualNormalGame
        goeva2Memory2.manualFirstHitCountEva = goeva2.manualFirstHitCountEva
        goeva2Memory2.manualFirstHitCountGodzilla = goeva2.manualFirstHitCountGodzilla
        goeva2Memory2.manualFirstHitCountAt = goeva2.manualFirstHitCountAt
        goeva2Memory2.screenCount1 = goeva2.screenCount1
        goeva2Memory2.screenCount2 = goeva2.screenCount2
        goeva2Memory2.screenCount3 = goeva2.screenCount3
        goeva2Memory2.screenCount4 = goeva2.screenCount4
        goeva2Memory2.screenCount5 = goeva2.screenCount5
        goeva2Memory2.screenCount6 = goeva2.screenCount6
        goeva2Memory2.screenCount7 = goeva2.screenCount7
        goeva2Memory2.screenCount8 = goeva2.screenCount8
        goeva2Memory2.screenCount9 = goeva2.screenCount9
        goeva2Memory2.screenCount10 = goeva2.screenCount10
        goeva2Memory2.screenCountSum = goeva2.screenCountSum
    }
    func saveMemory3() {
        goeva2Memory3.suikaCount = goeva2.suikaCount
        goeva2Memory3.suikaCzCount = goeva2.suikaCzCount
        goeva2Memory3.bonusNormalWeakCount = goeva2.bonusNormalWeakCount
        goeva2Memory3.bonusNormalWeakCountHit = goeva2.bonusNormalWeakCountHit
        goeva2Memory3.bonusNormalStrong1Count = goeva2.bonusNormalStrong1Count
        goeva2Memory3.bonusNormalStrong1CountHit = goeva2.bonusNormalStrong1CountHit
        goeva2Memory3.bonusNormalStrong2Count = goeva2.bonusNormalStrong2Count
        goeva2Memory3.bonusNormalStrong2CountHit = goeva2.bonusNormalStrong2CountHit
        goeva2Memory3.bonusHighWeakCount = goeva2.bonusHighWeakCount
        goeva2Memory3.bonusHighWeakCountHit = goeva2.bonusHighWeakCountHit
        goeva2Memory3.bonusHighStrong1Count = goeva2.bonusHighStrong1Count
        goeva2Memory3.bonusHighStrong1CountHit = goeva2.bonusHighStrong1CountHit
        goeva2Memory3.bonusHighStrong2Count = goeva2.bonusHighStrong2Count
        goeva2Memory3.bonusHighStrong2CountHit = goeva2.bonusHighStrong2CountHit
        goeva2Memory3.bonusSuperWeakCount = goeva2.bonusSuperWeakCount
        goeva2Memory3.bonusSuperWeakCountHit = goeva2.bonusSuperWeakCountHit
        goeva2Memory3.gameArrayData = goeva2.gameArrayData
        goeva2Memory3.bonusKindArrayData = goeva2.bonusKindArrayData
        goeva2Memory3.atResultArrayData = goeva2.atResultArrayData
        goeva2Memory3.playGameSum = goeva2.playGameSum
        goeva2Memory3.firstHitCountBonus = goeva2.firstHitCountBonus
        goeva2Memory3.firstHitCountAt = goeva2.firstHitCountAt
        goeva2Memory3.firstHitInputMode = goeva2.firstHitInputMode
        goeva2Memory3.manualNormalGame = goeva2.manualNormalGame
        goeva2Memory3.manualFirstHitCountEva = goeva2.manualFirstHitCountEva
        goeva2Memory3.manualFirstHitCountGodzilla = goeva2.manualFirstHitCountGodzilla
        goeva2Memory3.manualFirstHitCountAt = goeva2.manualFirstHitCountAt
        goeva2Memory3.screenCount1 = goeva2.screenCount1
        goeva2Memory3.screenCount2 = goeva2.screenCount2
        goeva2Memory3.screenCount3 = goeva2.screenCount3
        goeva2Memory3.screenCount4 = goeva2.screenCount4
        goeva2Memory3.screenCount5 = goeva2.screenCount5
        goeva2Memory3.screenCount6 = goeva2.screenCount6
        goeva2Memory3.screenCount7 = goeva2.screenCount7
        goeva2Memory3.screenCount8 = goeva2.screenCount8
        goeva2Memory3.screenCount9 = goeva2.screenCount9
        goeva2Memory3.screenCount10 = goeva2.screenCount10
        goeva2Memory3.screenCountSum = goeva2.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct goeva2SubViewLoadMemory: View {
    @ObservedObject var goeva2: Goeva2
    @ObservedObject var goeva2Memory1: Goeva2Memory1
    @ObservedObject var goeva2Memory2: Goeva2Memory2
    @ObservedObject var goeva2Memory3: Goeva2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: goeva2.machineName,
            selectedMemory: $goeva2.selectedMemory,
            memoMemory1: goeva2Memory1.memo,
            dateDoubleMemory1: goeva2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: goeva2Memory2.memo,
            dateDoubleMemory2: goeva2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: goeva2Memory3.memo,
            dateDoubleMemory3: goeva2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        goeva2.suikaCount = goeva2Memory1.suikaCount
        goeva2.suikaCzCount = goeva2Memory1.suikaCzCount
        goeva2.bonusNormalWeakCount = goeva2Memory1.bonusNormalWeakCount
        goeva2.bonusNormalWeakCountHit = goeva2Memory1.bonusNormalWeakCountHit
        goeva2.bonusNormalStrong1Count = goeva2Memory1.bonusNormalStrong1Count
        goeva2.bonusNormalStrong1CountHit = goeva2Memory1.bonusNormalStrong1CountHit
        goeva2.bonusNormalStrong2Count = goeva2Memory1.bonusNormalStrong2Count
        goeva2.bonusNormalStrong2CountHit = goeva2Memory1.bonusNormalStrong2CountHit
        goeva2.bonusHighWeakCount = goeva2Memory1.bonusHighWeakCount
        goeva2.bonusHighWeakCountHit = goeva2Memory1.bonusHighWeakCountHit
        goeva2.bonusHighStrong1Count = goeva2Memory1.bonusHighStrong1Count
        goeva2.bonusHighStrong1CountHit = goeva2Memory1.bonusHighStrong1CountHit
        goeva2.bonusHighStrong2Count = goeva2Memory1.bonusHighStrong2Count
        goeva2.bonusHighStrong2CountHit = goeva2Memory1.bonusHighStrong2CountHit
        goeva2.bonusSuperWeakCount = goeva2Memory1.bonusSuperWeakCount
        goeva2.bonusSuperWeakCountHit = goeva2Memory1.bonusSuperWeakCountHit
        let gameArrayDecoded = decodeIntArray(from: goeva2Memory1.gameArrayData)
        saveArray(gameArrayDecoded, forKey: goeva2.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: goeva2Memory1.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: goeva2.bonusKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: goeva2Memory1.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: goeva2.atResultArrayKey)
        goeva2.playGameSum = goeva2Memory1.playGameSum
        goeva2.firstHitCountBonus = goeva2Memory1.firstHitCountBonus
        goeva2.firstHitCountAt = goeva2Memory1.firstHitCountAt
        goeva2.firstHitInputMode = goeva2Memory1.firstHitInputMode
        goeva2.manualNormalGame = goeva2Memory1.manualNormalGame
        goeva2.manualFirstHitCountEva = goeva2Memory1.manualFirstHitCountEva
        goeva2.manualFirstHitCountGodzilla = goeva2Memory1.manualFirstHitCountGodzilla
        goeva2.manualFirstHitCountAt = goeva2Memory1.manualFirstHitCountAt
        goeva2.screenCount1 = goeva2Memory1.screenCount1
        goeva2.screenCount2 = goeva2Memory1.screenCount2
        goeva2.screenCount3 = goeva2Memory1.screenCount3
        goeva2.screenCount4 = goeva2Memory1.screenCount4
        goeva2.screenCount5 = goeva2Memory1.screenCount5
        goeva2.screenCount6 = goeva2Memory1.screenCount6
        goeva2.screenCount7 = goeva2Memory1.screenCount7
        goeva2.screenCount8 = goeva2Memory1.screenCount8
        goeva2.screenCount9 = goeva2Memory1.screenCount9
        goeva2.screenCount10 = goeva2Memory1.screenCount10
        goeva2.screenCountSum = goeva2Memory1.screenCountSum
    }
    func loadMemory2() {
        goeva2.suikaCount = goeva2Memory2.suikaCount
        goeva2.suikaCzCount = goeva2Memory2.suikaCzCount
        goeva2.bonusNormalWeakCount = goeva2Memory2.bonusNormalWeakCount
        goeva2.bonusNormalWeakCountHit = goeva2Memory2.bonusNormalWeakCountHit
        goeva2.bonusNormalStrong1Count = goeva2Memory2.bonusNormalStrong1Count
        goeva2.bonusNormalStrong1CountHit = goeva2Memory2.bonusNormalStrong1CountHit
        goeva2.bonusNormalStrong2Count = goeva2Memory2.bonusNormalStrong2Count
        goeva2.bonusNormalStrong2CountHit = goeva2Memory2.bonusNormalStrong2CountHit
        goeva2.bonusHighWeakCount = goeva2Memory2.bonusHighWeakCount
        goeva2.bonusHighWeakCountHit = goeva2Memory2.bonusHighWeakCountHit
        goeva2.bonusHighStrong1Count = goeva2Memory2.bonusHighStrong1Count
        goeva2.bonusHighStrong1CountHit = goeva2Memory2.bonusHighStrong1CountHit
        goeva2.bonusHighStrong2Count = goeva2Memory2.bonusHighStrong2Count
        goeva2.bonusHighStrong2CountHit = goeva2Memory2.bonusHighStrong2CountHit
        goeva2.bonusSuperWeakCount = goeva2Memory2.bonusSuperWeakCount
        goeva2.bonusSuperWeakCountHit = goeva2Memory2.bonusSuperWeakCountHit
        let gameArrayDecoded = decodeIntArray(from: goeva2Memory2.gameArrayData)
        saveArray(gameArrayDecoded, forKey: goeva2.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: goeva2Memory2.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: goeva2.bonusKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: goeva2Memory2.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: goeva2.atResultArrayKey)
        goeva2.playGameSum = goeva2Memory2.playGameSum
        goeva2.firstHitCountBonus = goeva2Memory2.firstHitCountBonus
        goeva2.firstHitCountAt = goeva2Memory2.firstHitCountAt
        goeva2.firstHitInputMode = goeva2Memory2.firstHitInputMode
        goeva2.manualNormalGame = goeva2Memory2.manualNormalGame
        goeva2.manualFirstHitCountEva = goeva2Memory2.manualFirstHitCountEva
        goeva2.manualFirstHitCountGodzilla = goeva2Memory2.manualFirstHitCountGodzilla
        goeva2.manualFirstHitCountAt = goeva2Memory2.manualFirstHitCountAt
        goeva2.screenCount1 = goeva2Memory2.screenCount1
        goeva2.screenCount2 = goeva2Memory2.screenCount2
        goeva2.screenCount3 = goeva2Memory2.screenCount3
        goeva2.screenCount4 = goeva2Memory2.screenCount4
        goeva2.screenCount5 = goeva2Memory2.screenCount5
        goeva2.screenCount6 = goeva2Memory2.screenCount6
        goeva2.screenCount7 = goeva2Memory2.screenCount7
        goeva2.screenCount8 = goeva2Memory2.screenCount8
        goeva2.screenCount9 = goeva2Memory2.screenCount9
        goeva2.screenCount10 = goeva2Memory2.screenCount10
        goeva2.screenCountSum = goeva2Memory2.screenCountSum
    }
    func loadMemory3() {
        goeva2.suikaCount = goeva2Memory3.suikaCount
        goeva2.suikaCzCount = goeva2Memory3.suikaCzCount
        goeva2.bonusNormalWeakCount = goeva2Memory3.bonusNormalWeakCount
        goeva2.bonusNormalWeakCountHit = goeva2Memory3.bonusNormalWeakCountHit
        goeva2.bonusNormalStrong1Count = goeva2Memory3.bonusNormalStrong1Count
        goeva2.bonusNormalStrong1CountHit = goeva2Memory3.bonusNormalStrong1CountHit
        goeva2.bonusNormalStrong2Count = goeva2Memory3.bonusNormalStrong2Count
        goeva2.bonusNormalStrong2CountHit = goeva2Memory3.bonusNormalStrong2CountHit
        goeva2.bonusHighWeakCount = goeva2Memory3.bonusHighWeakCount
        goeva2.bonusHighWeakCountHit = goeva2Memory3.bonusHighWeakCountHit
        goeva2.bonusHighStrong1Count = goeva2Memory3.bonusHighStrong1Count
        goeva2.bonusHighStrong1CountHit = goeva2Memory3.bonusHighStrong1CountHit
        goeva2.bonusHighStrong2Count = goeva2Memory3.bonusHighStrong2Count
        goeva2.bonusHighStrong2CountHit = goeva2Memory3.bonusHighStrong2CountHit
        goeva2.bonusSuperWeakCount = goeva2Memory3.bonusSuperWeakCount
        goeva2.bonusSuperWeakCountHit = goeva2Memory3.bonusSuperWeakCountHit
        let gameArrayDecoded = decodeIntArray(from: goeva2Memory3.gameArrayData)
        saveArray(gameArrayDecoded, forKey: goeva2.gameArrayKey)
        let bonusKindArrayDecoded = decodeStringArray(from: goeva2Memory3.bonusKindArrayData)
        saveArray(bonusKindArrayDecoded, forKey: goeva2.bonusKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: goeva2Memory3.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: goeva2.atResultArrayKey)
        goeva2.playGameSum = goeva2Memory3.playGameSum
        goeva2.firstHitCountBonus = goeva2Memory3.firstHitCountBonus
        goeva2.firstHitCountAt = goeva2Memory3.firstHitCountAt
        goeva2.firstHitInputMode = goeva2Memory3.firstHitInputMode
        goeva2.manualNormalGame = goeva2Memory3.manualNormalGame
        goeva2.manualFirstHitCountEva = goeva2Memory3.manualFirstHitCountEva
        goeva2.manualFirstHitCountGodzilla = goeva2Memory3.manualFirstHitCountGodzilla
        goeva2.manualFirstHitCountAt = goeva2Memory3.manualFirstHitCountAt
        goeva2.screenCount1 = goeva2Memory3.screenCount1
        goeva2.screenCount2 = goeva2Memory3.screenCount2
        goeva2.screenCount3 = goeva2Memory3.screenCount3
        goeva2.screenCount4 = goeva2Memory3.screenCount4
        goeva2.screenCount5 = goeva2Memory3.screenCount5
        goeva2.screenCount6 = goeva2Memory3.screenCount6
        goeva2.screenCount7 = goeva2Memory3.screenCount7
        goeva2.screenCount8 = goeva2Memory3.screenCount8
        goeva2.screenCount9 = goeva2Memory3.screenCount9
        goeva2.screenCount10 = goeva2Memory3.screenCount10
        goeva2.screenCountSum = goeva2Memory3.screenCountSum
    }
}

#Preview {
    goeva2ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
