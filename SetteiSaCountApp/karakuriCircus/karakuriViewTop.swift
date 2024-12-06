//
//  karakuriViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/28.
//

import SwiftUI

// ////////////////////////
// 変数
// ////////////////////////
class Karakuri: ObservableObject {
    // //////////////////////
    // スイカと幕間チャンス
    // //////////////////////
    @AppStorage("karakuriSuikaCount") var suikaCount = 0
    @AppStorage("karakuriMakuaiCount") var makuaiCount = 0
    @AppStorage("karakuriMakuaiPlayGame") var makuaiPlayGame = 0
    // スイカ回数の配列
    let suikaCountArrayKey = "karakuriSuikaCountArrayKey"
    @AppStorage("karakuriSuikaCountArrayKey") var suikaCountArrayData: Data?
    
    // 1行削除
    func removeLastHistoryMakuai() {
        arrayIntRemoveLast(arrayData: suikaCountArrayData, key: suikaCountArrayKey)
    }
    
    // データ追加
    func addDataHistoryMakuai() {
        arrayIntAddData(arrayData: suikaCountArrayData, addData: suikaCount, key: suikaCountArrayKey)
    }
    
    func resetMakuai() {
        arrayIntRemoveAll(arrayData: suikaCountArrayData, key: suikaCountArrayKey)
        suikaCount = 0
        makuaiCount = 0
        makuaiPlayGame = 0
        minusCheck = false
    }
    
    // //////////////////////
    // CZ履歴
    // //////////////////////
    // 選択肢の設定
    @Published var selectListZone = ["100G未満", "100G台", "200G台", "300G台", "400G台", "500G台", "600G台", "700G台", "800G台", "900G台", "1000G台", "1100G台", "1200G台",]
    @Published var selectListTrigger = ["レア役", "規定ゲーム数", "天井", "その他"]
    @Published var selectListScreen = ["karakuriCzScreenNarumi", "karakuriCzScreenMasaru", "karakuriCzScreenShirogane", "karakuriCzScreen3persons", "karakuriCzScreenCoronbine", "karakuriCzScreenFaceless", "karakuriCzScreenSilverQueen", "karakuriCzScreenLise", "karakuriCzScreenArm", "karakuriCzScreenPiero", "karakuriCzAtHit"]
    // 選択結果の設定
    @Published var selectedZone = "100G台"
    @Published var selectedTrigger = "規定ゲーム数"
    @Published var selectedScreen = "karakuriCzAtHit"
    // //// 配列の設定
    // 当選ゾーンの配列
    let zoneArrayKey = "karakuriZoneArrayKey"
    @AppStorage("karakuriZoneArrayKey") var zoneArrayData: Data?
    // 当選契機の配列
    let triggerArrayKey = "karakuriTriggerArrayKey"
    @AppStorage("karakuriTriggerArrayKey") var triggerArrayData: Data?
    // 終了画面の配列
    let screenArrayKey = "karakuriScreenArrayKey"
    @AppStorage("karakuriScreenArrayKey") var screenArrayData: Data?
    
    // 1行削除
    func removeLastHistoryCz() {
        arrayStringRemoveLast(arrayData: zoneArrayData, key: zoneArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: screenArrayData, key: screenArrayKey)
        selectedZone = "100G台"
        selectedTrigger = "規定ゲーム数"
        selectedScreen = "karakuriCzScreenMasaru"
    }
    
    // データ追加
    func addDataHistoryCz() {
        arrayStringAddData(arrayData: zoneArrayData, addData: selectedZone, key: zoneArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: screenArrayData, addData: selectedScreen, key: screenArrayKey)
        selectedZone = "100G台"
        selectedTrigger = "規定ゲーム数"
        selectedScreen = "karakuriCzScreenMasaru"
    }
    
    func resetHistoryCz() {
        arrayStringRemoveAll(arrayData: zoneArrayData, key: zoneArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: screenArrayData, key: screenArrayKey)
        selectedZone = "100G台"
        selectedTrigger = "規定ゲーム数"
        selectedScreen = "karakuriCzScreenMasaru"
        minusCheck = false
    }
    
