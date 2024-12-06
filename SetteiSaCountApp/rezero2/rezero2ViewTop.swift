//
//  rezero2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/26.
//

import SwiftUI
import TipKit


// ///////////////////////////
// 変数
// ///////////////////////////
class Rezero2: ObservableObject {
    // //////////////////////////
    // チキチキ雪合戦
    // //////////////////////////
    @AppStorage("rezero2SnowballCountSingle") var snowballCountSingle = 0 {
        didSet {
            snowballCountSum = countSum(snowballCountSingle, snowballCountMultiple)
        }
    }
        @AppStorage("rezero2SnowballCountMultiple") var snowballCountMultiple = 0 {
            didSet {
                snowballCountSum = countSum(snowballCountSingle, snowballCountMultiple)
            }
        }
    @AppStorage("rezero2SnowballCountSum") var snowballCountSum = 0
    
    func resetSnowball() {
        snowballCountSingle = 0
        snowballCountMultiple = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // 初当たり履歴
    // //////////////////////////
    // 選択肢の設定
    @Published var selectListPtZone = ["100未満", "100台", "200台", "300台", "400台", "500台", "600台", "700台", "800台", "900台", "1000台", "1100台", "1200台", "1300台", "1400台"]
    @Published var selectListTrigger = ["規定Pt", "引き戻し", "雪合戦", "直撃", "天井", "その他"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedPt = "200台"
    @Published var selectedTrigger = "規定Pt"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "rezero2GameArrayKey"
    @AppStorage("rezero2GameArrayKey") var gameArrayData: Data?
    // Ptゾーン配列
    let ptZoneArrayKey = "rezero2PtZoneArrayKey"
    @AppStorage("rezero2PtZoneArrayKey") var ptZoneArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "rezero2TriggerArrayKey"
    @AppStorage("rezero2TriggerArrayKey") var triggerArrayData: Data?
    // //// 結果集計用
    @AppStorage("rezero2AtHitCount") var atHitCount = 0
    @AppStorage("rezero2PlayGameSum") var playGameSum = 0
    @AppStorage("rezero2ComebackCount") var comebackCount = 0
    @AppStorage("rezero2PtDrawKisuCount") var ptDrawKisuCount = 0
    @AppStorage("rezero2PtDrawGusuCount") var ptDrawGusuCount = 0
    @AppStorage("rezero2PtDrawKisuWinCount") var ptDrawKisuWinCount = 0
    @AppStorage("rezero2PtDrawGusuWinCount") var ptDrawGusuWinCount = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: ptZoneArrayData, key: ptZoneArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        let gameArray = decodeIntArray(from: gameArrayData)
        playGameSum = gameArray.filter({$0 > 32}).reduce(0, +)
//        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        atHitCount = (atHitCount - comebackCount) > 0 ? (atHitCount - comebackCount) : 0
        ptDrawCount()
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
    }
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: ptZoneArrayData, addData: selectedPt, key: ptZoneArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        let gameArray = decodeIntArray(from: gameArrayData)
        playGameSum = gameArray.filter({$0 > 32}).reduce(0, +)
//        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        atHitCount = (atHitCount - comebackCount) > 0 ? (atHitCount - comebackCount) : 0
        ptDrawCount()
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
    }
    
