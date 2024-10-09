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


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct mt5ViewTop: View {
    @ObservedObject var mt5 = Mt5()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // ５枚役
                    NavigationLink(destination: mt5View5coin()) {
                        unitLabelMenu(imageSystemName: "5.circle", textBody: "５枚役")
                    }
                    .popoverTip(mt5TipAdd5Coins())
                    // 周期履歴
                    NavigationLink(destination: mt5ViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "周期履歴")
//                        Image(systemName: "pencil.and.list.clipboard")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("周期履歴")
                    }
                    // 激走チャージ後のセリフ
                    NavigationLink(destination: mt5GekisoView()) {
                        unitLabelMenu(imageSystemName: "message", textBody: "激走チャージ後のセリフ")
//                        Image(systemName: "message")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("激走チャージ後のセリフ")
                    }
                    // ライバルモード
                    NavigationLink(destination: mt5RivalModeView()) {
                        unitLabelMenu(imageSystemName: "person.2", textBody: "ライバルモード")
//                        Image(systemName: "person.2")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ライバルモード")
                    }
                    // ラウンド開始画面の示唆
                    NavigationLink(destination: mt5ViewRoundScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ラウンド開始画面示唆")
//                        Image(systemName: "photo.on.rectangle")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ラウンド開始画面示唆")
                    }
                    // AT終了後のメダル
                    NavigationLink(destination: mt5ViewMedal()) {
                        unitLabelMenu(imageSystemName: "medal", textBody: "AT終了後のメダル")
//                        Image(systemName: "medal")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("AT終了後のメダル")
                    }
                    // 青島SG
                    NavigationLink(destination: mt5ViewAoshimaSG()) {
                        unitLabelMenu(imageSystemName: "sailboat", textBody: "青島SG")
//                        Image(systemName: "sailboat")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("青島SG")
                    }
                    // エンディング
                    NavigationLink(destination: mt5ViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
//                        Image(systemName: "flag.checkered")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "モンキーターン5")
                }
            }
            .navigationTitle("メニュー")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetAll, message: "この機種の全ページのデータは完全に消去されます")
                }
            }
        }
    }
}

#Preview {
    mt5ViewTop()
}
