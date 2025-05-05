//
//  mrJugViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct mrJugViewTop: View {
//    @ObservedObject var ver210 = Ver210()
//    @ObservedObject var mrJug = MrJug()
    @StateObject var mrJug = MrJug()
    @State var isShowAlert: Bool = false
    @StateObject var mrJugMemory1 = MrJugMemory1()
    @StateObject var mrJugMemory2 = MrJugMemory2()
    @StateObject var mrJugMemory3 = MrJugMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ミスタージャグラー")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: mrJugVer2ViewKenDataInput(mrJug: mrJug)) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                } header: {
                    Text("見")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                .popoverTip(tipUnitJugHanaCommonKenView())
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: mrJugVer2ViewJissenStartData(mrJug: mrJug)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: mrJugVer2ViewJissenCount(mrJug: mrJug)) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: mrJugVer2ViewJissenTotalDataCheck(mrJug: mrJug)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.arrival",
                            textBody: "総合結果確認"
                        )
                    }
                } header: {
                    Text("実戦")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                .popoverTip(tipUnitJugHanaCommonJissenView())
                // 設定推測グラフ
                NavigationLink(destination: mrJugVer2View95CiTotal(mrJug: mrJug)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4588")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(mrJugSubViewLoadMemory(
                        mrJug: mrJug,
                        mrJugMemory1: mrJugMemory1,
                        mrJugMemory2: mrJugMemory2,
                        mrJugMemory3: mrJugMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(mrJugSubViewSaveMemory(
                        mrJug: mrJug,
                        mrJugMemory1: mrJugMemory1,
                        mrJugMemory2: mrJugMemory2,
                        mrJugMemory3: mrJugMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mrJug.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
//        .onAppear {
//            if ver210.ver210MrJugNewBadgeStatus != "none" {
//                ver210.ver210MrJugNewBadgeStatus = "none"
//            }
//        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct mrJugSubViewSaveMemory: View {
    @ObservedObject var mrJug: MrJug
    @ObservedObject var mrJugMemory1: MrJugMemory1
    @ObservedObject var mrJugMemory2: MrJugMemory2
    @ObservedObject var mrJugMemory3: MrJugMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ミスタージャグラー",
            selectedMemory: $mrJug.selectedMemory,
            memoMemory1: $mrJugMemory1.memo,
            dateDoubleMemory1: $mrJugMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mrJugMemory2.memo,
            dateDoubleMemory2: $mrJugMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mrJugMemory3.memo,
            dateDoubleMemory3: $mrJugMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mrJugMemory1.kenBackCalculationEnable = mrJug.kenBackCalculationEnable
        mrJugMemory1.kenGameIput = mrJug.kenGameIput
        mrJugMemory1.kenBigCountInput = mrJug.kenBigCountInput
        mrJugMemory1.kenRegCountInput = mrJug.kenRegCountInput
        mrJugMemory1.kenCoinDifferenceInput = mrJug.kenCoinDifferenceInput
        mrJugMemory1.kenBonusCountSum = mrJug.kenBonusCountSum
        mrJugMemory1.kenBellBackCalculationCount = mrJug.kenBellBackCalculationCount
        mrJugMemory1.startBackCalculationEnable = mrJug.startBackCalculationEnable
        mrJugMemory1.startGameInput = mrJug.startGameInput
        mrJugMemory1.startBigCountInput = mrJug.startBigCountInput
        mrJugMemory1.startRegCountInput = mrJug.startRegCountInput
        mrJugMemory1.startCoinDifferenceInput = mrJug.startCoinDifferenceInput
        mrJugMemory1.startBonusCountSum = mrJug.startBonusCountSum
        mrJugMemory1.startBellBackCalculationCount = mrJug.startBellBackCalculationCount
        mrJugMemory1.personalBellCount = mrJug.personalBellCount
        mrJugMemory1.personalAloneBigCount = mrJug.personalAloneBigCount
        mrJugMemory1.personalCherryBigCount = mrJug.personalCherryBigCount
        mrJugMemory1.personalBigCountSum = mrJug.personalBigCountSum
        mrJugMemory1.personalAloneRegCount = mrJug.personalAloneRegCount
        mrJugMemory1.personalCherryRegCount = mrJug.personalCherryRegCount
        mrJugMemory1.currentGames = mrJug.currentGames
        mrJugMemory1.personalRegCountSum = mrJug.personalRegCountSum
        mrJugMemory1.personalBonusCountSum = mrJug.personalBonusCountSum
        mrJugMemory1.playGame = mrJug.playGame
        mrJugMemory1.totalBigCount = mrJug.totalBigCount
        mrJugMemory1.totalRegCount = mrJug.totalRegCount
        mrJugMemory1.totalBellCount = mrJug.totalBellCount
        mrJugMemory1.totalBonusCountSum = mrJug.totalBonusCountSum
    }
    func saveMemory2() {
        mrJugMemory2.kenBackCalculationEnable = mrJug.kenBackCalculationEnable
        mrJugMemory2.kenGameIput = mrJug.kenGameIput
        mrJugMemory2.kenBigCountInput = mrJug.kenBigCountInput
        mrJugMemory2.kenRegCountInput = mrJug.kenRegCountInput
        mrJugMemory2.kenCoinDifferenceInput = mrJug.kenCoinDifferenceInput
        mrJugMemory2.kenBonusCountSum = mrJug.kenBonusCountSum
        mrJugMemory2.kenBellBackCalculationCount = mrJug.kenBellBackCalculationCount
        mrJugMemory2.startBackCalculationEnable = mrJug.startBackCalculationEnable
        mrJugMemory2.startGameInput = mrJug.startGameInput
        mrJugMemory2.startBigCountInput = mrJug.startBigCountInput
        mrJugMemory2.startRegCountInput = mrJug.startRegCountInput
        mrJugMemory2.startCoinDifferenceInput = mrJug.startCoinDifferenceInput
        mrJugMemory2.startBonusCountSum = mrJug.startBonusCountSum
        mrJugMemory2.startBellBackCalculationCount = mrJug.startBellBackCalculationCount
        mrJugMemory2.personalBellCount = mrJug.personalBellCount
        mrJugMemory2.personalAloneBigCount = mrJug.personalAloneBigCount
        mrJugMemory2.personalCherryBigCount = mrJug.personalCherryBigCount
        mrJugMemory2.personalBigCountSum = mrJug.personalBigCountSum
        mrJugMemory2.personalAloneRegCount = mrJug.personalAloneRegCount
        mrJugMemory2.personalCherryRegCount = mrJug.personalCherryRegCount
        mrJugMemory2.currentGames = mrJug.currentGames
        mrJugMemory2.personalRegCountSum = mrJug.personalRegCountSum
        mrJugMemory2.personalBonusCountSum = mrJug.personalBonusCountSum
        mrJugMemory2.playGame = mrJug.playGame
        mrJugMemory2.totalBigCount = mrJug.totalBigCount
        mrJugMemory2.totalRegCount = mrJug.totalRegCount
        mrJugMemory2.totalBellCount = mrJug.totalBellCount
        mrJugMemory2.totalBonusCountSum = mrJug.totalBonusCountSum
    }
    func saveMemory3() {
        mrJugMemory3.kenBackCalculationEnable = mrJug.kenBackCalculationEnable
        mrJugMemory3.kenGameIput = mrJug.kenGameIput
        mrJugMemory3.kenBigCountInput = mrJug.kenBigCountInput
        mrJugMemory3.kenRegCountInput = mrJug.kenRegCountInput
        mrJugMemory3.kenCoinDifferenceInput = mrJug.kenCoinDifferenceInput
        mrJugMemory3.kenBonusCountSum = mrJug.kenBonusCountSum
        mrJugMemory3.kenBellBackCalculationCount = mrJug.kenBellBackCalculationCount
        mrJugMemory3.startBackCalculationEnable = mrJug.startBackCalculationEnable
        mrJugMemory3.startGameInput = mrJug.startGameInput
        mrJugMemory3.startBigCountInput = mrJug.startBigCountInput
        mrJugMemory3.startRegCountInput = mrJug.startRegCountInput
        mrJugMemory3.startCoinDifferenceInput = mrJug.startCoinDifferenceInput
        mrJugMemory3.startBonusCountSum = mrJug.startBonusCountSum
        mrJugMemory3.startBellBackCalculationCount = mrJug.startBellBackCalculationCount
        mrJugMemory3.personalBellCount = mrJug.personalBellCount
        mrJugMemory3.personalAloneBigCount = mrJug.personalAloneBigCount
        mrJugMemory3.personalCherryBigCount = mrJug.personalCherryBigCount
        mrJugMemory3.personalBigCountSum = mrJug.personalBigCountSum
        mrJugMemory3.personalAloneRegCount = mrJug.personalAloneRegCount
        mrJugMemory3.personalCherryRegCount = mrJug.personalCherryRegCount
        mrJugMemory3.currentGames = mrJug.currentGames
        mrJugMemory3.personalRegCountSum = mrJug.personalRegCountSum
        mrJugMemory3.personalBonusCountSum = mrJug.personalBonusCountSum
        mrJugMemory3.playGame = mrJug.playGame
        mrJugMemory3.totalBigCount = mrJug.totalBigCount
        mrJugMemory3.totalRegCount = mrJug.totalRegCount
        mrJugMemory3.totalBellCount = mrJug.totalBellCount
        mrJugMemory3.totalBonusCountSum = mrJug.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct mrJugSubViewLoadMemory: View {
    @ObservedObject var mrJug: MrJug
    @ObservedObject var mrJugMemory1: MrJugMemory1
    @ObservedObject var mrJugMemory2: MrJugMemory2
    @ObservedObject var mrJugMemory3: MrJugMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ミスタージャグラー",
            selectedMemory: $mrJug.selectedMemory,
            memoMemory1: mrJugMemory1.memo,
            dateDoubleMemory1: mrJugMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mrJugMemory2.memo,
            dateDoubleMemory2: mrJugMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mrJugMemory3.memo,
            dateDoubleMemory3: mrJugMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        mrJug.kenBackCalculationEnable = mrJugMemory1.kenBackCalculationEnable
        mrJug.kenGameIput = mrJugMemory1.kenGameIput
        mrJug.kenBigCountInput = mrJugMemory1.kenBigCountInput
        mrJug.kenRegCountInput = mrJugMemory1.kenRegCountInput
        mrJug.kenCoinDifferenceInput = mrJugMemory1.kenCoinDifferenceInput
        mrJug.kenBonusCountSum = mrJugMemory1.kenBonusCountSum
        mrJug.kenBellBackCalculationCount = mrJugMemory1.kenBellBackCalculationCount
        mrJug.startBackCalculationEnable = mrJugMemory1.startBackCalculationEnable
        mrJug.startGameInput = mrJugMemory1.startGameInput
        mrJug.startBigCountInput = mrJugMemory1.startBigCountInput
        mrJug.startRegCountInput = mrJugMemory1.startRegCountInput
        mrJug.startCoinDifferenceInput = mrJugMemory1.startCoinDifferenceInput
        mrJug.startBonusCountSum = mrJugMemory1.startBonusCountSum
        mrJug.startBellBackCalculationCount = mrJugMemory1.startBellBackCalculationCount
        mrJug.personalBellCount = mrJugMemory1.personalBellCount
        mrJug.personalAloneBigCount = mrJugMemory1.personalAloneBigCount
        mrJug.personalCherryBigCount = mrJugMemory1.personalCherryBigCount
        mrJug.personalBigCountSum = mrJugMemory1.personalBigCountSum
        mrJug.personalAloneRegCount = mrJugMemory1.personalAloneRegCount
        mrJug.personalCherryRegCount = mrJugMemory1.personalCherryRegCount
        mrJug.currentGames = mrJugMemory1.currentGames
        mrJug.personalRegCountSum = mrJugMemory1.personalRegCountSum
        mrJug.personalBonusCountSum = mrJugMemory1.personalBonusCountSum
        mrJug.playGame = mrJugMemory1.playGame
        mrJug.totalBigCount = mrJugMemory1.totalBigCount
        mrJug.totalRegCount = mrJugMemory1.totalRegCount
        mrJug.totalBellCount = mrJugMemory1.totalBellCount
        mrJug.totalBonusCountSum = mrJugMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        mrJug.kenBackCalculationEnable = mrJugMemory2.kenBackCalculationEnable
        mrJug.kenGameIput = mrJugMemory2.kenGameIput
        mrJug.kenBigCountInput = mrJugMemory2.kenBigCountInput
        mrJug.kenRegCountInput = mrJugMemory2.kenRegCountInput
        mrJug.kenCoinDifferenceInput = mrJugMemory2.kenCoinDifferenceInput
        mrJug.kenBonusCountSum = mrJugMemory2.kenBonusCountSum
        mrJug.kenBellBackCalculationCount = mrJugMemory2.kenBellBackCalculationCount
        mrJug.startBackCalculationEnable = mrJugMemory2.startBackCalculationEnable
        mrJug.startGameInput = mrJugMemory2.startGameInput
        mrJug.startBigCountInput = mrJugMemory2.startBigCountInput
        mrJug.startRegCountInput = mrJugMemory2.startRegCountInput
        mrJug.startCoinDifferenceInput = mrJugMemory2.startCoinDifferenceInput
        mrJug.startBonusCountSum = mrJugMemory2.startBonusCountSum
        mrJug.startBellBackCalculationCount = mrJugMemory2.startBellBackCalculationCount
        mrJug.personalBellCount = mrJugMemory2.personalBellCount
        mrJug.personalAloneBigCount = mrJugMemory2.personalAloneBigCount
        mrJug.personalCherryBigCount = mrJugMemory2.personalCherryBigCount
        mrJug.personalBigCountSum = mrJugMemory2.personalBigCountSum
        mrJug.personalAloneRegCount = mrJugMemory2.personalAloneRegCount
        mrJug.personalCherryRegCount = mrJugMemory2.personalCherryRegCount
        mrJug.currentGames = mrJugMemory2.currentGames
        mrJug.personalRegCountSum = mrJugMemory2.personalRegCountSum
        mrJug.personalBonusCountSum = mrJugMemory2.personalBonusCountSum
        mrJug.playGame = mrJugMemory2.playGame
        mrJug.totalBigCount = mrJugMemory2.totalBigCount
        mrJug.totalRegCount = mrJugMemory2.totalRegCount
        mrJug.totalBellCount = mrJugMemory2.totalBellCount
        mrJug.totalBonusCountSum = mrJugMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        mrJug.kenBackCalculationEnable = mrJugMemory3.kenBackCalculationEnable
        mrJug.kenGameIput = mrJugMemory3.kenGameIput
        mrJug.kenBigCountInput = mrJugMemory3.kenBigCountInput
        mrJug.kenRegCountInput = mrJugMemory3.kenRegCountInput
        mrJug.kenCoinDifferenceInput = mrJugMemory3.kenCoinDifferenceInput
        mrJug.kenBonusCountSum = mrJugMemory3.kenBonusCountSum
        mrJug.kenBellBackCalculationCount = mrJugMemory3.kenBellBackCalculationCount
        mrJug.startBackCalculationEnable = mrJugMemory3.startBackCalculationEnable
        mrJug.startGameInput = mrJugMemory3.startGameInput
        mrJug.startBigCountInput = mrJugMemory3.startBigCountInput
        mrJug.startRegCountInput = mrJugMemory3.startRegCountInput
        mrJug.startCoinDifferenceInput = mrJugMemory3.startCoinDifferenceInput
        mrJug.startBonusCountSum = mrJugMemory3.startBonusCountSum
        mrJug.startBellBackCalculationCount = mrJugMemory3.startBellBackCalculationCount
        mrJug.personalBellCount = mrJugMemory3.personalBellCount
        mrJug.personalAloneBigCount = mrJugMemory3.personalAloneBigCount
        mrJug.personalCherryBigCount = mrJugMemory3.personalCherryBigCount
        mrJug.personalBigCountSum = mrJugMemory3.personalBigCountSum
        mrJug.personalAloneRegCount = mrJugMemory3.personalAloneRegCount
        mrJug.personalCherryRegCount = mrJugMemory3.personalCherryRegCount
        mrJug.currentGames = mrJugMemory3.currentGames
        mrJug.personalRegCountSum = mrJugMemory3.personalRegCountSum
        mrJug.personalBonusCountSum = mrJugMemory3.personalBonusCountSum
        mrJug.playGame = mrJugMemory3.playGame
        mrJug.totalBigCount = mrJugMemory3.totalBigCount
        mrJug.totalRegCount = mrJugMemory3.totalRegCount
        mrJug.totalBellCount = mrJugMemory3.totalBellCount
        mrJug.totalBonusCountSum = mrJugMemory3.totalBonusCountSum
    }
}


#Preview {
    mrJugViewTop()
}
