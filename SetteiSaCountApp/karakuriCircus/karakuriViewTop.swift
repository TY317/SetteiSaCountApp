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
    
    func resetAll() {
        resetMakuai()
        resetHistoryCz()
        resetStage()
        resetAtScreen()
        resetIchigeki()
        resetEnding()
    }
}

struct karakuriViewTop: View {
    @ObservedObject var karakuri = Karakuri()
    @State var isShowAlert = false
    
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
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    karakuriViewTop()
}