    // //// 内部Pt抽選の回数を算出
    func ptDrawCount() {
        let ptZoneArray = decodeStringArray(from: ptZoneArrayData)
        let triggerArray = decodeStringArray(from: triggerArrayData)
        // 最初に変数を0リセット
        ptDrawKisuCount = 0
        ptDrawGusuCount = 0
        ptDrawKisuWinCount = 0
        ptDrawGusuWinCount = 0
        
        // 配列にデータがあれば集計
        if ptZoneArray.count > 0 {
            for index in ptZoneArray.indices {
                // 当選Ptが100未満
                if ptZoneArray[index] == selectListPtZone[0] {
                    
                }
                // 当選Ptが100台
                else if ptZoneArray[index] == selectListPtZone[1] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 1
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                    }
                }
                // 当選Ptが200台
                else if ptZoneArray[index] == selectListPtZone[2] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 1
                            ptDrawGusuCount += 1
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 1
                        }
                    }
                }
                // 当選Ptが300台
                else if ptZoneArray[index] == selectListPtZone[3] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 2
                            ptDrawGusuCount += 1
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 1
                            ptDrawGusuCount += 1
                        }
                    }
                }
                // 当選Ptが400台
                else if ptZoneArray[index] == selectListPtZone[4] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 2
                            ptDrawGusuCount += 2
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 2
                            ptDrawGusuCount += 1
                        }
                    }
                }
                // 当選Ptが500台
                else if ptZoneArray[index] == selectListPtZone[5] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 3
                            ptDrawGusuCount += 2
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 2
                            ptDrawGusuCount += 2
                        }
                    }
                }
                // 当選Ptが600台
                else if ptZoneArray[index] == selectListPtZone[6] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 3
                            ptDrawGusuCount += 3
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 3
                            ptDrawGusuCount += 2
                        }
                    }
                }
                // 当選Ptが700台
                else if ptZoneArray[index] == selectListPtZone[7] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 4
                            ptDrawGusuCount += 3
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 3
                            ptDrawGusuCount += 3
                        }
                    }
                }
                // 当選Ptが800台
                else if ptZoneArray[index] == selectListPtZone[8] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 4
                            ptDrawGusuCount += 4
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 4
                            ptDrawGusuCount += 3
                        }
                    }
                }
                // 当選Ptが900台
                else if ptZoneArray[index] == selectListPtZone[9] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 5
                            ptDrawGusuCount += 4
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 4
                            ptDrawGusuCount += 4
                        }
                    }
                }
                // 当選Ptが1000台
                else if ptZoneArray[index] == selectListPtZone[10] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 5
                            ptDrawGusuCount += 5
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 5
                            ptDrawGusuCount += 4
                        }
                    }
                }
                // 当選Ptが1100台
                else if ptZoneArray[index] == selectListPtZone[11] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 6
                            ptDrawGusuCount += 5
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 5
                            ptDrawGusuCount += 5
                        }
                    }
                }
                // 当選Ptが1200台
                else if ptZoneArray[index] == selectListPtZone[12] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 6
                            ptDrawGusuCount += 6
                            ptDrawGusuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 6
                            ptDrawGusuCount += 5
                        }
                    }
                }
                // 当選Ptが1300台
                else if ptZoneArray[index] == selectListPtZone[13] {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 7
                            ptDrawGusuCount += 6
                            ptDrawKisuWinCount += 1
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 6
                            ptDrawGusuCount += 6
                        }
                    }
                }
                // 当選Ptが1400台
                else {
                    if triggerArray.indices.contains(index) {
                        // 規定Ptでの当選の場合
                        if triggerArray[index] == selectListTrigger[0] {
                            ptDrawKisuCount += 7
                            ptDrawGusuCount += 6
                        }
                        // それ以外での当選の場合
                        else {
                            ptDrawKisuCount += 7
                            ptDrawGusuCount += 6
                        }
                    }
                }
            }
        }
        // 配列にデータがなければ0にする
        else {
            ptDrawKisuCount = 0
            ptDrawGusuCount = 0
            ptDrawKisuWinCount = 0
            ptDrawGusuWinCount = 0
        }
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: ptZoneArrayData, key: ptZoneArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        let gameArray = decodeIntArray(from: gameArrayData)
        playGameSum = gameArray.filter({$0 > 32}).reduce(0, +)
//        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        atHitCount = (atHitCount - comebackCount) > 0 ? (atHitCount - comebackCount) : 0
        ptDrawCount()
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    @AppStorage("rezero2ScreenCurrentKeyword") var screenCurrentKeyword = ""
    let screenKeywordList = ["rezero2ScreenGrave", "rezero2ScreenBathMen", "rezero2ScreenBathWomen", "rezero2ScreenRamRem", "rezero2ScreenTeaParty", "rezero2ScreenOutdoorBath", "rezero2ScreenEkidona", "rezero2ScreenBeatris"]
    @AppStorage("rezero2ScreenCountGrave") var screenCountGrave = 0 {
        didSet {
            screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
        }
    }
        @AppStorage("rezero2ScreenCountBathMen") var screenCountBathMen = 0 {
            didSet {
                screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
            }
        }
            @AppStorage("rezero2ScreenCountBathWomen") var screenCountBathWomen = 0 {
                didSet {
                    screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                }
            }
                @AppStorage("rezero2ScreenCountRamRem") var screenCountRamRem = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                    }
                }
                    @AppStorage("rezero2ScreenCountTeaParty") var screenCountTeaParty = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                        }
                    }
                        @AppStorage("rezero2ScreenCountOutdoorBath") var screenCountOutdoorBath = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                            }
                        }
                            @AppStorage("rezero2ScreenCountEkidona") var screenCountEkidona = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                                }
                            }
                                @AppStorage("rezero2ScreenCountBeatris") var screenCountBeatris = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountGrave, screenCountBathMen, screenCountBathWomen, screenCountRamRem, screenCountTeaParty, screenCountOutdoorBath, screenCountEkidona, screenCountBeatris)
                                    }
                                }
    @AppStorage("rezero2ScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCurrentKeyword = ""
        screenCountGrave = 0
        screenCountBathMen = 0
        screenCountBathWomen = 0
        screenCountRamRem = 0
        screenCountTeaParty = 0
        screenCountOutdoorBath = 0
        screenCountEkidona = 0
        screenCountBeatris = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // 共通
    // //////////////////////////
    @AppStorage("rezero2MinusCheck") var minusCheck: Bool = false
    @AppStorage("rezero2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetSnowball()
        resetHistory()
        resetScreen()
    }
}