    // //////////////////////
    // AT中のステージ
    // //////////////////////
    @AppStorage("karakuriStageCountMasaru") var stageCountMasaru = 0 {
        didSet {
            stageCountFirstSum = countSum(stageCountMasaru, stageCountNarumi)
        }
    }
        @AppStorage("karakuriStageCountNarumi") var stageCountNarumi = 0 {
            didSet {
                stageCountFirstSum = countSum(stageCountMasaru, stageCountNarumi)
            }
        }
    @AppStorage("karakuriStageCountTable1") var stageCountTable1 = 0 {
        didSet {
            stageCountTableSum = countSum(stageCountTable1, stageCountTable2, stageCountTable3, stageCountTable4)
        }
    }
        @AppStorage("karakuriStageCountTable2") var stageCountTable2 = 0 {
            didSet {
                stageCountTableSum = countSum(stageCountTable1, stageCountTable2, stageCountTable3, stageCountTable4)
            }
        }
            @AppStorage("karakuriStageCountTable3") var stageCountTable3 = 0 {
                didSet {
                    stageCountTableSum = countSum(stageCountTable1, stageCountTable2, stageCountTable3, stageCountTable4)
                }
            }
                @AppStorage("karakuriStageCountTable4") var stageCountTable4 = 0 {
                    didSet {
                        stageCountTableSum = countSum(stageCountTable1, stageCountTable2, stageCountTable3, stageCountTable4)
                    }
                }
    @AppStorage("karakuriStageCountFirstSum") var stageCountFirstSum = 0
    @AppStorage("karakuriStageCountTableSum") var stageCountTableSum = 0
    
    func resetStage() {
        stageCountMasaru = 0
        stageCountNarumi = 0
        stageCountTable1 = 0
        stageCountTable2 = 0
        stageCountTable3 = 0
        stageCountTable4 = 0
        minusCheck = false
    }
    // //////////////////////
    // AT終了画面
    // //////////////////////
    @AppStorage("karakuriAtScreenCurrentKeyword") var atScreenCurrentKeyword: String = ""
    let atScreenKeywordList: [String] = ["default", "enemy", "women", "ajino", "3person", "fran"]
    @AppStorage("karakuriAtScreenCountDefault") var atScreenCountDefault = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
        }
    }
        @AppStorage("karakuriAtScreenCountEnemy") var atScreenCountEnemy = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
            }
        }
            @AppStorage("karakuriAtScreenCountWomen") var atScreenCountWomen = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
                }
            }
                @AppStorage("karakuriAtScreenCountAjino") var atScreenCountAjino = 0 {
                    didSet {
                        atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
                    }
                }
                    @AppStorage("karakuriAtScreenCount3Person") var atScreenCount3Person = 0 {
                        didSet {
                            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
                        }
                    }
                        @AppStorage("karakuriAtScreenCountFran") var atScreenCountFran = 0 {
                            didSet {
                                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountEnemy, atScreenCountWomen, atScreenCountAjino, atScreenCount3Person, atScreenCountFran)
                            }
                        }
    @AppStorage("karakuriAtScreenCountSum") var atScreenCountSum = 0
    
    func resetAtScreen() {
        atScreenCurrentKeyword = ""
        atScreenCountDefault = 0
        atScreenCountEnemy = 0
        atScreenCountWomen = 0
        atScreenCountAjino = 0
        atScreenCount3Person = 0
        atScreenCountFran = 0
        minusCheck = false
    }
    
    // //////////////////////
    // 運命の一撃
    // //////////////////////
    @AppStorage("karakuriIchigekiSuccessCount") var ichigekiSuccessCount = 0 {
        didSet {
            ichigekiCountSum = countSum(ichigekiSuccessCount, ichigekiFalceCount)
        }
    }
        @AppStorage("karakuriIchigekiFalseCount") var ichigekiFalceCount = 0 {
            didSet {
                ichigekiCountSum = countSum(ichigekiSuccessCount, ichigekiFalceCount)
            }
        }
    @AppStorage("karakuriIchigekiCountSum") var ichigekiCountSum = 0
    
    func resetIchigeki() {
        ichigekiSuccessCount = 0
        ichigekiFalceCount = 0
        minusCheck = false
    }
    
    // //////////////////////
    // エンディング
    // //////////////////////
    @AppStorage("karakuriEndingCountWhite") var endingCountWhite = 0 {
        didSet {
            endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
        }
    }
        @AppStorage("karakuriEndingCountBlue") var endingCountBlue = 0 {
            didSet {
                endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
            }
        }
            @AppStorage("karakuriEndingCountYellow") var endingCountYellow = 0 {
                didSet {
                    endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
                }
            }
                @AppStorage("karakuriEndingCountGreen") var endingCountGreen = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
                    }
                }
                    @AppStorage("karakuriEndingCountRed") var endingCountRed = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
                        }
                    }
                        @AppStorage("karakuriEndingCountPurple") var endingCountPurple = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
                            }
                        }
                            @AppStorage("karakuriEndingCountRainbow") var endingCountRainbow = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountWhite, endingCountBlue, endingCountYellow, endingCountGreen, endingCountRed, endingCountPurple, endingCountRainbow)
                                }
                            }
    @AppStorage("karakuriEndingCountSum") var endingCountSum = 0
    
    func resetEnding() {
        endingCountWhite = 0
        endingCountBlue = 0
        endingCountYellow = 0
        endingCountGreen = 0
        endingCountRed = 0
        endingCountPurple = 0
        endingCountRainbow = 0
        minusCheck = false
    }
    
    // //////////////////////
    // 共通
    // //////////////////////
    @AppStorage("karakuriMinusCheck") var minusCheck = false
    @AppStorage("karakuriSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetMakuai()
        resetHistoryCz()
        resetStage()
        resetAtScreen()
        resetIchigeki()
        resetEnding()
    }
}

