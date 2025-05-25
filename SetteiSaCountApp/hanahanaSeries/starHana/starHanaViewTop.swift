//
//  starHanaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI
import FirebaseAnalytics

struct starHanaViewTop: View {
//    @ObservedObject var ver220 = Ver220()
//    @ObservedObject var starHana = StarHana()
    @StateObject var starHana = StarHana()
    @State var isShowAlert: Bool = false
    @StateObject var starHanaMemory1 = StarHanaMemory1()
    @StateObject var starHanaMemory2 = StarHanaMemory2()
    @StateObject var starHanaMemory3 = StarHanaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "スターハナハナ")
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: starHanaVer2ViewKenDataInput(starHana: starHana)) {
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
                    NavigationLink(destination: starHanaVer2ViewJissenStartData(starHana: starHana)) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: starHanaVer2ViewJissenCount(starHana: starHana)) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: starHanaVer2ViewJissenTotalDataCheck(starHana: starHana)) {
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
                NavigationLink(destination: starHanaVer2View95CiTotal(starHana: starHana)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4680")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スターハナハナ",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "スターハナハナ", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "starHanaViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: starHanaViewTop appeared.") // デバッグ用にログ出力
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(starHanaSubViewLoadMemory(
                        starHana: starHana,
                        starHanaMemory1: starHanaMemory1,
                        starHanaMemory2: starHanaMemory2,
                        starHanaMemory3: starHanaMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(starHanaSubViewSaveMemory(
                        starHana: starHana,
                        starHanaMemory1: starHanaMemory1,
                        starHanaMemory2: starHanaMemory2,
                        starHanaMemory3: starHanaMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: starHana.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
//        .onAppear {
//            if ver220.starHanaNewBadgeStatus != "none" {
//                ver220.starHanaNewBadgeStatus = "none"
//            }
//        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct starHanaSubViewSaveMemory: View {
    @ObservedObject var starHana: StarHana
    @ObservedObject var starHanaMemory1: StarHanaMemory1
    @ObservedObject var starHanaMemory2: StarHanaMemory2
    @ObservedObject var starHanaMemory3: StarHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "スターハナハナ",
            selectedMemory: $starHana.selectedMemory,
            memoMemory1: $starHanaMemory1.memo,
            dateDoubleMemory1: $starHanaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $starHanaMemory2.memo,
            dateDoubleMemory2: $starHanaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $starHanaMemory3.memo,
            dateDoubleMemory3: $starHanaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        starHanaMemory1.kenBackCalculationEnable = starHana.kenBackCalculationEnable
        starHanaMemory1.kenGameIput = starHana.kenGameIput
        starHanaMemory1.kenBigCountInput = starHana.kenBigCountInput
        starHanaMemory1.kenRegCountInput = starHana.kenRegCountInput
        starHanaMemory1.kenCoinDifferenceInput = starHana.kenCoinDifferenceInput
        starHanaMemory1.kenBonusCountSum = starHana.kenBonusCountSum
        starHanaMemory1.kenBellBackCalculationCount = starHana.kenBellBackCalculationCount
        starHanaMemory1.startBackCalculationEnable = starHana.startBackCalculationEnable
        starHanaMemory1.startGameInput = starHana.startGameInput
        starHanaMemory1.startBigCountInput = starHana.startBigCountInput
        starHanaMemory1.startRegCountInput = starHana.startRegCountInput
        starHanaMemory1.startCoinDifferenceInput = starHana.startCoinDifferenceInput
        starHanaMemory1.startBonusCountSum = starHana.startBonusCountSum
        starHanaMemory1.startBellBackCalculationCount = starHana.startBellBackCalculationCount
        starHanaMemory1.bellCount = starHana.bellCount
        starHanaMemory1.bigCount = starHana.bigCount
        starHanaMemory1.regCount = starHana.regCount
        starHanaMemory1.bbSuikaCount = starHana.bbSuikaCount
        starHanaMemory1.bbLampBCount = starHana.bbLampBCount
        starHanaMemory1.bbLampYCount = starHana.bbLampYCount
        starHanaMemory1.bbLampGCount = starHana.bbLampGCount
        starHanaMemory1.bbLampRCount = starHana.bbLampRCount
        starHanaMemory1.rbLampBCount = starHana.rbLampBCount
        starHanaMemory1.rbLampYCount = starHana.rbLampYCount
        starHanaMemory1.rbLampGCount = starHana.rbLampGCount
        starHanaMemory1.rbLampRCount = starHana.rbLampRCount
        starHanaMemory1.currentGames = starHana.currentGames
        starHanaMemory1.totalBonus = starHana.totalBonus
        starHanaMemory1.playGames = starHana.playGames
        starHanaMemory1.bigPlayGames = starHana.bigPlayGames
        starHanaMemory1.bbLampCountSum = starHana.bbLampCountSum
        starHanaMemory1.rbLampCountSum = starHana.rbLampCountSum
        starHanaMemory1.rbLampKisuCountSum = starHana.rbLampKisuCountSum
        starHanaMemory1.rbLampGusuCountSum = starHana.rbLampGusuCountSum
        starHanaMemory1.totalBigCount = starHana.totalBigCount
        starHanaMemory1.totalRegCount = starHana.totalRegCount
        starHanaMemory1.totalBellCount = starHana.totalBellCount
        starHanaMemory1.totalBonusCountSum = starHana.totalBonusCountSum
    }
    func saveMemory2() {
        starHanaMemory2.kenBackCalculationEnable = starHana.kenBackCalculationEnable
        starHanaMemory2.kenGameIput = starHana.kenGameIput
        starHanaMemory2.kenBigCountInput = starHana.kenBigCountInput
        starHanaMemory2.kenRegCountInput = starHana.kenRegCountInput
        starHanaMemory2.kenCoinDifferenceInput = starHana.kenCoinDifferenceInput
        starHanaMemory2.kenBonusCountSum = starHana.kenBonusCountSum
        starHanaMemory2.kenBellBackCalculationCount = starHana.kenBellBackCalculationCount
        starHanaMemory2.startBackCalculationEnable = starHana.startBackCalculationEnable
        starHanaMemory2.startGameInput = starHana.startGameInput
        starHanaMemory2.startBigCountInput = starHana.startBigCountInput
        starHanaMemory2.startRegCountInput = starHana.startRegCountInput
        starHanaMemory2.startCoinDifferenceInput = starHana.startCoinDifferenceInput
        starHanaMemory2.startBonusCountSum = starHana.startBonusCountSum
        starHanaMemory2.startBellBackCalculationCount = starHana.startBellBackCalculationCount
        starHanaMemory2.bellCount = starHana.bellCount
        starHanaMemory2.bigCount = starHana.bigCount
        starHanaMemory2.regCount = starHana.regCount
        starHanaMemory2.bbSuikaCount = starHana.bbSuikaCount
        starHanaMemory2.bbLampBCount = starHana.bbLampBCount
        starHanaMemory2.bbLampYCount = starHana.bbLampYCount
        starHanaMemory2.bbLampGCount = starHana.bbLampGCount
        starHanaMemory2.bbLampRCount = starHana.bbLampRCount
        starHanaMemory2.rbLampBCount = starHana.rbLampBCount
        starHanaMemory2.rbLampYCount = starHana.rbLampYCount
        starHanaMemory2.rbLampGCount = starHana.rbLampGCount
        starHanaMemory2.rbLampRCount = starHana.rbLampRCount
        starHanaMemory2.currentGames = starHana.currentGames
        starHanaMemory2.totalBonus = starHana.totalBonus
        starHanaMemory2.playGames = starHana.playGames
        starHanaMemory2.bigPlayGames = starHana.bigPlayGames
        starHanaMemory2.bbLampCountSum = starHana.bbLampCountSum
        starHanaMemory2.rbLampCountSum = starHana.rbLampCountSum
        starHanaMemory2.rbLampKisuCountSum = starHana.rbLampKisuCountSum
        starHanaMemory2.rbLampGusuCountSum = starHana.rbLampGusuCountSum
        starHanaMemory2.totalBigCount = starHana.totalBigCount
        starHanaMemory2.totalRegCount = starHana.totalRegCount
        starHanaMemory2.totalBellCount = starHana.totalBellCount
        starHanaMemory2.totalBonusCountSum = starHana.totalBonusCountSum
    }
    func saveMemory3() {
        starHanaMemory3.kenBackCalculationEnable = starHana.kenBackCalculationEnable
        starHanaMemory3.kenGameIput = starHana.kenGameIput
        starHanaMemory3.kenBigCountInput = starHana.kenBigCountInput
        starHanaMemory3.kenRegCountInput = starHana.kenRegCountInput
        starHanaMemory3.kenCoinDifferenceInput = starHana.kenCoinDifferenceInput
        starHanaMemory3.kenBonusCountSum = starHana.kenBonusCountSum
        starHanaMemory3.kenBellBackCalculationCount = starHana.kenBellBackCalculationCount
        starHanaMemory3.startBackCalculationEnable = starHana.startBackCalculationEnable
        starHanaMemory3.startGameInput = starHana.startGameInput
        starHanaMemory3.startBigCountInput = starHana.startBigCountInput
        starHanaMemory3.startRegCountInput = starHana.startRegCountInput
        starHanaMemory3.startCoinDifferenceInput = starHana.startCoinDifferenceInput
        starHanaMemory3.startBonusCountSum = starHana.startBonusCountSum
        starHanaMemory3.startBellBackCalculationCount = starHana.startBellBackCalculationCount
        starHanaMemory3.bellCount = starHana.bellCount
        starHanaMemory3.bigCount = starHana.bigCount
        starHanaMemory3.regCount = starHana.regCount
        starHanaMemory3.bbSuikaCount = starHana.bbSuikaCount
        starHanaMemory3.bbLampBCount = starHana.bbLampBCount
        starHanaMemory3.bbLampYCount = starHana.bbLampYCount
        starHanaMemory3.bbLampGCount = starHana.bbLampGCount
        starHanaMemory3.bbLampRCount = starHana.bbLampRCount
        starHanaMemory3.rbLampBCount = starHana.rbLampBCount
        starHanaMemory3.rbLampYCount = starHana.rbLampYCount
        starHanaMemory3.rbLampGCount = starHana.rbLampGCount
        starHanaMemory3.rbLampRCount = starHana.rbLampRCount
        starHanaMemory3.currentGames = starHana.currentGames
        starHanaMemory3.totalBonus = starHana.totalBonus
        starHanaMemory3.playGames = starHana.playGames
        starHanaMemory3.bigPlayGames = starHana.bigPlayGames
        starHanaMemory3.bbLampCountSum = starHana.bbLampCountSum
        starHanaMemory3.rbLampCountSum = starHana.rbLampCountSum
        starHanaMemory3.rbLampKisuCountSum = starHana.rbLampKisuCountSum
        starHanaMemory3.rbLampGusuCountSum = starHana.rbLampGusuCountSum
        starHanaMemory3.totalBigCount = starHana.totalBigCount
        starHanaMemory3.totalRegCount = starHana.totalRegCount
        starHanaMemory3.totalBellCount = starHana.totalBellCount
        starHanaMemory3.totalBonusCountSum = starHana.totalBonusCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct starHanaSubViewLoadMemory: View {
    @ObservedObject var starHana: StarHana
    @ObservedObject var starHanaMemory1: StarHanaMemory1
    @ObservedObject var starHanaMemory2: StarHanaMemory2
    @ObservedObject var starHanaMemory3: StarHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "スターハナハナ",
            selectedMemory: $starHana.selectedMemory,
            memoMemory1: starHanaMemory1.memo,
            dateDoubleMemory1: starHanaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: starHanaMemory2.memo,
            dateDoubleMemory2: starHanaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: starHanaMemory3.memo,
            dateDoubleMemory3: starHanaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        starHana.kenBackCalculationEnable = starHanaMemory1.kenBackCalculationEnable
        starHana.kenGameIput = starHanaMemory1.kenGameIput
        starHana.kenBigCountInput = starHanaMemory1.kenBigCountInput
        starHana.kenRegCountInput = starHanaMemory1.kenRegCountInput
        starHana.kenCoinDifferenceInput = starHanaMemory1.kenCoinDifferenceInput
        starHana.kenBonusCountSum = starHanaMemory1.kenBonusCountSum
        starHana.kenBellBackCalculationCount = starHanaMemory1.kenBellBackCalculationCount
        starHana.startBackCalculationEnable = starHanaMemory1.startBackCalculationEnable
        starHana.startGameInput = starHanaMemory1.startGameInput
        starHana.startBigCountInput = starHanaMemory1.startBigCountInput
        starHana.startRegCountInput = starHanaMemory1.startRegCountInput
        starHana.startCoinDifferenceInput = starHanaMemory1.startCoinDifferenceInput
        starHana.startBonusCountSum = starHanaMemory1.startBonusCountSum
        starHana.startBellBackCalculationCount = starHanaMemory1.startBellBackCalculationCount
        starHana.bellCount = starHanaMemory1.bellCount
        starHana.bigCount = starHanaMemory1.bigCount
        starHana.regCount = starHanaMemory1.regCount
        starHana.bbSuikaCount = starHanaMemory1.bbSuikaCount
        starHana.bbLampBCount = starHanaMemory1.bbLampBCount
        starHana.bbLampYCount = starHanaMemory1.bbLampYCount
        starHana.bbLampGCount = starHanaMemory1.bbLampGCount
        starHana.bbLampRCount = starHanaMemory1.bbLampRCount
        starHana.rbLampBCount = starHanaMemory1.rbLampBCount
        starHana.rbLampYCount = starHanaMemory1.rbLampYCount
        starHana.rbLampGCount = starHanaMemory1.rbLampGCount
        starHana.rbLampRCount = starHanaMemory1.rbLampRCount
        starHana.currentGames = starHanaMemory1.currentGames
        starHana.totalBonus = starHanaMemory1.totalBonus
        starHana.playGames = starHanaMemory1.playGames
        starHana.bigPlayGames = starHanaMemory1.bigPlayGames
        starHana.bbLampCountSum = starHanaMemory1.bbLampCountSum
        starHana.rbLampCountSum = starHanaMemory1.rbLampCountSum
        starHana.rbLampKisuCountSum = starHanaMemory1.rbLampKisuCountSum
        starHana.rbLampGusuCountSum = starHanaMemory1.rbLampGusuCountSum
        starHana.totalBigCount = starHanaMemory1.totalBigCount
        starHana.totalRegCount = starHanaMemory1.totalRegCount
        starHana.totalBellCount = starHanaMemory1.totalBellCount
        starHana.totalBonusCountSum = starHanaMemory1.totalBonusCountSum
    }
    func loadMemory2() {
        starHana.kenBackCalculationEnable = starHanaMemory2.kenBackCalculationEnable
        starHana.kenGameIput = starHanaMemory2.kenGameIput
        starHana.kenBigCountInput = starHanaMemory2.kenBigCountInput
        starHana.kenRegCountInput = starHanaMemory2.kenRegCountInput
        starHana.kenCoinDifferenceInput = starHanaMemory2.kenCoinDifferenceInput
        starHana.kenBonusCountSum = starHanaMemory2.kenBonusCountSum
        starHana.kenBellBackCalculationCount = starHanaMemory2.kenBellBackCalculationCount
        starHana.startBackCalculationEnable = starHanaMemory2.startBackCalculationEnable
        starHana.startGameInput = starHanaMemory2.startGameInput
        starHana.startBigCountInput = starHanaMemory2.startBigCountInput
        starHana.startRegCountInput = starHanaMemory2.startRegCountInput
        starHana.startCoinDifferenceInput = starHanaMemory2.startCoinDifferenceInput
        starHana.startBonusCountSum = starHanaMemory2.startBonusCountSum
        starHana.startBellBackCalculationCount = starHanaMemory2.startBellBackCalculationCount
        starHana.bellCount = starHanaMemory2.bellCount
        starHana.bigCount = starHanaMemory2.bigCount
        starHana.regCount = starHanaMemory2.regCount
        starHana.bbSuikaCount = starHanaMemory2.bbSuikaCount
        starHana.bbLampBCount = starHanaMemory2.bbLampBCount
        starHana.bbLampYCount = starHanaMemory2.bbLampYCount
        starHana.bbLampGCount = starHanaMemory2.bbLampGCount
        starHana.bbLampRCount = starHanaMemory2.bbLampRCount
        starHana.rbLampBCount = starHanaMemory2.rbLampBCount
        starHana.rbLampYCount = starHanaMemory2.rbLampYCount
        starHana.rbLampGCount = starHanaMemory2.rbLampGCount
        starHana.rbLampRCount = starHanaMemory2.rbLampRCount
        starHana.currentGames = starHanaMemory2.currentGames
        starHana.totalBonus = starHanaMemory2.totalBonus
        starHana.playGames = starHanaMemory2.playGames
        starHana.bigPlayGames = starHanaMemory2.bigPlayGames
        starHana.bbLampCountSum = starHanaMemory2.bbLampCountSum
        starHana.rbLampCountSum = starHanaMemory2.rbLampCountSum
        starHana.rbLampKisuCountSum = starHanaMemory2.rbLampKisuCountSum
        starHana.rbLampGusuCountSum = starHanaMemory2.rbLampGusuCountSum
        starHana.totalBigCount = starHanaMemory2.totalBigCount
        starHana.totalRegCount = starHanaMemory2.totalRegCount
        starHana.totalBellCount = starHanaMemory2.totalBellCount
        starHana.totalBonusCountSum = starHanaMemory2.totalBonusCountSum
    }
    func loadMemory3() {
        starHana.kenBackCalculationEnable = starHanaMemory3.kenBackCalculationEnable
        starHana.kenGameIput = starHanaMemory3.kenGameIput
        starHana.kenBigCountInput = starHanaMemory3.kenBigCountInput
        starHana.kenRegCountInput = starHanaMemory3.kenRegCountInput
        starHana.kenCoinDifferenceInput = starHanaMemory3.kenCoinDifferenceInput
        starHana.kenBonusCountSum = starHanaMemory3.kenBonusCountSum
        starHana.kenBellBackCalculationCount = starHanaMemory3.kenBellBackCalculationCount
        starHana.startBackCalculationEnable = starHanaMemory3.startBackCalculationEnable
        starHana.startGameInput = starHanaMemory3.startGameInput
        starHana.startBigCountInput = starHanaMemory3.startBigCountInput
        starHana.startRegCountInput = starHanaMemory3.startRegCountInput
        starHana.startCoinDifferenceInput = starHanaMemory3.startCoinDifferenceInput
        starHana.startBonusCountSum = starHanaMemory3.startBonusCountSum
        starHana.startBellBackCalculationCount = starHanaMemory3.startBellBackCalculationCount
        starHana.bellCount = starHanaMemory3.bellCount
        starHana.bigCount = starHanaMemory3.bigCount
        starHana.regCount = starHanaMemory3.regCount
        starHana.bbSuikaCount = starHanaMemory3.bbSuikaCount
        starHana.bbLampBCount = starHanaMemory3.bbLampBCount
        starHana.bbLampYCount = starHanaMemory3.bbLampYCount
        starHana.bbLampGCount = starHanaMemory3.bbLampGCount
        starHana.bbLampRCount = starHanaMemory3.bbLampRCount
        starHana.rbLampBCount = starHanaMemory3.rbLampBCount
        starHana.rbLampYCount = starHanaMemory3.rbLampYCount
        starHana.rbLampGCount = starHanaMemory3.rbLampGCount
        starHana.rbLampRCount = starHanaMemory3.rbLampRCount
        starHana.currentGames = starHanaMemory3.currentGames
        starHana.totalBonus = starHanaMemory3.totalBonus
        starHana.playGames = starHanaMemory3.playGames
        starHana.bigPlayGames = starHanaMemory3.bigPlayGames
        starHana.bbLampCountSum = starHanaMemory3.bbLampCountSum
        starHana.rbLampCountSum = starHanaMemory3.rbLampCountSum
        starHana.rbLampKisuCountSum = starHanaMemory3.rbLampKisuCountSum
        starHana.rbLampGusuCountSum = starHanaMemory3.rbLampGusuCountSum
        starHana.totalBigCount = starHanaMemory3.totalBigCount
        starHana.totalRegCount = starHanaMemory3.totalRegCount
        starHana.totalBellCount = starHanaMemory3.totalBellCount
        starHana.totalBonusCountSum = starHanaMemory3.totalBonusCountSum
    }
}

#Preview {
    starHanaViewTop()
}
