//
//  mt5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/20.
//

import SwiftUI
import TipKit


// //////////////////////
// 変数
// //////////////////////
protocol mt5Protocol {
    // //////////////////////
    // 履歴用
    // //////////////////////
    var selectedShuki: String { get set }
    var selectedPt: String { get set }
    var selectedTrigger: String { get set }
    var selectedResult: String { get set }
    func historyReset()
    
    // //////////////////////
    // 共通
    // //////////////////////
    var minusCheck: Bool { get set }
}

class Mt5: ObservableObject, mt5Protocol {
    // //////////////////////
    // 5枚役
    // //////////////////////
    @AppStorage("mt5Coin5Count") var coin5Count = 0
    @AppStorage("mt5StartGame") var startGame = 0 {
        didSet {
            let games = currentGame - startGame
            playGame = games > 0 ? games : 0
        }
    }
        @AppStorage("mt5CurrentGame") var currentGame = 0 {
            didSet {
                let games = currentGame - startGame
                playGame = games > 0 ? games : 0
            }
        }
    @AppStorage("mt5PlayGame") var playGame = 0
    
    func resetCoin5() {
        coin5Count = 0
        startGame = 0
        currentGame = 0
        minusCheck = false
    }
    
    // //////////////////////
    // 履歴用
    // //////////////////////
    @Published var selectListShuki = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期"]
    @Published var selectedShuki = "1周期"
    @Published var selectListPt = ["111Pt", "222Pt", "333Pt", "444Pt", "555Pt", "666Pt"]
    @Published var selectedPt = "111Pt"
    @Published var selectListTrigger = ["規定Pt", "超抜", "直撃(強レア)", "直撃(弱レア)", "天井", "確定役"]
    @Published var selectedTrigger = "規定Pt"
    @Published var selectListResult = ["ハズレ", "当選"]
    @Published var selectedResult = "ハズレ"
    // //// 周期配列の設定
    let mt5ShukiArrayKey = "mt5ShukiArrayKey"     // 配列を保存するためのキー
    @AppStorage("mt5ShukiArrayKey") var mt5ShukiArrayData: Data?     // JSONデータを保存するためのAppstrage変数
    // //// Pt配列の設定
    let mt5PtArrayKey = "mt5PtArrayKey"     // 配列を保存するためのキー
    @AppStorage("mt5PtArrayKey") var mt5PtArrayData: Data?     // JSONデータを保存するためのAppstrage変数
    // //// 当選契機配列の設定
    let mt5TriggerArrayKey = "mt5TriggerArrayKey"     // 配列を保存するためのキー
    @AppStorage("mt5TriggerArrayKey") var mt5TriggerArrayData: Data?     // JSONデータを保存するためのAppstrage変数
    // //// 結果配列の設定
    let mt5ResultArrayKey = "mt5ResultArrayKey"     // 配列を保存するためのキー
    @AppStorage("mt5ResultArrayKey") var mt5ResultArrayData: Data? {
        didSet {
            atCountPlus1 = AtCountPlus1()
        }
    }
    
    
    // 周期履歴ページのデータを全リセットする関数
    func historyReset() {
        selectedShuki = "1周期"
        selectedPt = "111Pt"
        selectedTrigger = "規定Pt"
        selectedResult = "ハズレ"
        // 周期配列のリセット
        var toSavemt5ShukiArray = decodeStringArray(from: mt5ShukiArrayData)
        toSavemt5ShukiArray.removeAll()
        saveArray(toSavemt5ShukiArray, forKey: mt5ShukiArrayKey)
        // Pt配列のリセット
        var toSavemt5PtArray = decodeStringArray(from: mt5PtArrayData)
        toSavemt5PtArray.removeAll()
        saveArray(toSavemt5PtArray, forKey: mt5PtArrayKey)
        // 当選契機配列のリセット
        var toSavemt5TriggerArray = decodeStringArray(from: mt5TriggerArrayData)
        toSavemt5TriggerArray.removeAll()
        saveArray(toSavemt5TriggerArray, forKey: mt5TriggerArrayKey)
        // 結果配列のリセット
        var toSavemt5ResultArray = decodeStringArray(from: mt5ResultArrayData)
        toSavemt5ResultArray.removeAll()
        saveArray(toSavemt5ResultArray, forKey: mt5ResultArrayKey)
        atCountPlus1 = AtCountPlus1()
        atCount = AtCount()
        minusCheck = false
    }
    
