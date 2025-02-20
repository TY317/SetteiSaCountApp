//
//  hanaTenshoVer2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/26.
//

import SwiftUI
import TipKit


// ///////////////////////
// 変数
// ///////////////////////
class HanaTensho: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        7.50,
        7.45,
        7.39,
        7.32,
        7.26,
        7.25
    ]
    let denominateListBig: [Double] = [
        297,
        284,
        273,
        262,
        249,
        236
    ]
    let denominateListReg: [Double] = [
        496,
        458,
        425,
        397,
        366,
        337
    ]
    let denominateListBonusSum: [Double] = [
        186,
        175,
        166,
        157,
        148,
        139
    ]
    let denominateListBbSuika: [Double] = [
        48,
        44,
        42,
        40,
        35,
        32
    ]
    let percentListBbLamp: [Double] = [
        10.9,
        12.8,
        13.3,
        15.1,
        15.4,
        16.9
    ]
    let percentListRbLampKisuSisa: [Double] = [
        60,
        40,
        60,
        40,
        60,
        50
    ]
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("hanaTenshoKenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("hanaTenshoKenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("hanaTenshoKenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("hanaTenshoKenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("hanaTenshoKenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("hanaTenshoKenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("hanaTenshoKenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 48.0   // チェリー確率
        let suikaDenominate: Double = 160.0   // スイカ確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let suikaGetRatio: Double = 0.7   // ベル奪取率
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 120   // REG獲得枚数
        let cherryOut: Double = 4   // チェリー払い出し枚数
        let bellOut: Double = 10   // ぶどう・ベル払い出し枚数
        let suikaOut: Double = 6   // ベル払い出し枚数
        
        // //// ゲーム数の内訳算出
        let replayGame = Double(game) / replayDenominate
        let normalGame = Double(game) - replayGame
        
        // //// IN枚数の計算
        let normalGameIn = normalGame * 3
        let inTotal = normalGameIn
        
        // //// OUT枚数の計算
        let bigOutTotal = Double(bigCount) * bigOut
        let regOutTotal = Double(regCount) * regOut
        let cherryOutTotal = Double(game) / cherryDenominate * cherryOut * cherryGetRatio
        let suikaOutTotal = Double(game) / suikaDenominate * suikaOut * suikaGetRatio
        let outTotalWithoutBell = bigOutTotal + regOutTotal + cherryOutTotal + suikaOutTotal
        
        // //// ぶどう抜き逆算値の算出
        let bellOutTotal = Double(coinDifference) - outTotalWithoutBell + inTotal
        let bellBackCalculateCount = Int(bellOutTotal / bellOut)
        
        return bellBackCalculateCount
    }
    
    func kenToStartRecord() {
        resetStartData()
        hanaReset()
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
    @AppStorage("hanaTenshoStartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("hanaTenshoStartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGames = currentGames - startGameInput
            }
        }
            @AppStorage("hanaTenshoStartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, bigCount)
                }
            }
                @AppStorage("hanaTenshoStartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, regCount)
                    }
                }
                    @AppStorage("hanaTenshoStartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("hanaTenshoStartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("hanaTenshoStartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    
    func resetStartData() {
        startGameInput = 0
        startBigCountInput = 0
        startRegCountInput = 0
        startCoinDifferenceInput = 0
        minusCheck = false
    }
    
    // /////////////////
    // 実戦カウント
    // /////////////////
    @AppStorage("hanaTenshoBellCount") var bellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, bellCount)
        }
    }
    @AppStorage("hanaTenshoBigCount") var bigCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
            totalBigCount = countSum(startBigCountInput, bigCount)
        }
    }
    @AppStorage("hanaTenshoRegCount") var regCount = 0 {
        didSet {
            totalBonus = countSum(bigCount, regCount)
            totalRegCount = countSum(startRegCountInput, regCount)
        }
    }
    @AppStorage("hanaTenshoBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = countSum(bbLampBCount, bbLampYCount, bbLampGCount, bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("hanaTenshoRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("hanaTenshoRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampKisuCountSum = countSum(rbLampBCount, rbLampGCount)
        }
    }
    @AppStorage("hanaTenshoRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = countSum(rbLampBCount, rbLampYCount, rbLampGCount, rbLampRCount)
            rbLampGusuCountSum = countSum(rbLampYCount, rbLampRCount)
        }
    }
    @AppStorage("hanaTenshoCurrentGames") var currentGames = 0 {
        didSet {
            playGames = currentGames - startGameInput
        }
    }
    
    @AppStorage("hanaTenshoTotalBonus") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGames") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGames") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSum") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSum") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSum") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
    // ビッグ消化ゲーム数
    private func BigPlayGames(big:Int) -> Int {
        return big * 24
    }
    
    func hanaReset() {
        bellCount = 0
        bigCount = 0
        regCount = 0
        bbSuikaCount = 0
        bbLampBCount = 0
        bbLampYCount = 0
        bbLampGCount = 0
        bbLampRCount = 0
        rbLampBCount = 0
        rbLampYCount = 0
        rbLampGCount = 0
        rbLampRCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("hanaTenshoTotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("hanaTenshoTotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("hanaTenshoTotalBellCount") var totalBellCount = 0
    @AppStorage("hanaTenshoTotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("hanaTenshoMinusCheck") var minusCheck: Bool = false
    @AppStorage("hanaTenshoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        hanaReset()
    }
}


// //// メモリー1
class HanaTenshoMemory1: ObservableObject {
    @AppStorage("hanaTenshoKenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoKenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("hanaTenshoKenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("hanaTenshoKenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("hanaTenshoKenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoKenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("hanaTenshoKenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoStartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoStartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("hanaTenshoStartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("hanaTenshoStartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("hanaTenshoStartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoStartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("hanaTenshoStartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoBellCountMemory1") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory1") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory1") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("hanaTenshoCurrentGamesMemory1") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory1") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory1") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoTotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("hanaTenshoTotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("hanaTenshoTotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("hanaTenshoTotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("hanaTenshoMemoMemory1") var memo = ""
    @AppStorage("hanaTenshoDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class HanaTenshoMemory2: ObservableObject {
    @AppStorage("hanaTenshoKenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoKenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("hanaTenshoKenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("hanaTenshoKenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("hanaTenshoKenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoKenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("hanaTenshoKenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoStartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoStartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("hanaTenshoStartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("hanaTenshoStartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("hanaTenshoStartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoStartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("hanaTenshoStartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoBellCountMemory2") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory2") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory2") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("hanaTenshoCurrentGamesMemory2") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory2") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory2") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoTotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("hanaTenshoTotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("hanaTenshoTotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("hanaTenshoTotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("hanaTenshoMemoMemory2") var memo = ""
    @AppStorage("hanaTenshoDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class HanaTenshoMemory3: ObservableObject {
    @AppStorage("hanaTenshoKenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoKenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("hanaTenshoKenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("hanaTenshoKenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("hanaTenshoKenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoKenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("hanaTenshoKenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoStartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("hanaTenshoStartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("hanaTenshoStartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("hanaTenshoStartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("hanaTenshoStartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("hanaTenshoStartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("hanaTenshoStartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("hanaTenshoBellCountMemory3") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory3") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory3") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("hanaTenshoCurrentGamesMemory3") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory3") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory3") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoTotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("hanaTenshoTotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("hanaTenshoTotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("hanaTenshoTotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("hanaTenshoMemoMemory3") var memo = ""
    @AppStorage("hanaTenshoDateMemory3") var dateDouble = 0.0
}

struct hanaTenshoVer2ViewTop: View {
    @ObservedObject var hanaTensho = HanaTensho()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "ハナハナ鳳凰天翔")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: hanaTenshoVer2ViewKenDataInput()) {
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
                    NavigationLink(destination: hanaTenshoVer2ViewJissenStartData()) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: hanaTenshoVer2ViewJissenCount()) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: hanaTenshoVer2ViewJissenTotalDataCheck()) {
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
                NavigationLink(destination: hanaTenshoVer2View95CiTotal()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4014")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(hanaTenshoSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(hanaTenshoSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hanaTensho.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct hanaTenshoSubViewSaveMemory: View {
    @ObservedObject var hanaTensho = HanaTensho()
    @ObservedObject var hanaTenshoMemory1 = HanaTenshoMemory1()
    @ObservedObject var hanaTenshoMemory2 = HanaTenshoMemory2()
    @ObservedObject var hanaTenshoMemory3 = HanaTenshoMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ハナハナ鳳凰天翔",
            selectedMemory: $hanaTensho.selectedMemory,
            memoMemory1: $hanaTenshoMemory1.memo,
            dateDoubleMemory1: $hanaTenshoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hanaTenshoMemory2.memo,
            dateDoubleMemory2: $hanaTenshoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hanaTenshoMemory3.memo,
            dateDoubleMemory3: $hanaTenshoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hanaTenshoMemory1.kenBackCalculationEnable = hanaTensho.kenBackCalculationEnable
        hanaTenshoMemory1.kenGameIput = hanaTensho.kenGameIput
        hanaTenshoMemory1.kenBigCountInput = hanaTensho.kenBigCountInput
        hanaTenshoMemory1.kenRegCountInput = hanaTensho.kenRegCountInput
        hanaTenshoMemory1.kenCoinDifferenceInput = hanaTensho.kenCoinDifferenceInput
        hanaTenshoMemory1.kenBonusCountSum = hanaTensho.kenBonusCountSum
        hanaTenshoMemory1.kenBellBackCalculationCount = hanaTensho.kenBellBackCalculationCount
        hanaTenshoMemory1.startBackCalculationEnable = hanaTensho.startBackCalculationEnable
        hanaTenshoMemory1.startGameInput = hanaTensho.startGameInput
        hanaTenshoMemory1.startBigCountInput = hanaTensho.startBigCountInput
        hanaTenshoMemory1.startRegCountInput = hanaTensho.startRegCountInput
        hanaTenshoMemory1.startCoinDifferenceInput = hanaTensho.startCoinDifferenceInput
        hanaTenshoMemory1.startBonusCountSum = hanaTensho.startBonusCountSum
        hanaTenshoMemory1.startBellBackCalculationCount = hanaTensho.startBellBackCalculationCount
        hanaTenshoMemory1.bellCount = hanaTensho.bellCount
        hanaTenshoMemory1.bigCount = hanaTensho.bigCount
        hanaTenshoMemory1.regCount = hanaTensho.regCount
        hanaTenshoMemory1.bbSuikaCount = hanaTensho.bbSuikaCount
        hanaTenshoMemory1.bbLampBCount = hanaTensho.bbLampBCount
        hanaTenshoMemory1.bbLampYCount = hanaTensho.bbLampYCount
        hanaTenshoMemory1.bbLampGCount = hanaTensho.bbLampGCount
        hanaTenshoMemory1.bbLampRCount = hanaTensho.bbLampRCount
        hanaTenshoMemory1.rbLampBCount = hanaTensho.rbLampBCount
        hanaTenshoMemory1.rbLampYCount = hanaTensho.rbLampYCount
        hanaTenshoMemory1.rbLampGCount = hanaTensho.rbLampGCount
        hanaTenshoMemory1.rbLampRCount = hanaTensho.rbLampRCount
        hanaTenshoMemory1.currentGames = hanaTensho.currentGames
        hanaTenshoMemory1.totalBonus = hanaTensho.totalBonus
        hanaTenshoMemory1.playGames = hanaTensho.playGames
        hanaTenshoMemory1.bigPlayGames = hanaTensho.bigPlayGames
        hanaTenshoMemory1.bbLampCountSum = hanaTensho.bbLampCountSum
        hanaTenshoMemory1.rbLampCountSum = hanaTensho.rbLampCountSum
        hanaTenshoMemory1.rbLampKisuCountSum = hanaTensho.rbLampKisuCountSum
        hanaTenshoMemory1.rbLampGusuCountSum = hanaTensho.rbLampGusuCountSum
        hanaTenshoMemory1.totalBigCount = hanaTensho.totalBigCount
        hanaTenshoMemory1.totalRegCount = hanaTensho.totalRegCount
        hanaTenshoMemory1.totalBellCount = hanaTensho.totalBellCount
        hanaTenshoMemory1.totalBonusCountSum = hanaTensho.totalBonusCountSum
    }
    func saveMemory2() {
        hanaTenshoMemory2.kenBackCalculationEnable = hanaTensho.kenBackCalculationEnable
        hanaTenshoMemory2.kenGameIput = hanaTensho.kenGameIput
        hanaTenshoMemory2.kenBigCountInput = hanaTensho.kenBigCountInput
        hanaTenshoMemory2.kenRegCountInput = hanaTensho.kenRegCountInput
        hanaTenshoMemory2.kenCoinDifferenceInput = hanaTensho.kenCoinDifferenceInput
        hanaTenshoMemory2.kenBonusCountSum = hanaTensho.kenBonusCountSum
        hanaTenshoMemory2.kenBellBackCalculationCount = hanaTensho.kenBellBackCalculationCount
        hanaTenshoMemory2.startBackCalculationEnable = hanaTensho.startBackCalculationEnable
        hanaTenshoMemory2.startGameInput = hanaTensho.startGameInput
        hanaTenshoMemory2.startBigCountInput = hanaTensho.startBigCountInput
        hanaTenshoMemory2.startRegCountInput = hanaTensho.startRegCountInput
        hanaTenshoMemory2.startCoinDifferenceInput = hanaTensho.startCoinDifferenceInput
        hanaTenshoMemory2.startBonusCountSum = hanaTensho.startBonusCountSum
        hanaTenshoMemory2.startBellBackCalculationCount = hanaTensho.startBellBackCalculationCount
        hanaTenshoMemory2.bellCount = hanaTensho.bellCount
        hanaTenshoMemory2.bigCount = hanaTensho.bigCount
        hanaTenshoMemory2.regCount = hanaTensho.regCount
        hanaTenshoMemory2.bbSuikaCount = hanaTensho.bbSuikaCount
        hanaTenshoMemory2.bbLampBCount = hanaTensho.bbLampBCount
        hanaTenshoMemory2.bbLampYCount = hanaTensho.bbLampYCount
        hanaTenshoMemory2.bbLampGCount = hanaTensho.bbLampGCount
        hanaTenshoMemory2.bbLampRCount = hanaTensho.bbLampRCount
        hanaTenshoMemory2.rbLampBCount = hanaTensho.rbLampBCount
        hanaTenshoMemory2.rbLampYCount = hanaTensho.rbLampYCount
        hanaTenshoMemory2.rbLampGCount = hanaTensho.rbLampGCount
        hanaTenshoMemory2.rbLampRCount = hanaTensho.rbLampRCount
        hanaTenshoMemory2.currentGames = hanaTensho.currentGames
        hanaTenshoMemory2.totalBonus = hanaTensho.totalBonus
        hanaTenshoMemory2.playGames = hanaTensho.playGames
        hanaTenshoMemory2.bigPlayGames = hanaTensho.bigPlayGames
        hanaTenshoMemory2.bbLampCountSum = hanaTensho.bbLampCountSum
        hanaTenshoMemory2.rbLampCountSum = hanaTensho.rbLampCountSum
        hanaTenshoMemory2.rbLampKisuCountSum = hanaTensho.rbLampKisuCountSum
        hanaTenshoMemory2.rbLampGusuCountSum = hanaTensho.rbLampGusuCountSum
        hanaTenshoMemory2.totalBigCount = hanaTensho.totalBigCount
        hanaTenshoMemory2.totalRegCount = hanaTensho.totalRegCount
        hanaTenshoMemory2.totalBellCount = hanaTensho.totalBellCount
        hanaTenshoMemory2.totalBonusCountSum = hanaTensho.totalBonusCountSum
    }
    func saveMemory3() {
        hanaTenshoMemory3.kenBackCalculationEnable = hanaTensho.kenBackCalculationEnable
        hanaTenshoMemory3.kenGameIput = hanaTensho.kenGameIput
        hanaTenshoMemory3.kenBigCountInput = hanaTensho.kenBigCountInput
        hanaTenshoMemory3.kenRegCountInput = hanaTensho.kenRegCountInput
        hanaTenshoMemory3.kenCoinDifferenceInput = hanaTensho.kenCoinDifferenceInput
        hanaTenshoMemory3.kenBonusCountSum = hanaTensho.kenBonusCountSum
        hanaTenshoMemory3.kenBellBackCalculationCount = hanaTensho.kenBellBackCalculationCount
        hanaTenshoMemory3.startBackCalculationEnable = hanaTensho.startBackCalculationEnable
        hanaTenshoMemory3.startGameInput = hanaTensho.startGameInput
        hanaTenshoMemory3.startBigCountInput = hanaTensho.startBigCountInput
        hanaTenshoMemory3.startRegCountInput = hanaTensho.startRegCountInput
        hanaTenshoMemory3.startCoinDifferenceInput = hanaTensho.startCoinDifferenceInput
        hanaTenshoMemory3.startBonusCountSum = hanaTensho.startBonusCountSum
        hanaTenshoMemory3.startBellBackCalculationCount = hanaTensho.startBellBackCalculationCount
        hanaTenshoMemory3.bellCount = hanaTensho.bellCount
        hanaTenshoMemory3.bigCount = hanaTensho.bigCount
        hanaTenshoMemory3.regCount = hanaTensho.regCount
        hanaTenshoMemory3.bbSuikaCount = hanaTensho.bbSuikaCount
        hanaTenshoMemory3.bbLampBCount = hanaTensho.bbLampBCount
        hanaTenshoMemory3.bbLampYCount = hanaTensho.bbLampYCount
        hanaTenshoMemory3.bbLampGCount = hanaTensho.bbLampGCount
        hanaTenshoMemory3.bbLampRCount = hanaTensho.bbLampRCount
        hanaTenshoMemory3.rbLampBCount = hanaTensho.rbLampBCount
        hanaTenshoMemory3.rbLampYCount = hanaTensho.rbLampYCount
        hanaTenshoMemory3.rbLampGCount = hanaTensho.rbLampGCount
        hanaTenshoMemory3.rbLampRCount = hanaTensho.rbLampRCount
        hanaTenshoMemory3.currentGames = hanaTensho.currentGames
        hanaTenshoMemory3.totalBonus = hanaTensho.totalBonus
        hanaTenshoMemory3.playGames = hanaTensho.playGames
        hanaTenshoMemory3.bigPlayGames = hanaTensho.bigPlayGames
        hanaTenshoMemory3.bbLampCountSum = hanaTensho.bbLampCountSum
        hanaTenshoMemory3.rbLampCountSum = hanaTensho.rbLampCountSum
        hanaTenshoMemory3.rbLampKisuCountSum = hanaTensho.rbLampKisuCountSum
        hanaTenshoMemory3.rbLampGusuCountSum = hanaTensho.rbLampGusuCountSum
        hanaTenshoMemory3.totalBigCount = hanaTensho.totalBigCount
        hanaTenshoMemory3.totalRegCount = hanaTensho.totalRegCount
        hanaTenshoMemory3.totalBellCount = hanaTensho.totalBellCount
        hanaTenshoMemory3.totalBonusCountSum = hanaTensho.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct hanaTenshoSubViewLoadMemory: View {
    @ObservedObject var hanaTensho = HanaTensho()
    @ObservedObject var hanaTenshoMemory1 = HanaTenshoMemory1()
    @ObservedObject var hanaTenshoMemory2 = HanaTenshoMemory2()
    @ObservedObject var hanaTenshoMemory3 = HanaTenshoMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ハナハナ鳳凰天翔",
            selectedMemory: $hanaTensho.selectedMemory,
            memoMemory1: hanaTenshoMemory1.memo,
            dateDoubleMemory1: hanaTenshoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hanaTenshoMemory2.memo,
            dateDoubleMemory2: hanaTenshoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hanaTenshoMemory3.memo,
            dateDoubleMemory3: hanaTenshoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        hanaTensho.kenBackCalculationEnable = hanaTenshoMemory1.kenBackCalculationEnable
        hanaTensho.kenGameIput = hanaTenshoMemory1.kenGameIput
        hanaTensho.kenBigCountInput = hanaTenshoMemory1.kenBigCountInput
        hanaTensho.kenRegCountInput = hanaTenshoMemory1.kenRegCountInput
        hanaTensho.kenCoinDifferenceInput = hanaTenshoMemory1.kenCoinDifferenceInput
        hanaTensho.kenBonusCountSum = hanaTenshoMemory1.kenBonusCountSum
        hanaTensho.kenBellBackCalculationCount = hanaTenshoMemory1.kenBellBackCalculationCount
        hanaTensho.startBackCalculationEnable = hanaTenshoMemory1.startBackCalculationEnable
        hanaTensho.startGameInput = hanaTenshoMemory1.startGameInput
        hanaTensho.startBigCountInput = hanaTenshoMemory1.startBigCountInput
        hanaTensho.startRegCountInput = hanaTenshoMemory1.startRegCountInput
        hanaTensho.startCoinDifferenceInput = hanaTenshoMemory1.startCoinDifferenceInput
        hanaTensho.startBonusCountSum = hanaTenshoMemory1.startBonusCountSum
        hanaTensho.startBellBackCalculationCount = hanaTenshoMemory1.startBellBackCalculationCount
        hanaTensho.bellCount = hanaTenshoMemory1.bellCount
        hanaTensho.bigCount = hanaTenshoMemory1.bigCount
        hanaTensho.regCount = hanaTenshoMemory1.regCount
        hanaTensho.bbSuikaCount = hanaTenshoMemory1.bbSuikaCount
        hanaTensho.bbLampBCount = hanaTenshoMemory1.bbLampBCount
        hanaTensho.bbLampYCount = hanaTenshoMemory1.bbLampYCount
        hanaTensho.bbLampGCount = hanaTenshoMemory1.bbLampGCount
        hanaTensho.bbLampRCount = hanaTenshoMemory1.bbLampRCount
        hanaTensho.rbLampBCount = hanaTenshoMemory1.rbLampBCount
        hanaTensho.rbLampYCount = hanaTenshoMemory1.rbLampYCount
        hanaTensho.rbLampGCount = hanaTenshoMemory1.rbLampGCount
        hanaTensho.rbLampRCount = hanaTenshoMemory1.rbLampRCount
        hanaTensho.currentGames = hanaTenshoMemory1.currentGames
        hanaTensho.totalBonus = hanaTenshoMemory1.totalBonus
        hanaTensho.playGames = hanaTenshoMemory1.playGames
        hanaTensho.bigPlayGames = hanaTenshoMemory1.bigPlayGames
        hanaTensho.bbLampCountSum = hanaTenshoMemory1.bbLampCountSum
        hanaTensho.rbLampCountSum = hanaTenshoMemory1.rbLampCountSum
        hanaTensho.rbLampKisuCountSum = hanaTenshoMemory1.rbLampKisuCountSum
        hanaTensho.rbLampGusuCountSum = hanaTenshoMemory1.rbLampGusuCountSum
        hanaTensho.totalBigCount = hanaTenshoMemory1.totalBigCount
        hanaTensho.totalRegCount = hanaTenshoMemory1.totalRegCount
        hanaTensho.totalBellCount = hanaTenshoMemory1.totalBellCount
        hanaTensho.totalBonusCountSum = hanaTenshoMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        hanaTensho.kenBackCalculationEnable = hanaTenshoMemory2.kenBackCalculationEnable
        hanaTensho.kenGameIput = hanaTenshoMemory2.kenGameIput
        hanaTensho.kenBigCountInput = hanaTenshoMemory2.kenBigCountInput
        hanaTensho.kenRegCountInput = hanaTenshoMemory2.kenRegCountInput
        hanaTensho.kenCoinDifferenceInput = hanaTenshoMemory2.kenCoinDifferenceInput
        hanaTensho.kenBonusCountSum = hanaTenshoMemory2.kenBonusCountSum
        hanaTensho.kenBellBackCalculationCount = hanaTenshoMemory2.kenBellBackCalculationCount
        hanaTensho.startBackCalculationEnable = hanaTenshoMemory2.startBackCalculationEnable
        hanaTensho.startGameInput = hanaTenshoMemory2.startGameInput
        hanaTensho.startBigCountInput = hanaTenshoMemory2.startBigCountInput
        hanaTensho.startRegCountInput = hanaTenshoMemory2.startRegCountInput
        hanaTensho.startCoinDifferenceInput = hanaTenshoMemory2.startCoinDifferenceInput
        hanaTensho.startBonusCountSum = hanaTenshoMemory2.startBonusCountSum
        hanaTensho.startBellBackCalculationCount = hanaTenshoMemory2.startBellBackCalculationCount
        hanaTensho.bellCount = hanaTenshoMemory2.bellCount
        hanaTensho.bigCount = hanaTenshoMemory2.bigCount
        hanaTensho.regCount = hanaTenshoMemory2.regCount
        hanaTensho.bbSuikaCount = hanaTenshoMemory2.bbSuikaCount
        hanaTensho.bbLampBCount = hanaTenshoMemory2.bbLampBCount
        hanaTensho.bbLampYCount = hanaTenshoMemory2.bbLampYCount
        hanaTensho.bbLampGCount = hanaTenshoMemory2.bbLampGCount
        hanaTensho.bbLampRCount = hanaTenshoMemory2.bbLampRCount
        hanaTensho.rbLampBCount = hanaTenshoMemory2.rbLampBCount
        hanaTensho.rbLampYCount = hanaTenshoMemory2.rbLampYCount
        hanaTensho.rbLampGCount = hanaTenshoMemory2.rbLampGCount
        hanaTensho.rbLampRCount = hanaTenshoMemory2.rbLampRCount
        hanaTensho.currentGames = hanaTenshoMemory2.currentGames
        hanaTensho.totalBonus = hanaTenshoMemory2.totalBonus
        hanaTensho.playGames = hanaTenshoMemory2.playGames
        hanaTensho.bigPlayGames = hanaTenshoMemory2.bigPlayGames
        hanaTensho.bbLampCountSum = hanaTenshoMemory2.bbLampCountSum
        hanaTensho.rbLampCountSum = hanaTenshoMemory2.rbLampCountSum
        hanaTensho.rbLampKisuCountSum = hanaTenshoMemory2.rbLampKisuCountSum
        hanaTensho.rbLampGusuCountSum = hanaTenshoMemory2.rbLampGusuCountSum
        hanaTensho.totalBigCount = hanaTenshoMemory2.totalBigCount
        hanaTensho.totalRegCount = hanaTenshoMemory2.totalRegCount
        hanaTensho.totalBellCount = hanaTenshoMemory2.totalBellCount
        hanaTensho.totalBonusCountSum = hanaTenshoMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        hanaTensho.kenBackCalculationEnable = hanaTenshoMemory3.kenBackCalculationEnable
        hanaTensho.kenGameIput = hanaTenshoMemory3.kenGameIput
        hanaTensho.kenBigCountInput = hanaTenshoMemory3.kenBigCountInput
        hanaTensho.kenRegCountInput = hanaTenshoMemory3.kenRegCountInput
        hanaTensho.kenCoinDifferenceInput = hanaTenshoMemory3.kenCoinDifferenceInput
        hanaTensho.kenBonusCountSum = hanaTenshoMemory3.kenBonusCountSum
        hanaTensho.kenBellBackCalculationCount = hanaTenshoMemory3.kenBellBackCalculationCount
        hanaTensho.startBackCalculationEnable = hanaTenshoMemory3.startBackCalculationEnable
        hanaTensho.startGameInput = hanaTenshoMemory3.startGameInput
        hanaTensho.startBigCountInput = hanaTenshoMemory3.startBigCountInput
        hanaTensho.startRegCountInput = hanaTenshoMemory3.startRegCountInput
        hanaTensho.startCoinDifferenceInput = hanaTenshoMemory3.startCoinDifferenceInput
        hanaTensho.startBonusCountSum = hanaTenshoMemory3.startBonusCountSum
        hanaTensho.startBellBackCalculationCount = hanaTenshoMemory3.startBellBackCalculationCount
        hanaTensho.bellCount = hanaTenshoMemory3.bellCount
        hanaTensho.bigCount = hanaTenshoMemory3.bigCount
        hanaTensho.regCount = hanaTenshoMemory3.regCount
        hanaTensho.bbSuikaCount = hanaTenshoMemory3.bbSuikaCount
        hanaTensho.bbLampBCount = hanaTenshoMemory3.bbLampBCount
        hanaTensho.bbLampYCount = hanaTenshoMemory3.bbLampYCount
        hanaTensho.bbLampGCount = hanaTenshoMemory3.bbLampGCount
        hanaTensho.bbLampRCount = hanaTenshoMemory3.bbLampRCount
        hanaTensho.rbLampBCount = hanaTenshoMemory3.rbLampBCount
        hanaTensho.rbLampYCount = hanaTenshoMemory3.rbLampYCount
        hanaTensho.rbLampGCount = hanaTenshoMemory3.rbLampGCount
        hanaTensho.rbLampRCount = hanaTenshoMemory3.rbLampRCount
        hanaTensho.currentGames = hanaTenshoMemory3.currentGames
        hanaTensho.totalBonus = hanaTenshoMemory3.totalBonus
        hanaTensho.playGames = hanaTenshoMemory3.playGames
        hanaTensho.bigPlayGames = hanaTenshoMemory3.bigPlayGames
        hanaTensho.bbLampCountSum = hanaTenshoMemory3.bbLampCountSum
        hanaTensho.rbLampCountSum = hanaTenshoMemory3.rbLampCountSum
        hanaTensho.rbLampKisuCountSum = hanaTenshoMemory3.rbLampKisuCountSum
        hanaTensho.rbLampGusuCountSum = hanaTenshoMemory3.rbLampGusuCountSum
        hanaTensho.totalBigCount = hanaTenshoMemory3.totalBigCount
        hanaTensho.totalRegCount = hanaTenshoMemory3.totalRegCount
        hanaTensho.totalBellCount = hanaTenshoMemory3.totalBellCount
        hanaTensho.totalBonusCountSum = hanaTenshoMemory3.totalBonusCountSum
    }
}

#Preview {
    hanaTenshoVer2ViewTop()
}
