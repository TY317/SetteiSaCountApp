//
//  rioAceViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/02.
//

import SwiftUI

struct rioAceViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var rioAce = RioAce()
    @State var isShowAlert: Bool = false
    @StateObject var rioAceMemory1 = RioAceMemory1()
    @StateObject var rioAceMemory2 = RioAceMemory2()
    @StateObject var rioAceMemory3 = RioAceMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: rioAce.machineName,
//                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: rioAceViewNormal(
                        rioAce: rioAce,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.rioAceMenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: rioAceViewCz(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.rioAceMenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
                    NavigationLink(destination: rioAceViewFirstHit(
                        rioAce: rioAce,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.rioAceMenuFirstHitBadge,
                        )
                    }
                    
//                    // REG
//                    NavigationLink(destination: rioAceViewReg(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "person.2.fill",
//                            textBody: "REG",
//                            badgeStatus: common.rioAceMenuRegBadge,
//                        )
//                    }
//
                    // AT終了画面
                    NavigationLink(destination: rioAceViewScreen(
                        rioAce: rioAce,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signature",
                            textBody: "ボーナス・AT終了画面",
                            badgeStatus: common.rioAceMenuScreenBadge,
                        )
                    }

//                    // エンディング
//                    NavigationLink(destination: rioAceViewEnding(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.rioAceMenuEndingBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: rioAceViewOmikuji(
//                        rioAce: rioAce,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.rioAceMenuOmikujiBadge,
//                        )
//                    }
//
                    // ケロッとトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: rioAceView95Ci(
                    rioAce: rioAce,
                    selection: 4,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: rioAceViewBayes(
                    rioAce: rioAce,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.rioAceMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4984")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©コーエーテクモウェーブ All rights reserved.")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($common.rioAceMachineIconBadge)
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4984")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(rioAceSubViewLoadMemory(
                    rioAce: rioAce,
                    rioAceMemory1: rioAceMemory1,
                    rioAceMemory2: rioAceMemory2,
                    rioAceMemory3: rioAceMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(rioAceSubViewSaveMemory(
                    rioAce: rioAce,
                    rioAceMemory1: rioAceMemory1,
                    rioAceMemory2: rioAceMemory2,
                    rioAceMemory3: rioAceMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: rioAce.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct rioAceSubViewSaveMemory: View {
    @ObservedObject var rioAce: RioAce
    @ObservedObject var rioAceMemory1: RioAceMemory1
    @ObservedObject var rioAceMemory2: RioAceMemory2
    @ObservedObject var rioAceMemory3: RioAceMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: rioAce.machineName,
            selectedMemory: $rioAce.selectedMemory,
            memoMemory1: $rioAceMemory1.memo,
            dateDoubleMemory1: $rioAceMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $rioAceMemory2.memo,
            dateDoubleMemory2: $rioAceMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $rioAceMemory3.memo,
            dateDoubleMemory3: $rioAceMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        rioAceMemory1.kiteiReplay = rioAce.kiteiReplay
        rioAceMemory1.kiteiReplayHit = rioAce.kiteiReplayHit
        rioAceMemory1.normalGame = rioAce.normalGame
        rioAceMemory1.firstHitCountNoirRoom = rioAce.firstHitCountNoirRoom
        rioAceMemory1.firstHitCountDirectBonus = rioAce.firstHitCountDirectBonus
        rioAceMemory1.firstHitCountWithoutDirect = rioAce.firstHitCountWithoutDirect
        rioAceMemory1.screenCountNone = rioAce.screenCountNone
        rioAceMemory1.screenCountRio = rioAce.screenCountRio
        rioAceMemory1.screenCountMint = rioAce.screenCountMint
        rioAceMemory1.screenCountRina = rioAce.screenCountRina
        rioAceMemory1.screenCountSum = rioAce.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAceMemory1.aceModeCountMiss = rioAce.aceModeCountMiss
        rioAceMemory1.aceModeCountHit = rioAce.aceModeCountHit
        rioAceMemory1.aceModeCountSum = rioAce.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAceMemory1.suikaCount = rioAce.suikaCount
        rioAceMemory1.roomSuccessCount = rioAce.roomSuccessCount
        rioAceMemory1.duringRoomSuikaCountMemo = rioAce.duringRoomSuikaCountMemo
    }
    func saveMemory2() {
        rioAceMemory2.kiteiReplay = rioAce.kiteiReplay
        rioAceMemory2.kiteiReplayHit = rioAce.kiteiReplayHit
        rioAceMemory2.normalGame = rioAce.normalGame
        rioAceMemory2.firstHitCountNoirRoom = rioAce.firstHitCountNoirRoom
        rioAceMemory2.firstHitCountDirectBonus = rioAce.firstHitCountDirectBonus
        rioAceMemory2.firstHitCountWithoutDirect = rioAce.firstHitCountWithoutDirect
        rioAceMemory2.screenCountNone = rioAce.screenCountNone
        rioAceMemory2.screenCountRio = rioAce.screenCountRio
        rioAceMemory2.screenCountMint = rioAce.screenCountMint
        rioAceMemory2.screenCountRina = rioAce.screenCountRina
        rioAceMemory2.screenCountSum = rioAce.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAceMemory2.aceModeCountMiss = rioAce.aceModeCountMiss
        rioAceMemory2.aceModeCountHit = rioAce.aceModeCountHit
        rioAceMemory2.aceModeCountSum = rioAce.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAceMemory2.suikaCount = rioAce.suikaCount
        rioAceMemory2.roomSuccessCount = rioAce.roomSuccessCount
        rioAceMemory2.duringRoomSuikaCountMemo = rioAce.duringRoomSuikaCountMemo
    }
    func saveMemory3() {
        rioAceMemory3.kiteiReplay = rioAce.kiteiReplay
        rioAceMemory3.kiteiReplayHit = rioAce.kiteiReplayHit
        rioAceMemory3.normalGame = rioAce.normalGame
        rioAceMemory3.firstHitCountNoirRoom = rioAce.firstHitCountNoirRoom
        rioAceMemory3.firstHitCountDirectBonus = rioAce.firstHitCountDirectBonus
        rioAceMemory3.firstHitCountWithoutDirect = rioAce.firstHitCountWithoutDirect
        rioAceMemory3.screenCountNone = rioAce.screenCountNone
        rioAceMemory3.screenCountRio = rioAce.screenCountRio
        rioAceMemory3.screenCountMint = rioAce.screenCountMint
        rioAceMemory3.screenCountRina = rioAce.screenCountRina
        rioAceMemory3.screenCountSum = rioAce.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAceMemory3.aceModeCountMiss = rioAce.aceModeCountMiss
        rioAceMemory3.aceModeCountHit = rioAce.aceModeCountHit
        rioAceMemory3.aceModeCountSum = rioAce.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAceMemory3.suikaCount = rioAce.suikaCount
        rioAceMemory3.roomSuccessCount = rioAce.roomSuccessCount
        rioAceMemory3.duringRoomSuikaCountMemo = rioAce.duringRoomSuikaCountMemo
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct rioAceSubViewLoadMemory: View {
    @ObservedObject var rioAce: RioAce
    @ObservedObject var rioAceMemory1: RioAceMemory1
    @ObservedObject var rioAceMemory2: RioAceMemory2
    @ObservedObject var rioAceMemory3: RioAceMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: rioAce.machineName,
            selectedMemory: $rioAce.selectedMemory,
            memoMemory1: rioAceMemory1.memo,
            dateDoubleMemory1: rioAceMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: rioAceMemory2.memo,
            dateDoubleMemory2: rioAceMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: rioAceMemory3.memo,
            dateDoubleMemory3: rioAceMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        rioAce.kiteiReplay = rioAceMemory1.kiteiReplay
        rioAce.kiteiReplayHit = rioAceMemory1.kiteiReplayHit
        rioAce.normalGame = rioAceMemory1.normalGame
        rioAce.firstHitCountNoirRoom = rioAceMemory1.firstHitCountNoirRoom
        rioAce.firstHitCountDirectBonus = rioAceMemory1.firstHitCountDirectBonus
        rioAce.firstHitCountWithoutDirect = rioAceMemory1.firstHitCountWithoutDirect
        rioAce.screenCountNone = rioAceMemory1.screenCountNone
        rioAce.screenCountRio = rioAceMemory1.screenCountRio
        rioAce.screenCountMint = rioAceMemory1.screenCountMint
        rioAce.screenCountRina = rioAceMemory1.screenCountRina
        rioAce.screenCountSum = rioAceMemory1.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAce.aceModeCountMiss = rioAceMemory1.aceModeCountMiss
        rioAce.aceModeCountHit = rioAceMemory1.aceModeCountHit
        rioAce.aceModeCountSum = rioAceMemory1.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAce.suikaCount = rioAceMemory1.suikaCount
        rioAce.roomSuccessCount = rioAceMemory1.roomSuccessCount
        rioAce.duringRoomSuikaCountMemo = rioAceMemory1.duringRoomSuikaCountMemo
    }
    func loadMemory2() {
        rioAce.kiteiReplay = rioAceMemory2.kiteiReplay
        rioAce.kiteiReplayHit = rioAceMemory2.kiteiReplayHit
        rioAce.normalGame = rioAceMemory2.normalGame
        rioAce.firstHitCountNoirRoom = rioAceMemory2.firstHitCountNoirRoom
        rioAce.firstHitCountDirectBonus = rioAceMemory2.firstHitCountDirectBonus
        rioAce.firstHitCountWithoutDirect = rioAceMemory2.firstHitCountWithoutDirect
        rioAce.screenCountNone = rioAceMemory2.screenCountNone
        rioAce.screenCountRio = rioAceMemory2.screenCountRio
        rioAce.screenCountMint = rioAceMemory2.screenCountMint
        rioAce.screenCountRina = rioAceMemory2.screenCountRina
        rioAce.screenCountSum = rioAceMemory2.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAce.aceModeCountMiss = rioAceMemory2.aceModeCountMiss
        rioAce.aceModeCountHit = rioAceMemory2.aceModeCountHit
        rioAce.aceModeCountSum = rioAceMemory2.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAce.suikaCount = rioAceMemory2.suikaCount
        rioAce.roomSuccessCount = rioAceMemory2.roomSuccessCount
        rioAce.duringRoomSuikaCountMemo = rioAceMemory2.duringRoomSuikaCountMemo
    }
    func loadMemory3() {
        rioAce.kiteiReplay = rioAceMemory3.kiteiReplay
        rioAce.kiteiReplayHit = rioAceMemory3.kiteiReplayHit
        rioAce.normalGame = rioAceMemory3.normalGame
        rioAce.firstHitCountNoirRoom = rioAceMemory3.firstHitCountNoirRoom
        rioAce.firstHitCountDirectBonus = rioAceMemory3.firstHitCountDirectBonus
        rioAce.firstHitCountWithoutDirect = rioAceMemory3.firstHitCountWithoutDirect
        rioAce.screenCountNone = rioAceMemory3.screenCountNone
        rioAce.screenCountRio = rioAceMemory3.screenCountRio
        rioAce.screenCountMint = rioAceMemory3.screenCountMint
        rioAce.screenCountRina = rioAceMemory3.screenCountRina
        rioAce.screenCountSum = rioAceMemory3.screenCountSum
        
        // ------------
        // ver3.27.1
        // ------------
        rioAce.aceModeCountMiss = rioAceMemory3.aceModeCountMiss
        rioAce.aceModeCountHit = rioAceMemory3.aceModeCountHit
        rioAce.aceModeCountSum = rioAceMemory3.aceModeCountSum
        
        // -------
        // ver4.0.0
        // -------
        rioAce.suikaCount = rioAceMemory3.suikaCount
        rioAce.roomSuccessCount = rioAceMemory3.roomSuccessCount
        rioAce.duringRoomSuikaCountMemo = rioAceMemory3.duringRoomSuikaCountMemo
    }
}

#Preview {
    rioAceViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
