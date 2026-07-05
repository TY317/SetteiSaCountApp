//
//  otome5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import SwiftUI

struct otome5ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var otome5 = Otome5()
    @State var isShowAlert: Bool = false
    @StateObject var otome5Memory1 = Otome5Memory1()
    @StateObject var otome5Memory2 = Otome5Memory2()
    @StateObject var otome5Memory3 = Otome5Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: otome5.machineName,
//                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: otome5ViewNormal(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.otome5MenuNormalBadge,
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: otome5ViewHistory(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "周期履歴メモ",
                            badgeStatus: common.otome5MenuHistoryBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: otome5ViewFirstHit(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.otome5MenuFirstHitBadge,
                        )
                    }

//                    // フィギュアコレクション
//                    NavigationLink(destination: otome5ViewFigure(
//                        otome5: otome5,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "figure.stand",
//                            textBody: "フィギュアコレクション",
//                            badgeStatus: common.otome5MenuFigureBadge,
//                        )
//                    }

                    // 出陣ボーナス終了画面
                    NavigationLink(destination: otome5ViewScreen(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "出陣ボーナス終了画面",
                            badgeStatus: common.otome5MenuScreenBadge,
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: otome5ViewAtScreen(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.otome5MenuAtScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: otome5ViewEnding(
                        otome5: otome5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.otome5MenuEndingBadge,
                        )
                    }

//                    // おみくじ
//                    NavigationLink(destination: otome5ViewOmikuji(
//                        otome5: otome5,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.otome5MenuOmikujiBadge,
//                        )
//                    }
//
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: otome5.machineName,
//                        titleFont: .title,
//                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: otome5View95Ci(
                    otome5: otome5,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: otome5ViewBayes(
                    otome5: otome5,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.otome5MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5009")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©HEIWA")
                    Text("Character design by SHIROGUMI INC.")
                }
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($common.otome5MachineIconBadge)
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5009")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(otome5SubViewLoadMemory(
                    otome5: otome5,
                    otome5Memory1: otome5Memory1,
                    otome5Memory2: otome5Memory2,
                    otome5Memory3: otome5Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(otome5SubViewSaveMemory(
                    otome5: otome5,
                    otome5Memory1: otome5Memory1,
                    otome5Memory2: otome5Memory2,
                    otome5Memory3: otome5Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: otome5.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct otome5SubViewSaveMemory: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var otome5Memory1: Otome5Memory1
    @ObservedObject var otome5Memory2: Otome5Memory2
    @ObservedObject var otome5Memory3: Otome5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: otome5.machineName,
            selectedMemory: $otome5.selectedMemory,
            memoMemory1: $otome5Memory1.memo,
            dateDoubleMemory1: $otome5Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $otome5Memory2.memo,
            dateDoubleMemory2: $otome5Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $otome5Memory3.memo,
            dateDoubleMemory3: $otome5Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        otome5Memory1.otomeAttackMiss = otome5.otomeAttackMiss
        otome5Memory1.otomeAttackHit = otome5.otomeAttackHit
        otome5Memory1.otomeAttackSum = otome5.otomeAttackSum
        otome5Memory1.gameArrayData = otome5.gameArrayData
        otome5Memory1.cycleArrayData = otome5.cycleArrayData
        otome5Memory1.kindArrayData = otome5.kindArrayData
        otome5Memory1.normalGame = otome5.normalGame
        otome5Memory1.firstHitCountAt = otome5.firstHitCountAt
        otome5Memory1.firstHitCountDirect = otome5.firstHitCountDirect
        otome5Memory1.screenCountDefaut = otome5.screenCountDefaut
        otome5Memory1.screenCountOver2 = otome5.screenCountOver2
        otome5Memory1.screenCountOver3 = otome5.screenCountOver3
        otome5Memory1.screenCountOver4 = otome5.screenCountOver4
        otome5Memory1.screenCountOver5 = otome5.screenCountOver5
        otome5Memory1.screenCountOver6 = otome5.screenCountOver6
        otome5Memory1.screenCountSum = otome5.screenCountSum
    }
    func saveMemory2() {
        otome5Memory2.otomeAttackMiss = otome5.otomeAttackMiss
        otome5Memory2.otomeAttackHit = otome5.otomeAttackHit
        otome5Memory2.otomeAttackSum = otome5.otomeAttackSum
        otome5Memory2.gameArrayData = otome5.gameArrayData
        otome5Memory2.cycleArrayData = otome5.cycleArrayData
        otome5Memory2.kindArrayData = otome5.kindArrayData
        otome5Memory2.normalGame = otome5.normalGame
        otome5Memory2.firstHitCountAt = otome5.firstHitCountAt
        otome5Memory2.firstHitCountDirect = otome5.firstHitCountDirect
        otome5Memory2.screenCountDefaut = otome5.screenCountDefaut
        otome5Memory2.screenCountOver2 = otome5.screenCountOver2
        otome5Memory2.screenCountOver3 = otome5.screenCountOver3
        otome5Memory2.screenCountOver4 = otome5.screenCountOver4
        otome5Memory2.screenCountOver5 = otome5.screenCountOver5
        otome5Memory2.screenCountOver6 = otome5.screenCountOver6
        otome5Memory2.screenCountSum = otome5.screenCountSum
    }
    func saveMemory3() {
        otome5Memory3.otomeAttackMiss = otome5.otomeAttackMiss
        otome5Memory3.otomeAttackHit = otome5.otomeAttackHit
        otome5Memory3.otomeAttackSum = otome5.otomeAttackSum
        otome5Memory3.gameArrayData = otome5.gameArrayData
        otome5Memory3.cycleArrayData = otome5.cycleArrayData
        otome5Memory3.kindArrayData = otome5.kindArrayData
        otome5Memory3.normalGame = otome5.normalGame
        otome5Memory3.firstHitCountAt = otome5.firstHitCountAt
        otome5Memory3.firstHitCountDirect = otome5.firstHitCountDirect
        otome5Memory3.screenCountDefaut = otome5.screenCountDefaut
        otome5Memory3.screenCountOver2 = otome5.screenCountOver2
        otome5Memory3.screenCountOver3 = otome5.screenCountOver3
        otome5Memory3.screenCountOver4 = otome5.screenCountOver4
        otome5Memory3.screenCountOver5 = otome5.screenCountOver5
        otome5Memory3.screenCountOver6 = otome5.screenCountOver6
        otome5Memory3.screenCountSum = otome5.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct otome5SubViewLoadMemory: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var otome5Memory1: Otome5Memory1
    @ObservedObject var otome5Memory2: Otome5Memory2
    @ObservedObject var otome5Memory3: Otome5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: otome5.machineName,
            selectedMemory: $otome5.selectedMemory,
            memoMemory1: otome5Memory1.memo,
            dateDoubleMemory1: otome5Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: otome5Memory2.memo,
            dateDoubleMemory2: otome5Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: otome5Memory3.memo,
            dateDoubleMemory3: otome5Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        otome5.otomeAttackMiss = otome5Memory1.otomeAttackMiss
        otome5.otomeAttackHit = otome5Memory1.otomeAttackHit
        otome5.otomeAttackSum = otome5Memory1.otomeAttackSum
        let array = decodeIntArray(from: otome5Memory1.cycleArrayData)
        let array2 = decodeIntArray(from: otome5Memory1.gameArrayData)
        let array3 = decodeStringArray(from: otome5Memory1.kindArrayData)
        saveArray(array2, forKey: otome5.gameArrayKey)
        saveArray(array, forKey: otome5.cycleArrayKey)
        saveArray(array3, forKey: otome5.kindArrayKey)
//        otome5.gameArrayData = otome5Memory1.gameArrayData
//        otome5.cycleArrayData = otome5Memory1.cycleArrayData
//        otome5.kindArrayData = otome5Memory1.kindArrayData
        otome5.normalGame = otome5Memory1.normalGame
        otome5.firstHitCountAt = otome5Memory1.firstHitCountAt
        otome5.firstHitCountDirect = otome5Memory1.firstHitCountDirect
        otome5.screenCountDefaut = otome5Memory1.screenCountDefaut
        otome5.screenCountOver2 = otome5Memory1.screenCountOver2
        otome5.screenCountOver3 = otome5Memory1.screenCountOver3
        otome5.screenCountOver4 = otome5Memory1.screenCountOver4
        otome5.screenCountOver5 = otome5Memory1.screenCountOver5
        otome5.screenCountOver6 = otome5Memory1.screenCountOver6
        otome5.screenCountSum = otome5Memory1.screenCountSum
    }
    func loadMemory2() {
        otome5.otomeAttackMiss = otome5Memory2.otomeAttackMiss
        otome5.otomeAttackHit = otome5Memory2.otomeAttackHit
        otome5.otomeAttackSum = otome5Memory2.otomeAttackSum
        let array = decodeIntArray(from: otome5Memory2.cycleArrayData)
        let array2 = decodeIntArray(from: otome5Memory2.gameArrayData)
        let array3 = decodeStringArray(from: otome5Memory2.kindArrayData)
        saveArray(array2, forKey: otome5.gameArrayKey)
        saveArray(array, forKey: otome5.cycleArrayKey)
        saveArray(array3, forKey: otome5.kindArrayKey)
//        otome5.gameArrayData = otome5Memory2.gameArrayData
//        otome5.cycleArrayData = otome5Memory2.cycleArrayData
//        otome5.kindArrayData = otome5Memory2.kindArrayData
        otome5.normalGame = otome5Memory2.normalGame
        otome5.firstHitCountAt = otome5Memory2.firstHitCountAt
        otome5.firstHitCountDirect = otome5Memory2.firstHitCountDirect
        otome5.screenCountDefaut = otome5Memory2.screenCountDefaut
        otome5.screenCountOver2 = otome5Memory2.screenCountOver2
        otome5.screenCountOver3 = otome5Memory2.screenCountOver3
        otome5.screenCountOver4 = otome5Memory2.screenCountOver4
        otome5.screenCountOver5 = otome5Memory2.screenCountOver5
        otome5.screenCountOver6 = otome5Memory2.screenCountOver6
        otome5.screenCountSum = otome5Memory2.screenCountSum
    }
    func loadMemory3() {
        otome5.otomeAttackMiss = otome5Memory3.otomeAttackMiss
        otome5.otomeAttackHit = otome5Memory3.otomeAttackHit
        otome5.otomeAttackSum = otome5Memory3.otomeAttackSum
        let array = decodeIntArray(from: otome5Memory3.cycleArrayData)
        let array2 = decodeIntArray(from: otome5Memory3.gameArrayData)
        let array3 = decodeStringArray(from: otome5Memory3.kindArrayData)
        saveArray(array2, forKey: otome5.gameArrayKey)
        saveArray(array, forKey: otome5.cycleArrayKey)
        saveArray(array3, forKey: otome5.kindArrayKey)
//        otome5.gameArrayData = otome5Memory3.gameArrayData
//        otome5.cycleArrayData = otome5Memory3.cycleArrayData
//        otome5.kindArrayData = otome5Memory3.kindArrayData
        otome5.normalGame = otome5Memory3.normalGame
        otome5.firstHitCountAt = otome5Memory3.firstHitCountAt
        otome5.firstHitCountDirect = otome5Memory3.firstHitCountDirect
        otome5.screenCountDefaut = otome5Memory3.screenCountDefaut
        otome5.screenCountOver2 = otome5Memory3.screenCountOver2
        otome5.screenCountOver3 = otome5Memory3.screenCountOver3
        otome5.screenCountOver4 = otome5Memory3.screenCountOver4
        otome5.screenCountOver5 = otome5Memory3.screenCountOver5
        otome5.screenCountOver6 = otome5Memory3.screenCountOver6
        otome5.screenCountSum = otome5Memory3.screenCountSum
    }
}

#Preview {
    otome5ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
