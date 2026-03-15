//
//  thunderViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import SwiftUI

struct thunderViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var thunder = Thunder()
    @State var isShowAlert: Bool = false
    @StateObject var thunderMemory1 = ThunderMemory1()
    @StateObject var thunderMemory2 = ThunderMemory2()
    @StateObject var thunderMemory3 = ThunderMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: thunder.machineName)
                }
                
                Section {
                    // 打ち始めデータ入力
                    NavigationLink(destination: thunderViewStart(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ入力",
                            badgeStatus: common.thunderMenuStartBadge,
                        )
                    }
                    
                    // プレイデータ入力
                    NavigationLink(destination: thunderViewPlay(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "ユニメモデータ入力",
                            badgeStatus: common.thunderMenuPlayBadge,
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: thunderViewScreen(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.thunderMenuScreenBadge,
                        )
                    }
//                    
//                    // おみくじ
//                    NavigationLink(destination: thunderViewOmikuji(
//                        thunder: thunder,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.thunderMenuOmikujiBadge,
//                        )
//                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: thunderView95Ci(
                    thunder: thunder,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: thunderViewBayes(
                    thunder: thunder,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.thunderMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4943")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(thunderSubViewLoadMemory(
                    thunder: thunder,
                    thunderMemory1: thunderMemory1,
                    thunderMemory2: thunderMemory2,
                    thunderMemory3: thunderMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(thunderSubViewSaveMemory(
                    thunder: thunder,
                    thunderMemory1: thunderMemory1,
                    thunderMemory2: thunderMemory2,
                    thunderMemory3: thunderMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: thunder.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct thunderSubViewSaveMemory: View {
    @ObservedObject var thunder: Thunder
    @ObservedObject var thunderMemory1: ThunderMemory1
    @ObservedObject var thunderMemory2: ThunderMemory2
    @ObservedObject var thunderMemory3: ThunderMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: thunder.machineName,
            selectedMemory: $thunder.selectedMemory,
            memoMemory1: $thunderMemory1.memo,
            dateDoubleMemory1: $thunderMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $thunderMemory2.memo,
            dateDoubleMemory2: $thunderMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $thunderMemory3.memo,
            dateDoubleMemory3: $thunderMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        thunderMemory1.startGame = thunder.startGame
        thunderMemory1.startBig = thunder.startBig
        thunderMemory1.startReg = thunder.startReg
        thunderMemory1.playGame = thunder.playGame
        thunderMemory1.totalGame = thunder.totalGame
        thunderMemory1.normalKoyakuCountBellA = thunder.normalKoyakuCountBellA
        thunderMemory1.normalKoyakuCountBellB = thunder.normalKoyakuCountBellB
        thunderMemory1.normalKoyakuCountBellSum = thunder.normalKoyakuCountBellSum
        thunderMemory1.normalKoyakuCountSuika = thunder.normalKoyakuCountSuika
        thunderMemory1.normalKoyakuCountCherryB = thunder.normalKoyakuCountCherryB
        thunderMemory1.playBig = thunder.playBig
        thunderMemory1.playReg = thunder.playReg
        thunderMemory1.totalBig = thunder.totalBig
        thunderMemory1.totalReg = thunder.totalReg
        thunderMemory1.btRedSeven = thunder.btRedSeven
        thunderMemory1.bbCountBellC = thunder.bbCountBellC
        thunderMemory1.bbCountBellB = thunder.bbCountBellB
        thunderMemory1.bbGame = thunder.bbGame
        thunderMemory1.bbCountReach = thunder.bbCountReach
    }
    func saveMemory2() {
        thunderMemory2.startGame = thunder.startGame
        thunderMemory2.startBig = thunder.startBig
        thunderMemory2.startReg = thunder.startReg
        thunderMemory2.playGame = thunder.playGame
        thunderMemory2.totalGame = thunder.totalGame
        thunderMemory2.normalKoyakuCountBellA = thunder.normalKoyakuCountBellA
        thunderMemory2.normalKoyakuCountBellB = thunder.normalKoyakuCountBellB
        thunderMemory2.normalKoyakuCountBellSum = thunder.normalKoyakuCountBellSum
        thunderMemory2.normalKoyakuCountSuika = thunder.normalKoyakuCountSuika
        thunderMemory2.normalKoyakuCountCherryB = thunder.normalKoyakuCountCherryB
        thunderMemory2.playBig = thunder.playBig
        thunderMemory2.playReg = thunder.playReg
        thunderMemory2.totalBig = thunder.totalBig
        thunderMemory2.totalReg = thunder.totalReg
        thunderMemory2.btRedSeven = thunder.btRedSeven
        thunderMemory2.bbCountBellC = thunder.bbCountBellC
        thunderMemory2.bbCountBellB = thunder.bbCountBellB
        thunderMemory2.bbGame = thunder.bbGame
        thunderMemory2.bbCountReach = thunder.bbCountReach
    }
    func saveMemory3() {
        thunderMemory3.startGame = thunder.startGame
        thunderMemory3.startBig = thunder.startBig
        thunderMemory3.startReg = thunder.startReg
        thunderMemory3.playGame = thunder.playGame
        thunderMemory3.totalGame = thunder.totalGame
        thunderMemory3.normalKoyakuCountBellA = thunder.normalKoyakuCountBellA
        thunderMemory3.normalKoyakuCountBellB = thunder.normalKoyakuCountBellB
        thunderMemory3.normalKoyakuCountBellSum = thunder.normalKoyakuCountBellSum
        thunderMemory3.normalKoyakuCountSuika = thunder.normalKoyakuCountSuika
        thunderMemory3.normalKoyakuCountCherryB = thunder.normalKoyakuCountCherryB
        thunderMemory3.playBig = thunder.playBig
        thunderMemory3.playReg = thunder.playReg
        thunderMemory3.totalBig = thunder.totalBig
        thunderMemory3.totalReg = thunder.totalReg
        thunderMemory3.btRedSeven = thunder.btRedSeven
        thunderMemory3.bbCountBellC = thunder.bbCountBellC
        thunderMemory3.bbCountBellB = thunder.bbCountBellB
        thunderMemory3.bbGame = thunder.bbGame
        thunderMemory3.bbCountReach = thunder.bbCountReach
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct thunderSubViewLoadMemory: View {
    @ObservedObject var thunder: Thunder
    @ObservedObject var thunderMemory1: ThunderMemory1
    @ObservedObject var thunderMemory2: ThunderMemory2
    @ObservedObject var thunderMemory3: ThunderMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: thunder.machineName,
            selectedMemory: $thunder.selectedMemory,
            memoMemory1: thunderMemory1.memo,
            dateDoubleMemory1: thunderMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: thunderMemory2.memo,
            dateDoubleMemory2: thunderMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: thunderMemory3.memo,
            dateDoubleMemory3: thunderMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        thunder.startGame = thunderMemory1.startGame
        thunder.startBig = thunderMemory1.startBig
        thunder.startReg = thunderMemory1.startReg
        thunder.playGame = thunderMemory1.playGame
        thunder.totalGame = thunderMemory1.totalGame
        thunder.normalKoyakuCountBellA = thunderMemory1.normalKoyakuCountBellA
        thunder.normalKoyakuCountBellB = thunderMemory1.normalKoyakuCountBellB
        thunder.normalKoyakuCountBellSum = thunderMemory1.normalKoyakuCountBellSum
        thunder.normalKoyakuCountSuika = thunderMemory1.normalKoyakuCountSuika
        thunder.normalKoyakuCountCherryB = thunderMemory1.normalKoyakuCountCherryB
        thunder.playBig = thunderMemory1.playBig
        thunder.playReg = thunderMemory1.playReg
        thunder.totalBig = thunderMemory1.totalBig
        thunder.totalReg = thunderMemory1.totalReg
        thunder.btRedSeven = thunderMemory1.btRedSeven
        thunder.bbCountBellC = thunderMemory1.bbCountBellC
        thunder.bbCountBellB = thunderMemory1.bbCountBellB
        thunder.bbGame = thunderMemory1.bbGame
        thunder.bbCountReach = thunderMemory1.bbCountReach
    }
    func loadMemory2() {
        thunder.startGame = thunderMemory2.startGame
        thunder.startBig = thunderMemory2.startBig
        thunder.startReg = thunderMemory2.startReg
        thunder.playGame = thunderMemory2.playGame
        thunder.totalGame = thunderMemory2.totalGame
        thunder.normalKoyakuCountBellA = thunderMemory2.normalKoyakuCountBellA
        thunder.normalKoyakuCountBellB = thunderMemory2.normalKoyakuCountBellB
        thunder.normalKoyakuCountBellSum = thunderMemory2.normalKoyakuCountBellSum
        thunder.normalKoyakuCountSuika = thunderMemory2.normalKoyakuCountSuika
        thunder.normalKoyakuCountCherryB = thunderMemory2.normalKoyakuCountCherryB
        thunder.playBig = thunderMemory2.playBig
        thunder.playReg = thunderMemory2.playReg
        thunder.totalBig = thunderMemory2.totalBig
        thunder.totalReg = thunderMemory2.totalReg
        thunder.btRedSeven = thunderMemory2.btRedSeven
        thunder.bbCountBellC = thunderMemory2.bbCountBellC
        thunder.bbCountBellB = thunderMemory2.bbCountBellB
        thunder.bbGame = thunderMemory2.bbGame
        thunder.bbCountReach = thunderMemory2.bbCountReach
    }
    func loadMemory3() {
        thunder.startGame = thunderMemory3.startGame
        thunder.startBig = thunderMemory3.startBig
        thunder.startReg = thunderMemory3.startReg
        thunder.playGame = thunderMemory3.playGame
        thunder.totalGame = thunderMemory3.totalGame
        thunder.normalKoyakuCountBellA = thunderMemory3.normalKoyakuCountBellA
        thunder.normalKoyakuCountBellB = thunderMemory3.normalKoyakuCountBellB
        thunder.normalKoyakuCountBellSum = thunderMemory3.normalKoyakuCountBellSum
        thunder.normalKoyakuCountSuika = thunderMemory3.normalKoyakuCountSuika
        thunder.normalKoyakuCountCherryB = thunderMemory3.normalKoyakuCountCherryB
        thunder.playBig = thunderMemory3.playBig
        thunder.playReg = thunderMemory3.playReg
        thunder.totalBig = thunderMemory3.totalBig
        thunder.totalReg = thunderMemory3.totalReg
        thunder.btRedSeven = thunderMemory3.btRedSeven
        thunder.bbCountBellC = thunderMemory3.bbCountBellC
        thunder.bbCountBellB = thunderMemory3.bbCountBellB
        thunder.bbGame = thunderMemory3.bbGame
        thunder.bbCountReach = thunderMemory3.bbCountReach
    }
}

#Preview {
    thunderViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