    // 周期履歴データに1行追加する関数
    func addDatatoHistory() {
        // 周期配列へのデータ追加
        var toSavemt5ShukiArray = decodeStringArray(from: mt5ShukiArrayData)
        toSavemt5ShukiArray.append(selectedShuki)
        saveArray(toSavemt5ShukiArray, forKey: mt5ShukiArrayKey)
        // Pt配列へのデータ追加
        var toSavemt5PtArray = decodeStringArray(from: mt5PtArrayData)
        toSavemt5PtArray.append(selectedPt)
        saveArray(toSavemt5PtArray, forKey: mt5PtArrayKey)
        // 当選契機配列へのデータ追加
        var toSavemt5TriggerArray = decodeStringArray(from: mt5TriggerArrayData)
        toSavemt5TriggerArray.append(selectedTrigger)
        saveArray(toSavemt5TriggerArray, forKey: mt5TriggerArrayKey)
        // 結果配列へのデータ追加
        var toSavemt5ResultArray = decodeStringArray(from: mt5ResultArrayData)
        toSavemt5ResultArray.append(selectedResult)
        saveArray(toSavemt5ResultArray, forKey: mt5ResultArrayKey)
        atCountPlus1 = AtCountPlus1()
        atCount = AtCount()
        selectedShuki = "1周期"
        selectedPt = "111Pt"
        selectedTrigger = "規定Pt"
        selectedResult = "ハズレ"
        minusCheck = false
    }
    
    // 周期履歴データから1行削除する関数
    func removeLastHistory() {
        // 周期配列から1行削除
        var toSavemt5ShukiArray = decodeStringArray(from: mt5ShukiArrayData)
        if toSavemt5ShukiArray.count > 0 {
            toSavemt5ShukiArray.removeLast()
            saveArray(toSavemt5ShukiArray, forKey: mt5ShukiArrayKey)
        } else {
            
        }
        // Pt配列へのデータ追加
        var toSavemt5PtArray = decodeStringArray(from: mt5PtArrayData)
        if toSavemt5PtArray.count > 0 {
            toSavemt5PtArray.removeLast()
            saveArray(toSavemt5PtArray, forKey: mt5PtArrayKey)
        } else {
            
        }
        // 当選契機配列へのデータ追加
        var toSavemt5TriggerArray = decodeStringArray(from: mt5TriggerArrayData)
        if toSavemt5TriggerArray.count > 0 {
            toSavemt5TriggerArray.removeLast()
            saveArray(toSavemt5TriggerArray, forKey: mt5TriggerArrayKey)
        } else {
            
        }
        // 結果配列へのデータ追加
        var toSavemt5ResultArray = decodeStringArray(from: mt5ResultArrayData)
        if toSavemt5ResultArray.count > 0 {
            toSavemt5ResultArray.removeLast()
            saveArray(toSavemt5ResultArray, forKey: mt5ResultArrayKey)
        } else {
            
        }
        
        atCountPlus1 = AtCountPlus1()
        atCount = AtCount()
//        minusCheck = false
    }
    
    // ////////////////////
    // 激走チャージ用
    // ////////////////////
    @AppStorage("mt5HatanoACount") var hatanoACount = 0 {
        didSet {
            hatanoCountSum = HatanoCountSum(aCount: hatanoACount, bCount: hatanoBCount)
        }
    }
    @AppStorage("mt5HatanoBCount") var hatanoBCount = 0 {
        didSet {
            hatanoCountSum = HatanoCountSum(aCount: hatanoACount, bCount: hatanoBCount)
        }
    }
    // カウント合計
    @AppStorage("mt5HatanoCountSum") var hatanoCountSum = 0
    private func HatanoCountSum(aCount: Int, bCount: Int) -> Int {
        return aCount + bCount
    }
    
    // ページ内のデータリセット
    func resetGekiso() {
        hatanoACount = 0
        hatanoBCount = 0
        minusCheck = false
    }
    
    
    // /////////////////////
    // ライバルモード用
    // /////////////////////
    @AppStorage("mt5RivalGamoCount") var rivalGamoCount = 0
    @AppStorage("mt5RivalHamaokaCount") var rivalHamaokaCount = 0
    @AppStorage("mt5RivalEnokiCount") var rivalEnokiCount = 0
    // AT回数のカウント
    @AppStorage("mt5ATCountPlus1") var atCountPlus1 = 0
    private func AtCountPlus1() -> Int {
        let array = decodeStringArray(from: mt5ResultArrayData)
        let count = array.filter { $0 == selectListResult[1] }.count
        return count + 1
    }
    
    // ページ内のデータリセット
    func resetRival() {
        rivalGamoCount = 0
        rivalHamaokaCount = 0
        rivalEnokiCount = 0
        minusCheck = false
    }
    
    
    // ////////////////////
    // AT終了後のメダル用
    // ////////////////////
    @AppStorage("mt5BlueMedalCount") var blueMedalCount = 0
    @AppStorage("mt5YellowMedalCount") var yellowMedalCount = 0
    @AppStorage("mt5BlackMedalCount") var blackMedalCount = 0
    