// //// メモリー1
class Rezero2Memory1: ObservableObject {
    @AppStorage("rezero2SnowballCountSingleMemory1") var snowballCountSingle = 0
    @AppStorage("rezero2SnowballCountMultipleMemory1") var snowballCountMultiple = 0
    @AppStorage("rezero2SnowballCountSumMemory1") var snowballCountSum = 0
    @AppStorage("rezero2GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("rezero2PtZoneArrayKeyMemory1") var ptZoneArrayData: Data?
    @AppStorage("rezero2TriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("rezero2AtHitCountMemory1") var atHitCount = 0
    @AppStorage("rezero2PlayGameSumMemory1") var playGameSum = 0
    @AppStorage("rezero2ComebackCountMemory1") var comebackCount = 0
    @AppStorage("rezero2ScreenCountGraveMemory1") var screenCountGrave = 0
    @AppStorage("rezero2ScreenCountBathMenMemory1") var screenCountBathMen = 0
    @AppStorage("rezero2ScreenCountBathWomenMemory1") var screenCountBathWomen = 0
    @AppStorage("rezero2ScreenCountRamRemMemory1") var screenCountRamRem = 0
    @AppStorage("rezero2ScreenCountTeaPartyMemory1") var screenCountTeaParty = 0
    @AppStorage("rezero2ScreenCountOutdoorBathMemory1") var screenCountOutdoorBath = 0
    @AppStorage("rezero2ScreenCountEkidonaMemory1") var screenCountEkidona = 0
    @AppStorage("rezero2ScreenCountBeatrisMemory1") var screenCountBeatris = 0
    @AppStorage("rezero2ScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("rezero2MemoMemory1") var memo = ""
    @AppStorage("rezero2DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class Rezero2Memory2: ObservableObject {
    @AppStorage("rezero2SnowballCountSingleMemory2") var snowballCountSingle = 0
    @AppStorage("rezero2SnowballCountMultipleMemory2") var snowballCountMultiple = 0
    @AppStorage("rezero2SnowballCountSumMemory2") var snowballCountSum = 0
    @AppStorage("rezero2GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("rezero2PtZoneArrayKeyMemory2") var ptZoneArrayData: Data?
    @AppStorage("rezero2TriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("rezero2AtHitCountMemory2") var atHitCount = 0
    @AppStorage("rezero2PlayGameSumMemory2") var playGameSum = 0
    @AppStorage("rezero2ComebackCountMemory2") var comebackCount = 0
    @AppStorage("rezero2ScreenCountGraveMemory2") var screenCountGrave = 0
    @AppStorage("rezero2ScreenCountBathMenMemory2") var screenCountBathMen = 0
    @AppStorage("rezero2ScreenCountBathWomenMemory2") var screenCountBathWomen = 0
    @AppStorage("rezero2ScreenCountRamRemMemory2") var screenCountRamRem = 0
    @AppStorage("rezero2ScreenCountTeaPartyMemory2") var screenCountTeaParty = 0
    @AppStorage("rezero2ScreenCountOutdoorBathMemory2") var screenCountOutdoorBath = 0
    @AppStorage("rezero2ScreenCountEkidonaMemory2") var screenCountEkidona = 0
    @AppStorage("rezero2ScreenCountBeatrisMemory2") var screenCountBeatris = 0
    @AppStorage("rezero2ScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("rezero2MemoMemory2") var memo = ""
    @AppStorage("rezero2DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class Rezero2Memory3: ObservableObject {
    @AppStorage("rezero2SnowballCountSingleMemory3") var snowballCountSingle = 0
    @AppStorage("rezero2SnowballCountMultipleMemory3") var snowballCountMultiple = 0
    @AppStorage("rezero2SnowballCountSumMemory3") var snowballCountSum = 0
    @AppStorage("rezero2GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("rezero2PtZoneArrayKeyMemory3") var ptZoneArrayData: Data?
    @AppStorage("rezero2TriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("rezero2AtHitCountMemory3") var atHitCount = 0
    @AppStorage("rezero2PlayGameSumMemory3") var playGameSum = 0
    @AppStorage("rezero2ComebackCountMemory3") var comebackCount = 0
    @AppStorage("rezero2ScreenCountGraveMemory3") var screenCountGrave = 0
    @AppStorage("rezero2ScreenCountBathMenMemory3") var screenCountBathMen = 0
    @AppStorage("rezero2ScreenCountBathWomenMemory3") var screenCountBathWomen = 0
    @AppStorage("rezero2ScreenCountRamRemMemory3") var screenCountRamRem = 0
    @AppStorage("rezero2ScreenCountTeaPartyMemory3") var screenCountTeaParty = 0
    @AppStorage("rezero2ScreenCountOutdoorBathMemory3") var screenCountOutdoorBath = 0
    @AppStorage("rezero2ScreenCountEkidonaMemory3") var screenCountEkidona = 0
    @AppStorage("rezero2ScreenCountBeatrisMemory3") var screenCountBeatris = 0
    @AppStorage("rezero2ScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("rezero2MemoMemory3") var memo = ""
    @AppStorage("rezero2DateMemory3") var dateDouble = 0.0
}


struct rezero2ViewTop: View {
    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2Memory1 = Rezero2Memory1()
    @ObservedObject var rezero2Memory2 = Rezero2Memory2()
    @ObservedObject var rezero2Memory3 = Rezero2Memory3()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 菜月家の時計での示唆
                    NavigationLink(destination: rezero2ViewWatch()) {
                        unitLabelMenu(imageSystemName: "watch.analog", textBody: "菜月家ステージでの時計演出")
                    }
                    // チキチキ雪合戦
                    NavigationLink(destination: rezero2ViewSnowball()) {
                        unitLabelMenu(imageSystemName: "snowflake", textBody: "チキチキ雪合戦")
                    }
                    // 初当たり履歴
                    NavigationLink(destination: rezero2ViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "AT初当たり履歴")
                    }
                    // AT終了画面
                    NavigationLink(destination: rezero2ViewScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "Re:ゼロ season2")
                }
                // 設定推測グラフ
                NavigationLink(destination: rezero2View95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                .popoverTip(tipVer16095CiAdd())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(rezero2ViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(rezero2ViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rezero2.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct rezero2ViewSaveMemory: View {
    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2Memory1 = Rezero2Memory1()
    @ObservedObject var rezero2Memory2 = Rezero2Memory2()
    @ObservedObject var rezero2Memory3 = Rezero2Memory3()
    @State var isShowSaveAlert: Bool = false
    var body: some View {
        unitViewSaveMemory(
            machineName: "Re:ゼロ season2",
            selectedMemory: $rezero2.selectedMemory,
            memoMemory1: $rezero2Memory1.memo,
            dateDoubleMemory1: $rezero2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $rezero2Memory2.memo,
            dateDoubleMemory2: $rezero2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $rezero2Memory3.memo,
            dateDoubleMemory3: $rezero2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        rezero2Memory1.snowballCountSingle = rezero2.snowballCountSingle
        rezero2Memory1.snowballCountMultiple = rezero2.snowballCountMultiple
        rezero2Memory1.snowballCountSum = rezero2.snowballCountSum
        rezero2Memory1.gameArrayData = rezero2.gameArrayData
        rezero2Memory1.ptZoneArrayData = rezero2.ptZoneArrayData
        rezero2Memory1.triggerArrayData = rezero2.triggerArrayData
        rezero2Memory1.atHitCount = rezero2.atHitCount
        rezero2Memory1.playGameSum = rezero2.playGameSum
        rezero2Memory1.comebackCount = rezero2.comebackCount
        rezero2Memory1.screenCountGrave = rezero2.screenCountGrave
        rezero2Memory1.screenCountBathMen = rezero2.screenCountBathMen
        rezero2Memory1.screenCountBathWomen = rezero2.screenCountBathWomen
        rezero2Memory1.screenCountRamRem = rezero2.screenCountRamRem
        rezero2Memory1.screenCountTeaParty = rezero2.screenCountTeaParty
        rezero2Memory1.screenCountOutdoorBath = rezero2.screenCountOutdoorBath
        rezero2Memory1.screenCountEkidona = rezero2.screenCountEkidona
        rezero2Memory1.screenCountBeatris = rezero2.screenCountBeatris
        rezero2Memory1.screenCountSum = rezero2.screenCountSum
    }
    func saveMemory2() {
        rezero2Memory2.snowballCountSingle = rezero2.snowballCountSingle
        rezero2Memory2.snowballCountMultiple = rezero2.snowballCountMultiple
        rezero2Memory2.snowballCountSum = rezero2.snowballCountSum
        rezero2Memory2.gameArrayData = rezero2.gameArrayData
        rezero2Memory2.ptZoneArrayData = rezero2.ptZoneArrayData
        rezero2Memory2.triggerArrayData = rezero2.triggerArrayData
        rezero2Memory2.atHitCount = rezero2.atHitCount
        rezero2Memory2.playGameSum = rezero2.playGameSum
        rezero2Memory2.comebackCount = rezero2.comebackCount
        rezero2Memory2.screenCountGrave = rezero2.screenCountGrave
        rezero2Memory2.screenCountBathMen = rezero2.screenCountBathMen
        rezero2Memory2.screenCountBathWomen = rezero2.screenCountBathWomen
        rezero2Memory2.screenCountRamRem = rezero2.screenCountRamRem
        rezero2Memory2.screenCountTeaParty = rezero2.screenCountTeaParty
        rezero2Memory2.screenCountOutdoorBath = rezero2.screenCountOutdoorBath
        rezero2Memory2.screenCountEkidona = rezero2.screenCountEkidona
        rezero2Memory2.screenCountBeatris = rezero2.screenCountBeatris
        rezero2Memory2.screenCountSum = rezero2.screenCountSum
    }
    func saveMemory3() {
        rezero2Memory3.snowballCountSingle = rezero2.snowballCountSingle
        rezero2Memory3.snowballCountMultiple = rezero2.snowballCountMultiple
        rezero2Memory3.snowballCountSum = rezero2.snowballCountSum
        rezero2Memory3.gameArrayData = rezero2.gameArrayData
        rezero2Memory3.ptZoneArrayData = rezero2.ptZoneArrayData
        rezero2Memory3.triggerArrayData = rezero2.triggerArrayData
        rezero2Memory3.atHitCount = rezero2.atHitCount
        rezero2Memory3.playGameSum = rezero2.playGameSum
        rezero2Memory3.comebackCount = rezero2.comebackCount
        rezero2Memory3.screenCountGrave = rezero2.screenCountGrave
        rezero2Memory3.screenCountBathMen = rezero2.screenCountBathMen
        rezero2Memory3.screenCountBathWomen = rezero2.screenCountBathWomen
        rezero2Memory3.screenCountRamRem = rezero2.screenCountRamRem
        rezero2Memory3.screenCountTeaParty = rezero2.screenCountTeaParty
        rezero2Memory3.screenCountOutdoorBath = rezero2.screenCountOutdoorBath
        rezero2Memory3.screenCountEkidona = rezero2.screenCountEkidona
        rezero2Memory3.screenCountBeatris = rezero2.screenCountBeatris
        rezero2Memory3.screenCountSum = rezero2.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct rezero2ViewLoadMemory: View {
    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2Memory1 = Rezero2Memory1()
    @ObservedObject var rezero2Memory2 = Rezero2Memory2()
    @ObservedObject var rezero2Memory3 = Rezero2Memory3()
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "Re:ゼロ season2",
            selectedMemory: $rezero2.selectedMemory,
            memoMemory1: rezero2Memory1.memo,
            dateDoubleMemory1: rezero2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: rezero2Memory2.memo,
            dateDoubleMemory2: rezero2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: rezero2Memory3.memo,
            dateDoubleMemory3: rezero2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        rezero2.snowballCountSingle = rezero2Memory1.snowballCountSingle
        rezero2.snowballCountMultiple = rezero2Memory1.snowballCountMultiple
        rezero2.snowballCountSum = rezero2Memory1.snowballCountSum
        rezero2.gameArrayData = rezero2Memory1.gameArrayData
        rezero2.ptZoneArrayData = rezero2Memory1.ptZoneArrayData
        rezero2.triggerArrayData = rezero2Memory1.triggerArrayData
        rezero2.atHitCount = rezero2Memory1.atHitCount
        rezero2.playGameSum = rezero2Memory1.playGameSum
        rezero2.comebackCount = rezero2Memory1.comebackCount
        rezero2.screenCountGrave = rezero2Memory1.screenCountGrave
        rezero2.screenCountBathMen = rezero2Memory1.screenCountBathMen
        rezero2.screenCountBathWomen = rezero2Memory1.screenCountBathWomen
        rezero2.screenCountRamRem = rezero2Memory1.screenCountRamRem
        rezero2.screenCountTeaParty = rezero2Memory1.screenCountTeaParty
        rezero2.screenCountOutdoorBath = rezero2Memory1.screenCountOutdoorBath
        rezero2.screenCountEkidona = rezero2Memory1.screenCountEkidona
        rezero2.screenCountBeatris = rezero2Memory1.screenCountBeatris
        rezero2.screenCountSum = rezero2Memory1.screenCountSum
    }
    func loadMemory2() {
        rezero2.snowballCountSingle = rezero2Memory2.snowballCountSingle
        rezero2.snowballCountMultiple = rezero2Memory2.snowballCountMultiple
        rezero2.snowballCountSum = rezero2Memory2.snowballCountSum
        rezero2.gameArrayData = rezero2Memory2.gameArrayData
        rezero2.ptZoneArrayData = rezero2Memory2.ptZoneArrayData
        rezero2.triggerArrayData = rezero2Memory2.triggerArrayData
        rezero2.atHitCount = rezero2Memory2.atHitCount
        rezero2.playGameSum = rezero2Memory2.playGameSum
        rezero2.comebackCount = rezero2Memory2.comebackCount
        rezero2.screenCountGrave = rezero2Memory2.screenCountGrave
        rezero2.screenCountBathMen = rezero2Memory2.screenCountBathMen
        rezero2.screenCountBathWomen = rezero2Memory2.screenCountBathWomen
        rezero2.screenCountRamRem = rezero2Memory2.screenCountRamRem
        rezero2.screenCountTeaParty = rezero2Memory2.screenCountTeaParty
        rezero2.screenCountOutdoorBath = rezero2Memory2.screenCountOutdoorBath
        rezero2.screenCountEkidona = rezero2Memory2.screenCountEkidona
        rezero2.screenCountBeatris = rezero2Memory2.screenCountBeatris
        rezero2.screenCountSum = rezero2Memory2.screenCountSum
    }
    func loadMemory3() {
        rezero2.snowballCountSingle = rezero2Memory3.snowballCountSingle
        rezero2.snowballCountMultiple = rezero2Memory3.snowballCountMultiple
        rezero2.snowballCountSum = rezero2Memory3.snowballCountSum
        rezero2.gameArrayData = rezero2Memory3.gameArrayData
        rezero2.ptZoneArrayData = rezero2Memory3.ptZoneArrayData
        rezero2.triggerArrayData = rezero2Memory3.triggerArrayData
        rezero2.atHitCount = rezero2Memory3.atHitCount
        rezero2.playGameSum = rezero2Memory3.playGameSum
        rezero2.comebackCount = rezero2Memory3.comebackCount
        rezero2.screenCountGrave = rezero2Memory3.screenCountGrave
        rezero2.screenCountBathMen = rezero2Memory3.screenCountBathMen
        rezero2.screenCountBathWomen = rezero2Memory3.screenCountBathWomen
        rezero2.screenCountRamRem = rezero2Memory3.screenCountRamRem
        rezero2.screenCountTeaParty = rezero2Memory3.screenCountTeaParty
        rezero2.screenCountOutdoorBath = rezero2Memory3.screenCountOutdoorBath
        rezero2.screenCountEkidona = rezero2Memory3.screenCountEkidona
        rezero2.screenCountBeatris = rezero2Memory3.screenCountBeatris
        rezero2.screenCountSum = rezero2Memory3.screenCountSum
    }
}

#Preview {
    rezero2ViewTop()
}
