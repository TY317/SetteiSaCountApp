//
//  myJug5Ver2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/12.
//

import SwiftUI
import FirebaseAnalytics

// ///////////////////////
// 変数
// ///////////////////////
class MyJug5: ObservableObject {
    // ////////////////////////
    // 確率値
    // ////////////////////////
    let denominateListBell: [Double] = [
        5.90,
        5.85,
        5.80,
        5.78,
        5.76,
        5.66
    ]
    
    let denominateListBigSum: [Double] = [
        273,
        271,
        266,
        254,
        240,
        229
    ]
    
    let denominateListRegSum: [Double] = [
        410,
        386,
        336,
        290,
        269,
        229
    ]
    
    let denominateListRegAlone: [Double] = [
        655,
        596,
        497,
        405,
        390,
        328
    ]
    
    let denominateListRegCherry: [Double] = [
        1092,
        1092,
        1040,
        1024,
        862,
        762
    ]
    
    let denominateListBonusSum: [Double] = [
        164,
        159,
        149,
        135,
        127,
        115
    ]
    
    // ////////////////////////
    // 見
    // ////////////////////////
    @AppStorage("myJug5KenBackCalculationEnable") var kenBackCalculationEnable: Bool = false {
        didSet {
            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
        }
    }
        @AppStorage("myJug5KenGameIput") var kenGameIput: Int = 0 {
            didSet {
                kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
            }
        }
            @AppStorage("myJug5KenBigCountInput") var kenBigCountInput: Int = 0 {
                didSet {
                    kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                    kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                }
            }
                @AppStorage("myJug5KenRegCountInput") var kenRegCountInput: Int = 0 {
                    didSet {
                        kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        kenBonusCountSum = countSum(kenBigCountInput, kenRegCountInput)
                    }
                }
                    @AppStorage("myJug5KenCoinDifferenceInput") var kenCoinDifferenceInput: Int = 0 {
                        didSet {
                            kenBellBackCalculationCount = bellBackCalculate(game: kenGameIput, bigCount: kenBigCountInput, regCount: kenRegCountInput, coinDifference: kenCoinDifferenceInput)
                        }
                    }
    @AppStorage("myJug5KenBonusCountSum") var kenBonusCountSum: Int = 0
    @AppStorage("myJug5KenBellBackCalculationCount") var kenBellBackCalculationCount: Int = 0
    
