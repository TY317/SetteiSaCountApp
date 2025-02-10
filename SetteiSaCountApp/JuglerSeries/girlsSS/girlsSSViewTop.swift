//
//  girlsSSViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/09.
//

import SwiftUI

struct girlsSSViewTop: View {
    @ObservedObject var ver210 = Ver210()
    @ObservedObject var girlsSS = GirlsSS()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ジャグラーガールズSS")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: girlsSSVer2ViewKenDataInput()) {
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
                    NavigationLink(destination: girlsSSVer2ViewJissenStartData()) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: girlsSSVer2ViewJissenCount()) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: girlsSSVer2ViewJissenTotalDataCheck()) {
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
                NavigationLink(destination: girlsSSVer2View95CiTotal()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(girlsSSSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(girlsSSSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: girlsSS.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
        .onAppear {
            if ver210.ver210GirlsSSNewBadgeStatus != "none" {
                ver210.ver210GirlsSSNewBadgeStatus = "none"
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct girlsSSSubViewSaveMemory: View {
    @ObservedObject var girlsSS = GirlsSS()
    @ObservedObject var girlsSSMemory1 = GirlsSSMemory1()
    @ObservedObject var girlsSSMemory2 = GirlsSSMemory2()
    @ObservedObject var girlsSSMemory3 = GirlsSSMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ジャグラーガールズSS",
            selectedMemory: $girlsSS.selectedMemory,
            memoMemory1: $girlsSSMemory1.memo,
            dateDoubleMemory1: $girlsSSMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $girlsSSMemory2.memo,
            dateDoubleMemory2: $girlsSSMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $girlsSSMemory3.memo,
            dateDoubleMemory3: $girlsSSMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        girlsSSMemory1.kenBackCalculationEnable = girlsSS.kenBackCalculationEnable
        girlsSSMemory1.kenGameIput = girlsSS.kenGameIput
        girlsSSMemory1.kenBigCountInput = girlsSS.kenBigCountInput
        girlsSSMemory1.kenRegCountInput = girlsSS.kenRegCountInput
        girlsSSMemory1.kenCoinDifferenceInput = girlsSS.kenCoinDifferenceInput
        girlsSSMemory1.kenBonusCountSum = girlsSS.kenBonusCountSum
        girlsSSMemory1.kenBellBackCalculationCount = girlsSS.kenBellBackCalculationCount
        girlsSSMemory1.startBackCalculationEnable = girlsSS.startBackCalculationEnable
        girlsSSMemory1.startGameInput = girlsSS.startGameInput
        girlsSSMemory1.startBigCountInput = girlsSS.startBigCountInput
        girlsSSMemory1.startRegCountInput = girlsSS.startRegCountInput
        girlsSSMemory1.startCoinDifferenceInput = girlsSS.startCoinDifferenceInput
        girlsSSMemory1.startBonusCountSum = girlsSS.startBonusCountSum
        girlsSSMemory1.startBellBackCalculationCount = girlsSS.startBellBackCalculationCount
        girlsSSMemory1.personalBellCount = girlsSS.personalBellCount
        girlsSSMemory1.personalAloneBigCount = girlsSS.personalAloneBigCount
        girlsSSMemory1.personalCherryBigCount = girlsSS.personalCherryBigCount
        girlsSSMemory1.personalBigCountSum = girlsSS.personalBigCountSum
        girlsSSMemory1.personalAloneRegCount = girlsSS.personalAloneRegCount
        girlsSSMemory1.personalCherryRegCount = girlsSS.personalCherryRegCount
        girlsSSMemory1.currentGames = girlsSS.currentGames
        girlsSSMemory1.personalRegCountSum = girlsSS.personalRegCountSum
        girlsSSMemory1.personalBonusCountSum = girlsSS.personalBonusCountSum
        girlsSSMemory1.playGame = girlsSS.playGame
        girlsSSMemory1.totalBigCount = girlsSS.totalBigCount
        girlsSSMemory1.totalRegCount = girlsSS.totalRegCount
        girlsSSMemory1.totalBellCount = girlsSS.totalBellCount
        girlsSSMemory1.totalBonusCountSum = girlsSS.totalBonusCountSum
    }
    func saveMemory2() {
        girlsSSMemory2.kenBackCalculationEnable = girlsSS.kenBackCalculationEnable
        girlsSSMemory2.kenGameIput = girlsSS.kenGameIput
        girlsSSMemory2.kenBigCountInput = girlsSS.kenBigCountInput
        girlsSSMemory2.kenRegCountInput = girlsSS.kenRegCountInput
        girlsSSMemory2.kenCoinDifferenceInput = girlsSS.kenCoinDifferenceInput
        girlsSSMemory2.kenBonusCountSum = girlsSS.kenBonusCountSum
        girlsSSMemory2.kenBellBackCalculationCount = girlsSS.kenBellBackCalculationCount
        girlsSSMemory2.startBackCalculationEnable = girlsSS.startBackCalculationEnable
        girlsSSMemory2.startGameInput = girlsSS.startGameInput
        girlsSSMemory2.startBigCountInput = girlsSS.startBigCountInput
        girlsSSMemory2.startRegCountInput = girlsSS.startRegCountInput
        girlsSSMemory2.startCoinDifferenceInput = girlsSS.startCoinDifferenceInput
        girlsSSMemory2.startBonusCountSum = girlsSS.startBonusCountSum
        girlsSSMemory2.startBellBackCalculationCount = girlsSS.startBellBackCalculationCount
        girlsSSMemory2.personalBellCount = girlsSS.personalBellCount
        girlsSSMemory2.personalAloneBigCount = girlsSS.personalAloneBigCount
        girlsSSMemory2.personalCherryBigCount = girlsSS.personalCherryBigCount
        girlsSSMemory2.personalBigCountSum = girlsSS.personalBigCountSum
        girlsSSMemory2.personalAloneRegCount = girlsSS.personalAloneRegCount
        girlsSSMemory2.personalCherryRegCount = girlsSS.personalCherryRegCount
        girlsSSMemory2.currentGames = girlsSS.currentGames
        girlsSSMemory2.personalRegCountSum = girlsSS.personalRegCountSum
        girlsSSMemory2.personalBonusCountSum = girlsSS.personalBonusCountSum
        girlsSSMemory2.playGame = girlsSS.playGame
        girlsSSMemory2.totalBigCount = girlsSS.totalBigCount
        girlsSSMemory2.totalRegCount = girlsSS.totalRegCount
        girlsSSMemory2.totalBellCount = girlsSS.totalBellCount
        girlsSSMemory2.totalBonusCountSum = girlsSS.totalBonusCountSum
    }
    func saveMemory3() {
        girlsSSMemory3.kenBackCalculationEnable = girlsSS.kenBackCalculationEnable
        girlsSSMemory3.kenGameIput = girlsSS.kenGameIput
        girlsSSMemory3.kenBigCountInput = girlsSS.kenBigCountInput
        girlsSSMemory3.kenRegCountInput = girlsSS.kenRegCountInput
        girlsSSMemory3.kenCoinDifferenceInput = girlsSS.kenCoinDifferenceInput
        girlsSSMemory3.kenBonusCountSum = girlsSS.kenBonusCountSum
        girlsSSMemory3.kenBellBackCalculationCount = girlsSS.kenBellBackCalculationCount
        girlsSSMemory3.startBackCalculationEnable = girlsSS.startBackCalculationEnable
        girlsSSMemory3.startGameInput = girlsSS.startGameInput
        girlsSSMemory3.startBigCountInput = girlsSS.startBigCountInput
        girlsSSMemory3.startRegCountInput = girlsSS.startRegCountInput
        girlsSSMemory3.startCoinDifferenceInput = girlsSS.startCoinDifferenceInput
        girlsSSMemory3.startBonusCountSum = girlsSS.startBonusCountSum
        girlsSSMemory3.startBellBackCalculationCount = girlsSS.startBellBackCalculationCount
        girlsSSMemory3.personalBellCount = girlsSS.personalBellCount
        girlsSSMemory3.personalAloneBigCount = girlsSS.personalAloneBigCount
        girlsSSMemory3.personalCherryBigCount = girlsSS.personalCherryBigCount
        girlsSSMemory3.personalBigCountSum = girlsSS.personalBigCountSum
        girlsSSMemory3.personalAloneRegCount = girlsSS.personalAloneRegCount
        girlsSSMemory3.personalCherryRegCount = girlsSS.personalCherryRegCount
        girlsSSMemory3.currentGames = girlsSS.currentGames
        girlsSSMemory3.personalRegCountSum = girlsSS.personalRegCountSum
        girlsSSMemory3.personalBonusCountSum = girlsSS.personalBonusCountSum
        girlsSSMemory3.playGame = girlsSS.playGame
        girlsSSMemory3.totalBigCount = girlsSS.totalBigCount
        girlsSSMemory3.totalRegCount = girlsSS.totalRegCount
        girlsSSMemory3.totalBellCount = girlsSS.totalBellCount
        girlsSSMemory3.totalBonusCountSum = girlsSS.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct girlsSSSubViewLoadMemory: View {
    @ObservedObject var girlsSS = GirlsSS()
    @ObservedObject var girlsSSMemory1 = GirlsSSMemory1()
    @ObservedObject var girlsSSMemory2 = GirlsSSMemory2()
    @ObservedObject var girlsSSMemory3 = GirlsSSMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ジャグラーガールズSS",
            selectedMemory: $girlsSS.selectedMemory,
            memoMemory1: girlsSSMemory1.memo,
            dateDoubleMemory1: girlsSSMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: girlsSSMemory2.memo,
            dateDoubleMemory2: girlsSSMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: girlsSSMemory3.memo,
            dateDoubleMemory3: girlsSSMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        girlsSS.kenBackCalculationEnable = girlsSSMemory1.kenBackCalculationEnable
        girlsSS.kenGameIput = girlsSSMemory1.kenGameIput
        girlsSS.kenBigCountInput = girlsSSMemory1.kenBigCountInput
        girlsSS.kenRegCountInput = girlsSSMemory1.kenRegCountInput
        girlsSS.kenCoinDifferenceInput = girlsSSMemory1.kenCoinDifferenceInput
        girlsSS.kenBonusCountSum = girlsSSMemory1.kenBonusCountSum
        girlsSS.kenBellBackCalculationCount = girlsSSMemory1.kenBellBackCalculationCount
        girlsSS.startBackCalculationEnable = girlsSSMemory1.startBackCalculationEnable
        girlsSS.startGameInput = girlsSSMemory1.startGameInput
        girlsSS.startBigCountInput = girlsSSMemory1.startBigCountInput
        girlsSS.startRegCountInput = girlsSSMemory1.startRegCountInput
        girlsSS.startCoinDifferenceInput = girlsSSMemory1.startCoinDifferenceInput
        girlsSS.startBonusCountSum = girlsSSMemory1.startBonusCountSum
        girlsSS.startBellBackCalculationCount = girlsSSMemory1.startBellBackCalculationCount
        girlsSS.personalBellCount = girlsSSMemory1.personalBellCount
        girlsSS.personalAloneBigCount = girlsSSMemory1.personalAloneBigCount
        girlsSS.personalCherryBigCount = girlsSSMemory1.personalCherryBigCount
        girlsSS.personalBigCountSum = girlsSSMemory1.personalBigCountSum
        girlsSS.personalAloneRegCount = girlsSSMemory1.personalAloneRegCount
        girlsSS.personalCherryRegCount = girlsSSMemory1.personalCherryRegCount
        girlsSS.currentGames = girlsSSMemory1.currentGames
        girlsSS.personalRegCountSum = girlsSSMemory1.personalRegCountSum
        girlsSS.personalBonusCountSum = girlsSSMemory1.personalBonusCountSum
        girlsSS.playGame = girlsSSMemory1.playGame
        girlsSS.totalBigCount = girlsSSMemory1.totalBigCount
        girlsSS.totalRegCount = girlsSSMemory1.totalRegCount
        girlsSS.totalBellCount = girlsSSMemory1.totalBellCount
        girlsSS.totalBonusCountSum = girlsSSMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        girlsSS.kenBackCalculationEnable = girlsSSMemory2.kenBackCalculationEnable
        girlsSS.kenGameIput = girlsSSMemory2.kenGameIput
        girlsSS.kenBigCountInput = girlsSSMemory2.kenBigCountInput
        girlsSS.kenRegCountInput = girlsSSMemory2.kenRegCountInput
        girlsSS.kenCoinDifferenceInput = girlsSSMemory2.kenCoinDifferenceInput
        girlsSS.kenBonusCountSum = girlsSSMemory2.kenBonusCountSum
        girlsSS.kenBellBackCalculationCount = girlsSSMemory2.kenBellBackCalculationCount
        girlsSS.startBackCalculationEnable = girlsSSMemory2.startBackCalculationEnable
        girlsSS.startGameInput = girlsSSMemory2.startGameInput
        girlsSS.startBigCountInput = girlsSSMemory2.startBigCountInput
        girlsSS.startRegCountInput = girlsSSMemory2.startRegCountInput
        girlsSS.startCoinDifferenceInput = girlsSSMemory2.startCoinDifferenceInput
        girlsSS.startBonusCountSum = girlsSSMemory2.startBonusCountSum
        girlsSS.startBellBackCalculationCount = girlsSSMemory2.startBellBackCalculationCount
        girlsSS.personalBellCount = girlsSSMemory2.personalBellCount
        girlsSS.personalAloneBigCount = girlsSSMemory2.personalAloneBigCount
        girlsSS.personalCherryBigCount = girlsSSMemory2.personalCherryBigCount
        girlsSS.personalBigCountSum = girlsSSMemory2.personalBigCountSum
        girlsSS.personalAloneRegCount = girlsSSMemory2.personalAloneRegCount
        girlsSS.personalCherryRegCount = girlsSSMemory2.personalCherryRegCount
        girlsSS.currentGames = girlsSSMemory2.currentGames
        girlsSS.personalRegCountSum = girlsSSMemory2.personalRegCountSum
        girlsSS.personalBonusCountSum = girlsSSMemory2.personalBonusCountSum
        girlsSS.playGame = girlsSSMemory2.playGame
        girlsSS.totalBigCount = girlsSSMemory2.totalBigCount
        girlsSS.totalRegCount = girlsSSMemory2.totalRegCount
        girlsSS.totalBellCount = girlsSSMemory2.totalBellCount
        girlsSS.totalBonusCountSum = girlsSSMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        girlsSS.kenBackCalculationEnable = girlsSSMemory3.kenBackCalculationEnable
        girlsSS.kenGameIput = girlsSSMemory3.kenGameIput
        girlsSS.kenBigCountInput = girlsSSMemory3.kenBigCountInput
        girlsSS.kenRegCountInput = girlsSSMemory3.kenRegCountInput
        girlsSS.kenCoinDifferenceInput = girlsSSMemory3.kenCoinDifferenceInput
        girlsSS.kenBonusCountSum = girlsSSMemory3.kenBonusCountSum
        girlsSS.kenBellBackCalculationCount = girlsSSMemory3.kenBellBackCalculationCount
        girlsSS.startBackCalculationEnable = girlsSSMemory3.startBackCalculationEnable
        girlsSS.startGameInput = girlsSSMemory3.startGameInput
        girlsSS.startBigCountInput = girlsSSMemory3.startBigCountInput
        girlsSS.startRegCountInput = girlsSSMemory3.startRegCountInput
        girlsSS.startCoinDifferenceInput = girlsSSMemory3.startCoinDifferenceInput
        girlsSS.startBonusCountSum = girlsSSMemory3.startBonusCountSum
        girlsSS.startBellBackCalculationCount = girlsSSMemory3.startBellBackCalculationCount
        girlsSS.personalBellCount = girlsSSMemory3.personalBellCount
        girlsSS.personalAloneBigCount = girlsSSMemory3.personalAloneBigCount
        girlsSS.personalCherryBigCount = girlsSSMemory3.personalCherryBigCount
        girlsSS.personalBigCountSum = girlsSSMemory3.personalBigCountSum
        girlsSS.personalAloneRegCount = girlsSSMemory3.personalAloneRegCount
        girlsSS.personalCherryRegCount = girlsSSMemory3.personalCherryRegCount
        girlsSS.currentGames = girlsSSMemory3.currentGames
        girlsSS.personalRegCountSum = girlsSSMemory3.personalRegCountSum
        girlsSS.personalBonusCountSum = girlsSSMemory3.personalBonusCountSum
        girlsSS.playGame = girlsSSMemory3.playGame
        girlsSS.totalBigCount = girlsSSMemory3.totalBigCount
        girlsSS.totalRegCount = girlsSSMemory3.totalRegCount
        girlsSS.totalBellCount = girlsSSMemory3.totalBellCount
        girlsSS.totalBonusCountSum = girlsSSMemory3.totalBonusCountSum
    }
}

#Preview {
    girlsSSViewTop()
}