    // AT回数のカウント
    @AppStorage("mt5ATCount") var atCount = 0
    private func AtCount() -> Int {
        let array = decodeStringArray(from: mt5ResultArrayData)
        let count = array.filter { $0 == selectListResult[1] }.count
        return count
    }
    // ページ内データリセット
    func resetMedal() {
        blueMedalCount = 0
        yellowMedalCount = 0
        blackMedalCount = 0
        minusCheck = false
    }
    
    // //////////////////////
    // 青島SGとエンディング
    // //////////////////////
    @AppStorage("mt5AoshimaSGShifukuCount") var AoshimaSGShifukuCount = 0 {
        didSet {
            AoshimaSGCountSum = countSum(AoshimaSGShifukuCount, AoshimaSGRaceCount, AoshimaSGDressCount, AoshimaSGHatanoCount)
        }
    }
    @AppStorage("mt5AoshimaSGRaceCount") var AoshimaSGRaceCount = 0 {
        didSet {
            AoshimaSGCountSum = countSum(AoshimaSGShifukuCount, AoshimaSGRaceCount, AoshimaSGDressCount, AoshimaSGHatanoCount)
        }
    }
    @AppStorage("mt5AoshimaSGDressCount") var AoshimaSGDressCount = 0 {
        didSet {
            AoshimaSGCountSum = countSum(AoshimaSGShifukuCount, AoshimaSGRaceCount, AoshimaSGDressCount, AoshimaSGHatanoCount)
        }
    }
    @AppStorage("mt5AoshimaSGHatanoCount") var AoshimaSGHatanoCount = 0 {
        didSet {
            AoshimaSGCountSum = countSum(AoshimaSGShifukuCount, AoshimaSGRaceCount, AoshimaSGDressCount, AoshimaSGHatanoCount)
        }
    }
    @AppStorage("mt5AoshimaSGCountSum") var AoshimaSGCountSum = 0
//    @AppStorage("mt5AoshimaSGCurrentKeyword") var AoshimaSGCurrentKeyword = ""
    @AppStorage("mt5AoshimaSGCurrentKeyword") var AoshimaSGCurrentKeyword = ""
    @Published var AoshimaSGShifukuKeyword = "私服"
    @Published var AoshimaSGRaceKeyword = "レース服"
    @Published var AoshimaSGDressKeyword = "ドレス"
    @Published var AoshimaSGHatanoKeyword = "波多野"
    
    func resetAoshima() {
        AoshimaSGShifukuCount = 0
        AoshimaSGRaceCount = 0
        AoshimaSGDressCount = 0
        AoshimaSGHatanoCount = 0
    }
    
    // //////////////////////
    // 共通
    // //////////////////////
    @AppStorage("mt5MinusCheck") var minusCheck = false
    @AppStorage("mt5SelectedMemory") var selectedMemory = "メモリー1"
    
    // データ全リセット
    func resetAll() {
        historyReset()
        resetGekiso()
        resetRival()
        resetMedal()
        resetAoshima()
        resetCoin5()
    }
}


