//
//  vivyViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var vivy = Vivy()
    @State var isShowAlert: Bool = false
    @StateObject var vivyMemory1 = VivyMemory1()
    @StateObject var vivyMemory2 = VivyMemory2()
    @StateObject var vivyMemory3 = VivyMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: vivy.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: vivyViewNormal(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.vivyMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: vivyViewFirstHit(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.vivyMenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: vivyViewScreen(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.vivyMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: vivyViewEnding(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.vivyMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "コパンダトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: vivy.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: vivyView95Ci(
                    vivy: vivy,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: vivyViewBayes(
                    vivy: vivy,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.vivyMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5120")

                // コピーライト
                unitSectionCopyright {
                    Text("©Vivy Score／アニプレックス・WIT STUDIO")
                    Text("©DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5120")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(vivySubViewLoadMemory(
                    vivy: vivy,
                    vivyMemory1: vivyMemory1,
                    vivyMemory2: vivyMemory2,
                    vivyMemory3: vivyMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(vivySubViewSaveMemory(
                    vivy: vivy,
                    vivyMemory1: vivyMemory1,
                    vivyMemory2: vivyMemory2,
                    vivyMemory3: vivyMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: vivy.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct vivySubViewSaveMemory: View {
    @ObservedObject var vivy: Vivy
    @ObservedObject var vivyMemory1: VivyMemory1
    @ObservedObject var vivyMemory2: VivyMemory2
    @ObservedObject var vivyMemory3: VivyMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: vivy.machineName,
            selectedMemory: $vivy.selectedMemory,
            memoMemory1: $vivyMemory1.memo,
            dateDoubleMemory1: $vivyMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $vivyMemory2.memo,
            dateDoubleMemory2: $vivyMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $vivyMemory3.memo,
            dateDoubleMemory3: $vivyMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        vivyMemory1.accelPromoteCountMiss1 = vivy.accelPromoteCountMiss1
        vivyMemory1.accelPromoteCountHit1 = vivy.accelPromoteCountHit1
        vivyMemory1.accelPromoteCountSum1 = vivy.accelPromoteCountSum1
        vivyMemory1.accelPromoteCountMiss2 = vivy.accelPromoteCountMiss2
        vivyMemory1.accelPromoteCountHit2 = vivy.accelPromoteCountHit2
        vivyMemory1.accelPromoteCountSum2 = vivy.accelPromoteCountSum2
        vivyMemory1.accelPromoteCountMiss3 = vivy.accelPromoteCountMiss3
        vivyMemory1.accelPromoteCountHit3 = vivy.accelPromoteCountHit3
        vivyMemory1.accelPromoteCountSum3 = vivy.accelPromoteCountSum3
        vivyMemory1.accelPromoteCountMiss4 = vivy.accelPromoteCountMiss4
        vivyMemory1.accelPromoteCountHit4 = vivy.accelPromoteCountHit4
        vivyMemory1.accelPromoteCountSum4 = vivy.accelPromoteCountSum4
        vivyMemory1.weakCherryGameNormal = vivy.weakCherryGameNormal
        vivyMemory1.weakCherryCountNormal = vivy.weakCherryCountNormal
        vivyMemory1.weakCherryGameHigh2 = vivy.weakCherryGameHigh2
        vivyMemory1.weakCherryCountHigh2 = vivy.weakCherryCountHigh2
        vivyMemory1.weakCherryGameHigh3 = vivy.weakCherryGameHigh3
        vivyMemory1.weakCherryCountHigh3 = vivy.weakCherryCountHigh3
        vivyMemory1.playGameSum = vivy.playGameSum
        vivyMemory1.firstHitCountAt = vivy.firstHitCountAt
        vivyMemory1.firstHitInputMode = vivy.firstHitInputMode
        vivyMemory1.manualNormalGame = vivy.manualNormalGame
        vivyMemory1.manualFirstHitCountAt = vivy.manualFirstHitCountAt
        vivyMemory1.screenCount1 = vivy.screenCount1
        vivyMemory1.screenCount2 = vivy.screenCount2
        vivyMemory1.screenCount3 = vivy.screenCount3
        vivyMemory1.screenCount4 = vivy.screenCount4
        vivyMemory1.screenCount5 = vivy.screenCount5
        vivyMemory1.screenCount6 = vivy.screenCount6
        vivyMemory1.screenCount7 = vivy.screenCount7
        vivyMemory1.screenCount8 = vivy.screenCount8
        vivyMemory1.screenCount9 = vivy.screenCount9
        vivyMemory1.screenCountSum = vivy.screenCountSum
        vivyMemory1.charaCount1 = vivy.charaCount1
        vivyMemory1.charaCount2 = vivy.charaCount2
        vivyMemory1.charaCount3 = vivy.charaCount3
        vivyMemory1.charaCount4 = vivy.charaCount4
        vivyMemory1.charaCount5 = vivy.charaCount5
        vivyMemory1.charaCount6 = vivy.charaCount6
        vivyMemory1.charaCountSum = vivy.charaCountSum
        vivyMemory1.entryKindArrayData = vivy.entryKindArrayData
        vivyMemory1.gameArrayData = vivy.gameArrayData
        vivyMemory1.centerArrayData = vivy.centerArrayData
        vivyMemory1.rightArrayData = vivy.rightArrayData
    }
    func saveMemory2() {
        vivyMemory2.accelPromoteCountMiss1 = vivy.accelPromoteCountMiss1
        vivyMemory2.accelPromoteCountHit1 = vivy.accelPromoteCountHit1
        vivyMemory2.accelPromoteCountSum1 = vivy.accelPromoteCountSum1
        vivyMemory2.accelPromoteCountMiss2 = vivy.accelPromoteCountMiss2
        vivyMemory2.accelPromoteCountHit2 = vivy.accelPromoteCountHit2
        vivyMemory2.accelPromoteCountSum2 = vivy.accelPromoteCountSum2
        vivyMemory2.accelPromoteCountMiss3 = vivy.accelPromoteCountMiss3
        vivyMemory2.accelPromoteCountHit3 = vivy.accelPromoteCountHit3
        vivyMemory2.accelPromoteCountSum3 = vivy.accelPromoteCountSum3
        vivyMemory2.accelPromoteCountMiss4 = vivy.accelPromoteCountMiss4
        vivyMemory2.accelPromoteCountHit4 = vivy.accelPromoteCountHit4
        vivyMemory2.accelPromoteCountSum4 = vivy.accelPromoteCountSum4
        vivyMemory2.weakCherryGameNormal = vivy.weakCherryGameNormal
        vivyMemory2.weakCherryCountNormal = vivy.weakCherryCountNormal
        vivyMemory2.weakCherryGameHigh2 = vivy.weakCherryGameHigh2
        vivyMemory2.weakCherryCountHigh2 = vivy.weakCherryCountHigh2
        vivyMemory2.weakCherryGameHigh3 = vivy.weakCherryGameHigh3
        vivyMemory2.weakCherryCountHigh3 = vivy.weakCherryCountHigh3
        vivyMemory2.playGameSum = vivy.playGameSum
        vivyMemory2.firstHitCountAt = vivy.firstHitCountAt
        vivyMemory2.firstHitInputMode = vivy.firstHitInputMode
        vivyMemory2.manualNormalGame = vivy.manualNormalGame
        vivyMemory2.manualFirstHitCountAt = vivy.manualFirstHitCountAt
        vivyMemory2.screenCount1 = vivy.screenCount1
        vivyMemory2.screenCount2 = vivy.screenCount2
        vivyMemory2.screenCount3 = vivy.screenCount3
        vivyMemory2.screenCount4 = vivy.screenCount4
        vivyMemory2.screenCount5 = vivy.screenCount5
        vivyMemory2.screenCount6 = vivy.screenCount6
        vivyMemory2.screenCount7 = vivy.screenCount7
        vivyMemory2.screenCount8 = vivy.screenCount8
        vivyMemory2.screenCount9 = vivy.screenCount9
        vivyMemory2.screenCountSum = vivy.screenCountSum
        vivyMemory2.charaCount1 = vivy.charaCount1
        vivyMemory2.charaCount2 = vivy.charaCount2
        vivyMemory2.charaCount3 = vivy.charaCount3
        vivyMemory2.charaCount4 = vivy.charaCount4
        vivyMemory2.charaCount5 = vivy.charaCount5
        vivyMemory2.charaCount6 = vivy.charaCount6
        vivyMemory2.charaCountSum = vivy.charaCountSum
        vivyMemory2.entryKindArrayData = vivy.entryKindArrayData
        vivyMemory2.gameArrayData = vivy.gameArrayData
        vivyMemory2.centerArrayData = vivy.centerArrayData
        vivyMemory2.rightArrayData = vivy.rightArrayData
    }
    func saveMemory3() {
        vivyMemory3.accelPromoteCountMiss1 = vivy.accelPromoteCountMiss1
        vivyMemory3.accelPromoteCountHit1 = vivy.accelPromoteCountHit1
        vivyMemory3.accelPromoteCountSum1 = vivy.accelPromoteCountSum1
        vivyMemory3.accelPromoteCountMiss2 = vivy.accelPromoteCountMiss2
        vivyMemory3.accelPromoteCountHit2 = vivy.accelPromoteCountHit2
        vivyMemory3.accelPromoteCountSum2 = vivy.accelPromoteCountSum2
        vivyMemory3.accelPromoteCountMiss3 = vivy.accelPromoteCountMiss3
        vivyMemory3.accelPromoteCountHit3 = vivy.accelPromoteCountHit3
        vivyMemory3.accelPromoteCountSum3 = vivy.accelPromoteCountSum3
        vivyMemory3.accelPromoteCountMiss4 = vivy.accelPromoteCountMiss4
        vivyMemory3.accelPromoteCountHit4 = vivy.accelPromoteCountHit4
        vivyMemory3.accelPromoteCountSum4 = vivy.accelPromoteCountSum4
        vivyMemory3.weakCherryGameNormal = vivy.weakCherryGameNormal
        vivyMemory3.weakCherryCountNormal = vivy.weakCherryCountNormal
        vivyMemory3.weakCherryGameHigh2 = vivy.weakCherryGameHigh2
        vivyMemory3.weakCherryCountHigh2 = vivy.weakCherryCountHigh2
        vivyMemory3.weakCherryGameHigh3 = vivy.weakCherryGameHigh3
        vivyMemory3.weakCherryCountHigh3 = vivy.weakCherryCountHigh3
        vivyMemory3.playGameSum = vivy.playGameSum
        vivyMemory3.firstHitCountAt = vivy.firstHitCountAt
        vivyMemory3.firstHitInputMode = vivy.firstHitInputMode
        vivyMemory3.manualNormalGame = vivy.manualNormalGame
        vivyMemory3.manualFirstHitCountAt = vivy.manualFirstHitCountAt
        vivyMemory3.screenCount1 = vivy.screenCount1
        vivyMemory3.screenCount2 = vivy.screenCount2
        vivyMemory3.screenCount3 = vivy.screenCount3
        vivyMemory3.screenCount4 = vivy.screenCount4
        vivyMemory3.screenCount5 = vivy.screenCount5
        vivyMemory3.screenCount6 = vivy.screenCount6
        vivyMemory3.screenCount7 = vivy.screenCount7
        vivyMemory3.screenCount8 = vivy.screenCount8
        vivyMemory3.screenCount9 = vivy.screenCount9
        vivyMemory3.screenCountSum = vivy.screenCountSum
        vivyMemory3.charaCount1 = vivy.charaCount1
        vivyMemory3.charaCount2 = vivy.charaCount2
        vivyMemory3.charaCount3 = vivy.charaCount3
        vivyMemory3.charaCount4 = vivy.charaCount4
        vivyMemory3.charaCount5 = vivy.charaCount5
        vivyMemory3.charaCount6 = vivy.charaCount6
        vivyMemory3.charaCountSum = vivy.charaCountSum
        vivyMemory3.entryKindArrayData = vivy.entryKindArrayData
        vivyMemory3.gameArrayData = vivy.gameArrayData
        vivyMemory3.centerArrayData = vivy.centerArrayData
        vivyMemory3.rightArrayData = vivy.rightArrayData
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct vivySubViewLoadMemory: View {
    @ObservedObject var vivy: Vivy
    @ObservedObject var vivyMemory1: VivyMemory1
    @ObservedObject var vivyMemory2: VivyMemory2
    @ObservedObject var vivyMemory3: VivyMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: vivy.machineName,
            selectedMemory: $vivy.selectedMemory,
            memoMemory1: vivyMemory1.memo,
            dateDoubleMemory1: vivyMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: vivyMemory2.memo,
            dateDoubleMemory2: vivyMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: vivyMemory3.memo,
            dateDoubleMemory3: vivyMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        vivy.accelPromoteCountMiss1 = vivyMemory1.accelPromoteCountMiss1
        vivy.accelPromoteCountHit1 = vivyMemory1.accelPromoteCountHit1
        vivy.accelPromoteCountSum1 = vivyMemory1.accelPromoteCountSum1
        vivy.accelPromoteCountMiss2 = vivyMemory1.accelPromoteCountMiss2
        vivy.accelPromoteCountHit2 = vivyMemory1.accelPromoteCountHit2
        vivy.accelPromoteCountSum2 = vivyMemory1.accelPromoteCountSum2
        vivy.accelPromoteCountMiss3 = vivyMemory1.accelPromoteCountMiss3
        vivy.accelPromoteCountHit3 = vivyMemory1.accelPromoteCountHit3
        vivy.accelPromoteCountSum3 = vivyMemory1.accelPromoteCountSum3
        vivy.accelPromoteCountMiss4 = vivyMemory1.accelPromoteCountMiss4
        vivy.accelPromoteCountHit4 = vivyMemory1.accelPromoteCountHit4
        vivy.accelPromoteCountSum4 = vivyMemory1.accelPromoteCountSum4
        vivy.weakCherryGameNormal = vivyMemory1.weakCherryGameNormal
        vivy.weakCherryCountNormal = vivyMemory1.weakCherryCountNormal
        vivy.weakCherryGameHigh2 = vivyMemory1.weakCherryGameHigh2
        vivy.weakCherryCountHigh2 = vivyMemory1.weakCherryCountHigh2
        vivy.weakCherryGameHigh3 = vivyMemory1.weakCherryGameHigh3
        vivy.weakCherryCountHigh3 = vivyMemory1.weakCherryCountHigh3
        vivy.playGameSum = vivyMemory1.playGameSum
        vivy.firstHitCountAt = vivyMemory1.firstHitCountAt
        vivy.firstHitInputMode = vivyMemory1.firstHitInputMode
        vivy.manualNormalGame = vivyMemory1.manualNormalGame
        vivy.manualFirstHitCountAt = vivyMemory1.manualFirstHitCountAt
        vivy.screenCount1 = vivyMemory1.screenCount1
        vivy.screenCount2 = vivyMemory1.screenCount2
        vivy.screenCount3 = vivyMemory1.screenCount3
        vivy.screenCount4 = vivyMemory1.screenCount4
        vivy.screenCount5 = vivyMemory1.screenCount5
        vivy.screenCount6 = vivyMemory1.screenCount6
        vivy.screenCount7 = vivyMemory1.screenCount7
        vivy.screenCount8 = vivyMemory1.screenCount8
        vivy.screenCount9 = vivyMemory1.screenCount9
        vivy.screenCountSum = vivyMemory1.screenCountSum
        vivy.charaCount1 = vivyMemory1.charaCount1
        vivy.charaCount2 = vivyMemory1.charaCount2
        vivy.charaCount3 = vivyMemory1.charaCount3
        vivy.charaCount4 = vivyMemory1.charaCount4
        vivy.charaCount5 = vivyMemory1.charaCount5
        vivy.charaCount6 = vivyMemory1.charaCount6
        vivy.charaCountSum = vivyMemory1.charaCountSum
        let entryKindArrayDecoded = decodeStringArray(from: vivyMemory1.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: vivy.entryKindArrayKey)
        let gameArrayDecoded = decodeIntArray(from: vivyMemory1.gameArrayData)
        saveArray(gameArrayDecoded, forKey: vivy.gameArrayKey)
        let centerArrayDecoded = decodeStringArray(from: vivyMemory1.centerArrayData)
        saveArray(centerArrayDecoded, forKey: vivy.centerArrayKey)
        let rightArrayDecoded = decodeStringArray(from: vivyMemory1.rightArrayData)
        saveArray(rightArrayDecoded, forKey: vivy.rightArrayKey)
    }
    func loadMemory2() {
        vivy.accelPromoteCountMiss1 = vivyMemory2.accelPromoteCountMiss1
        vivy.accelPromoteCountHit1 = vivyMemory2.accelPromoteCountHit1
        vivy.accelPromoteCountSum1 = vivyMemory2.accelPromoteCountSum1
        vivy.accelPromoteCountMiss2 = vivyMemory2.accelPromoteCountMiss2
        vivy.accelPromoteCountHit2 = vivyMemory2.accelPromoteCountHit2
        vivy.accelPromoteCountSum2 = vivyMemory2.accelPromoteCountSum2
        vivy.accelPromoteCountMiss3 = vivyMemory2.accelPromoteCountMiss3
        vivy.accelPromoteCountHit3 = vivyMemory2.accelPromoteCountHit3
        vivy.accelPromoteCountSum3 = vivyMemory2.accelPromoteCountSum3
        vivy.accelPromoteCountMiss4 = vivyMemory2.accelPromoteCountMiss4
        vivy.accelPromoteCountHit4 = vivyMemory2.accelPromoteCountHit4
        vivy.accelPromoteCountSum4 = vivyMemory2.accelPromoteCountSum4
        vivy.weakCherryGameNormal = vivyMemory2.weakCherryGameNormal
        vivy.weakCherryCountNormal = vivyMemory2.weakCherryCountNormal
        vivy.weakCherryGameHigh2 = vivyMemory2.weakCherryGameHigh2
        vivy.weakCherryCountHigh2 = vivyMemory2.weakCherryCountHigh2
        vivy.weakCherryGameHigh3 = vivyMemory2.weakCherryGameHigh3
        vivy.weakCherryCountHigh3 = vivyMemory2.weakCherryCountHigh3
        vivy.playGameSum = vivyMemory2.playGameSum
        vivy.firstHitCountAt = vivyMemory2.firstHitCountAt
        vivy.firstHitInputMode = vivyMemory2.firstHitInputMode
        vivy.manualNormalGame = vivyMemory2.manualNormalGame
        vivy.manualFirstHitCountAt = vivyMemory2.manualFirstHitCountAt
        vivy.screenCount1 = vivyMemory2.screenCount1
        vivy.screenCount2 = vivyMemory2.screenCount2
        vivy.screenCount3 = vivyMemory2.screenCount3
        vivy.screenCount4 = vivyMemory2.screenCount4
        vivy.screenCount5 = vivyMemory2.screenCount5
        vivy.screenCount6 = vivyMemory2.screenCount6
        vivy.screenCount7 = vivyMemory2.screenCount7
        vivy.screenCount8 = vivyMemory2.screenCount8
        vivy.screenCount9 = vivyMemory2.screenCount9
        vivy.screenCountSum = vivyMemory2.screenCountSum
        vivy.charaCount1 = vivyMemory2.charaCount1
        vivy.charaCount2 = vivyMemory2.charaCount2
        vivy.charaCount3 = vivyMemory2.charaCount3
        vivy.charaCount4 = vivyMemory2.charaCount4
        vivy.charaCount5 = vivyMemory2.charaCount5
        vivy.charaCount6 = vivyMemory2.charaCount6
        vivy.charaCountSum = vivyMemory2.charaCountSum
        let entryKindArrayDecoded = decodeStringArray(from: vivyMemory2.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: vivy.entryKindArrayKey)
        let gameArrayDecoded = decodeIntArray(from: vivyMemory2.gameArrayData)
        saveArray(gameArrayDecoded, forKey: vivy.gameArrayKey)
        let centerArrayDecoded = decodeStringArray(from: vivyMemory2.centerArrayData)
        saveArray(centerArrayDecoded, forKey: vivy.centerArrayKey)
        let rightArrayDecoded = decodeStringArray(from: vivyMemory2.rightArrayData)
        saveArray(rightArrayDecoded, forKey: vivy.rightArrayKey)
    }
    func loadMemory3() {
        vivy.accelPromoteCountMiss1 = vivyMemory3.accelPromoteCountMiss1
        vivy.accelPromoteCountHit1 = vivyMemory3.accelPromoteCountHit1
        vivy.accelPromoteCountSum1 = vivyMemory3.accelPromoteCountSum1
        vivy.accelPromoteCountMiss2 = vivyMemory3.accelPromoteCountMiss2
        vivy.accelPromoteCountHit2 = vivyMemory3.accelPromoteCountHit2
        vivy.accelPromoteCountSum2 = vivyMemory3.accelPromoteCountSum2
        vivy.accelPromoteCountMiss3 = vivyMemory3.accelPromoteCountMiss3
        vivy.accelPromoteCountHit3 = vivyMemory3.accelPromoteCountHit3
        vivy.accelPromoteCountSum3 = vivyMemory3.accelPromoteCountSum3
        vivy.accelPromoteCountMiss4 = vivyMemory3.accelPromoteCountMiss4
        vivy.accelPromoteCountHit4 = vivyMemory3.accelPromoteCountHit4
        vivy.accelPromoteCountSum4 = vivyMemory3.accelPromoteCountSum4
        vivy.weakCherryGameNormal = vivyMemory3.weakCherryGameNormal
        vivy.weakCherryCountNormal = vivyMemory3.weakCherryCountNormal
        vivy.weakCherryGameHigh2 = vivyMemory3.weakCherryGameHigh2
        vivy.weakCherryCountHigh2 = vivyMemory3.weakCherryCountHigh2
        vivy.weakCherryGameHigh3 = vivyMemory3.weakCherryGameHigh3
        vivy.weakCherryCountHigh3 = vivyMemory3.weakCherryCountHigh3
        vivy.playGameSum = vivyMemory3.playGameSum
        vivy.firstHitCountAt = vivyMemory3.firstHitCountAt
        vivy.firstHitInputMode = vivyMemory3.firstHitInputMode
        vivy.manualNormalGame = vivyMemory3.manualNormalGame
        vivy.manualFirstHitCountAt = vivyMemory3.manualFirstHitCountAt
        vivy.screenCount1 = vivyMemory3.screenCount1
        vivy.screenCount2 = vivyMemory3.screenCount2
        vivy.screenCount3 = vivyMemory3.screenCount3
        vivy.screenCount4 = vivyMemory3.screenCount4
        vivy.screenCount5 = vivyMemory3.screenCount5
        vivy.screenCount6 = vivyMemory3.screenCount6
        vivy.screenCount7 = vivyMemory3.screenCount7
        vivy.screenCount8 = vivyMemory3.screenCount8
        vivy.screenCount9 = vivyMemory3.screenCount9
        vivy.screenCountSum = vivyMemory3.screenCountSum
        vivy.charaCount1 = vivyMemory3.charaCount1
        vivy.charaCount2 = vivyMemory3.charaCount2
        vivy.charaCount3 = vivyMemory3.charaCount3
        vivy.charaCount4 = vivyMemory3.charaCount4
        vivy.charaCount5 = vivyMemory3.charaCount5
        vivy.charaCount6 = vivyMemory3.charaCount6
        vivy.charaCountSum = vivyMemory3.charaCountSum
        let entryKindArrayDecoded = decodeStringArray(from: vivyMemory3.entryKindArrayData)
        saveArray(entryKindArrayDecoded, forKey: vivy.entryKindArrayKey)
        let gameArrayDecoded = decodeIntArray(from: vivyMemory3.gameArrayData)
        saveArray(gameArrayDecoded, forKey: vivy.gameArrayKey)
        let centerArrayDecoded = decodeStringArray(from: vivyMemory3.centerArrayData)
        saveArray(centerArrayDecoded, forKey: vivy.centerArrayKey)
        let rightArrayDecoded = decodeStringArray(from: vivyMemory3.rightArrayData)
        saveArray(rightArrayDecoded, forKey: vivy.rightArrayKey)
    }
}

#Preview {
    vivyViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
