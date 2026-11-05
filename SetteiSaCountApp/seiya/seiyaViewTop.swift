//
//  seiyaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var seiya = Seiya()
    @State var isShowAlert: Bool = false
    @StateObject var seiyaMemory1 = SeiyaMemory1()
    @StateObject var seiyaMemory2 = SeiyaMemory2()
    @StateObject var seiyaMemory3 = SeiyaMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: seiyaViewNormal(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.seiyaMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: seiyaViewFirstHit(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.seiyaMenuFirstHitBadge,
                        )
                    }

                    // AT中
                    NavigationLink(destination: seiyaViewDuringAt(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "sparkles",
                            textBody: "AT中",
                            badgeStatus: common.seiyaMenuDuringAtBadge,
                        )
                    }

                    // AT終了画面
                    NavigationLink(destination: seiyaViewScreen(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.seiyaMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: seiyaViewEnding(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.seiyaMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKujiluckyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "クジラッキートロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: seiya.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: seiyaView95Ci(
                    seiya: seiya,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: seiyaViewBayes(
                    seiya: seiya,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.seiyaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5104")

                // コピーライト
                unitSectionCopyright {
                    Text("©車田正美・東映アニメーション")
                    Text("©SANYO BUSSAN CO.,LTD.")
                    Text("©SANTHREE CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5104")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(seiyaSubViewLoadMemory(
                    seiya: seiya,
                    seiyaMemory1: seiyaMemory1,
                    seiyaMemory2: seiyaMemory2,
                    seiyaMemory3: seiyaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(seiyaSubViewSaveMemory(
                    seiya: seiya,
                    seiyaMemory1: seiyaMemory1,
                    seiyaMemory2: seiyaMemory2,
                    seiyaMemory3: seiyaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: seiya.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct seiyaSubViewSaveMemory: View {
    @ObservedObject var seiya: Seiya
    @ObservedObject var seiyaMemory1: SeiyaMemory1
    @ObservedObject var seiyaMemory2: SeiyaMemory2
    @ObservedObject var seiyaMemory3: SeiyaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: seiya.machineName,
            selectedMemory: $seiya.selectedMemory,
            memoMemory1: $seiyaMemory1.memo,
            dateDoubleMemory1: $seiyaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $seiyaMemory2.memo,
            dateDoubleMemory2: $seiyaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $seiyaMemory3.memo,
            dateDoubleMemory3: $seiyaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        seiyaMemory1.gameArrayData = seiya.gameArrayData
        seiyaMemory1.czKindArrayData = seiya.czKindArrayData
        seiyaMemory1.atResultArrayData = seiya.atResultArrayData
        seiyaMemory1.playGameSum = seiya.playGameSum
        seiyaMemory1.firstHitCountCz = seiya.firstHitCountCz
        seiyaMemory1.firstHitCountAt = seiya.firstHitCountAt
        seiyaMemory1.firstHitInputMode = seiya.firstHitInputMode
        seiyaMemory1.manualNormalGame = seiya.manualNormalGame
        seiyaMemory1.manualFirstHitCountCz = seiya.manualFirstHitCountCz
        seiyaMemory1.manualFirstHitCountAt = seiya.manualFirstHitCountAt
        seiyaMemory1.opponentCount1 = seiya.opponentCount1
        seiyaMemory1.opponentCount2 = seiya.opponentCount2
        seiyaMemory1.opponentCount3 = seiya.opponentCount3
        seiyaMemory1.opponentCountSum = seiya.opponentCountSum
        seiyaMemory1.charaCount1 = seiya.charaCount1
        seiyaMemory1.charaCount2 = seiya.charaCount2
        seiyaMemory1.charaCount3 = seiya.charaCount3
        seiyaMemory1.charaCountSum = seiya.charaCountSum
        seiyaMemory1.screenCount1 = seiya.screenCount1
        seiyaMemory1.screenCount2 = seiya.screenCount2
        seiyaMemory1.screenCount3 = seiya.screenCount3
        seiyaMemory1.screenCount4 = seiya.screenCount4
        seiyaMemory1.screenCount5 = seiya.screenCount5
        seiyaMemory1.screenCount6 = seiya.screenCount6
        seiyaMemory1.screenCount7 = seiya.screenCount7
        seiyaMemory1.screenCount8 = seiya.screenCount8
        seiyaMemory1.screenCountSum = seiya.screenCountSum
        seiyaMemory1.lampCount1 = seiya.lampCount1
        seiyaMemory1.lampCount2 = seiya.lampCount2
        seiyaMemory1.lampCount3 = seiya.lampCount3
        seiyaMemory1.lampCount4 = seiya.lampCount4
        seiyaMemory1.lampCount5 = seiya.lampCount5
        seiyaMemory1.lampCount6 = seiya.lampCount6
        seiyaMemory1.lampCountSum = seiya.lampCountSum
    }
    func saveMemory2() {
        seiyaMemory2.gameArrayData = seiya.gameArrayData
        seiyaMemory2.czKindArrayData = seiya.czKindArrayData
        seiyaMemory2.atResultArrayData = seiya.atResultArrayData
        seiyaMemory2.playGameSum = seiya.playGameSum
        seiyaMemory2.firstHitCountCz = seiya.firstHitCountCz
        seiyaMemory2.firstHitCountAt = seiya.firstHitCountAt
        seiyaMemory2.firstHitInputMode = seiya.firstHitInputMode
        seiyaMemory2.manualNormalGame = seiya.manualNormalGame
        seiyaMemory2.manualFirstHitCountCz = seiya.manualFirstHitCountCz
        seiyaMemory2.manualFirstHitCountAt = seiya.manualFirstHitCountAt
        seiyaMemory2.opponentCount1 = seiya.opponentCount1
        seiyaMemory2.opponentCount2 = seiya.opponentCount2
        seiyaMemory2.opponentCount3 = seiya.opponentCount3
        seiyaMemory2.opponentCountSum = seiya.opponentCountSum
        seiyaMemory2.charaCount1 = seiya.charaCount1
        seiyaMemory2.charaCount2 = seiya.charaCount2
        seiyaMemory2.charaCount3 = seiya.charaCount3
        seiyaMemory2.charaCountSum = seiya.charaCountSum
        seiyaMemory2.screenCount1 = seiya.screenCount1
        seiyaMemory2.screenCount2 = seiya.screenCount2
        seiyaMemory2.screenCount3 = seiya.screenCount3
        seiyaMemory2.screenCount4 = seiya.screenCount4
        seiyaMemory2.screenCount5 = seiya.screenCount5
        seiyaMemory2.screenCount6 = seiya.screenCount6
        seiyaMemory2.screenCount7 = seiya.screenCount7
        seiyaMemory2.screenCount8 = seiya.screenCount8
        seiyaMemory2.screenCountSum = seiya.screenCountSum
        seiyaMemory2.lampCount1 = seiya.lampCount1
        seiyaMemory2.lampCount2 = seiya.lampCount2
        seiyaMemory2.lampCount3 = seiya.lampCount3
        seiyaMemory2.lampCount4 = seiya.lampCount4
        seiyaMemory2.lampCount5 = seiya.lampCount5
        seiyaMemory2.lampCount6 = seiya.lampCount6
        seiyaMemory2.lampCountSum = seiya.lampCountSum
    }
    func saveMemory3() {
        seiyaMemory3.gameArrayData = seiya.gameArrayData
        seiyaMemory3.czKindArrayData = seiya.czKindArrayData
        seiyaMemory3.atResultArrayData = seiya.atResultArrayData
        seiyaMemory3.playGameSum = seiya.playGameSum
        seiyaMemory3.firstHitCountCz = seiya.firstHitCountCz
        seiyaMemory3.firstHitCountAt = seiya.firstHitCountAt
        seiyaMemory3.firstHitInputMode = seiya.firstHitInputMode
        seiyaMemory3.manualNormalGame = seiya.manualNormalGame
        seiyaMemory3.manualFirstHitCountCz = seiya.manualFirstHitCountCz
        seiyaMemory3.manualFirstHitCountAt = seiya.manualFirstHitCountAt
        seiyaMemory3.opponentCount1 = seiya.opponentCount1
        seiyaMemory3.opponentCount2 = seiya.opponentCount2
        seiyaMemory3.opponentCount3 = seiya.opponentCount3
        seiyaMemory3.opponentCountSum = seiya.opponentCountSum
        seiyaMemory3.charaCount1 = seiya.charaCount1
        seiyaMemory3.charaCount2 = seiya.charaCount2
        seiyaMemory3.charaCount3 = seiya.charaCount3
        seiyaMemory3.charaCountSum = seiya.charaCountSum
        seiyaMemory3.screenCount1 = seiya.screenCount1
        seiyaMemory3.screenCount2 = seiya.screenCount2
        seiyaMemory3.screenCount3 = seiya.screenCount3
        seiyaMemory3.screenCount4 = seiya.screenCount4
        seiyaMemory3.screenCount5 = seiya.screenCount5
        seiyaMemory3.screenCount6 = seiya.screenCount6
        seiyaMemory3.screenCount7 = seiya.screenCount7
        seiyaMemory3.screenCount8 = seiya.screenCount8
        seiyaMemory3.screenCountSum = seiya.screenCountSum
        seiyaMemory3.lampCount1 = seiya.lampCount1
        seiyaMemory3.lampCount2 = seiya.lampCount2
        seiyaMemory3.lampCount3 = seiya.lampCount3
        seiyaMemory3.lampCount4 = seiya.lampCount4
        seiyaMemory3.lampCount5 = seiya.lampCount5
        seiyaMemory3.lampCount6 = seiya.lampCount6
        seiyaMemory3.lampCountSum = seiya.lampCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct seiyaSubViewLoadMemory: View {
    @ObservedObject var seiya: Seiya
    @ObservedObject var seiyaMemory1: SeiyaMemory1
    @ObservedObject var seiyaMemory2: SeiyaMemory2
    @ObservedObject var seiyaMemory3: SeiyaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: seiya.machineName,
            selectedMemory: $seiya.selectedMemory,
            memoMemory1: seiyaMemory1.memo,
            dateDoubleMemory1: seiyaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: seiyaMemory2.memo,
            dateDoubleMemory2: seiyaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: seiyaMemory3.memo,
            dateDoubleMemory3: seiyaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let gameArrayDecoded = decodeIntArray(from: seiyaMemory1.gameArrayData)
        saveArray(gameArrayDecoded, forKey: seiya.gameArrayKey)
        let czKindArrayDecoded = decodeStringArray(from: seiyaMemory1.czKindArrayData)
        saveArray(czKindArrayDecoded, forKey: seiya.czKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: seiyaMemory1.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: seiya.atResultArrayKey)
        seiya.playGameSum = seiyaMemory1.playGameSum
        seiya.firstHitCountCz = seiyaMemory1.firstHitCountCz
        seiya.firstHitCountAt = seiyaMemory1.firstHitCountAt
        seiya.firstHitInputMode = seiyaMemory1.firstHitInputMode
        seiya.manualNormalGame = seiyaMemory1.manualNormalGame
        seiya.manualFirstHitCountCz = seiyaMemory1.manualFirstHitCountCz
        seiya.manualFirstHitCountAt = seiyaMemory1.manualFirstHitCountAt
        seiya.opponentCount1 = seiyaMemory1.opponentCount1
        seiya.opponentCount2 = seiyaMemory1.opponentCount2
        seiya.opponentCount3 = seiyaMemory1.opponentCount3
        seiya.opponentCountSum = seiyaMemory1.opponentCountSum
        seiya.charaCount1 = seiyaMemory1.charaCount1
        seiya.charaCount2 = seiyaMemory1.charaCount2
        seiya.charaCount3 = seiyaMemory1.charaCount3
        seiya.charaCountSum = seiyaMemory1.charaCountSum
        seiya.screenCount1 = seiyaMemory1.screenCount1
        seiya.screenCount2 = seiyaMemory1.screenCount2
        seiya.screenCount3 = seiyaMemory1.screenCount3
        seiya.screenCount4 = seiyaMemory1.screenCount4
        seiya.screenCount5 = seiyaMemory1.screenCount5
        seiya.screenCount6 = seiyaMemory1.screenCount6
        seiya.screenCount7 = seiyaMemory1.screenCount7
        seiya.screenCount8 = seiyaMemory1.screenCount8
        seiya.screenCountSum = seiyaMemory1.screenCountSum
        seiya.lampCount1 = seiyaMemory1.lampCount1
        seiya.lampCount2 = seiyaMemory1.lampCount2
        seiya.lampCount3 = seiyaMemory1.lampCount3
        seiya.lampCount4 = seiyaMemory1.lampCount4
        seiya.lampCount5 = seiyaMemory1.lampCount5
        seiya.lampCount6 = seiyaMemory1.lampCount6
        seiya.lampCountSum = seiyaMemory1.lampCountSum
    }
    func loadMemory2() {
        let gameArrayDecoded = decodeIntArray(from: seiyaMemory2.gameArrayData)
        saveArray(gameArrayDecoded, forKey: seiya.gameArrayKey)
        let czKindArrayDecoded = decodeStringArray(from: seiyaMemory2.czKindArrayData)
        saveArray(czKindArrayDecoded, forKey: seiya.czKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: seiyaMemory2.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: seiya.atResultArrayKey)
        seiya.playGameSum = seiyaMemory2.playGameSum
        seiya.firstHitCountCz = seiyaMemory2.firstHitCountCz
        seiya.firstHitCountAt = seiyaMemory2.firstHitCountAt
        seiya.firstHitInputMode = seiyaMemory2.firstHitInputMode
        seiya.manualNormalGame = seiyaMemory2.manualNormalGame
        seiya.manualFirstHitCountCz = seiyaMemory2.manualFirstHitCountCz
        seiya.manualFirstHitCountAt = seiyaMemory2.manualFirstHitCountAt
        seiya.opponentCount1 = seiyaMemory2.opponentCount1
        seiya.opponentCount2 = seiyaMemory2.opponentCount2
        seiya.opponentCount3 = seiyaMemory2.opponentCount3
        seiya.opponentCountSum = seiyaMemory2.opponentCountSum
        seiya.charaCount1 = seiyaMemory2.charaCount1
        seiya.charaCount2 = seiyaMemory2.charaCount2
        seiya.charaCount3 = seiyaMemory2.charaCount3
        seiya.charaCountSum = seiyaMemory2.charaCountSum
        seiya.screenCount1 = seiyaMemory2.screenCount1
        seiya.screenCount2 = seiyaMemory2.screenCount2
        seiya.screenCount3 = seiyaMemory2.screenCount3
        seiya.screenCount4 = seiyaMemory2.screenCount4
        seiya.screenCount5 = seiyaMemory2.screenCount5
        seiya.screenCount6 = seiyaMemory2.screenCount6
        seiya.screenCount7 = seiyaMemory2.screenCount7
        seiya.screenCount8 = seiyaMemory2.screenCount8
        seiya.screenCountSum = seiyaMemory2.screenCountSum
        seiya.lampCount1 = seiyaMemory2.lampCount1
        seiya.lampCount2 = seiyaMemory2.lampCount2
        seiya.lampCount3 = seiyaMemory2.lampCount3
        seiya.lampCount4 = seiyaMemory2.lampCount4
        seiya.lampCount5 = seiyaMemory2.lampCount5
        seiya.lampCount6 = seiyaMemory2.lampCount6
        seiya.lampCountSum = seiyaMemory2.lampCountSum
    }
    func loadMemory3() {
        let gameArrayDecoded = decodeIntArray(from: seiyaMemory3.gameArrayData)
        saveArray(gameArrayDecoded, forKey: seiya.gameArrayKey)
        let czKindArrayDecoded = decodeStringArray(from: seiyaMemory3.czKindArrayData)
        saveArray(czKindArrayDecoded, forKey: seiya.czKindArrayKey)
        let atResultArrayDecoded = decodeStringArray(from: seiyaMemory3.atResultArrayData)
        saveArray(atResultArrayDecoded, forKey: seiya.atResultArrayKey)
        seiya.playGameSum = seiyaMemory3.playGameSum
        seiya.firstHitCountCz = seiyaMemory3.firstHitCountCz
        seiya.firstHitCountAt = seiyaMemory3.firstHitCountAt
        seiya.firstHitInputMode = seiyaMemory3.firstHitInputMode
        seiya.manualNormalGame = seiyaMemory3.manualNormalGame
        seiya.manualFirstHitCountCz = seiyaMemory3.manualFirstHitCountCz
        seiya.manualFirstHitCountAt = seiyaMemory3.manualFirstHitCountAt
        seiya.opponentCount1 = seiyaMemory3.opponentCount1
        seiya.opponentCount2 = seiyaMemory3.opponentCount2
        seiya.opponentCount3 = seiyaMemory3.opponentCount3
        seiya.opponentCountSum = seiyaMemory3.opponentCountSum
        seiya.charaCount1 = seiyaMemory3.charaCount1
        seiya.charaCount2 = seiyaMemory3.charaCount2
        seiya.charaCount3 = seiyaMemory3.charaCount3
        seiya.charaCountSum = seiyaMemory3.charaCountSum
        seiya.screenCount1 = seiyaMemory3.screenCount1
        seiya.screenCount2 = seiyaMemory3.screenCount2
        seiya.screenCount3 = seiyaMemory3.screenCount3
        seiya.screenCount4 = seiyaMemory3.screenCount4
        seiya.screenCount5 = seiyaMemory3.screenCount5
        seiya.screenCount6 = seiyaMemory3.screenCount6
        seiya.screenCount7 = seiyaMemory3.screenCount7
        seiya.screenCount8 = seiyaMemory3.screenCount8
        seiya.screenCountSum = seiyaMemory3.screenCountSum
        seiya.lampCount1 = seiyaMemory3.lampCount1
        seiya.lampCount2 = seiyaMemory3.lampCount2
        seiya.lampCount3 = seiyaMemory3.lampCount3
        seiya.lampCount4 = seiyaMemory3.lampCount4
        seiya.lampCount5 = seiyaMemory3.lampCount5
        seiya.lampCount6 = seiyaMemory3.lampCount6
        seiya.lampCountSum = seiyaMemory3.lampCountSum
    }
}

#Preview {
    seiyaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