    func bellBackCalculate(game: Int, bigCount: Int, regCount: Int, coinDifference: Int) -> Int {
        // 各種確率の定義
        let replayDenominate = 7.298   // リプレイ確率
        let cherryDenominate: Double = 34   // チェリー確率
        let cherryGetRatio = 0.9   // チェリー奪取率
        let budonukiAverageGame = 1.31   // ぶどう抜き平均消化ゲーム数（1枚がけ）
        let budonukiAverageIn = 1.13   // ぶどう抜き平均IN枚数
        let budonukiAverageOut = 1.01   // ぶどう抜き平均OUT枚数
        let bigOut: Double = 240   // ビッグ獲得枚数
        let regOut: Double = 96   // REG獲得枚数
        let cherryOut: Double = 2   // チェリー払い出し枚数
        let bellOut: Double = 8   // ぶどう・ベル払い出し枚数
        
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
        let outTotalWithoutBell = budonukiOut + bigOutTotal + regOutTotal + cherryOutTotal
        
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
    @AppStorage("myJug5StartBackCalculationEnable") var startBackCalculationEnable: Bool = false {
        didSet {
            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
        }
    }
        @AppStorage("myJug5StartGames") var startGameInput: Int = 0 {
            didSet {
                startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                playGame = currentGames - startGameInput
            }
        }
            @AppStorage("myJug5StartBigCountInput") var startBigCountInput: Int = 0 {
                didSet {
                    startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                    startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                    totalBigCount = countSum(startBigCountInput, personalBigCount)
                }
            }
                @AppStorage("myJug5StartRegCountInput") var startRegCountInput: Int = 0 {
                    didSet {
                        startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        startBonusCountSum = countSum(startBigCountInput, startRegCountInput)
                        totalRegCount = countSum(startRegCountInput, personalRegCountSum)
                    }
                }
                    @AppStorage("myJug5StartCoinDifferenceInput") var startCoinDifferenceInput: Int = 0 {
                        didSet {
                            startBellBackCalculationCount = bellBackCalculate(game: startGameInput, bigCount: startBigCountInput, regCount: startRegCountInput, coinDifference: startCoinDifferenceInput)
                        }
                    }
    @AppStorage("myJug5StartBonusCountSum") var startBonusCountSum: Int = 0
    @AppStorage("myJug5StartBellBackCalculationCount") var startBellBackCalculationCount: Int = 0 {
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
    @AppStorage("myJug5BellCount") var personalBellCount = 0 {
        didSet {
            totalBellCount = countSum(startBellBackCalculationCount, personalBellCount)
        }
    }
    @AppStorage("myJug5BigCount") var personalBigCount = 0 {
        didSet {
            personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
            totalBigCount = countSum(startBigCountInput, personalBigCount)
        }
    }
        @AppStorage("myJug5AloneRegCount") var personalAloneRegCount = 0 {
            didSet {
                personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
                personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
            }
        }
            @AppStorage("myJug5CherryRegCount") var personalCherryRegCount = 0 {
                didSet {
                    personalBonusCountSum = countSum(personalBigCount, personalAloneRegCount, personalCherryRegCount)
                    personalRegCountSum = countSum(personalAloneRegCount, personalCherryRegCount)
                }
            }
    @AppStorage("myJug5CurrentGames") var currentGames = 0 {
        didSet {
            playGame = currentGames - startGameInput
        }
    }
    @AppStorage("myJug5RegCountSum") var personalRegCountSum = 0 {
        didSet {
            totalRegCount = countSum(startRegCountInput, personalRegCountSum)
        }
    }
    @AppStorage("myJug5BonusCountSum") var personalBonusCountSum = 0
    @AppStorage("myJug5PlayGame") var playGame = 0
    
    func resetCountData() {
        personalBellCount = 0
        personalBigCount = 0
        personalAloneRegCount = 0
        personalCherryRegCount = 0
        currentGames = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 実戦 トータル結果
    // ////////////////////////
    @AppStorage("myJug5TotalBigCount") var totalBigCount = 0 {
        didSet {
            totalBonusCountSum = countSum(totalBigCount, totalRegCount)
        }
    }
        @AppStorage("myJug5TotalRegCount") var totalRegCount = 0 {
            didSet {
                totalBonusCountSum = countSum(totalBigCount, totalRegCount)
            }
        }
    @AppStorage("myJug5TotalBellCount") var totalBellCount = 0
    @AppStorage("myJug5TotalBonusCountSum") var totalBonusCountSum = 0
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("myJug5MinusCheck") var minusCheck: Bool = false
    @AppStorage("myJug5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKenDataInput()
        resetStartData()
        resetCountData()
    }
}


// //// メモリー1
class MyJug5Memory1: ObservableObject {
    @AppStorage("myJug5KenBackCalculationEnableMemory1") var kenBackCalculationEnable: Bool = false
    @AppStorage("myJug5KenGameIputMemory1") var kenGameIput: Int = 0
    @AppStorage("myJug5KenBigCountInputMemory1") var kenBigCountInput: Int = 0
    @AppStorage("myJug5KenRegCountInputMemory1") var kenRegCountInput: Int = 0
    @AppStorage("myJug5KenCoinDifferenceInputMemory1") var kenCoinDifferenceInput: Int = 0
    @AppStorage("myJug5KenBonusCountSumMemory1") var kenBonusCountSum: Int = 0
    @AppStorage("myJug5KenBellBackCalculationCountMemory1") var kenBellBackCalculationCount: Int = 0
    @AppStorage("myJug5StartBackCalculationEnableMemory1") var startBackCalculationEnable: Bool = false
    @AppStorage("myJug5StartGamesMemory1") var startGameInput: Int = 0
    @AppStorage("myJug5StartBigCountInputMemory1") var startBigCountInput: Int = 0
    @AppStorage("myJug5StartRegCountInputMemory1") var startRegCountInput: Int = 0
    @AppStorage("myJug5StartCoinDifferenceInputMemory1") var startCoinDifferenceInput: Int = 0
    @AppStorage("myJug5StartBonusCountSumMemory1") var startBonusCountSum: Int = 0
    @AppStorage("myJug5StartBellBackCalculationCountMemory1") var startBellBackCalculationCount: Int = 0
    @AppStorage("myJug5BellCountMemory1") var personalBellCount = 0
    @AppStorage("myJug5BigCountMemory1") var personalBigCount = 0
    @AppStorage("myJug5AloneRegCountMemory1") var personalAloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory1") var personalCherryRegCount = 0
    @AppStorage("myJug5CurrentGamesMemory1") var currentGames = 0
    @AppStorage("myJug5RegCountSumMemory1") var personalRegCountSum = 0
    @AppStorage("myJug5BonusCountSumMemory1") var personalBonusCountSum = 0
    @AppStorage("myJug5PlayGameMemory1") var playGame = 0
    @AppStorage("myJug5TotalBigCountMemory1") var totalBigCount = 0
    @AppStorage("myJug5TotalRegCountMemory1") var totalRegCount = 0
    @AppStorage("myJug5TotalBellCountMemory1") var totalBellCount = 0
    @AppStorage("myJug5TotalBonusCountSumMemory1") var totalBonusCountSum = 0
    @AppStorage("myJug5MemoMemory1") var memo = ""
    @AppStorage("myJug5DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class MyJug5Memory2: ObservableObject {
    @AppStorage("myJug5KenBackCalculationEnableMemory2") var kenBackCalculationEnable: Bool = false
    @AppStorage("myJug5KenGameIputMemory2") var kenGameIput: Int = 0
    @AppStorage("myJug5KenBigCountInputMemory2") var kenBigCountInput: Int = 0
    @AppStorage("myJug5KenRegCountInputMemory2") var kenRegCountInput: Int = 0
    @AppStorage("myJug5KenCoinDifferenceInputMemory2") var kenCoinDifferenceInput: Int = 0
    @AppStorage("myJug5KenBonusCountSumMemory2") var kenBonusCountSum: Int = 0
    @AppStorage("myJug5KenBellBackCalculationCountMemory2") var kenBellBackCalculationCount: Int = 0
    @AppStorage("myJug5StartBackCalculationEnableMemory2") var startBackCalculationEnable: Bool = false
    @AppStorage("myJug5StartGamesMemory2") var startGameInput: Int = 0
    @AppStorage("myJug5StartBigCountInputMemory2") var startBigCountInput: Int = 0
    @AppStorage("myJug5StartRegCountInputMemory2") var startRegCountInput: Int = 0
    @AppStorage("myJug5StartCoinDifferenceInputMemory2") var startCoinDifferenceInput: Int = 0
    @AppStorage("myJug5StartBonusCountSumMemory2") var startBonusCountSum: Int = 0
    @AppStorage("myJug5StartBellBackCalculationCountMemory2") var startBellBackCalculationCount: Int = 0
    @AppStorage("myJug5BellCountMemory2") var personalBellCount = 0
    @AppStorage("myJug5BigCountMemory2") var personalBigCount = 0
    @AppStorage("myJug5AloneRegCountMemory2") var personalAloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory2") var personalCherryRegCount = 0
    @AppStorage("myJug5CurrentGamesMemory2") var currentGames = 0
    @AppStorage("myJug5RegCountSumMemory2") var personalRegCountSum = 0
    @AppStorage("myJug5BonusCountSumMemory2") var personalBonusCountSum = 0
    @AppStorage("myJug5PlayGameMemory2") var playGame = 0
    @AppStorage("myJug5TotalBigCountMemory2") var totalBigCount = 0
    @AppStorage("myJug5TotalRegCountMemory2") var totalRegCount = 0
    @AppStorage("myJug5TotalBellCountMemory2") var totalBellCount = 0
    @AppStorage("myJug5TotalBonusCountSumMemory2") var totalBonusCountSum = 0
    @AppStorage("myJug5MemoMemory2") var memo = ""
    @AppStorage("myJug5DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class MyJug5Memory3: ObservableObject {
    @AppStorage("myJug5KenBackCalculationEnableMemory3") var kenBackCalculationEnable: Bool = false
    @AppStorage("myJug5KenGameIputMemory3") var kenGameIput: Int = 0
    @AppStorage("myJug5KenBigCountInputMemory3") var kenBigCountInput: Int = 0
    @AppStorage("myJug5KenRegCountInputMemory3") var kenRegCountInput: Int = 0
    @AppStorage("myJug5KenCoinDifferenceInputMemory3") var kenCoinDifferenceInput: Int = 0
    @AppStorage("myJug5KenBonusCountSumMemory3") var kenBonusCountSum: Int = 0
    @AppStorage("myJug5KenBellBackCalculationCountMemory3") var kenBellBackCalculationCount: Int = 0
    @AppStorage("myJug5StartBackCalculationEnableMemory3") var startBackCalculationEnable: Bool = false
    @AppStorage("myJug5StartGamesMemory3") var startGameInput: Int = 0
    @AppStorage("myJug5StartBigCountInputMemory3") var startBigCountInput: Int = 0
    @AppStorage("myJug5StartRegCountInputMemory3") var startRegCountInput: Int = 0
    @AppStorage("myJug5StartCoinDifferenceInputMemory3") var startCoinDifferenceInput: Int = 0
    @AppStorage("myJug5StartBonusCountSumMemory3") var startBonusCountSum: Int = 0
    @AppStorage("myJug5StartBellBackCalculationCountMemory3") var startBellBackCalculationCount: Int = 0
    @AppStorage("myJug5BellCountMemory3") var personalBellCount = 0
    @AppStorage("myJug5BigCountMemory3") var personalBigCount = 0
    @AppStorage("myJug5AloneRegCountMemory3") var personalAloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory3") var personalCherryRegCount = 0
    @AppStorage("myJug5CurrentGamesMemory3") var currentGames = 0
    @AppStorage("myJug5RegCountSumMemory3") var personalRegCountSum = 0
    @AppStorage("myJug5BonusCountSumMemory3") var personalBonusCountSum = 0
    @AppStorage("myJug5PlayGameMemory3") var playGame = 0
    @AppStorage("myJug5TotalBigCountMemory3") var totalBigCount = 0
    @AppStorage("myJug5TotalRegCountMemory3") var totalRegCount = 0
    @AppStorage("myJug5TotalBellCountMemory3") var totalBellCount = 0
    @AppStorage("myJug5TotalBonusCountSumMemory3") var totalBonusCountSum = 0
    @AppStorage("myJug5MemoMemory3") var memo = ""
    @AppStorage("myJug5DateMemory3") var dateDouble = 0.0
}


struct myJug5Ver2ViewTop: View {
//    @ObservedObject var myJug5 = MyJug5()
    @StateObject var myJug5 = MyJug5()
    @State var isShowAlert: Bool = false
    @StateObject var myJug5Memory1 = MyJug5Memory1()
    @StateObject var myJug5Memory2 = MyJug5Memory2()
    @StateObject var myJug5Memory3 = MyJug5Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "マイジャグラー5")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: myJug5Ver2ViewKenDataInput(myJug5: myJug5)) {
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
                    NavigationLink(destination: myJug5Ver2ViewJissenStartData(myJug5: myJug5)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: myJug5Ver2ViewJissenCount(myJug5: myJug5)) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: myJug5Ver2ViewJissenTotalDataCheck(myJug5: myJug5)) {
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
                NavigationLink(destination: myJug5Ver2View95CiTotal(myJug5: myJug5)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                NavigationLink(destination: myJug5ViewBayseTest(
                    myJug5: myJug5,
                )) {
                    Text("ベイステスト")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4029")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マイジャグラー5",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "マイジャグラー5", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "myJug5Ver2ViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: myJug5Ver2ViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(myJug5SubViewLoadMemory(
                        myJug5: myJug5,
                        myJug5Memory1: myJug5Memory1,
                        myJug5Memory2: myJug5Memory2,
                        myJug5Memory3: myJug5Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(myJug5SubViewSaveMemory(
                        myJug5: myJug5,
                        myJug5Memory1: myJug5Memory1,
                        myJug5Memory2: myJug5Memory2,
                        myJug5Memory3: myJug5Memory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: myJug5.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct myJug5SubViewSaveMemory: View {
    @ObservedObject var myJug5: MyJug5
    @ObservedObject var myJug5Memory1: MyJug5Memory1
    @ObservedObject var myJug5Memory2: MyJug5Memory2
    @ObservedObject var myJug5Memory3: MyJug5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $myJug5.selectedMemory,
            memoMemory1: $myJug5Memory1.memo,
            dateDoubleMemory1: $myJug5Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $myJug5Memory2.memo,
            dateDoubleMemory2: $myJug5Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $myJug5Memory3.memo,
            dateDoubleMemory3: $myJug5Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        myJug5Memory1.kenBackCalculationEnable = myJug5.kenBackCalculationEnable
        myJug5Memory1.kenGameIput = myJug5.kenGameIput
        myJug5Memory1.kenBigCountInput = myJug5.kenBigCountInput
        myJug5Memory1.kenRegCountInput = myJug5.kenRegCountInput
        myJug5Memory1.kenCoinDifferenceInput = myJug5.kenCoinDifferenceInput
        myJug5Memory1.kenBonusCountSum = myJug5.kenBonusCountSum
        myJug5Memory1.kenBellBackCalculationCount = myJug5.kenBellBackCalculationCount
        myJug5Memory1.startBackCalculationEnable = myJug5.startBackCalculationEnable
        myJug5Memory1.startGameInput = myJug5.startGameInput
        myJug5Memory1.startBigCountInput = myJug5.startBigCountInput
        myJug5Memory1.startRegCountInput = myJug5.startRegCountInput
        myJug5Memory1.startCoinDifferenceInput = myJug5.startCoinDifferenceInput
        myJug5Memory1.startBonusCountSum = myJug5.startBonusCountSum
        myJug5Memory1.startBellBackCalculationCount = myJug5.startBellBackCalculationCount
        myJug5Memory1.personalBellCount = myJug5.personalBellCount
        myJug5Memory1.personalBigCount = myJug5.personalBigCount
        myJug5Memory1.personalAloneRegCount = myJug5.personalAloneRegCount
        myJug5Memory1.personalCherryRegCount = myJug5.personalCherryRegCount
        myJug5Memory1.currentGames = myJug5.currentGames
        myJug5Memory1.personalRegCountSum = myJug5.personalRegCountSum
        myJug5Memory1.personalBonusCountSum = myJug5.personalBonusCountSum
        myJug5Memory1.playGame = myJug5.playGame
        myJug5Memory1.totalBigCount = myJug5.totalBigCount
        myJug5Memory1.totalRegCount = myJug5.totalRegCount
        myJug5Memory1.totalBellCount = myJug5.totalBellCount
        myJug5Memory1.totalBonusCountSum = myJug5.totalBonusCountSum
    }
    func saveMemory2() {
        myJug5Memory2.kenBackCalculationEnable = myJug5.kenBackCalculationEnable
        myJug5Memory2.kenGameIput = myJug5.kenGameIput
        myJug5Memory2.kenBigCountInput = myJug5.kenBigCountInput
        myJug5Memory2.kenRegCountInput = myJug5.kenRegCountInput
        myJug5Memory2.kenCoinDifferenceInput = myJug5.kenCoinDifferenceInput
        myJug5Memory2.kenBonusCountSum = myJug5.kenBonusCountSum
        myJug5Memory2.kenBellBackCalculationCount = myJug5.kenBellBackCalculationCount
        myJug5Memory2.startBackCalculationEnable = myJug5.startBackCalculationEnable
        myJug5Memory2.startGameInput = myJug5.startGameInput
        myJug5Memory2.startBigCountInput = myJug5.startBigCountInput
        myJug5Memory2.startRegCountInput = myJug5.startRegCountInput
        myJug5Memory2.startCoinDifferenceInput = myJug5.startCoinDifferenceInput
        myJug5Memory2.startBonusCountSum = myJug5.startBonusCountSum
        myJug5Memory2.startBellBackCalculationCount = myJug5.startBellBackCalculationCount
        myJug5Memory2.personalBellCount = myJug5.personalBellCount
        myJug5Memory2.personalBigCount = myJug5.personalBigCount
        myJug5Memory2.personalAloneRegCount = myJug5.personalAloneRegCount
        myJug5Memory2.personalCherryRegCount = myJug5.personalCherryRegCount
        myJug5Memory2.currentGames = myJug5.currentGames
        myJug5Memory2.personalRegCountSum = myJug5.personalRegCountSum
        myJug5Memory2.personalBonusCountSum = myJug5.personalBonusCountSum
        myJug5Memory2.playGame = myJug5.playGame
        myJug5Memory2.totalBigCount = myJug5.totalBigCount
        myJug5Memory2.totalRegCount = myJug5.totalRegCount
        myJug5Memory2.totalBellCount = myJug5.totalBellCount
        myJug5Memory2.totalBonusCountSum = myJug5.totalBonusCountSum
    }
    func saveMemory3() {
        myJug5Memory3.kenBackCalculationEnable = myJug5.kenBackCalculationEnable
        myJug5Memory3.kenGameIput = myJug5.kenGameIput
        myJug5Memory3.kenBigCountInput = myJug5.kenBigCountInput
        myJug5Memory3.kenRegCountInput = myJug5.kenRegCountInput
        myJug5Memory3.kenCoinDifferenceInput = myJug5.kenCoinDifferenceInput
        myJug5Memory3.kenBonusCountSum = myJug5.kenBonusCountSum
        myJug5Memory3.kenBellBackCalculationCount = myJug5.kenBellBackCalculationCount
        myJug5Memory3.startBackCalculationEnable = myJug5.startBackCalculationEnable
        myJug5Memory3.startGameInput = myJug5.startGameInput
        myJug5Memory3.startBigCountInput = myJug5.startBigCountInput
        myJug5Memory3.startRegCountInput = myJug5.startRegCountInput
        myJug5Memory3.startCoinDifferenceInput = myJug5.startCoinDifferenceInput
        myJug5Memory3.startBonusCountSum = myJug5.startBonusCountSum
        myJug5Memory3.startBellBackCalculationCount = myJug5.startBellBackCalculationCount
        myJug5Memory3.personalBellCount = myJug5.personalBellCount
        myJug5Memory3.personalBigCount = myJug5.personalBigCount
        myJug5Memory3.personalAloneRegCount = myJug5.personalAloneRegCount
        myJug5Memory3.personalCherryRegCount = myJug5.personalCherryRegCount
        myJug5Memory3.currentGames = myJug5.currentGames
        myJug5Memory3.personalRegCountSum = myJug5.personalRegCountSum
        myJug5Memory3.personalBonusCountSum = myJug5.personalBonusCountSum
        myJug5Memory3.playGame = myJug5.playGame
        myJug5Memory3.totalBigCount = myJug5.totalBigCount
        myJug5Memory3.totalRegCount = myJug5.totalRegCount
        myJug5Memory3.totalBellCount = myJug5.totalBellCount
        myJug5Memory3.totalBonusCountSum = myJug5.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct myJug5SubViewLoadMemory: View {
    @ObservedObject var myJug5: MyJug5
    @ObservedObject var myJug5Memory1: MyJug5Memory1
    @ObservedObject var myJug5Memory2: MyJug5Memory2
    @ObservedObject var myJug5Memory3: MyJug5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $myJug5.selectedMemory,
            memoMemory1: myJug5Memory1.memo,
            dateDoubleMemory1: myJug5Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: myJug5Memory2.memo,
            dateDoubleMemory2: myJug5Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: myJug5Memory3.memo,
            dateDoubleMemory3: myJug5Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        myJug5.kenBackCalculationEnable = myJug5Memory1.kenBackCalculationEnable
        myJug5.kenGameIput = myJug5Memory1.kenGameIput
        myJug5.kenBigCountInput = myJug5Memory1.kenBigCountInput
        myJug5.kenRegCountInput = myJug5Memory1.kenRegCountInput
        myJug5.kenCoinDifferenceInput = myJug5Memory1.kenCoinDifferenceInput
        myJug5.kenBonusCountSum = myJug5Memory1.kenBonusCountSum
        myJug5.kenBellBackCalculationCount = myJug5Memory1.kenBellBackCalculationCount
        myJug5.startBackCalculationEnable = myJug5Memory1.startBackCalculationEnable
        myJug5.startGameInput = myJug5Memory1.startGameInput
        myJug5.startBigCountInput = myJug5Memory1.startBigCountInput
        myJug5.startRegCountInput = myJug5Memory1.startRegCountInput
        myJug5.startCoinDifferenceInput = myJug5Memory1.startCoinDifferenceInput
        myJug5.startBonusCountSum = myJug5Memory1.startBonusCountSum
        myJug5.startBellBackCalculationCount = myJug5Memory1.startBellBackCalculationCount
        myJug5.personalBellCount = myJug5Memory1.personalBellCount
        myJug5.personalBigCount = myJug5Memory1.personalBigCount
        myJug5.personalAloneRegCount = myJug5Memory1.personalAloneRegCount
        myJug5.personalCherryRegCount = myJug5Memory1.personalCherryRegCount
        myJug5.currentGames = myJug5Memory1.currentGames
        myJug5.personalRegCountSum = myJug5Memory1.personalRegCountSum
        myJug5.personalBonusCountSum = myJug5Memory1.personalBonusCountSum
        myJug5.playGame = myJug5Memory1.playGame
        myJug5.totalBigCount = myJug5Memory1.totalBigCount
        myJug5.totalRegCount = myJug5Memory1.totalRegCount
        myJug5.totalBellCount = myJug5Memory1.totalBellCount
        myJug5.totalBonusCountSum = myJug5Memory1.totalBonusCountSum
    }
    func loadMemory2() {
        myJug5.kenBackCalculationEnable = myJug5Memory2.kenBackCalculationEnable
        myJug5.kenGameIput = myJug5Memory2.kenGameIput
        myJug5.kenBigCountInput = myJug5Memory2.kenBigCountInput
        myJug5.kenRegCountInput = myJug5Memory2.kenRegCountInput
        myJug5.kenCoinDifferenceInput = myJug5Memory2.kenCoinDifferenceInput
        myJug5.kenBonusCountSum = myJug5Memory2.kenBonusCountSum
        myJug5.kenBellBackCalculationCount = myJug5Memory2.kenBellBackCalculationCount
        myJug5.startBackCalculationEnable = myJug5Memory2.startBackCalculationEnable
        myJug5.startGameInput = myJug5Memory2.startGameInput
        myJug5.startBigCountInput = myJug5Memory2.startBigCountInput
        myJug5.startRegCountInput = myJug5Memory2.startRegCountInput
        myJug5.startCoinDifferenceInput = myJug5Memory2.startCoinDifferenceInput
        myJug5.startBonusCountSum = myJug5Memory2.startBonusCountSum
        myJug5.startBellBackCalculationCount = myJug5Memory2.startBellBackCalculationCount
        myJug5.personalBellCount = myJug5Memory2.personalBellCount
        myJug5.personalBigCount = myJug5Memory2.personalBigCount
        myJug5.personalAloneRegCount = myJug5Memory2.personalAloneRegCount
        myJug5.personalCherryRegCount = myJug5Memory2.personalCherryRegCount
        myJug5.currentGames = myJug5Memory2.currentGames
        myJug5.personalRegCountSum = myJug5Memory2.personalRegCountSum
        myJug5.personalBonusCountSum = myJug5Memory2.personalBonusCountSum
        myJug5.playGame = myJug5Memory2.playGame
        myJug5.totalBigCount = myJug5Memory2.totalBigCount
        myJug5.totalRegCount = myJug5Memory2.totalRegCount
        myJug5.totalBellCount = myJug5Memory2.totalBellCount
        myJug5.totalBonusCountSum = myJug5Memory2.totalBonusCountSum
    }
    func loadMemory3() {
        myJug5.kenBackCalculationEnable = myJug5Memory3.kenBackCalculationEnable
        myJug5.kenGameIput = myJug5Memory3.kenGameIput
        myJug5.kenBigCountInput = myJug5Memory3.kenBigCountInput
        myJug5.kenRegCountInput = myJug5Memory3.kenRegCountInput
        myJug5.kenCoinDifferenceInput = myJug5Memory3.kenCoinDifferenceInput
        myJug5.kenBonusCountSum = myJug5Memory3.kenBonusCountSum
        myJug5.kenBellBackCalculationCount = myJug5Memory3.kenBellBackCalculationCount
        myJug5.startBackCalculationEnable = myJug5Memory3.startBackCalculationEnable
        myJug5.startGameInput = myJug5Memory3.startGameInput
        myJug5.startBigCountInput = myJug5Memory3.startBigCountInput
        myJug5.startRegCountInput = myJug5Memory3.startRegCountInput
        myJug5.startCoinDifferenceInput = myJug5Memory3.startCoinDifferenceInput
        myJug5.startBonusCountSum = myJug5Memory3.startBonusCountSum
        myJug5.startBellBackCalculationCount = myJug5Memory3.startBellBackCalculationCount
        myJug5.personalBellCount = myJug5Memory3.personalBellCount
        myJug5.personalBigCount = myJug5Memory3.personalBigCount
        myJug5.personalAloneRegCount = myJug5Memory3.personalAloneRegCount
        myJug5.personalCherryRegCount = myJug5Memory3.personalCherryRegCount
        myJug5.currentGames = myJug5Memory3.currentGames
        myJug5.personalRegCountSum = myJug5Memory3.personalRegCountSum
        myJug5.personalBonusCountSum = myJug5Memory3.personalBonusCountSum
        myJug5.playGame = myJug5Memory3.playGame
        myJug5.totalBigCount = myJug5Memory3.totalBigCount
        myJug5.totalRegCount = myJug5Memory3.totalRegCount
        myJug5.totalBellCount = myJug5Memory3.totalBellCount
        myJug5.totalBonusCountSum = myJug5Memory3.totalBonusCountSum
    }
}


#Preview {
    myJug5Ver2ViewTop()
}