// //// メモリー1
class KarakuriMemory1: ObservableObject {
    @AppStorage("karakuriSuikaCountMemory1") var suikaCount = 0
    @AppStorage("karakuriMakuaiCountMemory1") var makuaiCount = 0
    @AppStorage("karakuriMakuaiPlayGameMemory1") var makuaiPlayGame = 0
    @AppStorage("karakuriSuikaCountArrayKeyMemory1") var suikaCountArrayData: Data?
    @AppStorage("karakuriZoneArrayKeyMemory1") var zoneArrayData: Data?
    @AppStorage("karakuriTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("karakuriScreenArrayKeyMemory1") var screenArrayData: Data?
    @AppStorage("karakuriStageCountMasaruMemory1") var stageCountMasaru = 0
    @AppStorage("karakuriStageCountNarumiMemory1") var stageCountNarumi = 0
    @AppStorage("karakuriStageCountTable1Memory1") var stageCountTable1 = 0
    @AppStorage("karakuriStageCountTable2Memory1") var stageCountTable2 = 0
    @AppStorage("karakuriStageCountTable3Memory1") var stageCountTable3 = 0
    @AppStorage("karakuriStageCountTable4Memory1") var stageCountTable4 = 0
    @AppStorage("karakuriStageCountFirstSumMemory1") var stageCountFirstSum = 0
    @AppStorage("karakuriStageCountTableSumMemory1") var stageCountTableSum = 0
    @AppStorage("karakuriAtScreenCountDefaultMemory1") var atScreenCountDefault = 0
    @AppStorage("karakuriAtScreenCountEnemyMemory1") var atScreenCountEnemy = 0
    @AppStorage("karakuriAtScreenCountWomenMemory1") var atScreenCountWomen = 0
    @AppStorage("karakuriAtScreenCountAjinoMemory1") var atScreenCountAjino = 0
    @AppStorage("karakuriAtScreenCount3PersonMemory1") var atScreenCount3Person = 0
    @AppStorage("karakuriAtScreenCountFranMemory1") var atScreenCountFran = 0
    @AppStorage("karakuriAtScreenCountSumMemory1") var atScreenCountSum = 0
    @AppStorage("karakuriIchigekiSuccessCountMemory1") var ichigekiSuccessCount = 0
    @AppStorage("karakuriIchigekiFalseCountMemory1") var ichigekiFalceCount = 0
    @AppStorage("karakuriIchigekiCountSumMemory1") var ichigekiCountSum = 0
    @AppStorage("karakuriEndingCountWhiteMemory1") var endingCountWhite = 0
    @AppStorage("karakuriEndingCountBlueMemory1") var endingCountBlue = 0
    @AppStorage("karakuriEndingCountYellowMemory1") var endingCountYellow = 0
    @AppStorage("karakuriEndingCountGreenMemory1") var endingCountGreen = 0
    @AppStorage("karakuriEndingCountRedMemory1") var endingCountRed = 0
    @AppStorage("karakuriEndingCountPurpleMemory1") var endingCountPurple = 0
    @AppStorage("karakuriEndingCountRainbowMemory1") var endingCountRainbow = 0
    @AppStorage("karakuriEndingCountSumMemory1") var endingCountSum = 0
    @AppStorage("karakuriMemoMemory1") var memo = ""
    @AppStorage("karakuriDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class KarakuriMemory2: ObservableObject {
    @AppStorage("karakuriSuikaCountMemory2") var suikaCount = 0
    @AppStorage("karakuriMakuaiCountMemory2") var makuaiCount = 0
    @AppStorage("karakuriMakuaiPlayGameMemory2") var makuaiPlayGame = 0
    @AppStorage("karakuriSuikaCountArrayKeyMemory2") var suikaCountArrayData: Data?
    @AppStorage("karakuriZoneArrayKeyMemory2") var zoneArrayData: Data?
    @AppStorage("karakuriTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("karakuriScreenArrayKeyMemory2") var screenArrayData: Data?
    @AppStorage("karakuriStageCountMasaruMemory2") var stageCountMasaru = 0
    @AppStorage("karakuriStageCountNarumiMemory2") var stageCountNarumi = 0
    @AppStorage("karakuriStageCountTable1Memory2") var stageCountTable1 = 0
    @AppStorage("karakuriStageCountTable2Memory2") var stageCountTable2 = 0
    @AppStorage("karakuriStageCountTable3Memory2") var stageCountTable3 = 0
    @AppStorage("karakuriStageCountTable4Memory2") var stageCountTable4 = 0
    @AppStorage("karakuriStageCountFirstSumMemory2") var stageCountFirstSum = 0
    @AppStorage("karakuriStageCountTableSumMemory2") var stageCountTableSum = 0
    @AppStorage("karakuriAtScreenCountDefaultMemory2") var atScreenCountDefault = 0
    @AppStorage("karakuriAtScreenCountEnemyMemory2") var atScreenCountEnemy = 0
    @AppStorage("karakuriAtScreenCountWomenMemory2") var atScreenCountWomen = 0
    @AppStorage("karakuriAtScreenCountAjinoMemory2") var atScreenCountAjino = 0
    @AppStorage("karakuriAtScreenCount3PersonMemory2") var atScreenCount3Person = 0
    @AppStorage("karakuriAtScreenCountFranMemory2") var atScreenCountFran = 0
    @AppStorage("karakuriAtScreenCountSumMemory2") var atScreenCountSum = 0
    @AppStorage("karakuriIchigekiSuccessCountMemory2") var ichigekiSuccessCount = 0
    @AppStorage("karakuriIchigekiFalseCountMemory2") var ichigekiFalceCount = 0
    @AppStorage("karakuriIchigekiCountSumMemory2") var ichigekiCountSum = 0
    @AppStorage("karakuriEndingCountWhiteMemory2") var endingCountWhite = 0
    @AppStorage("karakuriEndingCountBlueMemory2") var endingCountBlue = 0
    @AppStorage("karakuriEndingCountYellowMemory2") var endingCountYellow = 0
    @AppStorage("karakuriEndingCountGreenMemory2") var endingCountGreen = 0
    @AppStorage("karakuriEndingCountRedMemory2") var endingCountRed = 0
    @AppStorage("karakuriEndingCountPurpleMemory2") var endingCountPurple = 0
    @AppStorage("karakuriEndingCountRainbowMemory2") var endingCountRainbow = 0
    @AppStorage("karakuriEndingCountSumMemory2") var endingCountSum = 0
    @AppStorage("karakuriMemoMemory2") var memo = ""
    @AppStorage("karakuriDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class KarakuriMemory3: ObservableObject {
    @AppStorage("karakuriSuikaCountMemory3") var suikaCount = 0
    @AppStorage("karakuriMakuaiCountMemory3") var makuaiCount = 0
    @AppStorage("karakuriMakuaiPlayGameMemory3") var makuaiPlayGame = 0
    @AppStorage("karakuriSuikaCountArrayKeyMemory3") var suikaCountArrayData: Data?
    @AppStorage("karakuriZoneArrayKeyMemory3") var zoneArrayData: Data?
    @AppStorage("karakuriTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("karakuriScreenArrayKeyMemory3") var screenArrayData: Data?
    @AppStorage("karakuriStageCountMasaruMemory3") var stageCountMasaru = 0
    @AppStorage("karakuriStageCountNarumiMemory3") var stageCountNarumi = 0
    @AppStorage("karakuriStageCountTable1Memory3") var stageCountTable1 = 0
    @AppStorage("karakuriStageCountTable2Memory3") var stageCountTable2 = 0
    @AppStorage("karakuriStageCountTable3Memory3") var stageCountTable3 = 0
    @AppStorage("karakuriStageCountTable4Memory3") var stageCountTable4 = 0
    @AppStorage("karakuriStageCountFirstSumMemory3") var stageCountFirstSum = 0
    @AppStorage("karakuriStageCountTableSumMemory3") var stageCountTableSum = 0
    @AppStorage("karakuriAtScreenCountDefaultMemory3") var atScreenCountDefault = 0
    @AppStorage("karakuriAtScreenCountEnemyMemory3") var atScreenCountEnemy = 0
    @AppStorage("karakuriAtScreenCountWomenMemory3") var atScreenCountWomen = 0
    @AppStorage("karakuriAtScreenCountAjinoMemory3") var atScreenCountAjino = 0
    @AppStorage("karakuriAtScreenCount3PersonMemory3") var atScreenCount3Person = 0
    @AppStorage("karakuriAtScreenCountFranMemory3") var atScreenCountFran = 0
    @AppStorage("karakuriAtScreenCountSumMemory3") var atScreenCountSum = 0
    @AppStorage("karakuriIchigekiSuccessCountMemory3") var ichigekiSuccessCount = 0
    @AppStorage("karakuriIchigekiFalseCountMemory3") var ichigekiFalceCount = 0
    @AppStorage("karakuriIchigekiCountSumMemory3") var ichigekiCountSum = 0
    @AppStorage("karakuriEndingCountWhiteMemory3") var endingCountWhite = 0
    @AppStorage("karakuriEndingCountBlueMemory3") var endingCountBlue = 0
    @AppStorage("karakuriEndingCountYellowMemory3") var endingCountYellow = 0
    @AppStorage("karakuriEndingCountGreenMemory3") var endingCountGreen = 0
    @AppStorage("karakuriEndingCountRedMemory3") var endingCountRed = 0
    @AppStorage("karakuriEndingCountPurpleMemory3") var endingCountPurple = 0
    @AppStorage("karakuriEndingCountRainbowMemory3") var endingCountRainbow = 0
    @AppStorage("karakuriEndingCountSumMemory3") var endingCountSum = 0
    @AppStorage("karakuriMemoMemory3") var memo = ""
    @AppStorage("karakuriDateMemory3") var dateDouble = 0.0
}


struct karakuriViewTop: View {
    @ObservedObject var karakuri = Karakuri()
    @State var isShowAlert = false
    @State var isShowSaveView: Bool = false
    @State var isShowLoadView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // スイカと幕間チャンス
                    NavigationLink(destination: karakuriViewMakuai()) {
                        unitLabelMenu(imageSystemName: "curtains.closed", textBody: "スイカと通常幕間チャンス")
                    }
                    // CZ初当たり履歴
                    NavigationLink(destination: karakuriViewCzHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "CZ初当たり履歴")
                    }
                    // AT中のステージ
                    NavigationLink(destination: karakuriViewStage()) {
                        unitLabelMenu(imageSystemName: "robotic.vacuum", textBody: "AT中のステージ")
                    }
                    // AT終了画面
                    NavigationLink(destination: karakuriAtScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
                    }
                    // 運命の一劇突破率
                    NavigationLink(destination: karakuriViewIchigeki()) {
                        unitLabelMenu(imageSystemName: "party.popper", textBody: "運命の一劇")
                    }
                    // エンディング
                    NavigationLink(destination: karakuriViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "からくりサーカス")
                }
                // 設定推測グラフ
                NavigationLink(destination: karakuriView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                .popoverTip(tipVer16095CiAdd())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(karakuriViewLoadMemory()))
//                            .popoverTip(tipUnitButtonLoadMemory())
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(karakuriViewSaveMemory()))
//                            .popoverTip(tipUnitButtonSaveMemory())
                    }
                    .popoverTip(tipUnitButtonMemory())
                    // //// データリセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct karakuriViewSaveMemory: View {
    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuriMemory1 = KarakuriMemory1()
    @ObservedObject var karakuriMemory2 = KarakuriMemory2()
    @ObservedObject var karakuriMemory3 = KarakuriMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "からくりサーカス",
            selectedMemory: $karakuri.selectedMemory,
            memoMemory1: $karakuriMemory1.memo,
            dateDoubleMemory1: $karakuriMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $karakuriMemory2.memo,
            dateDoubleMemory2: $karakuriMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $karakuriMemory3.memo,
            dateDoubleMemory3: $karakuriMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert)
    }
    func saveMemory1() {
        karakuriMemory1.suikaCount = karakuri.suikaCount
        karakuriMemory1.makuaiCount = karakuri.makuaiCount
        karakuriMemory1.makuaiPlayGame = karakuri.makuaiPlayGame
        karakuriMemory1.suikaCountArrayData = karakuri.suikaCountArrayData
        karakuriMemory1.zoneArrayData = karakuri.zoneArrayData
        karakuriMemory1.triggerArrayData = karakuri.triggerArrayData
        karakuriMemory1.screenArrayData = karakuri.screenArrayData
        karakuriMemory1.stageCountMasaru = karakuri.stageCountMasaru
        karakuriMemory1.stageCountNarumi = karakuri.stageCountNarumi
        karakuriMemory1.stageCountTable1 = karakuri.stageCountTable1
        karakuriMemory1.stageCountTable2 = karakuri.stageCountTable2
        karakuriMemory1.stageCountTable3 = karakuri.stageCountTable3
        karakuriMemory1.stageCountTable4 = karakuri.stageCountTable4
        karakuriMemory1.stageCountFirstSum = karakuri.stageCountFirstSum
        karakuriMemory1.stageCountTableSum = karakuri.stageCountTableSum
        karakuriMemory1.atScreenCountDefault = karakuri.atScreenCountDefault
        karakuriMemory1.atScreenCountEnemy = karakuri.atScreenCountEnemy
        karakuriMemory1.atScreenCountWomen = karakuri.atScreenCountWomen
        karakuriMemory1.atScreenCountAjino = karakuri.atScreenCountAjino
        karakuriMemory1.atScreenCount3Person = karakuri.atScreenCount3Person
        karakuriMemory1.atScreenCountFran = karakuri.atScreenCountFran
        karakuriMemory1.atScreenCountSum = karakuri.atScreenCountSum
        karakuriMemory1.ichigekiSuccessCount = karakuri.ichigekiSuccessCount
        karakuriMemory1.ichigekiFalceCount = karakuri.ichigekiFalceCount
        karakuriMemory1.ichigekiCountSum = karakuri.ichigekiCountSum
        karakuriMemory1.endingCountWhite = karakuri.endingCountWhite
        karakuriMemory1.endingCountBlue = karakuri.endingCountBlue
        karakuriMemory1.endingCountYellow = karakuri.endingCountYellow
        karakuriMemory1.endingCountGreen = karakuri.endingCountGreen
        karakuriMemory1.endingCountRed = karakuri.endingCountRed
        karakuriMemory1.endingCountPurple = karakuri.endingCountPurple
        karakuriMemory1.endingCountRainbow = karakuri.endingCountRainbow
        karakuriMemory1.endingCountSum = karakuri.endingCountSum
    }
    func saveMemory2() {
        karakuriMemory2.suikaCount = karakuri.suikaCount
        karakuriMemory2.makuaiCount = karakuri.makuaiCount
        karakuriMemory2.makuaiPlayGame = karakuri.makuaiPlayGame
        karakuriMemory2.suikaCountArrayData = karakuri.suikaCountArrayData
        karakuriMemory2.zoneArrayData = karakuri.zoneArrayData
        karakuriMemory2.triggerArrayData = karakuri.triggerArrayData
        karakuriMemory2.screenArrayData = karakuri.screenArrayData
        karakuriMemory2.stageCountMasaru = karakuri.stageCountMasaru
        karakuriMemory2.stageCountNarumi = karakuri.stageCountNarumi
        karakuriMemory2.stageCountTable1 = karakuri.stageCountTable1
        karakuriMemory2.stageCountTable2 = karakuri.stageCountTable2
        karakuriMemory2.stageCountTable3 = karakuri.stageCountTable3
        karakuriMemory2.stageCountTable4 = karakuri.stageCountTable4
        karakuriMemory2.stageCountFirstSum = karakuri.stageCountFirstSum
        karakuriMemory2.stageCountTableSum = karakuri.stageCountTableSum
        karakuriMemory2.atScreenCountDefault = karakuri.atScreenCountDefault
        karakuriMemory2.atScreenCountEnemy = karakuri.atScreenCountEnemy
        karakuriMemory2.atScreenCountWomen = karakuri.atScreenCountWomen
        karakuriMemory2.atScreenCountAjino = karakuri.atScreenCountAjino
        karakuriMemory2.atScreenCount3Person = karakuri.atScreenCount3Person
        karakuriMemory2.atScreenCountFran = karakuri.atScreenCountFran
        karakuriMemory2.atScreenCountSum = karakuri.atScreenCountSum
        karakuriMemory2.ichigekiSuccessCount = karakuri.ichigekiSuccessCount
        karakuriMemory2.ichigekiFalceCount = karakuri.ichigekiFalceCount
        karakuriMemory2.ichigekiCountSum = karakuri.ichigekiCountSum
        karakuriMemory2.endingCountWhite = karakuri.endingCountWhite
        karakuriMemory2.endingCountBlue = karakuri.endingCountBlue
        karakuriMemory2.endingCountYellow = karakuri.endingCountYellow
        karakuriMemory2.endingCountGreen = karakuri.endingCountGreen
        karakuriMemory2.endingCountRed = karakuri.endingCountRed
        karakuriMemory2.endingCountPurple = karakuri.endingCountPurple
        karakuriMemory2.endingCountRainbow = karakuri.endingCountRainbow
        karakuriMemory2.endingCountSum = karakuri.endingCountSum
    }
    func saveMemory3() {
        karakuriMemory3.suikaCount = karakuri.suikaCount
        karakuriMemory3.makuaiCount = karakuri.makuaiCount
        karakuriMemory3.makuaiPlayGame = karakuri.makuaiPlayGame
        karakuriMemory3.suikaCountArrayData = karakuri.suikaCountArrayData
        karakuriMemory3.zoneArrayData = karakuri.zoneArrayData
        karakuriMemory3.triggerArrayData = karakuri.triggerArrayData
        karakuriMemory3.screenArrayData = karakuri.screenArrayData
        karakuriMemory3.stageCountMasaru = karakuri.stageCountMasaru
        karakuriMemory3.stageCountNarumi = karakuri.stageCountNarumi
        karakuriMemory3.stageCountTable1 = karakuri.stageCountTable1
        karakuriMemory3.stageCountTable2 = karakuri.stageCountTable2
        karakuriMemory3.stageCountTable3 = karakuri.stageCountTable3
        karakuriMemory3.stageCountTable4 = karakuri.stageCountTable4
        karakuriMemory3.stageCountFirstSum = karakuri.stageCountFirstSum
        karakuriMemory3.stageCountTableSum = karakuri.stageCountTableSum
        karakuriMemory3.atScreenCountDefault = karakuri.atScreenCountDefault
        karakuriMemory3.atScreenCountEnemy = karakuri.atScreenCountEnemy
        karakuriMemory3.atScreenCountWomen = karakuri.atScreenCountWomen
        karakuriMemory3.atScreenCountAjino = karakuri.atScreenCountAjino
        karakuriMemory3.atScreenCount3Person = karakuri.atScreenCount3Person
        karakuriMemory3.atScreenCountFran = karakuri.atScreenCountFran
        karakuriMemory3.atScreenCountSum = karakuri.atScreenCountSum
        karakuriMemory3.ichigekiSuccessCount = karakuri.ichigekiSuccessCount
        karakuriMemory3.ichigekiFalceCount = karakuri.ichigekiFalceCount
        karakuriMemory3.ichigekiCountSum = karakuri.ichigekiCountSum
        karakuriMemory3.endingCountWhite = karakuri.endingCountWhite
        karakuriMemory3.endingCountBlue = karakuri.endingCountBlue
        karakuriMemory3.endingCountYellow = karakuri.endingCountYellow
        karakuriMemory3.endingCountGreen = karakuri.endingCountGreen
        karakuriMemory3.endingCountRed = karakuri.endingCountRed
        karakuriMemory3.endingCountPurple = karakuri.endingCountPurple
        karakuriMemory3.endingCountRainbow = karakuri.endingCountRainbow
        karakuriMemory3.endingCountSum = karakuri.endingCountSum
    }
}


