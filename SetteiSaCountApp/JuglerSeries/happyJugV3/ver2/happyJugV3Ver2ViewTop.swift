//
//  happyJugV3Ver2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI
import FirebaseAnalytics

// //////////////////
// 変数
// //////////////////
class HappyJugV3: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        6.04,
        6.01,
        5.98,
        5.84,
        5.81,
        5.79
    ]
    
    let denominateListBigSum: [Double] = [
        273,
        271,
        263,
        254,
        239,
        226
    ]
    
    let denominateListRegSum: [Double] = [
        397,
        362,
        333,
        301,
        273,
        256
    ]
    
    let denominateListBonusSum: [Double] = [
        162,
        155,
        147,
        138,
        128,
        120
    ]
    
    let denominateListBigAlone: [Double] = [
        437,
        431,
        412,
        415,
        377,
        345
    ]
    
    let denominateListBigCherry: [Double] = [
        1489,
        1489,
        1489,
        1214,
        1214,
        1214
    ]
    
    let denominateListRegAlone: [Double] = [
        636,
        570,
        533,
        478,
        437,
        426
    ]
    
    let denominateListRegCherry: [Double] = [
        1057,
        993,
        886,
        809,
        728,
        643
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("happyJugV3KenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("happyJugV3KenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("happyJugV3KenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("happyJugV3KenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("happyJugV3KenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("happyJugV3KenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("happyJugV3KenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 55.5   // チェリー確率
        let suikaDenominate: Double = 655.36   // ベル確率
        let pieroDenominate: Double = 655.36   // ピエロ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.11   // ベル奪取率、V2スロマガ情報より
        let pieroGetRatio: Double = 0.16   // ピエロ奪取率、V2スロマガ情報より
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
        let suikaOut: Double = 14   // ベル払い出し枚数
        let pieroOut: Double = 10   // ピエロ払い出し枚数
        
        // //// ゲーム数の内訳算出
        let budonukiGame = Double(bigCount + regCount) * budonukiAverageGame / 3
        let replayGame = (Double(game) - budonukiGame) / replayDenominate
        let normalGame = Double(game) - replayGame - budonukiGame
        
        // //// IN枚数の計算
        let budonukiIn = Double(bigCount + regCount) * budonukiAverageIn
        let normalGameIn = normalGame * 3
        let inTotal = budonukiIn + normalGameIn
        
        // //// OUT枚数の計算
        let budonukiOut = Double(bigCount + regCount) * budonukiAverageOut
        let bigOutTotal = Double(bigCount) * bigOut
        let regOutTotal = Double(regCount) * regOut
        let cherryOutTotal = (Double(game) - budonukiGame) / cherryDenominate * cherryOut * cherryGetRatio
        let suikaOutTotal = (Double(game) - budonukiGame) / suikaDenominate * suikaOut * suikaGetRatio
        let pieroOutTotal = (Double(game) - budonukiGame) / pieroDenominate * pieroOut * pieroGetRatio
        let outTotalWithoutBell = budonukiOut + bigOutTotal + regOutTotal + cherryOutTotal + suikaOutTotal + pieroOutTotal
        
        // //// ぶどう抜き逆算値の算出
        let bellOutTotal = Double(coinDifference) - outTotalWithoutBell + inTotal
        let bellBackCalculateCount = Int(bellOutTotal / bellOut)
        
        return bellBackCalculateCount
    }
    
    func kenToStartRecord() {
        resetStartData()
        resetCountData()
        startBackCalculationEnable = kenBackCalculationEnable
        startGameInput = kenGameIput
        startBigCountInput = kenBigCountInput
        startRegCountInput = kenRegCountInput
        startCoinDifferenceInput = kenCoinDifferenceInput
        currentGames = kenGameIput
    }
    
    func resetKenDataInput() {
        kenGameIput = 0
        kenBigCountInput = 0
        kenRegCountInput = 0
        kenCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 打ち始めデータ
    // ////////////////////////
    @AppStorage("happyJugV3StartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("happyJugV3StartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("happyJugV3StartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCountSum)
                }
            }
                @AppStorage("happyJugV3StartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("happyJugV3StartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("happyJugV3StartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("happyJugV3StartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    
    func resetStartData() {
        startGameInput = 0
        startBigCountInput = 0
        startRegCountInput = 0
        startCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 カウント
    // ////////////////////////
    // //// 自分の実戦分
    @AppStorage("happyJugV3BellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("happyJugV3AloneBigCount") var personalAloneBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
    @AppStorage("happyJugV3CherryBigCount") var personalCherryBigCount = 0 {
        didSet {
            personalBigCountSum = countSum(personalAloneBigCount, personalCherryBigCount)
        }
    }
        @AppStorage("happyJugV3AloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("happyJugV3CherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("happyJugV3CurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("happyJugV3BigCountSum") var personalBigCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalBigCount = countSum(startBigCountInput, personalBigCountSum)
        }
    }
    @AppStorage("happyJugV3RegCountSum") var personalRegCountSum = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCountSum, personalRegCountSum)
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("happyJugV3BonusCountSum") var personalBonusCountSum = 0
    @AppStorage("happyJugV3PlayGame") var playGame = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalAloneBigCount = 0
        personalCherryBigCount = 0
        personalAloneRegCount = 0
        personalCherryRegCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("happyJugV3TotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("happyJugV3TotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("happyJugV3TotalBellCount") var totalBellCount = 0
    @AppStorage("happyJugV3TotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("happyJugV3MinusCheck") var minusCheck: Bool = false
    @AppStorage("happyJugV3SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
}


// //// メモリー1
class HappyJugV3Memory1: ObservableObject {
    @AppStorage("happyJugV3KenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3KenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("happyJugV3KenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("happyJugV3KenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("happyJugV3KenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3KenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("happyJugV3KenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3StartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3StartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("happyJugV3StartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("happyJugV3StartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("happyJugV3StartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3StartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("happyJugV3StartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3BellCountMemory1") var personalBellCount = 0
    @AppStorage("happyJugV3AloneBigCountMemory1") var personalAloneBigCount = 0
    @AppStorage("happyJugV3CherryBigCountMemory1") var personalCherryBigCount = 0
    @AppStorage("happyJugV3BigCountSumMemory1") var personalBigCountSum = 0
    @AppStorage("happyJugV3AloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("happyJugV3CherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("happyJugV3CurrentGamesMemory1") var currentGames = 0
    @AppStorage("happyJugV3RegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("happyJugV3BonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("happyJugV3PlayGameMemory1") var playGame = 0
    @AppStorage("happyJugV3TotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("happyJugV3TotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("happyJugV3TotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("happyJugV3TotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("happyJugV3MemoMemory1") var memo = ""
    @AppStorage("happyJugV3DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class HappyJugV3Memory2: ObservableObject {
    @AppStorage("happyJugV3KenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3KenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("happyJugV3KenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("happyJugV3KenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("happyJugV3KenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3KenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("happyJugV3KenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3StartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3StartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("happyJugV3StartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("happyJugV3StartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("happyJugV3StartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3StartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("happyJugV3StartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3BellCountMemory2") var personalBellCount = 0
    @AppStorage("happyJugV3AloneBigCountMemory2") var personalAloneBigCount = 0
    @AppStorage("happyJugV3CherryBigCountMemory2") var personalCherryBigCount = 0
    @AppStorage("happyJugV3BigCountSumMemory2") var personalBigCountSum = 0
    @AppStorage("happyJugV3AloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("happyJugV3CherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("happyJugV3CurrentGamesMemory2") var currentGames = 0
    @AppStorage("happyJugV3RegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("happyJugV3BonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("happyJugV3PlayGameMemory2") var playGame = 0
    @AppStorage("happyJugV3TotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("happyJugV3TotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("happyJugV3TotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("happyJugV3TotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("happyJugV3MemoMemory2") var memo = ""
    @AppStorage("happyJugV3DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class HappyJugV3Memory3: ObservableObject {
    @AppStorage("happyJugV3KenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3KenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("happyJugV3KenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("happyJugV3KenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("happyJugV3KenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3KenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("happyJugV3KenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3StartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("happyJugV3StartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("happyJugV3StartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("happyJugV3StartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("happyJugV3StartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("happyJugV3StartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("happyJugV3StartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("happyJugV3BellCountMemory3") var personalBellCount = 0
    @AppStorage("happyJugV3AloneBigCountMemory3") var personalAloneBigCount = 0
    @AppStorage("happyJugV3CherryBigCountMemory3") var personalCherryBigCount = 0
    @AppStorage("happyJugV3BigCountSumMemory3") var personalBigCountSum = 0
    @AppStorage("happyJugV3AloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("happyJugV3CherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("happyJugV3CurrentGamesMemory3") var currentGames = 0
    @AppStorage("happyJugV3RegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("happyJugV3BonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("happyJugV3PlayGameMemory3") var playGame = 0
    @AppStorage("happyJugV3TotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("happyJugV3TotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("happyJugV3TotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("happyJugV3TotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("happyJugV3MemoMemory3") var memo = ""
    @AppStorage("happyJugV3DateMemory3") var dateDouble = 0.0
}

struct happyJugV3Ver2ViewTop: View {
//    @ObservedObject var happyJugV3 = HappyJugV3()
    @StateObject var happyJugV3 = HappyJugV3()
    @State var isShowAlert: Bool = false
    @StateObject var happyJugV3Memory1 = HappyJugV3Memory1()
    @StateObject var happyJugV3Memory2 = HappyJugV3Memory2()
    @StateObject var happyJugV3Memory3 = HappyJugV3Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ハッピージャグラーV3")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: happyJugV3Ver2ViewKenDataInput(happyJugV3: happyJugV3)) {
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
                    NavigationLink(destination: happyJugV3Ver2ViewJissenStartData(happyJugV3: happyJugV3)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: happyJugV3Ver2ViewJissenCount(happyJugV3: happyJugV3)) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: happyJugV3Ver2ViewJissenTotalDataCheck(happyJugV3: happyJugV3)) {
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
//                .popoverTip(tipUnitJugHanaCommonJissenView())
                // 設定推測グラフ
                NavigationLink(destination: happyJugV3Ver2View95CiTotal(happyJugV3: happyJugV3)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4230")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ハッピージャグラーV3",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "ハッピージャグラーV3", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "happyJugV3Ver2ViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: happyJugV3Ver2ViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(happyJugV3SubViewLoadMemory(
                        happyJugV3: happyJugV3,
                        happyJugV3Memory1: happyJugV3Memory1,
                        happyJugV3Memory2: happyJugV3Memory2,
                        happyJugV3Memory3: happyJugV3Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(happyJugV3SubViewSaveMemory(
                        happyJugV3: happyJugV3,
                        happyJugV3Memory1: happyJugV3Memory1,
                        happyJugV3Memory2: happyJugV3Memory2,
                        happyJugV3Memory3: happyJugV3Memory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: happyJugV3.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct happyJugV3SubViewSaveMemory: View {
    @ObservedObject var happyJugV3: HappyJugV3
    @ObservedObject var happyJugV3Memory1: HappyJugV3Memory1
    @ObservedObject var happyJugV3Memory2: HappyJugV3Memory2
    @ObservedObject var happyJugV3Memory3: HappyJugV3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ハッピージャグラーV3",
            selectedMemory: $happyJugV3.selectedMemory,
            memoMemory1: $happyJugV3Memory1.memo,
            dateDoubleMemory1: $happyJugV3Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $happyJugV3Memory2.memo,
            dateDoubleMemory2: $happyJugV3Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $happyJugV3Memory3.memo,
            dateDoubleMemory3: $happyJugV3Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        happyJugV3Memory1.kenBackCalculationEnable = happyJugV3.kenBackCalculationEnable
        happyJugV3Memory1.kenGameIput = happyJugV3.kenGameIput
        happyJugV3Memory1.kenBigCountInput = happyJugV3.kenBigCountInput
        happyJugV3Memory1.kenRegCountInput = happyJugV3.kenRegCountInput
        happyJugV3Memory1.kenCoinDifferenceInput = happyJugV3.kenCoinDifferenceInput
        happyJugV3Memory1.kenBonusCountSum = happyJugV3.kenBonusCountSum
        happyJugV3Memory1.kenBellBackCalculationCount = happyJugV3.kenBellBackCalculationCount
        happyJugV3Memory1.startBackCalculationEnable = happyJugV3.startBackCalculationEnable
        happyJugV3Memory1.startGameInput = happyJugV3.startGameInput
        happyJugV3Memory1.startBigCountInput = happyJugV3.startBigCountInput
        happyJugV3Memory1.startRegCountInput = happyJugV3.startRegCountInput
        happyJugV3Memory1.startCoinDifferenceInput = happyJugV3.startCoinDifferenceInput
        happyJugV3Memory1.startBonusCountSum = happyJugV3.startBonusCountSum
        happyJugV3Memory1.startBellBackCalculationCount = happyJugV3.startBellBackCalculationCount
        happyJugV3Memory1.personalBellCount = happyJugV3.personalBellCount
        happyJugV3Memory1.personalAloneBigCount = happyJugV3.personalAloneBigCount
        happyJugV3Memory1.personalCherryBigCount = happyJugV3.personalCherryBigCount
        happyJugV3Memory1.personalBigCountSum = happyJugV3.personalBigCountSum
        happyJugV3Memory1.personalAloneRegCount = happyJugV3.personalAloneRegCount
        happyJugV3Memory1.personalCherryRegCount = happyJugV3.personalCherryRegCount
        happyJugV3Memory1.currentGames = happyJugV3.currentGames
        happyJugV3Memory1.personalRegCountSum = happyJugV3.personalRegCountSum
        happyJugV3Memory1.personalBonusCountSum = happyJugV3.personalBonusCountSum
        happyJugV3Memory1.playGame = happyJugV3.playGame
        happyJugV3Memory1.totalBigCount = happyJugV3.totalBigCount
        happyJugV3Memory1.totalRegCount = happyJugV3.totalRegCount
        happyJugV3Memory1.totalBellCount = happyJugV3.totalBellCount
        happyJugV3Memory1.totalBonusCountSum = happyJugV3.totalBonusCountSum
    }
    func saveMemory2() {
        happyJugV3Memory2.kenBackCalculationEnable = happyJugV3.kenBackCalculationEnable
        happyJugV3Memory2.kenGameIput = happyJugV3.kenGameIput
        happyJugV3Memory2.kenBigCountInput = happyJugV3.kenBigCountInput
        happyJugV3Memory2.kenRegCountInput = happyJugV3.kenRegCountInput
        happyJugV3Memory2.kenCoinDifferenceInput = happyJugV3.kenCoinDifferenceInput
        happyJugV3Memory2.kenBonusCountSum = happyJugV3.kenBonusCountSum
        happyJugV3Memory2.kenBellBackCalculationCount = happyJugV3.kenBellBackCalculationCount
        happyJugV3Memory2.startBackCalculationEnable = happyJugV3.startBackCalculationEnable
        happyJugV3Memory2.startGameInput = happyJugV3.startGameInput
        happyJugV3Memory2.startBigCountInput = happyJugV3.startBigCountInput
        happyJugV3Memory2.startRegCountInput = happyJugV3.startRegCountInput
        happyJugV3Memory2.startCoinDifferenceInput = happyJugV3.startCoinDifferenceInput
        happyJugV3Memory2.startBonusCountSum = happyJugV3.startBonusCountSum
        happyJugV3Memory2.startBellBackCalculationCount = happyJugV3.startBellBackCalculationCount
        happyJugV3Memory2.personalBellCount = happyJugV3.personalBellCount
        happyJugV3Memory2.personalAloneBigCount = happyJugV3.personalAloneBigCount
        happyJugV3Memory2.personalCherryBigCount = happyJugV3.personalCherryBigCount
        happyJugV3Memory2.personalBigCountSum = happyJugV3.personalBigCountSum
        happyJugV3Memory2.personalAloneRegCount = happyJugV3.personalAloneRegCount
        happyJugV3Memory2.personalCherryRegCount = happyJugV3.personalCherryRegCount
        happyJugV3Memory2.currentGames = happyJugV3.currentGames
        happyJugV3Memory2.personalRegCountSum = happyJugV3.personalRegCountSum
        happyJugV3Memory2.personalBonusCountSum = happyJugV3.personalBonusCountSum
        happyJugV3Memory2.playGame = happyJugV3.playGame
        happyJugV3Memory2.totalBigCount = happyJugV3.totalBigCount
        happyJugV3Memory2.totalRegCount = happyJugV3.totalRegCount
        happyJugV3Memory2.totalBellCount = happyJugV3.totalBellCount
        happyJugV3Memory2.totalBonusCountSum = happyJugV3.totalBonusCountSum
    }
    func saveMemory3() {
        happyJugV3Memory3.kenBackCalculationEnable = happyJugV3.kenBackCalculationEnable
        happyJugV3Memory3.kenGameIput = happyJugV3.kenGameIput
        happyJugV3Memory3.kenBigCountInput = happyJugV3.kenBigCountInput
        happyJugV3Memory3.kenRegCountInput = happyJugV3.kenRegCountInput
        happyJugV3Memory3.kenCoinDifferenceInput = happyJugV3.kenCoinDifferenceInput
        happyJugV3Memory3.kenBonusCountSum = happyJugV3.kenBonusCountSum
        happyJugV3Memory3.kenBellBackCalculationCount = happyJugV3.kenBellBackCalculationCount
        happyJugV3Memory3.startBackCalculationEnable = happyJugV3.startBackCalculationEnable
        happyJugV3Memory3.startGameInput = happyJugV3.startGameInput
        happyJugV3Memory3.startBigCountInput = happyJugV3.startBigCountInput
        happyJugV3Memory3.startRegCountInput = happyJugV3.startRegCountInput
        happyJugV3Memory3.startCoinDifferenceInput = happyJugV3.startCoinDifferenceInput
        happyJugV3Memory3.startBonusCountSum = happyJugV3.startBonusCountSum
        happyJugV3Memory3.startBellBackCalculationCount = happyJugV3.startBellBackCalculationCount
        happyJugV3Memory3.personalBellCount = happyJugV3.personalBellCount
        happyJugV3Memory3.personalAloneBigCount = happyJugV3.personalAloneBigCount
        happyJugV3Memory3.personalCherryBigCount = happyJugV3.personalCherryBigCount
        happyJugV3Memory3.personalBigCountSum = happyJugV3.personalBigCountSum
        happyJugV3Memory3.personalAloneRegCount = happyJugV3.personalAloneRegCount
        happyJugV3Memory3.personalCherryRegCount = happyJugV3.personalCherryRegCount
        happyJugV3Memory3.currentGames = happyJugV3.currentGames
        happyJugV3Memory3.personalRegCountSum = happyJugV3.personalRegCountSum
        happyJugV3Memory3.personalBonusCountSum = happyJugV3.personalBonusCountSum
        happyJugV3Memory3.playGame = happyJugV3.playGame
        happyJugV3Memory3.totalBigCount = happyJugV3.totalBigCount
        happyJugV3Memory3.totalRegCount = happyJugV3.totalRegCount
        happyJugV3Memory3.totalBellCount = happyJugV3.totalBellCount
        happyJugV3Memory3.totalBonusCountSum = happyJugV3.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct happyJugV3SubViewLoadMemory: View {
    @ObservedObject var happyJugV3: HappyJugV3
    @ObservedObject var happyJugV3Memory1: HappyJugV3Memory1
    @ObservedObject var happyJugV3Memory2: HappyJugV3Memory2
    @ObservedObject var happyJugV3Memory3: HappyJugV3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ハッピージャグラーV3",
            selectedMemory: $happyJugV3.selectedMemory,
            memoMemory1: happyJugV3Memory1.memo,
            dateDoubleMemory1: happyJugV3Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: happyJugV3Memory2.memo,
            dateDoubleMemory2: happyJugV3Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: happyJugV3Memory3.memo,
            dateDoubleMemory3: happyJugV3Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        happyJugV3.kenBackCalculationEnable = happyJugV3Memory1.kenBackCalculationEnable
        happyJugV3.kenGameIput = happyJugV3Memory1.kenGameIput
        happyJugV3.kenBigCountInput = happyJugV3Memory1.kenBigCountInput
        happyJugV3.kenRegCountInput = happyJugV3Memory1.kenRegCountInput
        happyJugV3.kenCoinDifferenceInput = happyJugV3Memory1.kenCoinDifferenceInput
        happyJugV3.kenBonusCountSum = happyJugV3Memory1.kenBonusCountSum
        happyJugV3.kenBellBackCalculationCount = happyJugV3Memory1.kenBellBackCalculationCount
        happyJugV3.startBackCalculationEnable = happyJugV3Memory1.startBackCalculationEnable
        happyJugV3.startGameInput = happyJugV3Memory1.startGameInput
        happyJugV3.startBigCountInput = happyJugV3Memory1.startBigCountInput
        happyJugV3.startRegCountInput = happyJugV3Memory1.startRegCountInput
        happyJugV3.startCoinDifferenceInput = happyJugV3Memory1.startCoinDifferenceInput
        happyJugV3.startBonusCountSum = happyJugV3Memory1.startBonusCountSum
        happyJugV3.startBellBackCalculationCount = happyJugV3Memory1.startBellBackCalculationCount
        happyJugV3.personalBellCount = happyJugV3Memory1.personalBellCount
        happyJugV3.personalAloneBigCount = happyJugV3Memory1.personalAloneBigCount
        happyJugV3.personalCherryBigCount = happyJugV3Memory1.personalCherryBigCount
        happyJugV3.personalBigCountSum = happyJugV3Memory1.personalBigCountSum
        happyJugV3.personalAloneRegCount = happyJugV3Memory1.personalAloneRegCount
        happyJugV3.personalCherryRegCount = happyJugV3Memory1.personalCherryRegCount
        happyJugV3.currentGames = happyJugV3Memory1.currentGames
        happyJugV3.personalRegCountSum = happyJugV3Memory1.personalRegCountSum
        happyJugV3.personalBonusCountSum = happyJugV3Memory1.personalBonusCountSum
        happyJugV3.playGame = happyJugV3Memory1.playGame
        happyJugV3.totalBigCount = happyJugV3Memory1.totalBigCount
        happyJugV3.totalRegCount = happyJugV3Memory1.totalRegCount
        happyJugV3.totalBellCount = happyJugV3Memory1.totalBellCount
        happyJugV3.totalBonusCountSum = happyJugV3Memory1.totalBonusCountSum
    }
    func loadMemory2() {
        happyJugV3.kenBackCalculationEnable = happyJugV3Memory2.kenBackCalculationEnable
        happyJugV3.kenGameIput = happyJugV3Memory2.kenGameIput
        happyJugV3.kenBigCountInput = happyJugV3Memory2.kenBigCountInput
        happyJugV3.kenRegCountInput = happyJugV3Memory2.kenRegCountInput
        happyJugV3.kenCoinDifferenceInput = happyJugV3Memory2.kenCoinDifferenceInput
        happyJugV3.kenBonusCountSum = happyJugV3Memory2.kenBonusCountSum
        happyJugV3.kenBellBackCalculationCount = happyJugV3Memory2.kenBellBackCalculationCount
        happyJugV3.startBackCalculationEnable = happyJugV3Memory2.startBackCalculationEnable
        happyJugV3.startGameInput = happyJugV3Memory2.startGameInput
        happyJugV3.startBigCountInput = happyJugV3Memory2.startBigCountInput
        happyJugV3.startRegCountInput = happyJugV3Memory2.startRegCountInput
        happyJugV3.startCoinDifferenceInput = happyJugV3Memory2.startCoinDifferenceInput
        happyJugV3.startBonusCountSum = happyJugV3Memory2.startBonusCountSum
        happyJugV3.startBellBackCalculationCount = happyJugV3Memory2.startBellBackCalculationCount
        happyJugV3.personalBellCount = happyJugV3Memory2.personalBellCount
        happyJugV3.personalAloneBigCount = happyJugV3Memory2.personalAloneBigCount
        happyJugV3.personalCherryBigCount = happyJugV3Memory2.personalCherryBigCount
        happyJugV3.personalBigCountSum = happyJugV3Memory2.personalBigCountSum
        happyJugV3.personalAloneRegCount = happyJugV3Memory2.personalAloneRegCount
        happyJugV3.personalCherryRegCount = happyJugV3Memory2.personalCherryRegCount
        happyJugV3.currentGames = happyJugV3Memory2.currentGames
        happyJugV3.personalRegCountSum = happyJugV3Memory2.personalRegCountSum
        happyJugV3.personalBonusCountSum = happyJugV3Memory2.personalBonusCountSum
        happyJugV3.playGame = happyJugV3Memory2.playGame
        happyJugV3.totalBigCount = happyJugV3Memory2.totalBigCount
        happyJugV3.totalRegCount = happyJugV3Memory2.totalRegCount
        happyJugV3.totalBellCount = happyJugV3Memory2.totalBellCount
        happyJugV3.totalBonusCountSum = happyJugV3Memory2.totalBonusCountSum
    }
    func loadMemory3() {
        happyJugV3.kenBackCalculationEnable = happyJugV3Memory3.kenBackCalculationEnable
        happyJugV3.kenGameIput = happyJugV3Memory3.kenGameIput
        happyJugV3.kenBigCountInput = happyJugV3Memory3.kenBigCountInput
        happyJugV3.kenRegCountInput = happyJugV3Memory3.kenRegCountInput
        happyJugV3.kenCoinDifferenceInput = happyJugV3Memory3.kenCoinDifferenceInput
        happyJugV3.kenBonusCountSum = happyJugV3Memory3.kenBonusCountSum
        happyJugV3.kenBellBackCalculationCount = happyJugV3Memory3.kenBellBackCalculationCount
        happyJugV3.startBackCalculationEnable = happyJugV3Memory3.startBackCalculationEnable
        happyJugV3.startGameInput = happyJugV3Memory3.startGameInput
        happyJugV3.startBigCountInput = happyJugV3Memory3.startBigCountInput
        happyJugV3.startRegCountInput = happyJugV3Memory3.startRegCountInput
        happyJugV3.startCoinDifferenceInput = happyJugV3Memory3.startCoinDifferenceInput
        happyJugV3.startBonusCountSum = happyJugV3Memory3.startBonusCountSum
        happyJugV3.startBellBackCalculationCount = happyJugV3Memory3.startBellBackCalculationCount
        happyJugV3.personalBellCount = happyJugV3Memory3.personalBellCount
        happyJugV3.personalAloneBigCount = happyJugV3Memory3.personalAloneBigCount
        happyJugV3.personalCherryBigCount = happyJugV3Memory3.personalCherryBigCount
        happyJugV3.personalBigCountSum = happyJugV3Memory3.personalBigCountSum
        happyJugV3.personalAloneRegCount = happyJugV3Memory3.personalAloneRegCount
        happyJugV3.personalCherryRegCount = happyJugV3Memory3.personalCherryRegCount
        happyJugV3.currentGames = happyJugV3Memory3.currentGames
        happyJugV3.personalRegCountSum = happyJugV3Memory3.personalRegCountSum
        happyJugV3.personalBonusCountSum = happyJugV3Memory3.personalBonusCountSum
        happyJugV3.playGame = happyJugV3Memory3.playGame
        happyJugV3.totalBigCount = happyJugV3Memory3.totalBigCount
        happyJugV3.totalRegCount = happyJugV3Memory3.totalRegCount
        happyJugV3.totalBellCount = happyJugV3Memory3.totalBellCount
        happyJugV3.totalBonusCountSum = happyJugV3Memory3.totalBonusCountSum
    }
}

#Preview {
    happyJugV3Ver2ViewTop()
}
