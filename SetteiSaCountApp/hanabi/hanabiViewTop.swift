//
//  hanabiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct hanabiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hanabi = Hanabi()
    @State var isShowAlert: Bool = false
    @StateObject var hanabiMemory1 = HanabiMemory1()
    @StateObject var hanabiMemory2 = HanabiMemory2()
    @StateObject var hanabiMemory3 = HanabiMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hanabi.machineName)
                }
                
//                Section {
//                    // 通常時
//                    NavigationLink(destination: hanabiViewKen(
//                        hanabi: hanabi,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "magnifyingglass",
//                            textBody: "空き台チェック",
//                            badgeStatus: common.hanabiMenuKenBadge,
//                        )
//                    }
//                } header: {
//                    HStack {
//                        Text("見")
//                        unitToolbarButtonQuestion {
//                            unitExView5body2image(
//                                title: "見",
//                                textBody1: "・空き台の設定判別やベル逆算はこちらから"
//                            )
//                        }
//                    }
//                }
                
                Section {
                    // 打ち始めデータ入力
                    NavigationLink(destination: hanabiViewStart(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ入力",
                            badgeStatus: common.hanabiMenuStartBadge,
                        )
                    }
                    
                    // プレイデータ入力
                    NavigationLink(destination: hanabiViewPlay(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "プレイデータ入力",
                            badgeStatus: common.hanabiMenuPlayBadge,
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hanabiView95Ci(
                    hanabi: hanabi,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hanabiViewBayes(
                    hanabi: hanabi,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hanabiMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4928")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(hanabiSubViewLoadMemory(
                    hanabi: hanabi,
                    hanabiMemory1: hanabiMemory1,
                    hanabiMemory2: hanabiMemory2,
                    hanabiMemory3: hanabiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(hanabiSubViewSaveMemory(
                    hanabi: hanabi,
                    hanabiMemory1: hanabiMemory1,
                    hanabiMemory2: hanabiMemory2,
                    hanabiMemory3: hanabiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hanabi.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct hanabiSubViewSaveMemory: View {
    @ObservedObject var hanabi: Hanabi
    @ObservedObject var hanabiMemory1: HanabiMemory1
    @ObservedObject var hanabiMemory2: HanabiMemory2
    @ObservedObject var hanabiMemory3: HanabiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: hanabi.machineName,
            selectedMemory: $hanabi.selectedMemory,
            memoMemory1: $hanabiMemory1.memo,
            dateDoubleMemory1: $hanabiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hanabiMemory2.memo,
            dateDoubleMemory2: $hanabiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hanabiMemory3.memo,
            dateDoubleMemory3: $hanabiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hanabiMemory1.startGame = hanabi.startGame
        hanabiMemory1.startBig = hanabi.startBig
        hanabiMemory1.startReg = hanabi.startReg
        hanabiMemory1.playGame = hanabi.playGame
        hanabiMemory1.totalGame = hanabi.totalGame
        hanabiMemory1.challengeGame = hanabi.challengeGame
        hanabiMemory1.hanabiGame = hanabi.hanabiGame
        hanabiMemory1.normalKoyakuCountBellA = hanabi.normalKoyakuCountBellA
        hanabiMemory1.normalKoyakuCountBellB = hanabi.normalKoyakuCountBellB
        hanabiMemory1.normalKoyakuCountBellSum = hanabi.normalKoyakuCountBellSum
        hanabiMemory1.normalKoyakuCountKohriA = hanabi.normalKoyakuCountKohriA
        hanabiMemory1.normalKoyakuCountKohriB = hanabi.normalKoyakuCountKohriB
        hanabiMemory1.normalKoyakuCountKohriSum = hanabi.normalKoyakuCountKohriSum
        hanabiMemory1.normalKoyakuCountCherryA1 = hanabi.normalKoyakuCountCherryA1
        hanabiMemory1.normalKoyakuCountCherryA2 = hanabi.normalKoyakuCountCherryA2
        hanabiMemory1.normalKoyakuCountCherryB = hanabi.normalKoyakuCountCherryB
        hanabiMemory1.playBig = hanabi.playBig
        hanabiMemory1.playReg = hanabi.playReg
        hanabiMemory1.totalBig = hanabi.totalBig
        hanabiMemory1.totalReg = hanabi.totalReg
        hanabiMemory1.hazureCountChallenge = hanabi.hazureCountChallenge
        hanabiMemory1.hazureCountGame = hanabi.hazureCountGame
        hanabiMemory1.bbCountBellA = hanabi.bbCountBellA
        hanabiMemory1.bbCountBellB = hanabi.bbCountBellB
        hanabiMemory1.bbCountBarake = hanabi.bbCountBarake
        hanabiMemory1.bbCountGame = hanabi.bbCountGame
        hanabiMemory1.rbCount1Mai = hanabi.rbCount1Mai
        hanabiMemory1.rbCount1MaiDeno = hanabi.rbCount1MaiDeno
        hanabiMemory1.rbCountBarake = hanabi.rbCountBarake
        hanabiMemory1.rbCountGame = hanabi.rbCountGame
    }
    func saveMemory2() {
        hanabiMemory2.startGame = hanabi.startGame
        hanabiMemory2.startBig = hanabi.startBig
        hanabiMemory2.startReg = hanabi.startReg
        hanabiMemory2.playGame = hanabi.playGame
        hanabiMemory2.totalGame = hanabi.totalGame
        hanabiMemory2.challengeGame = hanabi.challengeGame
        hanabiMemory2.hanabiGame = hanabi.hanabiGame
        hanabiMemory2.normalKoyakuCountBellA = hanabi.normalKoyakuCountBellA
        hanabiMemory2.normalKoyakuCountBellB = hanabi.normalKoyakuCountBellB
        hanabiMemory2.normalKoyakuCountBellSum = hanabi.normalKoyakuCountBellSum
        hanabiMemory2.normalKoyakuCountKohriA = hanabi.normalKoyakuCountKohriA
        hanabiMemory2.normalKoyakuCountKohriB = hanabi.normalKoyakuCountKohriB
        hanabiMemory2.normalKoyakuCountKohriSum = hanabi.normalKoyakuCountKohriSum
        hanabiMemory2.normalKoyakuCountCherryA1 = hanabi.normalKoyakuCountCherryA1
        hanabiMemory2.normalKoyakuCountCherryA2 = hanabi.normalKoyakuCountCherryA2
        hanabiMemory2.normalKoyakuCountCherryB = hanabi.normalKoyakuCountCherryB
        hanabiMemory2.playBig = hanabi.playBig
        hanabiMemory2.playReg = hanabi.playReg
        hanabiMemory2.totalBig = hanabi.totalBig
        hanabiMemory2.totalReg = hanabi.totalReg
        hanabiMemory2.hazureCountChallenge = hanabi.hazureCountChallenge
        hanabiMemory2.hazureCountGame = hanabi.hazureCountGame
        hanabiMemory2.bbCountBellA = hanabi.bbCountBellA
        hanabiMemory2.bbCountBellB = hanabi.bbCountBellB
        hanabiMemory2.bbCountBarake = hanabi.bbCountBarake
        hanabiMemory2.bbCountGame = hanabi.bbCountGame
        hanabiMemory2.rbCount1Mai = hanabi.rbCount1Mai
        hanabiMemory2.rbCount1MaiDeno = hanabi.rbCount1MaiDeno
        hanabiMemory2.rbCountBarake = hanabi.rbCountBarake
        hanabiMemory2.rbCountGame = hanabi.rbCountGame
    }
    func saveMemory3() {
        hanabiMemory3.startGame = hanabi.startGame
        hanabiMemory3.startBig = hanabi.startBig
        hanabiMemory3.startReg = hanabi.startReg
        hanabiMemory3.playGame = hanabi.playGame
        hanabiMemory3.totalGame = hanabi.totalGame
        hanabiMemory3.challengeGame = hanabi.challengeGame
        hanabiMemory3.hanabiGame = hanabi.hanabiGame
        hanabiMemory3.normalKoyakuCountBellA = hanabi.normalKoyakuCountBellA
        hanabiMemory3.normalKoyakuCountBellB = hanabi.normalKoyakuCountBellB
        hanabiMemory3.normalKoyakuCountBellSum = hanabi.normalKoyakuCountBellSum
        hanabiMemory3.normalKoyakuCountKohriA = hanabi.normalKoyakuCountKohriA
        hanabiMemory3.normalKoyakuCountKohriB = hanabi.normalKoyakuCountKohriB
        hanabiMemory3.normalKoyakuCountKohriSum = hanabi.normalKoyakuCountKohriSum
        hanabiMemory3.normalKoyakuCountCherryA1 = hanabi.normalKoyakuCountCherryA1
        hanabiMemory3.normalKoyakuCountCherryA2 = hanabi.normalKoyakuCountCherryA2
        hanabiMemory3.normalKoyakuCountCherryB = hanabi.normalKoyakuCountCherryB
        hanabiMemory3.playBig = hanabi.playBig
        hanabiMemory3.playReg = hanabi.playReg
        hanabiMemory3.totalBig = hanabi.totalBig
        hanabiMemory3.totalReg = hanabi.totalReg
        hanabiMemory3.hazureCountChallenge = hanabi.hazureCountChallenge
        hanabiMemory3.hazureCountGame = hanabi.hazureCountGame
        hanabiMemory3.bbCountBellA = hanabi.bbCountBellA
        hanabiMemory3.bbCountBellB = hanabi.bbCountBellB
        hanabiMemory3.bbCountBarake = hanabi.bbCountBarake
        hanabiMemory3.bbCountGame = hanabi.bbCountGame
        hanabiMemory3.rbCount1Mai = hanabi.rbCount1Mai
        hanabiMemory3.rbCount1MaiDeno = hanabi.rbCount1MaiDeno
        hanabiMemory3.rbCountBarake = hanabi.rbCountBarake
        hanabiMemory3.rbCountGame = hanabi.rbCountGame
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct hanabiSubViewLoadMemory: View {
    @ObservedObject var hanabi: Hanabi
    @ObservedObject var hanabiMemory1: HanabiMemory1
    @ObservedObject var hanabiMemory2: HanabiMemory2
    @ObservedObject var hanabiMemory3: HanabiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: hanabi.machineName,
            selectedMemory: $hanabi.selectedMemory,
            memoMemory1: hanabiMemory1.memo,
            dateDoubleMemory1: hanabiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hanabiMemory2.memo,
            dateDoubleMemory2: hanabiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hanabiMemory3.memo,
            dateDoubleMemory3: hanabiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        hanabi.startGame = hanabiMemory1.startGame
        hanabi.startBig = hanabiMemory1.startBig
        hanabi.startReg = hanabiMemory1.startReg
        hanabi.playGame = hanabiMemory1.playGame
        hanabi.totalGame = hanabiMemory1.totalGame
        hanabi.challengeGame = hanabiMemory1.challengeGame
        hanabi.hanabiGame = hanabiMemory1.hanabiGame
        hanabi.normalKoyakuCountBellA = hanabiMemory1.normalKoyakuCountBellA
        hanabi.normalKoyakuCountBellB = hanabiMemory1.normalKoyakuCountBellB
        hanabi.normalKoyakuCountBellSum = hanabiMemory1.normalKoyakuCountBellSum
        hanabi.normalKoyakuCountKohriA = hanabiMemory1.normalKoyakuCountKohriA
        hanabi.normalKoyakuCountKohriB = hanabiMemory1.normalKoyakuCountKohriB
        hanabi.normalKoyakuCountKohriSum = hanabiMemory1.normalKoyakuCountKohriSum
        hanabi.normalKoyakuCountCherryA1 = hanabiMemory1.normalKoyakuCountCherryA1
        hanabi.normalKoyakuCountCherryA2 = hanabiMemory1.normalKoyakuCountCherryA2
        hanabi.normalKoyakuCountCherryB = hanabiMemory1.normalKoyakuCountCherryB
        hanabi.playBig = hanabiMemory1.playBig
        hanabi.playReg = hanabiMemory1.playReg
        hanabi.totalBig = hanabiMemory1.totalBig
        hanabi.totalReg = hanabiMemory1.totalReg
        hanabi.hazureCountChallenge = hanabiMemory1.hazureCountChallenge
        hanabi.hazureCountGame = hanabiMemory1.hazureCountGame
        hanabi.bbCountBellA = hanabiMemory1.bbCountBellA
        hanabi.bbCountBellB = hanabiMemory1.bbCountBellB
        hanabi.bbCountBarake = hanabiMemory1.bbCountBarake
        hanabi.bbCountGame = hanabiMemory1.bbCountGame
        hanabi.rbCount1Mai = hanabiMemory1.rbCount1Mai
        hanabi.rbCount1MaiDeno = hanabiMemory1.rbCount1MaiDeno
        hanabi.rbCountBarake = hanabiMemory1.rbCountBarake
        hanabi.rbCountGame = hanabiMemory1.rbCountGame
    }
    func loadMemory2() {
        hanabi.startGame = hanabiMemory2.startGame
        hanabi.startBig = hanabiMemory2.startBig
        hanabi.startReg = hanabiMemory2.startReg
        hanabi.playGame = hanabiMemory2.playGame
        hanabi.totalGame = hanabiMemory2.totalGame
        hanabi.challengeGame = hanabiMemory2.challengeGame
        hanabi.hanabiGame = hanabiMemory2.hanabiGame
        hanabi.normalKoyakuCountBellA = hanabiMemory2.normalKoyakuCountBellA
        hanabi.normalKoyakuCountBellB = hanabiMemory2.normalKoyakuCountBellB
        hanabi.normalKoyakuCountBellSum = hanabiMemory2.normalKoyakuCountBellSum
        hanabi.normalKoyakuCountKohriA = hanabiMemory2.normalKoyakuCountKohriA
        hanabi.normalKoyakuCountKohriB = hanabiMemory2.normalKoyakuCountKohriB
        hanabi.normalKoyakuCountKohriSum = hanabiMemory2.normalKoyakuCountKohriSum
        hanabi.normalKoyakuCountCherryA1 = hanabiMemory2.normalKoyakuCountCherryA1
        hanabi.normalKoyakuCountCherryA2 = hanabiMemory2.normalKoyakuCountCherryA2
        hanabi.normalKoyakuCountCherryB = hanabiMemory2.normalKoyakuCountCherryB
        hanabi.playBig = hanabiMemory2.playBig
        hanabi.playReg = hanabiMemory2.playReg
        hanabi.totalBig = hanabiMemory2.totalBig
        hanabi.totalReg = hanabiMemory2.totalReg
        hanabi.hazureCountChallenge = hanabiMemory2.hazureCountChallenge
        hanabi.hazureCountGame = hanabiMemory2.hazureCountGame
        hanabi.bbCountBellA = hanabiMemory2.bbCountBellA
        hanabi.bbCountBellB = hanabiMemory2.bbCountBellB
        hanabi.bbCountBarake = hanabiMemory2.bbCountBarake
        hanabi.bbCountGame = hanabiMemory2.bbCountGame
        hanabi.rbCount1Mai = hanabiMemory2.rbCount1Mai
        hanabi.rbCount1MaiDeno = hanabiMemory2.rbCount1MaiDeno
        hanabi.rbCountBarake = hanabiMemory2.rbCountBarake
        hanabi.rbCountGame = hanabiMemory2.rbCountGame
    }
    func loadMemory3() {
        hanabi.startGame = hanabiMemory3.startGame
        hanabi.startBig = hanabiMemory3.startBig
        hanabi.startReg = hanabiMemory3.startReg
        hanabi.playGame = hanabiMemory3.playGame
        hanabi.totalGame = hanabiMemory3.totalGame
        hanabi.challengeGame = hanabiMemory3.challengeGame
        hanabi.hanabiGame = hanabiMemory3.hanabiGame
        hanabi.normalKoyakuCountBellA = hanabiMemory3.normalKoyakuCountBellA
        hanabi.normalKoyakuCountBellB = hanabiMemory3.normalKoyakuCountBellB
        hanabi.normalKoyakuCountBellSum = hanabiMemory3.normalKoyakuCountBellSum
        hanabi.normalKoyakuCountKohriA = hanabiMemory3.normalKoyakuCountKohriA
        hanabi.normalKoyakuCountKohriB = hanabiMemory3.normalKoyakuCountKohriB
        hanabi.normalKoyakuCountKohriSum = hanabiMemory3.normalKoyakuCountKohriSum
        hanabi.normalKoyakuCountCherryA1 = hanabiMemory3.normalKoyakuCountCherryA1
        hanabi.normalKoyakuCountCherryA2 = hanabiMemory3.normalKoyakuCountCherryA2
        hanabi.normalKoyakuCountCherryB = hanabiMemory3.normalKoyakuCountCherryB
        hanabi.playBig = hanabiMemory3.playBig
        hanabi.playReg = hanabiMemory3.playReg
        hanabi.totalBig = hanabiMemory3.totalBig
        hanabi.totalReg = hanabiMemory3.totalReg
        hanabi.hazureCountChallenge = hanabiMemory3.hazureCountChallenge
        hanabi.hazureCountGame = hanabiMemory3.hazureCountGame
        hanabi.bbCountBellA = hanabiMemory3.bbCountBellA
        hanabi.bbCountBellB = hanabiMemory3.bbCountBellB
        hanabi.bbCountBarake = hanabiMemory3.bbCountBarake
        hanabi.bbCountGame = hanabiMemory3.bbCountGame
        hanabi.rbCount1Mai = hanabiMemory3.rbCount1Mai
        hanabi.rbCount1MaiDeno = hanabiMemory3.rbCount1MaiDeno
        hanabi.rbCountBarake = hanabiMemory3.rbCountBarake
        hanabi.rbCountGame = hanabiMemory3.rbCountGame
    }
}

#Preview {
    hanabiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