// //// メモリー1
class Mt5Memory1: ObservableObject {
    @AppStorage("mt5Coin5CountMemory1") var coin5Count = 0
    @AppStorage("mt5StartGameMemory1") var startGame = 0
    @AppStorage("mt5CurrentGameMemory1") var currentGame = 0
    @AppStorage("mt5PlayGameMemory1") var playGame = 0
    @AppStorage("mt5ShukiArrayKeyMemory1") var mt5ShukiArrayData: Data?
    @AppStorage("mt5PtArrayKeyMemory1") var mt5PtArrayData: Data?
    @AppStorage("mt5TriggerArrayKeyMemory1") var mt5TriggerArrayData: Data?
    @AppStorage("mt5ResultArrayKeyMemory1") var mt5ResultArrayData: Data?
    @AppStorage("mt5HatanoACountMemory1") var hatanoACount = 0
    @AppStorage("mt5HatanoBCountMemory1") var hatanoBCount = 0
    @AppStorage("mt5HatanoCountSumMemory1") var hatanoCountSum = 0
    @AppStorage("mt5RivalGamoCountMemory1") var rivalGamoCount = 0
    @AppStorage("mt5RivalHamaokaCountMemory1") var rivalHamaokaCount = 0
    @AppStorage("mt5RivalEnokiCountMemory1") var rivalEnokiCount = 0
    @AppStorage("mt5ATCountPlus1Memory1") var atCountPlus1 = 0
    @AppStorage("mt5BlueMedalCountMemory1") var blueMedalCount = 0
    @AppStorage("mt5YellowMedalCountMemory1") var yellowMedalCount = 0
    @AppStorage("mt5BlackMedalCountMemory1") var blackMedalCount = 0
    @AppStorage("mt5ATCountMemory1") var atCount = 0
    @AppStorage("mt5AoshimaSGShifukuCountMemory1") var AoshimaSGShifukuCount = 0
    @AppStorage("mt5AoshimaSGRaceCountMemory1") var AoshimaSGRaceCount = 0
    @AppStorage("mt5AoshimaSGDressCountMemory1") var AoshimaSGDressCount = 0
    @AppStorage("mt5AoshimaSGHatanoCountMemory1") var AoshimaSGHatanoCount = 0
    @AppStorage("mt5AoshimaSGCountSumMemory1") var AoshimaSGCountSum = 0
    @AppStorage("mt5MemoMemory1") var memo = ""
    @AppStorage("mt5DateMemory1") var dateDouble = 0.0
}
// //// メモリー2
class Mt5Memory2: ObservableObject {
    @AppStorage("mt5Coin5CountMemory2") var coin5Count = 0
    @AppStorage("mt5StartGameMemory2") var startGame = 0
    @AppStorage("mt5CurrentGameMemory2") var currentGame = 0
    @AppStorage("mt5PlayGameMemory2") var playGame = 0
    @AppStorage("mt5ShukiArrayKeyMemory2") var mt5ShukiArrayData: Data?
    @AppStorage("mt5PtArrayKeyMemory2") var mt5PtArrayData: Data?
    @AppStorage("mt5TriggerArrayKeyMemory2") var mt5TriggerArrayData: Data?
    @AppStorage("mt5ResultArrayKeyMemory2") var mt5ResultArrayData: Data?
    @AppStorage("mt5HatanoACountMemory2") var hatanoACount = 0
    @AppStorage("mt5HatanoBCountMemory2") var hatanoBCount = 0
    @AppStorage("mt5HatanoCountSumMemory2") var hatanoCountSum = 0
    @AppStorage("mt5RivalGamoCountMemory2") var rivalGamoCount = 0
    @AppStorage("mt5RivalHamaokaCountMemory2") var rivalHamaokaCount = 0
    @AppStorage("mt5RivalEnokiCountMemory2") var rivalEnokiCount = 0
    @AppStorage("mt5ATCountPlus1Memory2") var atCountPlus1 = 0
    @AppStorage("mt5BlueMedalCountMemory2") var blueMedalCount = 0
    @AppStorage("mt5YellowMedalCountMemory2") var yellowMedalCount = 0
    @AppStorage("mt5BlackMedalCountMemory2") var blackMedalCount = 0
    @AppStorage("mt5ATCountMemory2") var atCount = 0
    @AppStorage("mt5AoshimaSGShifukuCountMemory2") var AoshimaSGShifukuCount = 0
    @AppStorage("mt5AoshimaSGRaceCountMemory2") var AoshimaSGRaceCount = 0
    @AppStorage("mt5AoshimaSGDressCountMemory2") var AoshimaSGDressCount = 0
    @AppStorage("mt5AoshimaSGHatanoCountMemory2") var AoshimaSGHatanoCount = 0
    @AppStorage("mt5AoshimaSGCountSumMemory2") var AoshimaSGCountSum = 0
    @AppStorage("mt5MemoMemory2") var memo = ""
    @AppStorage("mt5DateMemory2") var dateDouble = 0.0
}
// //// メモリー3
class Mt5Memory3: ObservableObject {
    @AppStorage("mt5Coin5CountMemory3") var coin5Count = 0
    @AppStorage("mt5StartGameMemory3") var startGame = 0
    @AppStorage("mt5CurrentGameMemory3") var currentGame = 0
    @AppStorage("mt5PlayGameMemory3") var playGame = 0
    @AppStorage("mt5ShukiArrayKeyMemory3") var mt5ShukiArrayData: Data?
    @AppStorage("mt5PtArrayKeyMemory3") var mt5PtArrayData: Data?
    @AppStorage("mt5TriggerArrayKeyMemory3") var mt5TriggerArrayData: Data?
    @AppStorage("mt5ResultArrayKeyMemory3") var mt5ResultArrayData: Data?
    @AppStorage("mt5HatanoACountMemory3") var hatanoACount = 0
    @AppStorage("mt5HatanoBCountMemory3") var hatanoBCount = 0
    @AppStorage("mt5HatanoCountSumMemory3") var hatanoCountSum = 0
    @AppStorage("mt5RivalGamoCountMemory3") var rivalGamoCount = 0
    @AppStorage("mt5RivalHamaokaCountMemory3") var rivalHamaokaCount = 0
    @AppStorage("mt5RivalEnokiCountMemory3") var rivalEnokiCount = 0
    @AppStorage("mt5ATCountPlus1Memory3") var atCountPlus1 = 0
    @AppStorage("mt5BlueMedalCountMemory3") var blueMedalCount = 0
    @AppStorage("mt5YellowMedalCountMemory3") var yellowMedalCount = 0
    @AppStorage("mt5BlackMedalCountMemory3") var blackMedalCount = 0
    @AppStorage("mt5ATCountMemory3") var atCount = 0
    @AppStorage("mt5AoshimaSGShifukuCountMemory3") var AoshimaSGShifukuCount = 0
    @AppStorage("mt5AoshimaSGRaceCountMemory3") var AoshimaSGRaceCount = 0
    @AppStorage("mt5AoshimaSGDressCountMemory3") var AoshimaSGDressCount = 0
    @AppStorage("mt5AoshimaSGHatanoCountMemory3") var AoshimaSGHatanoCount = 0
    @AppStorage("mt5AoshimaSGCountSumMemory3") var AoshimaSGCountSum = 0
    @AppStorage("mt5MemoMemory3") var memo = ""
    @AppStorage("mt5DateMemory3") var dateDouble = 0.0
}


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct mt5ViewTop: View {
//    @ObservedObject var mt5 = Mt5()
    @StateObject var mt5 = Mt5()
    @State var isShowAlert = false
    @StateObject var mt5Memory1 = Mt5Memory1()
    @StateObject var mt5Memory2 = Mt5Memory2()
    @StateObject var mt5Memory3 = Mt5Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // ５枚役
                    NavigationLink(destination: mt5View5coin(mt5: mt5)) {
                        unitLabelMenu(
                            imageSystemName: "5.circle",
                            textBody: "５枚役"
                        )
                    }
//                    .popoverTip(mt5TipAdd5Coins())
                    // 周期履歴
                    NavigationLink(destination: mt5ViewHistory(mt5: mt5)) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "周期履歴")
                    }
                    // 激走チャージ後のセリフ
                    NavigationLink(destination: mt5GekisoView(mt5: mt5)) {
                        unitLabelMenu(imageSystemName: "message", textBody: "激走チャージ後のセリフ")
                    }
                    // ライバルモード
                    NavigationLink(destination: mt5RivalModeView(mt5: mt5)) {
                        unitLabelMenu(imageSystemName: "person.2", textBody: "ライバルモード")
                    }
                    // ラウンド開始画面の示唆
                    NavigationLink(destination: mt5ViewRoundScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ラウンド開始画面示唆")
                    }
                    // AT終了後のメダル
                    NavigationLink(destination: mt5ViewMedal(mt5: mt5)) {
                        unitLabelMenu(imageSystemName: "medal", textBody: "AT終了後のメダル")
                    }
                    // 青島SG
                    NavigationLink(destination: mt5ViewAoshimaSG(mt5: mt5)) {
                        unitLabelMenu(imageSystemName: "sailboat", textBody: "青島SG")
                    }
                    // エンディング
                    NavigationLink(destination: mt5ViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "モンキーターン5")
                }
                
                // 設定推測グラフ
                NavigationLink(destination: mt5View95Ci(mt5: mt5)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4450")
                    .popoverTip(tipVer220AddLink())
            }
            .navigationTitle("メニュー")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        HStack {
                            // //// データ読み出し
                            unitButtonLoadMemory(loadView: AnyView(mt5ViewLoadMemory(
                                mt5: mt5,
                                mt5Memory1: mt5Memory1,
                                mt5Memory2: mt5Memory2,
                                mt5Memory3: mt5Memory3
                            )))
                            // //// データ保存
                            unitButtonSaveMemory(saveView: AnyView(mt5ViewSaveMemory(
                                mt5: mt5,
                                mt5Memory1: mt5Memory1,
                                mt5Memory2: mt5Memory2,
                                mt5Memory3: mt5Memory3
                            )))
                        }
                        .popoverTip(tipUnitButtonMemory())
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetAll, message: "この機種の全ページのデータは完全に消去されます")
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct mt5ViewSaveMemory: View {
    @ObservedObject var mt5: Mt5
    @ObservedObject var mt5Memory1: Mt5Memory1
    @ObservedObject var mt5Memory2: Mt5Memory2
    @ObservedObject var mt5Memory3: Mt5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "モンキーターン5",
            selectedMemory: $mt5.selectedMemory,
            memoMemory1: $mt5Memory1.memo,
            dateDoubleMemory1: $mt5Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mt5Memory2.memo,
            dateDoubleMemory2: $mt5Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mt5Memory3.memo,
            dateDoubleMemory3: $mt5Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mt5Memory1.coin5Count = mt5.coin5Count
        mt5Memory1.startGame = mt5.startGame
        mt5Memory1.currentGame = mt5.currentGame
        mt5Memory1.playGame = mt5.playGame
        mt5Memory1.mt5ShukiArrayData = mt5.mt5ShukiArrayData
        mt5Memory1.mt5PtArrayData = mt5.mt5PtArrayData
        mt5Memory1.mt5TriggerArrayData = mt5.mt5TriggerArrayData
        mt5Memory1.mt5ResultArrayData = mt5.mt5ResultArrayData
        mt5Memory1.hatanoACount = mt5.hatanoACount
        mt5Memory1.hatanoBCount = mt5.hatanoBCount
        mt5Memory1.hatanoCountSum = mt5.hatanoCountSum
        mt5Memory1.rivalGamoCount = mt5.rivalGamoCount
        mt5Memory1.rivalHamaokaCount = mt5.rivalHamaokaCount
        mt5Memory1.rivalEnokiCount = mt5.rivalEnokiCount
        mt5Memory1.atCountPlus1 = mt5.atCountPlus1
        mt5Memory1.blueMedalCount = mt5.blueMedalCount
        mt5Memory1.yellowMedalCount = mt5.yellowMedalCount
        mt5Memory1.blackMedalCount = mt5.blackMedalCount
        mt5Memory1.atCount = mt5.atCount
        mt5Memory1.AoshimaSGShifukuCount = mt5.AoshimaSGShifukuCount
        mt5Memory1.AoshimaSGRaceCount = mt5.AoshimaSGRaceCount
        mt5Memory1.AoshimaSGDressCount = mt5.AoshimaSGDressCount
        mt5Memory1.AoshimaSGHatanoCount = mt5.AoshimaSGHatanoCount
        mt5Memory1.AoshimaSGCountSum = mt5.AoshimaSGCountSum
    }
    func saveMemory2() {
        mt5Memory2.coin5Count = mt5.coin5Count
        mt5Memory2.startGame = mt5.startGame
        mt5Memory2.currentGame = mt5.currentGame
        mt5Memory2.playGame = mt5.playGame
        mt5Memory2.mt5ShukiArrayData = mt5.mt5ShukiArrayData
        mt5Memory2.mt5PtArrayData = mt5.mt5PtArrayData
        mt5Memory2.mt5TriggerArrayData = mt5.mt5TriggerArrayData
        mt5Memory2.mt5ResultArrayData = mt5.mt5ResultArrayData
        mt5Memory2.hatanoACount = mt5.hatanoACount
        mt5Memory2.hatanoBCount = mt5.hatanoBCount
        mt5Memory2.hatanoCountSum = mt5.hatanoCountSum
        mt5Memory2.rivalGamoCount = mt5.rivalGamoCount
        mt5Memory2.rivalHamaokaCount = mt5.rivalHamaokaCount
        mt5Memory2.rivalEnokiCount = mt5.rivalEnokiCount
        mt5Memory2.atCountPlus1 = mt5.atCountPlus1
        mt5Memory2.blueMedalCount = mt5.blueMedalCount
        mt5Memory2.yellowMedalCount = mt5.yellowMedalCount
        mt5Memory2.blackMedalCount = mt5.blackMedalCount
        mt5Memory2.atCount = mt5.atCount
        mt5Memory2.AoshimaSGShifukuCount = mt5.AoshimaSGShifukuCount
        mt5Memory2.AoshimaSGRaceCount = mt5.AoshimaSGRaceCount
        mt5Memory2.AoshimaSGDressCount = mt5.AoshimaSGDressCount
        mt5Memory2.AoshimaSGHatanoCount = mt5.AoshimaSGHatanoCount
        mt5Memory2.AoshimaSGCountSum = mt5.AoshimaSGCountSum
    }
    func saveMemory3() {
        mt5Memory3.coin5Count = mt5.coin5Count
        mt5Memory3.startGame = mt5.startGame
        mt5Memory3.currentGame = mt5.currentGame
        mt5Memory3.playGame = mt5.playGame
        mt5Memory3.mt5ShukiArrayData = mt5.mt5ShukiArrayData
        mt5Memory3.mt5PtArrayData = mt5.mt5PtArrayData
        mt5Memory3.mt5TriggerArrayData = mt5.mt5TriggerArrayData
        mt5Memory3.mt5ResultArrayData = mt5.mt5ResultArrayData
        mt5Memory3.hatanoACount = mt5.hatanoACount
        mt5Memory3.hatanoBCount = mt5.hatanoBCount
        mt5Memory3.hatanoCountSum = mt5.hatanoCountSum
        mt5Memory3.rivalGamoCount = mt5.rivalGamoCount
        mt5Memory3.rivalHamaokaCount = mt5.rivalHamaokaCount
        mt5Memory3.rivalEnokiCount = mt5.rivalEnokiCount
        mt5Memory3.atCountPlus1 = mt5.atCountPlus1
        mt5Memory3.blueMedalCount = mt5.blueMedalCount
        mt5Memory3.yellowMedalCount = mt5.yellowMedalCount
        mt5Memory3.blackMedalCount = mt5.blackMedalCount
        mt5Memory3.atCount = mt5.atCount
        mt5Memory3.AoshimaSGShifukuCount = mt5.AoshimaSGShifukuCount
        mt5Memory3.AoshimaSGRaceCount = mt5.AoshimaSGRaceCount
        mt5Memory3.AoshimaSGDressCount = mt5.AoshimaSGDressCount
        mt5Memory3.AoshimaSGHatanoCount = mt5.AoshimaSGHatanoCount
        mt5Memory3.AoshimaSGCountSum = mt5.AoshimaSGCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct mt5ViewLoadMemory: View {
    @ObservedObject var mt5: Mt5
    @ObservedObject var mt5Memory1: Mt5Memory1
    @ObservedObject var mt5Memory2: Mt5Memory2
    @ObservedObject var mt5Memory3: Mt5Memory3
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "モンキーターン5",
            selectedMemory: $mt5.selectedMemory,
            memoMemory1: mt5Memory1.memo,
            dateDoubleMemory1: mt5Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mt5Memory2.memo,
            dateDoubleMemory2: mt5Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mt5Memory3.memo,
            dateDoubleMemory3: mt5Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        mt5.coin5Count = mt5Memory1.coin5Count
        mt5.startGame = mt5Memory1.startGame
        mt5.currentGame = mt5Memory1.currentGame
        mt5.playGame = mt5Memory1.playGame
        let memoryMt5ShukiArray = decodeStringArray(from: mt5Memory1.mt5ShukiArrayData)
        saveArray(memoryMt5ShukiArray, forKey: mt5.mt5ShukiArrayKey)
        let memoryMt5PtArray = decodeStringArray(from: mt5Memory1.mt5PtArrayData)
        saveArray(memoryMt5PtArray, forKey: mt5.mt5PtArrayKey)
        let memoryMt5TriggerArray = decodeStringArray(from: mt5Memory1.mt5TriggerArrayData)
        saveArray(memoryMt5TriggerArray, forKey: mt5.mt5TriggerArrayKey)
        let memoryMt5ResultArray = decodeStringArray(from: mt5Memory1.mt5ResultArrayData)
        saveArray(memoryMt5ResultArray, forKey: mt5.mt5ResultArrayKey)
//        mt5.mt5ShukiArrayData = mt5Memory1.mt5ShukiArrayData
//        mt5.mt5PtArrayData = mt5Memory1.mt5PtArrayData
//        mt5.mt5TriggerArrayData = mt5Memory1.mt5TriggerArrayData
//        mt5.mt5ResultArrayData = mt5Memory1.mt5ResultArrayData
        mt5.hatanoACount = mt5Memory1.hatanoACount
        mt5.hatanoBCount = mt5Memory1.hatanoBCount
        mt5.hatanoCountSum = mt5Memory1.hatanoCountSum
        mt5.rivalGamoCount = mt5Memory1.rivalGamoCount
        mt5.rivalHamaokaCount = mt5Memory1.rivalHamaokaCount
        mt5.rivalEnokiCount = mt5Memory1.rivalEnokiCount
        mt5.atCountPlus1 = mt5Memory1.atCountPlus1
        mt5.blueMedalCount = mt5Memory1.blueMedalCount
        mt5.yellowMedalCount = mt5Memory1.yellowMedalCount
        mt5.blackMedalCount = mt5Memory1.blackMedalCount
        mt5.atCount = mt5Memory1.atCount
        mt5.AoshimaSGShifukuCount = mt5Memory1.AoshimaSGShifukuCount
        mt5.AoshimaSGRaceCount = mt5Memory1.AoshimaSGRaceCount
        mt5.AoshimaSGDressCount = mt5Memory1.AoshimaSGDressCount
        mt5.AoshimaSGHatanoCount = mt5Memory1.AoshimaSGHatanoCount
        mt5.AoshimaSGCountSum = mt5Memory1.AoshimaSGCountSum
    }
    func loadMemory2() {
        mt5.coin5Count = mt5Memory2.coin5Count
        mt5.startGame = mt5Memory2.startGame
        mt5.currentGame = mt5Memory2.currentGame
        mt5.playGame = mt5Memory2.playGame
        let memoryMt5ShukiArray = decodeStringArray(from: mt5Memory2.mt5ShukiArrayData)
        saveArray(memoryMt5ShukiArray, forKey: mt5.mt5ShukiArrayKey)
        let memoryMt5PtArray = decodeStringArray(from: mt5Memory2.mt5PtArrayData)
        saveArray(memoryMt5PtArray, forKey: mt5.mt5PtArrayKey)
        let memoryMt5TriggerArray = decodeStringArray(from: mt5Memory2.mt5TriggerArrayData)
        saveArray(memoryMt5TriggerArray, forKey: mt5.mt5TriggerArrayKey)
        let memoryMt5ResultArray = decodeStringArray(from: mt5Memory2.mt5ResultArrayData)
        saveArray(memoryMt5ResultArray, forKey: mt5.mt5ResultArrayKey)
//        mt5.mt5ShukiArrayData = mt5Memory2.mt5ShukiArrayData
//        mt5.mt5PtArrayData = mt5Memory2.mt5PtArrayData
//        mt5.mt5TriggerArrayData = mt5Memory2.mt5TriggerArrayData
//        mt5.mt5ResultArrayData = mt5Memory2.mt5ResultArrayData
        mt5.hatanoACount = mt5Memory2.hatanoACount
        mt5.hatanoBCount = mt5Memory2.hatanoBCount
        mt5.hatanoCountSum = mt5Memory2.hatanoCountSum
        mt5.rivalGamoCount = mt5Memory2.rivalGamoCount
        mt5.rivalHamaokaCount = mt5Memory2.rivalHamaokaCount
        mt5.rivalEnokiCount = mt5Memory2.rivalEnokiCount
        mt5.atCountPlus1 = mt5Memory2.atCountPlus1
        mt5.blueMedalCount = mt5Memory2.blueMedalCount
        mt5.yellowMedalCount = mt5Memory2.yellowMedalCount
        mt5.blackMedalCount = mt5Memory2.blackMedalCount
        mt5.atCount = mt5Memory2.atCount
        mt5.AoshimaSGShifukuCount = mt5Memory2.AoshimaSGShifukuCount
        mt5.AoshimaSGRaceCount = mt5Memory2.AoshimaSGRaceCount
        mt5.AoshimaSGDressCount = mt5Memory2.AoshimaSGDressCount
        mt5.AoshimaSGHatanoCount = mt5Memory2.AoshimaSGHatanoCount
        mt5.AoshimaSGCountSum = mt5Memory2.AoshimaSGCountSum
    }
    func loadMemory3() {
        mt5.coin5Count = mt5Memory3.coin5Count
        mt5.startGame = mt5Memory3.startGame
        mt5.currentGame = mt5Memory3.currentGame
        mt5.playGame = mt5Memory3.playGame
        let memoryMt5ShukiArray = decodeStringArray(from: mt5Memory3.mt5ShukiArrayData)
        saveArray(memoryMt5ShukiArray, forKey: mt5.mt5ShukiArrayKey)
        let memoryMt5PtArray = decodeStringArray(from: mt5Memory3.mt5PtArrayData)
        saveArray(memoryMt5PtArray, forKey: mt5.mt5PtArrayKey)
        let memoryMt5TriggerArray = decodeStringArray(from: mt5Memory3.mt5TriggerArrayData)
        saveArray(memoryMt5TriggerArray, forKey: mt5.mt5TriggerArrayKey)
        let memoryMt5ResultArray = decodeStringArray(from: mt5Memory3.mt5ResultArrayData)
        saveArray(memoryMt5ResultArray, forKey: mt5.mt5ResultArrayKey)
//        mt5.mt5ShukiArrayData = mt5Memory3.mt5ShukiArrayData
//        mt5.mt5PtArrayData = mt5Memory3.mt5PtArrayData
//        mt5.mt5TriggerArrayData = mt5Memory3.mt5TriggerArrayData
//        mt5.mt5ResultArrayData = mt5Memory3.mt5ResultArrayData
        mt5.hatanoACount = mt5Memory3.hatanoACount
        mt5.hatanoBCount = mt5Memory3.hatanoBCount
        mt5.hatanoCountSum = mt5Memory3.hatanoCountSum
        mt5.rivalGamoCount = mt5Memory3.rivalGamoCount
        mt5.rivalHamaokaCount = mt5Memory3.rivalHamaokaCount
        mt5.rivalEnokiCount = mt5Memory3.rivalEnokiCount
        mt5.atCountPlus1 = mt5Memory3.atCountPlus1
        mt5.blueMedalCount = mt5Memory3.blueMedalCount
        mt5.yellowMedalCount = mt5Memory3.yellowMedalCount
        mt5.blackMedalCount = mt5Memory3.blackMedalCount
        mt5.atCount = mt5Memory3.atCount
        mt5.AoshimaSGShifukuCount = mt5Memory3.AoshimaSGShifukuCount
        mt5.AoshimaSGRaceCount = mt5Memory3.AoshimaSGRaceCount
        mt5.AoshimaSGDressCount = mt5Memory3.AoshimaSGDressCount
        mt5.AoshimaSGHatanoCount = mt5Memory3.AoshimaSGHatanoCount
        mt5.AoshimaSGCountSum = mt5Memory3.AoshimaSGCountSum
    }
}

#Preview {
    mt5ViewTop()
}