// ///////////////////////////
// メモリーロード画面
// ///////////////////////////
struct karakuriViewLoadMemory: View {
    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuriMemory1 = KarakuriMemory1()
    @ObservedObject var karakuriMemory2 = KarakuriMemory2()
    @ObservedObject var karakuriMemory3 = KarakuriMemory3()
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "からくりサーカス",
            selectedMemory: $karakuri.selectedMemory,
            memoMemory1: karakuriMemory1.memo,
            dateDoubleMemory1: karakuriMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: karakuriMemory2.memo,
            dateDoubleMemory2: karakuriMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: karakuriMemory3.memo,
            dateDoubleMemory3: karakuriMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        karakuri.suikaCount = karakuriMemory1.suikaCount
        karakuri.makuaiCount = karakuriMemory1.makuaiCount
        karakuri.makuaiPlayGame = karakuriMemory1.makuaiPlayGame
        karakuri.suikaCountArrayData = karakuriMemory1.suikaCountArrayData
        karakuri.zoneArrayData = karakuriMemory1.zoneArrayData
        karakuri.triggerArrayData = karakuriMemory1.triggerArrayData
        karakuri.screenArrayData = karakuriMemory1.screenArrayData
        karakuri.stageCountMasaru = karakuriMemory1.stageCountMasaru
        karakuri.stageCountNarumi = karakuriMemory1.stageCountNarumi
        karakuri.stageCountTable1 = karakuriMemory1.stageCountTable1
        karakuri.stageCountTable2 = karakuriMemory1.stageCountTable2
        karakuri.stageCountTable3 = karakuriMemory1.stageCountTable3
        karakuri.stageCountTable4 = karakuriMemory1.stageCountTable4
        karakuri.stageCountFirstSum = karakuriMemory1.stageCountFirstSum
        karakuri.stageCountTableSum = karakuriMemory1.stageCountTableSum
        karakuri.atScreenCountDefault = karakuriMemory1.atScreenCountDefault
        karakuri.atScreenCountEnemy = karakuriMemory1.atScreenCountEnemy
        karakuri.atScreenCountWomen = karakuriMemory1.atScreenCountWomen
        karakuri.atScreenCountAjino = karakuriMemory1.atScreenCountAjino
        karakuri.atScreenCount3Person = karakuriMemory1.atScreenCount3Person
        karakuri.atScreenCountFran = karakuriMemory1.atScreenCountFran
        karakuri.atScreenCountSum = karakuriMemory1.atScreenCountSum
        karakuri.ichigekiSuccessCount = karakuriMemory1.ichigekiSuccessCount
        karakuri.ichigekiFalceCount = karakuriMemory1.ichigekiFalceCount
        karakuri.ichigekiCountSum = karakuriMemory1.ichigekiCountSum
        karakuri.endingCountWhite = karakuriMemory1.endingCountWhite
        karakuri.endingCountBlue = karakuriMemory1.endingCountBlue
        karakuri.endingCountYellow = karakuriMemory1.endingCountYellow
        karakuri.endingCountGreen = karakuriMemory1.endingCountGreen
        karakuri.endingCountRed = karakuriMemory1.endingCountRed
        karakuri.endingCountPurple = karakuriMemory1.endingCountPurple
        karakuri.endingCountRainbow = karakuriMemory1.endingCountRainbow
        karakuri.endingCountSum = karakuriMemory1.endingCountSum
    }
    func loadMemory2() {
        karakuri.suikaCount = karakuriMemory2.suikaCount
        karakuri.makuaiCount = karakuriMemory2.makuaiCount
        karakuri.makuaiPlayGame = karakuriMemory2.makuaiPlayGame
        karakuri.suikaCountArrayData = karakuriMemory2.suikaCountArrayData
        karakuri.zoneArrayData = karakuriMemory2.zoneArrayData
        karakuri.triggerArrayData = karakuriMemory2.triggerArrayData
        karakuri.screenArrayData = karakuriMemory2.screenArrayData
        karakuri.stageCountMasaru = karakuriMemory2.stageCountMasaru
        karakuri.stageCountNarumi = karakuriMemory2.stageCountNarumi
        karakuri.stageCountTable1 = karakuriMemory2.stageCountTable1
        karakuri.stageCountTable2 = karakuriMemory2.stageCountTable2
        karakuri.stageCountTable3 = karakuriMemory2.stageCountTable3
        karakuri.stageCountTable4 = karakuriMemory2.stageCountTable4
        karakuri.stageCountFirstSum = karakuriMemory2.stageCountFirstSum
        karakuri.stageCountTableSum = karakuriMemory2.stageCountTableSum
        karakuri.atScreenCountDefault = karakuriMemory2.atScreenCountDefault
        karakuri.atScreenCountEnemy = karakuriMemory2.atScreenCountEnemy
        karakuri.atScreenCountWomen = karakuriMemory2.atScreenCountWomen
        karakuri.atScreenCountAjino = karakuriMemory2.atScreenCountAjino
        karakuri.atScreenCount3Person = karakuriMemory2.atScreenCount3Person
        karakuri.atScreenCountFran = karakuriMemory2.atScreenCountFran
        karakuri.atScreenCountSum = karakuriMemory2.atScreenCountSum
        karakuri.ichigekiSuccessCount = karakuriMemory2.ichigekiSuccessCount
        karakuri.ichigekiFalceCount = karakuriMemory2.ichigekiFalceCount
        karakuri.ichigekiCountSum = karakuriMemory2.ichigekiCountSum
        karakuri.endingCountWhite = karakuriMemory2.endingCountWhite
        karakuri.endingCountBlue = karakuriMemory2.endingCountBlue
        karakuri.endingCountYellow = karakuriMemory2.endingCountYellow
        karakuri.endingCountGreen = karakuriMemory2.endingCountGreen
        karakuri.endingCountRed = karakuriMemory2.endingCountRed
        karakuri.endingCountPurple = karakuriMemory2.endingCountPurple
        karakuri.endingCountRainbow = karakuriMemory2.endingCountRainbow
        karakuri.endingCountSum = karakuriMemory2.endingCountSum
    }
    func loadMemory3() {
        karakuri.suikaCount = karakuriMemory3.suikaCount
        karakuri.makuaiCount = karakuriMemory3.makuaiCount
        karakuri.makuaiPlayGame = karakuriMemory3.makuaiPlayGame
        karakuri.suikaCountArrayData = karakuriMemory3.suikaCountArrayData
        karakuri.zoneArrayData = karakuriMemory3.zoneArrayData
        karakuri.triggerArrayData = karakuriMemory3.triggerArrayData
        karakuri.screenArrayData = karakuriMemory3.screenArrayData
        karakuri.stageCountMasaru = karakuriMemory3.stageCountMasaru
        karakuri.stageCountNarumi = karakuriMemory3.stageCountNarumi
        karakuri.stageCountTable1 = karakuriMemory3.stageCountTable1
        karakuri.stageCountTable2 = karakuriMemory3.stageCountTable2
        karakuri.stageCountTable3 = karakuriMemory3.stageCountTable3
        karakuri.stageCountTable4 = karakuriMemory3.stageCountTable4
        karakuri.stageCountFirstSum = karakuriMemory3.stageCountFirstSum
        karakuri.stageCountTableSum = karakuriMemory3.stageCountTableSum
        karakuri.atScreenCountDefault = karakuriMemory3.atScreenCountDefault
        karakuri.atScreenCountEnemy = karakuriMemory3.atScreenCountEnemy
        karakuri.atScreenCountWomen = karakuriMemory3.atScreenCountWomen
        karakuri.atScreenCountAjino = karakuriMemory3.atScreenCountAjino
        karakuri.atScreenCount3Person = karakuriMemory3.atScreenCount3Person
        karakuri.atScreenCountFran = karakuriMemory3.atScreenCountFran
        karakuri.atScreenCountSum = karakuriMemory3.atScreenCountSum
        karakuri.ichigekiSuccessCount = karakuriMemory3.ichigekiSuccessCount
        karakuri.ichigekiFalceCount = karakuriMemory3.ichigekiFalceCount
        karakuri.ichigekiCountSum = karakuriMemory3.ichigekiCountSum
        karakuri.endingCountWhite = karakuriMemory3.endingCountWhite
        karakuri.endingCountBlue = karakuriMemory3.endingCountBlue
        karakuri.endingCountYellow = karakuriMemory3.endingCountYellow
        karakuri.endingCountGreen = karakuriMemory3.endingCountGreen
        karakuri.endingCountRed = karakuriMemory3.endingCountRed
        karakuri.endingCountPurple = karakuriMemory3.endingCountPurple
        karakuri.endingCountRainbow = karakuriMemory3.endingCountRainbow
        karakuri.endingCountSum = karakuriMemory3.endingCountSum
    }
}

#Preview {
    karakuriViewTop()
}
