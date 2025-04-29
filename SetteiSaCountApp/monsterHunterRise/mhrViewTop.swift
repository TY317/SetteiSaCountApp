//
//  mhrViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/16.
//

import SwiftUI
import TipKit

// /////////////////////////
// 変数
// /////////////////////////
class Mhr: ObservableObject {
    // /////////////////////////
    // ボーナス初当り履歴
    // /////////////////////////
    // 選択肢の設定
    let selectListCycle = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期", "7周期"]
    let selectListTrigger = ["クエスト", "直撃", "だるま落し", "百竜夜行", "フリーズ", "天井", "その他"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedCycle = "3周期"
    @Published var selectedTrigger = "クエスト"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "mhrGameArrayKey"
    @AppStorage("mhrGameArrayKey") var gameArrayData: Data?
    // 周期配列
    let cycleArrayKey = "mhrCycleArrayKey"
    @AppStorage("mhrCycleArrayKey") var cycleArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "mhrTriggerArrayKey"
    @AppStorage("mhrTriggerArrayKey") var triggerArrayData: Data?
    // //// 結果集計用
    @AppStorage("mhrAtHitCount") var atHitCount = 0
    @AppStorage("mhrPlayGameSum") var playGameSum = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedCycle = "3周期"
        selectedTrigger = "クエスト"
    }
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedCycle = "3周期"
        selectedTrigger = "クエスト"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedCycle = "3周期"
        selectedTrigger = "クエスト"
        minusCheck = false
        riseZoneCount = 0
        airuCountUnder80 = 0
        airuCountOver120 = 0
    }
    
    // /////////////////////////
    // ボーナス確定画面
    // /////////////////////////
    @AppStorage("mhrBonusScreenCurrentKeyword") var bonusScreenCurrentKeyword: String = ""
    let bonusScreenKeywordList: [String] = [
        "mhrBonusScreenMen",
        "mhrBonusScreenWomen",
        "mhrBonusScreenYou",
        "mhrBonusScreen3Person"
    ]
    @AppStorage("mhrBonusScreenCountMen") var bonusScreenCountMen = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenCountMen, bonusScreenCountWomen, bonusScreenCountYou, bonusScreenCount3Person)
        }
    }
        @AppStorage("mhrBonusScreenCountWomen") var bonusScreenCountWomen = 0 {
            didSet {
                bonusScreenCountSum = countSum(bonusScreenCountMen, bonusScreenCountWomen, bonusScreenCountYou, bonusScreenCount3Person)
            }
        }
            @AppStorage("mhrBonusScreenCountYou") var bonusScreenCountYou = 0 {
                didSet {
                    bonusScreenCountSum = countSum(bonusScreenCountMen, bonusScreenCountWomen, bonusScreenCountYou, bonusScreenCount3Person)
                }
            }
                @AppStorage("mhrBonusScreenCount3Person") var bonusScreenCount3Person = 0 {
                    didSet {
                        bonusScreenCountSum = countSum(bonusScreenCountMen, bonusScreenCountWomen, bonusScreenCountYou, bonusScreenCount3Person)
                    }
                }
    @AppStorage("mhrBonusScreenCountSum") var bonusScreenCountSum = 0
    
    func resetBonusScreen() {
        bonusScreenCurrentKeyword = ""
        bonusScreenCountMen = 0
        bonusScreenCountWomen = 0
        bonusScreenCountYou = 0
        bonusScreenCount3Person = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // AT終了画面
    // /////////////////////////
    @AppStorage("mhrEndScreenCurrentKeyword") var endScreenCurrentKeyword: String = ""
    let endScreenKeywordList: [String] = [
        "mhrEndScreenWadomaru",
        "mhrEndScreenLuke",
        "mhrEndScreenHaruto",
        "mhrEndScreenAsh",
        "mhrEndScreenMimi",
        "mhrEndScreenTsubaki",
        "mhrEndScreenYouOtomo",
        "mhrEndScreenLaraMilandaTaichoIndoor",
        "mhrEndScreenIoriYomogi",
        "mhrEndScreenUtsushiFugen",
        "mhrEndScreenAll",
        "mhrEndScreenHinoeMinotoEnta",
        "mhrEndScreenLukeHarutoMimi",
        "mhrEndScreenWadoAshTsubaki",
        "mhrEndScreenLaraMilandaTaichoOutdoor"
    ]
    @AppStorage("mhrEndScreenCountKisu") var endScreenCountKisu = 0 {
        didSet {
            endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
        }
    }
        @AppStorage("mhrEndScreenCountGusu") var endScreenCountGusu = 0 {
            didSet {
                endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
            }
        }
            @AppStorage("mhrEndScreenCountTsubaki") var endScreenCountTsubaki = 0 {
                didSet {
                    endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                }
            }
                @AppStorage("mhrEndScreenCountYouOtomo") var endScreenCountYouOtomo = 0 {
                    didSet {
                        endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                    }
                }
                    @AppStorage("mhrEndScreenCountLaraMilandaTaichoIndoor") var endScreenCountLaraMilandaTaichoIndoor = 0 {
                        didSet {
                            endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                        }
                    }
                        @AppStorage("mhrEndScreenCountIoriYomogi") var endScreenCountIoriYomogi = 0 {
                            didSet {
                                endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                            }
                        }
                            @AppStorage("mhrEndScreenCountUtsushiFugen") var endScreenCountUtsushiFugen = 0 {
                                didSet {
                                    endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                }
                            }
                                @AppStorage("mhrEndScreenCountAll") var endScreenCountAll = 0 {
                                    didSet {
                                        endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                    }
                                }
                                    @AppStorage("mhrEndScreenCountHinoeMinotoEnta") var endScreenCountHinoeMinotoEnta = 0 {
                                        didSet {
                                            endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                        }
                                    }
                                        @AppStorage("mhrEndScreenCountLukeHarutoMimi") var endScreenCountLukeHarutoMimi = 0 {
                                            didSet {
                                                endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                            }
                                        }
                                            @AppStorage("mhrEndScreenCountWadoAshTsubaki") var endScreenCountWadoAshTsubaki = 0 {
                                                didSet {
                                                    endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                                }
                                            }
                                                @AppStorage("mhrEndScreenCountLaraMilandaTaichoOutdoor") var endScreenCountLaraMilandaTaichoOutdoor = 0 {
                                                    didSet {
                                                        endScreenCountSum = countSum(endScreenCountKisu, endScreenCountGusu, endScreenCountTsubaki, endScreenCountYouOtomo, endScreenCountLaraMilandaTaichoIndoor, endScreenCountIoriYomogi, endScreenCountUtsushiFugen, endScreenCountAll, endScreenCountHinoeMinotoEnta, endScreenCountLukeHarutoMimi, endScreenCountWadoAshTsubaki, endScreenCountLaraMilandaTaichoOutdoor)
                                                    }
                                                }
    @AppStorage("mhrEndScreenCountSum") var endScreenCountSum = 0
    
    func resetEndScreen() {
        endScreenCurrentKeyword = ""
        endScreenCountKisu = 0
        endScreenCountGusu = 0
        endScreenCountTsubaki = 0
        endScreenCountYouOtomo = 0
        endScreenCountLaraMilandaTaichoIndoor = 0
        endScreenCountIoriYomogi = 0
        endScreenCountUtsushiFugen = 0
        endScreenCountAll = 0
        endScreenCountHinoeMinotoEnta = 0
        endScreenCountLukeHarutoMimi = 0
        endScreenCountWadoAshTsubaki = 0
        endScreenCountLaraMilandaTaichoOutdoor = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // エンディング
    // /////////////////////////
    @AppStorage("mhrEndingCountBlue") var endingCountBlue = 0 {
        didSet {
            endingCountSum = countSum(endingCountBlue, endingCountGreen, endingCountRed, endingCountAny)
        }
    }
        @AppStorage("mhrEndingCountGreen") var endingCountGreen = 0 {
            didSet {
                endingCountSum = countSum(endingCountBlue, endingCountGreen, endingCountRed, endingCountAny)
            }
        }
            @AppStorage("mhrEndingCountRed") var endingCountRed = 0 {
                didSet {
                    endingCountSum = countSum(endingCountBlue, endingCountGreen, endingCountRed, endingCountAny)
                }
            }
                @AppStorage("mhrEndingCountAny") var endingCountAny = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountBlue, endingCountGreen, endingCountRed, endingCountAny)
                    }
                }
    @AppStorage("mhrEndingCountSum") var endingCountSum = 0
    
    func resetEnding() {
        endingCountBlue = 0
        endingCountGreen = 0
        endingCountRed = 0
        endingCountAny = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // 共通
    // /////////////////////////
    @AppStorage("mhrMinusCheck") var minusCheck: Bool = false
    @AppStorage("mhrSelectedMemory") var selectedMemory = "メモリー1"
    func resetAll() {
        resetHistory()
        resetBonusScreen()
        resetEndScreen()
        resetEnding()
    }
    
    // //// ver1.8.1追加
    @AppStorage("mhrRiseZoneCount") var riseZoneCount = 0
    
    // //// ver2.0.0追加
    @AppStorage("mhrAiruCountUnder80") var airuCountUnder80: Int = 0 {
        didSet {
            airuCountSum = countSum(airuCountUnder80, airuCountOver120)
        }
    }
        @AppStorage("mhrAiruCountOver120") var airuCountOver120: Int = 0 {
            didSet {
                airuCountSum = countSum(airuCountUnder80, airuCountOver120)
            }
        }
    @AppStorage("mhrAiruCountSum") var airuCountSum: Int = 0
}

// //// メモリー1
class MhrMemory1: ObservableObject {
    @AppStorage("mhrGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("mhrCycleArrayKeyMemory1") var cycleArrayData: Data?
    @AppStorage("mhrTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("mhrAtHitCountMemory1") var atHitCount = 0
    @AppStorage("mhrPlayGameSumMemory1") var playGameSum = 0
    @AppStorage("mhrBonusScreenCountMenMemory1") var bonusScreenCountMen = 0
    @AppStorage("mhrBonusScreenCountWomenMemory1") var bonusScreenCountWomen = 0
    @AppStorage("mhrBonusScreenCountYouMemory1") var bonusScreenCountYou = 0
    @AppStorage("mhrBonusScreenCount3PersonMemory1") var bonusScreenCount3Person = 0
    @AppStorage("mhrBonusScreenCountSumMemory1") var bonusScreenCountSum = 0
    @AppStorage("mhrEndScreenCountKisuMemory1") var endScreenCountKisu = 0
    @AppStorage("mhrEndScreenCountGusuMemory1") var endScreenCountGusu = 0
    @AppStorage("mhrEndScreenCountTsubakiMemory1") var endScreenCountTsubaki = 0
    @AppStorage("mhrEndScreenCountYouOtomoMemory1") var endScreenCountYouOtomo = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoIndoorMemory1") var endScreenCountLaraMilandaTaichoIndoor = 0
    @AppStorage("mhrEndScreenCountIoriYomogiMemory1") var endScreenCountIoriYomogi = 0
    @AppStorage("mhrEndScreenCountUtsushiFugenMemory1") var endScreenCountUtsushiFugen = 0
    @AppStorage("mhrEndScreenCountAllMemory1") var endScreenCountAll = 0
    @AppStorage("mhrEndScreenCountHinoeMinotoEntaMemory1") var endScreenCountHinoeMinotoEnta = 0
    @AppStorage("mhrEndScreenCountLukeHarutoMimiMemory1") var endScreenCountLukeHarutoMimi = 0
    @AppStorage("mhrEndScreenCountWadoAshTsubakiMemory1") var endScreenCountWadoAshTsubaki = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoOutdoorMemory1") var endScreenCountLaraMilandaTaichoOutdoor = 0
    @AppStorage("mhrEndScreenCountSumMemory1") var endScreenCountSum = 0
    @AppStorage("mhrEndingCountBlueMemory1") var endingCountBlue = 0
    @AppStorage("mhrEndingCountGreenMemory1") var endingCountGreen = 0
    @AppStorage("mhrEndingCountRedMemory1") var endingCountRed = 0
    @AppStorage("mhrEndingCountAnyMemory1") var endingCountAny = 0
    @AppStorage("mhrEndingCountSumMemory1") var endingCountSum = 0
    @AppStorage("mhrMemoMemory1") var memo = ""
    @AppStorage("mhrDateMemory1") var dateDouble = 0.0
    @AppStorage("mhrRiseZoneCountMemory1") var riseZoneCount = 0
    // //// ver2.0.0追加
    @AppStorage("mhrAiruCountUnder80Memory1") var airuCountUnder80: Int = 0
    @AppStorage("mhrAiruCountOver120Memory1") var airuCountOver120: Int = 0
    @AppStorage("mhrAiruCountSumMemory1") var airuCountSum: Int = 0
}

// //// メモリー2
class MhrMemory2: ObservableObject {
    @AppStorage("mhrGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("mhrCycleArrayKeyMemory2") var cycleArrayData: Data?
    @AppStorage("mhrTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("mhrAtHitCountMemory2") var atHitCount = 0
    @AppStorage("mhrPlayGameSumMemory2") var playGameSum = 0
    @AppStorage("mhrBonusScreenCountMenMemory2") var bonusScreenCountMen = 0
    @AppStorage("mhrBonusScreenCountWomenMemory2") var bonusScreenCountWomen = 0
    @AppStorage("mhrBonusScreenCountYouMemory2") var bonusScreenCountYou = 0
    @AppStorage("mhrBonusScreenCount3PersonMemory2") var bonusScreenCount3Person = 0
    @AppStorage("mhrBonusScreenCountSumMemory2") var bonusScreenCountSum = 0
    @AppStorage("mhrEndScreenCountKisuMemory2") var endScreenCountKisu = 0
    @AppStorage("mhrEndScreenCountGusuMemory2") var endScreenCountGusu = 0
    @AppStorage("mhrEndScreenCountTsubakiMemory2") var endScreenCountTsubaki = 0
    @AppStorage("mhrEndScreenCountYouOtomoMemory2") var endScreenCountYouOtomo = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoIndoorMemory2") var endScreenCountLaraMilandaTaichoIndoor = 0
    @AppStorage("mhrEndScreenCountIoriYomogiMemory2") var endScreenCountIoriYomogi = 0
    @AppStorage("mhrEndScreenCountUtsushiFugenMemory2") var endScreenCountUtsushiFugen = 0
    @AppStorage("mhrEndScreenCountAllMemory2") var endScreenCountAll = 0
    @AppStorage("mhrEndScreenCountHinoeMinotoEntaMemory2") var endScreenCountHinoeMinotoEnta = 0
    @AppStorage("mhrEndScreenCountLukeHarutoMimiMemory2") var endScreenCountLukeHarutoMimi = 0
    @AppStorage("mhrEndScreenCountWadoAshTsubakiMemory2") var endScreenCountWadoAshTsubaki = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoOutdoorMemory2") var endScreenCountLaraMilandaTaichoOutdoor = 0
    @AppStorage("mhrEndScreenCountSumMemory2") var endScreenCountSum = 0
    @AppStorage("mhrEndingCountBlueMemory2") var endingCountBlue = 0
    @AppStorage("mhrEndingCountGreenMemory2") var endingCountGreen = 0
    @AppStorage("mhrEndingCountRedMemory2") var endingCountRed = 0
    @AppStorage("mhrEndingCountAnyMemory2") var endingCountAny = 0
    @AppStorage("mhrEndingCountSumMemory2") var endingCountSum = 0
    @AppStorage("mhrMemoMemory2") var memo = ""
    @AppStorage("mhrDateMemory2") var dateDouble = 0.0
    @AppStorage("mhrRiseZoneCountMemory2") var riseZoneCount = 0
    @AppStorage("mhrAiruCountUnder80Memory2") var airuCountUnder80: Int = 0
    @AppStorage("mhrAiruCountOver120Memory2") var airuCountOver120: Int = 0
    @AppStorage("mhrAiruCountSumMemory2") var airuCountSum: Int = 0
}

// //// メモリー3
class MhrMemory3: ObservableObject {
    @AppStorage("mhrGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("mhrCycleArrayKeyMemory3") var cycleArrayData: Data?
    @AppStorage("mhrTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("mhrAtHitCountMemory3") var atHitCount = 0
    @AppStorage("mhrPlayGameSumMemory3") var playGameSum = 0
    @AppStorage("mhrBonusScreenCountMenMemory3") var bonusScreenCountMen = 0
    @AppStorage("mhrBonusScreenCountWomenMemory3") var bonusScreenCountWomen = 0
    @AppStorage("mhrBonusScreenCountYouMemory3") var bonusScreenCountYou = 0
    @AppStorage("mhrBonusScreenCount3PersonMemory3") var bonusScreenCount3Person = 0
    @AppStorage("mhrBonusScreenCountSumMemory3") var bonusScreenCountSum = 0
    @AppStorage("mhrEndScreenCountKisuMemory3") var endScreenCountKisu = 0
    @AppStorage("mhrEndScreenCountGusuMemory3") var endScreenCountGusu = 0
    @AppStorage("mhrEndScreenCountTsubakiMemory3") var endScreenCountTsubaki = 0
    @AppStorage("mhrEndScreenCountYouOtomoMemory3") var endScreenCountYouOtomo = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoIndoorMemory3") var endScreenCountLaraMilandaTaichoIndoor = 0
    @AppStorage("mhrEndScreenCountIoriYomogiMemory3") var endScreenCountIoriYomogi = 0
    @AppStorage("mhrEndScreenCountUtsushiFugenMemory3") var endScreenCountUtsushiFugen = 0
    @AppStorage("mhrEndScreenCountAllMemory3") var endScreenCountAll = 0
    @AppStorage("mhrEndScreenCountHinoeMinotoEntaMemory3") var endScreenCountHinoeMinotoEnta = 0
    @AppStorage("mhrEndScreenCountLukeHarutoMimiMemory3") var endScreenCountLukeHarutoMimi = 0
    @AppStorage("mhrEndScreenCountWadoAshTsubakiMemory3") var endScreenCountWadoAshTsubaki = 0
    @AppStorage("mhrEndScreenCountLaraMilandaTaichoOutdoorMemory3") var endScreenCountLaraMilandaTaichoOutdoor = 0
    @AppStorage("mhrEndScreenCountSumMemory3") var endScreenCountSum = 0
    @AppStorage("mhrEndingCountBlueMemory3") var endingCountBlue = 0
    @AppStorage("mhrEndingCountGreenMemory3") var endingCountGreen = 0
    @AppStorage("mhrEndingCountRedMemory3") var endingCountRed = 0
    @AppStorage("mhrEndingCountAnyMemory3") var endingCountAny = 0
    @AppStorage("mhrEndingCountSumMemory3") var endingCountSum = 0
    @AppStorage("mhrMemoMemory3") var memo = ""
    @AppStorage("mhrDateMemory3") var dateDouble = 0.0
    @AppStorage("mhrRiseZoneCountMemory3") var riseZoneCount = 0
    @AppStorage("mhrAiruCountUnder80Memory3") var airuCountUnder80: Int = 0
    @AppStorage("mhrAiruCountOver120Memory3") var airuCountOver120: Int = 0
    @AppStorage("mhrAiruCountSumMemory3") var airuCountSum: Int = 0
}

struct mhrViewTop: View {
//    @ObservedObject var mhr = Mhr()
    @StateObject var mhr = Mhr()
    @State var isShowAlert: Bool = false
    @StateObject var mhrMemory1 = MhrMemory1()
    @StateObject var mhrMemory2 = MhrMemory2()
    @StateObject var mhrMemory3 = MhrMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // AT初当り履歴
                    NavigationLink(destination: mhrViewHistory(mhr: mhr)) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "AT初当たり履歴"
                        )
//                        .popoverTip(tipVer200MhrUpdateInfo())
                    }
                    // ボーナス確定画面
                    NavigationLink(destination: mhrViewBonusScreen(mhr: mhr)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "ボーナス確定画面"
                        )
                    }
                    // ボーナス中　早期討伐時のキャラ紹介
                    NavigationLink(destination: mhrViewDuringBonus()) {
                        unitLabelMenu(
                            imageSystemName: "person.2",
                            textBody: "ボーナス中のキャラ紹介"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: mhrViewEndScreen(mhr: mhr)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: mhrViewEnding(mhr: mhr)) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "モンスターハンター ライズ", titleFont: .title2)
                }
                // 設定推測グラフ
                NavigationLink(destination: mhrView95Ci(mhr: mhr)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4676")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(mhrSubViewLoadMemory(
                        mhr: mhr,
                        mhrMemory1: mhrMemory1,
                        mhrMemory2: mhrMemory2,
                        mhrMemory3: mhrMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(mhrSubViewSaveMemory(
                        mhr: mhr,
                        mhrMemory1: mhrMemory1,
                        mhrMemory2: mhrMemory2,
                        mhrMemory3: mhrMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhr.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct mhrSubViewSaveMemory: View {
    @ObservedObject var mhr: Mhr
    @ObservedObject var mhrMemory1: MhrMemory1
    @ObservedObject var mhrMemory2: MhrMemory2
    @ObservedObject var mhrMemory3: MhrMemory3
    @State var isShowSaveAlert: Bool = false
    var body: some View {
        unitViewSaveMemory(
            machineName: "モンスターハンター ライズ",
            selectedMemory: $mhr.selectedMemory,
            memoMemory1: $mhrMemory1.memo,
            dateDoubleMemory1: $mhrMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mhrMemory2.memo,
            dateDoubleMemory2: $mhrMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mhrMemory3.memo,
            dateDoubleMemory3: $mhrMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mhrMemory1.gameArrayData = mhr.gameArrayData
        mhrMemory1.cycleArrayData = mhr.cycleArrayData
        mhrMemory1.triggerArrayData = mhr.triggerArrayData
        mhrMemory1.atHitCount = mhr.atHitCount
        mhrMemory1.playGameSum = mhr.playGameSum
        mhrMemory1.bonusScreenCountMen = mhr.bonusScreenCountMen
        mhrMemory1.bonusScreenCountWomen = mhr.bonusScreenCountWomen
        mhrMemory1.bonusScreenCountYou = mhr.bonusScreenCountYou
        mhrMemory1.bonusScreenCount3Person = mhr.bonusScreenCount3Person
        mhrMemory1.bonusScreenCountSum = mhr.bonusScreenCountSum
        mhrMemory1.endScreenCountKisu = mhr.endScreenCountKisu
        mhrMemory1.endScreenCountGusu = mhr.endScreenCountGusu
        mhrMemory1.endScreenCountTsubaki = mhr.endScreenCountTsubaki
        mhrMemory1.endScreenCountYouOtomo = mhr.endScreenCountYouOtomo
        mhrMemory1.endScreenCountLaraMilandaTaichoIndoor = mhr.endScreenCountLaraMilandaTaichoIndoor
        mhrMemory1.endScreenCountIoriYomogi = mhr.endScreenCountIoriYomogi
        mhrMemory1.endScreenCountUtsushiFugen = mhr.endScreenCountUtsushiFugen
        mhrMemory1.endScreenCountAll = mhr.endScreenCountAll
        mhrMemory1.endScreenCountHinoeMinotoEnta = mhr.endScreenCountHinoeMinotoEnta
        mhrMemory1.endScreenCountLukeHarutoMimi = mhr.endScreenCountLukeHarutoMimi
        mhrMemory1.endScreenCountWadoAshTsubaki = mhr.endScreenCountWadoAshTsubaki
        mhrMemory1.endScreenCountLaraMilandaTaichoOutdoor = mhr.endScreenCountLaraMilandaTaichoOutdoor
        mhrMemory1.endScreenCountSum = mhr.endScreenCountSum
        mhrMemory1.endingCountBlue = mhr.endingCountBlue
        mhrMemory1.endingCountGreen = mhr.endingCountGreen
        mhrMemory1.endingCountRed = mhr.endingCountRed
        mhrMemory1.endingCountAny = mhr.endingCountAny
        mhrMemory1.endingCountSum = mhr.endingCountSum
        mhrMemory1.riseZoneCount = mhr.riseZoneCount
        mhrMemory1.airuCountUnder80 = mhr.airuCountUnder80
        mhrMemory1.airuCountOver120 = mhr.airuCountOver120
        mhrMemory1.airuCountSum = mhr.airuCountSum
    }
    func saveMemory2() {
        mhrMemory2.gameArrayData = mhr.gameArrayData
        mhrMemory2.cycleArrayData = mhr.cycleArrayData
        mhrMemory2.triggerArrayData = mhr.triggerArrayData
        mhrMemory2.atHitCount = mhr.atHitCount
        mhrMemory2.playGameSum = mhr.playGameSum
        mhrMemory2.bonusScreenCountMen = mhr.bonusScreenCountMen
        mhrMemory2.bonusScreenCountWomen = mhr.bonusScreenCountWomen
        mhrMemory2.bonusScreenCountYou = mhr.bonusScreenCountYou
        mhrMemory2.bonusScreenCount3Person = mhr.bonusScreenCount3Person
        mhrMemory2.bonusScreenCountSum = mhr.bonusScreenCountSum
        mhrMemory2.endScreenCountKisu = mhr.endScreenCountKisu
        mhrMemory2.endScreenCountGusu = mhr.endScreenCountGusu
        mhrMemory2.endScreenCountTsubaki = mhr.endScreenCountTsubaki
        mhrMemory2.endScreenCountYouOtomo = mhr.endScreenCountYouOtomo
        mhrMemory2.endScreenCountLaraMilandaTaichoIndoor = mhr.endScreenCountLaraMilandaTaichoIndoor
        mhrMemory2.endScreenCountIoriYomogi = mhr.endScreenCountIoriYomogi
        mhrMemory2.endScreenCountUtsushiFugen = mhr.endScreenCountUtsushiFugen
        mhrMemory2.endScreenCountAll = mhr.endScreenCountAll
        mhrMemory2.endScreenCountHinoeMinotoEnta = mhr.endScreenCountHinoeMinotoEnta
        mhrMemory2.endScreenCountLukeHarutoMimi = mhr.endScreenCountLukeHarutoMimi
        mhrMemory2.endScreenCountWadoAshTsubaki = mhr.endScreenCountWadoAshTsubaki
        mhrMemory2.endScreenCountLaraMilandaTaichoOutdoor = mhr.endScreenCountLaraMilandaTaichoOutdoor
        mhrMemory2.endScreenCountSum = mhr.endScreenCountSum
        mhrMemory2.endingCountBlue = mhr.endingCountBlue
        mhrMemory2.endingCountGreen = mhr.endingCountGreen
        mhrMemory2.endingCountRed = mhr.endingCountRed
        mhrMemory2.endingCountAny = mhr.endingCountAny
        mhrMemory2.endingCountSum = mhr.endingCountSum
        mhrMemory2.riseZoneCount = mhr.riseZoneCount
        mhrMemory2.airuCountUnder80 = mhr.airuCountUnder80
        mhrMemory2.airuCountOver120 = mhr.airuCountOver120
        mhrMemory2.airuCountSum = mhr.airuCountSum
    }
    func saveMemory3() {
        mhrMemory3.gameArrayData = mhr.gameArrayData
        mhrMemory3.cycleArrayData = mhr.cycleArrayData
        mhrMemory3.triggerArrayData = mhr.triggerArrayData
        mhrMemory3.atHitCount = mhr.atHitCount
        mhrMemory3.playGameSum = mhr.playGameSum
        mhrMemory3.bonusScreenCountMen = mhr.bonusScreenCountMen
        mhrMemory3.bonusScreenCountWomen = mhr.bonusScreenCountWomen
        mhrMemory3.bonusScreenCountYou = mhr.bonusScreenCountYou
        mhrMemory3.bonusScreenCount3Person = mhr.bonusScreenCount3Person
        mhrMemory3.bonusScreenCountSum = mhr.bonusScreenCountSum
        mhrMemory3.endScreenCountKisu = mhr.endScreenCountKisu
        mhrMemory3.endScreenCountGusu = mhr.endScreenCountGusu
        mhrMemory3.endScreenCountTsubaki = mhr.endScreenCountTsubaki
        mhrMemory3.endScreenCountYouOtomo = mhr.endScreenCountYouOtomo
        mhrMemory3.endScreenCountLaraMilandaTaichoIndoor = mhr.endScreenCountLaraMilandaTaichoIndoor
        mhrMemory3.endScreenCountIoriYomogi = mhr.endScreenCountIoriYomogi
        mhrMemory3.endScreenCountUtsushiFugen = mhr.endScreenCountUtsushiFugen
        mhrMemory3.endScreenCountAll = mhr.endScreenCountAll
        mhrMemory3.endScreenCountHinoeMinotoEnta = mhr.endScreenCountHinoeMinotoEnta
        mhrMemory3.endScreenCountLukeHarutoMimi = mhr.endScreenCountLukeHarutoMimi
        mhrMemory3.endScreenCountWadoAshTsubaki = mhr.endScreenCountWadoAshTsubaki
        mhrMemory3.endScreenCountLaraMilandaTaichoOutdoor = mhr.endScreenCountLaraMilandaTaichoOutdoor
        mhrMemory3.endScreenCountSum = mhr.endScreenCountSum
        mhrMemory3.endingCountBlue = mhr.endingCountBlue
        mhrMemory3.endingCountGreen = mhr.endingCountGreen
        mhrMemory3.endingCountRed = mhr.endingCountRed
        mhrMemory3.endingCountAny = mhr.endingCountAny
        mhrMemory3.endingCountSum = mhr.endingCountSum
        mhrMemory3.riseZoneCount = mhr.riseZoneCount
        mhrMemory3.airuCountUnder80 = mhr.airuCountUnder80
        mhrMemory3.airuCountOver120 = mhr.airuCountOver120
        mhrMemory3.airuCountSum = mhr.airuCountSum
    }
}

// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct mhrSubViewLoadMemory: View {
    @ObservedObject var mhr: Mhr
    @ObservedObject var mhrMemory1: MhrMemory1
    @ObservedObject var mhrMemory2: MhrMemory2
    @ObservedObject var mhrMemory3: MhrMemory3
    @State var isShowSaveAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "モンスターハンター ライズ",
            selectedMemory: $mhr.selectedMemory,
            memoMemory1: mhrMemory1.memo,
            dateDoubleMemory1: mhrMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mhrMemory2.memo,
            dateDoubleMemory2: mhrMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mhrMemory3.memo,
            dateDoubleMemory3: mhrMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let memoryGameArray = decodeIntArray(from: mhrMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: mhr.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: mhrMemory1.cycleArrayData)
        saveArray(memoryCycleArray, forKey: mhr.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: mhrMemory1.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: mhr.triggerArrayKey)
//        mhr.gameArrayData = mhrMemory1.gameArrayData
//        mhr.cycleArrayData = mhrMemory1.cycleArrayData
//        mhr.triggerArrayData = mhrMemory1.triggerArrayData
        mhr.atHitCount = mhrMemory1.atHitCount
        mhr.playGameSum = mhrMemory1.playGameSum
        mhr.bonusScreenCountMen = mhrMemory1.bonusScreenCountMen
        mhr.bonusScreenCountWomen = mhrMemory1.bonusScreenCountWomen
        mhr.bonusScreenCountYou = mhrMemory1.bonusScreenCountYou
        mhr.bonusScreenCount3Person = mhrMemory1.bonusScreenCount3Person
        mhr.bonusScreenCountSum = mhrMemory1.bonusScreenCountSum
        mhr.endScreenCountKisu = mhrMemory1.endScreenCountKisu
        mhr.endScreenCountGusu = mhrMemory1.endScreenCountGusu
        mhr.endScreenCountTsubaki = mhrMemory1.endScreenCountTsubaki
        mhr.endScreenCountYouOtomo = mhrMemory1.endScreenCountYouOtomo
        mhr.endScreenCountLaraMilandaTaichoIndoor = mhrMemory1.endScreenCountLaraMilandaTaichoIndoor
        mhr.endScreenCountIoriYomogi = mhrMemory1.endScreenCountIoriYomogi
        mhr.endScreenCountUtsushiFugen = mhrMemory1.endScreenCountUtsushiFugen
        mhr.endScreenCountAll = mhrMemory1.endScreenCountAll
        mhr.endScreenCountHinoeMinotoEnta = mhrMemory1.endScreenCountHinoeMinotoEnta
        mhr.endScreenCountLukeHarutoMimi = mhrMemory1.endScreenCountLukeHarutoMimi
        mhr.endScreenCountWadoAshTsubaki = mhrMemory1.endScreenCountWadoAshTsubaki
        mhr.endScreenCountLaraMilandaTaichoOutdoor = mhrMemory1.endScreenCountLaraMilandaTaichoOutdoor
        mhr.endScreenCountSum = mhrMemory1.endScreenCountSum
        mhr.endingCountBlue = mhrMemory1.endingCountBlue
        mhr.endingCountGreen = mhrMemory1.endingCountGreen
        mhr.endingCountRed = mhrMemory1.endingCountRed
        mhr.endingCountAny = mhrMemory1.endingCountAny
        mhr.endingCountSum = mhrMemory1.endingCountSum
        mhr.riseZoneCount = mhrMemory1.riseZoneCount
        mhr.airuCountUnder80 = mhrMemory1.airuCountUnder80
        mhr.airuCountOver120 = mhrMemory1.airuCountOver120
        mhr.airuCountSum = mhrMemory1.airuCountSum
    }
    func loadMemory2() {
        let memoryGameArray = decodeIntArray(from: mhrMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: mhr.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: mhrMemory2.cycleArrayData)
        saveArray(memoryCycleArray, forKey: mhr.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: mhrMemory2.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: mhr.triggerArrayKey)
//        mhr.gameArrayData = mhrMemory2.gameArrayData
//        mhr.cycleArrayData = mhrMemory2.cycleArrayData
//        mhr.triggerArrayData = mhrMemory2.triggerArrayData
        mhr.atHitCount = mhrMemory2.atHitCount
        mhr.playGameSum = mhrMemory2.playGameSum
        mhr.bonusScreenCountMen = mhrMemory2.bonusScreenCountMen
        mhr.bonusScreenCountWomen = mhrMemory2.bonusScreenCountWomen
        mhr.bonusScreenCountYou = mhrMemory2.bonusScreenCountYou
        mhr.bonusScreenCount3Person = mhrMemory2.bonusScreenCount3Person
        mhr.bonusScreenCountSum = mhrMemory2.bonusScreenCountSum
        mhr.endScreenCountKisu = mhrMemory2.endScreenCountKisu
        mhr.endScreenCountGusu = mhrMemory2.endScreenCountGusu
        mhr.endScreenCountTsubaki = mhrMemory2.endScreenCountTsubaki
        mhr.endScreenCountYouOtomo = mhrMemory2.endScreenCountYouOtomo
        mhr.endScreenCountLaraMilandaTaichoIndoor = mhrMemory2.endScreenCountLaraMilandaTaichoIndoor
        mhr.endScreenCountIoriYomogi = mhrMemory2.endScreenCountIoriYomogi
        mhr.endScreenCountUtsushiFugen = mhrMemory2.endScreenCountUtsushiFugen
        mhr.endScreenCountAll = mhrMemory2.endScreenCountAll
        mhr.endScreenCountHinoeMinotoEnta = mhrMemory2.endScreenCountHinoeMinotoEnta
        mhr.endScreenCountLukeHarutoMimi = mhrMemory2.endScreenCountLukeHarutoMimi
        mhr.endScreenCountWadoAshTsubaki = mhrMemory2.endScreenCountWadoAshTsubaki
        mhr.endScreenCountLaraMilandaTaichoOutdoor = mhrMemory2.endScreenCountLaraMilandaTaichoOutdoor
        mhr.endScreenCountSum = mhrMemory2.endScreenCountSum
        mhr.endingCountBlue = mhrMemory2.endingCountBlue
        mhr.endingCountGreen = mhrMemory2.endingCountGreen
        mhr.endingCountRed = mhrMemory2.endingCountRed
        mhr.endingCountAny = mhrMemory2.endingCountAny
        mhr.endingCountSum = mhrMemory2.endingCountSum
        mhr.riseZoneCount = mhrMemory2.riseZoneCount
        mhr.airuCountUnder80 = mhrMemory2.airuCountUnder80
        mhr.airuCountOver120 = mhrMemory2.airuCountOver120
        mhr.airuCountSum = mhrMemory2.airuCountSum
    }
    func loadMemory3() {
        let memoryGameArray = decodeIntArray(from: mhrMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: mhr.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: mhrMemory3.cycleArrayData)
        saveArray(memoryCycleArray, forKey: mhr.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: mhrMemory3.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: mhr.triggerArrayKey)
//        mhr.gameArrayData = mhrMemory3.gameArrayData
//        mhr.cycleArrayData = mhrMemory3.cycleArrayData
//        mhr.triggerArrayData = mhrMemory3.triggerArrayData
        mhr.atHitCount = mhrMemory3.atHitCount
        mhr.playGameSum = mhrMemory3.playGameSum
        mhr.bonusScreenCountMen = mhrMemory3.bonusScreenCountMen
        mhr.bonusScreenCountWomen = mhrMemory3.bonusScreenCountWomen
        mhr.bonusScreenCountYou = mhrMemory3.bonusScreenCountYou
        mhr.bonusScreenCount3Person = mhrMemory3.bonusScreenCount3Person
        mhr.bonusScreenCountSum = mhrMemory3.bonusScreenCountSum
        mhr.endScreenCountKisu = mhrMemory3.endScreenCountKisu
        mhr.endScreenCountGusu = mhrMemory3.endScreenCountGusu
        mhr.endScreenCountTsubaki = mhrMemory3.endScreenCountTsubaki
        mhr.endScreenCountYouOtomo = mhrMemory3.endScreenCountYouOtomo
        mhr.endScreenCountLaraMilandaTaichoIndoor = mhrMemory3.endScreenCountLaraMilandaTaichoIndoor
        mhr.endScreenCountIoriYomogi = mhrMemory3.endScreenCountIoriYomogi
        mhr.endScreenCountUtsushiFugen = mhrMemory3.endScreenCountUtsushiFugen
        mhr.endScreenCountAll = mhrMemory3.endScreenCountAll
        mhr.endScreenCountHinoeMinotoEnta = mhrMemory3.endScreenCountHinoeMinotoEnta
        mhr.endScreenCountLukeHarutoMimi = mhrMemory3.endScreenCountLukeHarutoMimi
        mhr.endScreenCountWadoAshTsubaki = mhrMemory3.endScreenCountWadoAshTsubaki
        mhr.endScreenCountLaraMilandaTaichoOutdoor = mhrMemory3.endScreenCountLaraMilandaTaichoOutdoor
        mhr.endScreenCountSum = mhrMemory3.endScreenCountSum
        mhr.endingCountBlue = mhrMemory3.endingCountBlue
        mhr.endingCountGreen = mhrMemory3.endingCountGreen
        mhr.endingCountRed = mhrMemory3.endingCountRed
        mhr.endingCountAny = mhrMemory3.endingCountAny
        mhr.endingCountSum = mhrMemory3.endingCountSum
        mhr.riseZoneCount = mhrMemory3.riseZoneCount
        mhr.airuCountUnder80 = mhrMemory3.airuCountUnder80
        mhr.airuCountOver120 = mhrMemory3.airuCountOver120
        mhr.airuCountSum = mhrMemory3.airuCountSum
    }
}


#Preview {
    mhrViewTop()
}
