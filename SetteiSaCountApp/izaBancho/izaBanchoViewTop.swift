//
//  izaBanchoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewTop: View {
    @ObservedObject var ver330: Ver330
    @ObservedObject var ver340: Ver340
    @StateObject var izaBancho = IzaBancho()
    @State var isShowAlert: Bool = false
    @StateObject var izaBanchoMemory1 = IzaBanchoMemory1()
    @StateObject var izaBanchoMemory2 = IzaBanchoMemory2()
    @StateObject var izaBanchoMemory3 = IzaBanchoMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: izaBancho.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: izaBanchoViewNormal(
                        ver340: ver340,
                        izaBancho: izaBancho,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: ver340.izaBanchoMenuNormalBadgeStaus,
                        )
                    }
                    // 初当り
                    NavigationLink(destination: izaBanchoViewFirstHit(
                        ver340: ver340,
                        izaBancho: izaBancho,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: ver340.izaBanchoMenuFirstHitBadgeStaus,
                        )
                    }
                    // AT中
                    NavigationLink(destination: izaBanchoViewAtGift(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "gift.fill",
                            textBody: "AT突入時の成敗報酬"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: izaBanchoViewScreen(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: izaBanchoView95Ci(
                    izaBancho: izaBancho,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4805")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver340.izaBanchoMachineIconBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(izaBanchoSubViewLoadMemory(
                        izaBancho: izaBancho,
                        izaBanchoMemory1: izaBanchoMemory1,
                        izaBanchoMemory2: izaBanchoMemory2,
                        izaBanchoMemory3: izaBanchoMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(izaBanchoSubViewSaveMemory(
                        izaBancho: izaBancho,
                        izaBanchoMemory1: izaBanchoMemory1,
                        izaBanchoMemory2: izaBanchoMemory2,
                        izaBanchoMemory3: izaBanchoMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: izaBancho.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct izaBanchoSubViewSaveMemory: View {
    @ObservedObject var izaBancho: IzaBancho
    @ObservedObject var izaBanchoMemory1: IzaBanchoMemory1
    @ObservedObject var izaBanchoMemory2: IzaBanchoMemory2
    @ObservedObject var izaBanchoMemory3: IzaBanchoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: izaBancho.machineName,
            selectedMemory: $izaBancho.selectedMemory,
            memoMemory1: $izaBanchoMemory1.memo,
            dateDoubleMemory1: $izaBanchoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $izaBanchoMemory2.memo,
            dateDoubleMemory2: $izaBanchoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $izaBanchoMemory3.memo,
            dateDoubleMemory3: $izaBanchoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        izaBanchoMemory1.screenCountDefault = izaBancho.screenCountDefault
        izaBanchoMemory1.screenCountScreen2 = izaBancho.screenCountScreen2
        izaBanchoMemory1.screenCountScreen3 = izaBancho.screenCountScreen3
        izaBanchoMemory1.screenCountScreen4 = izaBancho.screenCountScreen4
        izaBanchoMemory1.screenCountScreen5 = izaBancho.screenCountScreen5
        izaBanchoMemory1.screenCountScreen6 = izaBancho.screenCountScreen6
        izaBanchoMemory1.screenCountScreen7 = izaBancho.screenCountScreen7
        izaBanchoMemory1.screenCountScreen8 = izaBancho.screenCountScreen8
        izaBanchoMemory1.screenCountSum = izaBancho.screenCountSum
        izaBanchoMemory1.gameArrayData = izaBancho.gameArrayData
        izaBanchoMemory1.bonusKindArrayData = izaBancho.bonusKindArrayData
        izaBanchoMemory1.triggerArrayData = izaBancho.triggerArrayData
        izaBanchoMemory1.playGameSum = izaBancho.playGameSum
        izaBanchoMemory1.atCount = izaBancho.atCount
        izaBanchoMemory1.bonusCount = izaBancho.bonusCount
        izaBanchoMemory1.firstHitCount = izaBancho.firstHitCount
    }
    func saveMemory2() {
        izaBanchoMemory2.screenCountDefault = izaBancho.screenCountDefault
        izaBanchoMemory2.screenCountScreen2 = izaBancho.screenCountScreen2
        izaBanchoMemory2.screenCountScreen3 = izaBancho.screenCountScreen3
        izaBanchoMemory2.screenCountScreen4 = izaBancho.screenCountScreen4
        izaBanchoMemory2.screenCountScreen5 = izaBancho.screenCountScreen5
        izaBanchoMemory2.screenCountScreen6 = izaBancho.screenCountScreen6
        izaBanchoMemory2.screenCountScreen7 = izaBancho.screenCountScreen7
        izaBanchoMemory2.screenCountScreen8 = izaBancho.screenCountScreen8
        izaBanchoMemory2.screenCountSum = izaBancho.screenCountSum
        izaBanchoMemory2.gameArrayData = izaBancho.gameArrayData
        izaBanchoMemory2.bonusKindArrayData = izaBancho.bonusKindArrayData
        izaBanchoMemory2.triggerArrayData = izaBancho.triggerArrayData
        izaBanchoMemory2.playGameSum = izaBancho.playGameSum
        izaBanchoMemory2.atCount = izaBancho.atCount
        izaBanchoMemory2.bonusCount = izaBancho.bonusCount
        izaBanchoMemory2.firstHitCount = izaBancho.firstHitCount
    }
    func saveMemory3() {
        izaBanchoMemory3.screenCountDefault = izaBancho.screenCountDefault
        izaBanchoMemory3.screenCountScreen2 = izaBancho.screenCountScreen2
        izaBanchoMemory3.screenCountScreen3 = izaBancho.screenCountScreen3
        izaBanchoMemory3.screenCountScreen4 = izaBancho.screenCountScreen4
        izaBanchoMemory3.screenCountScreen5 = izaBancho.screenCountScreen5
        izaBanchoMemory3.screenCountScreen6 = izaBancho.screenCountScreen6
        izaBanchoMemory3.screenCountScreen7 = izaBancho.screenCountScreen7
        izaBanchoMemory3.screenCountScreen8 = izaBancho.screenCountScreen8
        izaBanchoMemory3.screenCountSum = izaBancho.screenCountSum
        izaBanchoMemory3.gameArrayData = izaBancho.gameArrayData
        izaBanchoMemory3.bonusKindArrayData = izaBancho.bonusKindArrayData
        izaBanchoMemory3.triggerArrayData = izaBancho.triggerArrayData
        izaBanchoMemory3.playGameSum = izaBancho.playGameSum
        izaBanchoMemory3.atCount = izaBancho.atCount
        izaBanchoMemory3.bonusCount = izaBancho.bonusCount
        izaBanchoMemory3.firstHitCount = izaBancho.firstHitCount
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct izaBanchoSubViewLoadMemory: View {
    @ObservedObject var izaBancho: IzaBancho
    @ObservedObject var izaBanchoMemory1: IzaBanchoMemory1
    @ObservedObject var izaBanchoMemory2: IzaBanchoMemory2
    @ObservedObject var izaBanchoMemory3: IzaBanchoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: izaBancho.machineName,
            selectedMemory: $izaBancho.selectedMemory,
            memoMemory1: izaBanchoMemory1.memo,
            dateDoubleMemory1: izaBanchoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: izaBanchoMemory2.memo,
            dateDoubleMemory2: izaBanchoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: izaBanchoMemory3.memo,
            dateDoubleMemory3: izaBanchoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        izaBancho.screenCountDefault = izaBanchoMemory1.screenCountDefault
        izaBancho.screenCountScreen2 = izaBanchoMemory1.screenCountScreen2
        izaBancho.screenCountScreen3 = izaBanchoMemory1.screenCountScreen3
        izaBancho.screenCountScreen4 = izaBanchoMemory1.screenCountScreen4
        izaBancho.screenCountScreen5 = izaBanchoMemory1.screenCountScreen5
        izaBancho.screenCountScreen6 = izaBanchoMemory1.screenCountScreen6
        izaBancho.screenCountScreen7 = izaBanchoMemory1.screenCountScreen7
        izaBancho.screenCountScreen8 = izaBanchoMemory1.screenCountScreen8
        izaBancho.screenCountSum = izaBanchoMemory1.screenCountSum
        izaBancho.playGameSum = izaBanchoMemory1.playGameSum
        izaBancho.atCount = izaBanchoMemory1.atCount
        izaBancho.bonusCount = izaBanchoMemory1.bonusCount
        izaBancho.firstHitCount = izaBanchoMemory1.firstHitCount
        let memoryGameArrayData = decodeIntArray(from: izaBanchoMemory1.gameArrayData)
        saveArray(memoryGameArrayData, forKey: izaBancho.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: izaBanchoMemory1.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: izaBancho.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: izaBanchoMemory1.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: izaBancho.triggerArrayKey)
    }
    func loadMemory2() {
        izaBancho.screenCountDefault = izaBanchoMemory2.screenCountDefault
        izaBancho.screenCountScreen2 = izaBanchoMemory2.screenCountScreen2
        izaBancho.screenCountScreen3 = izaBanchoMemory2.screenCountScreen3
        izaBancho.screenCountScreen4 = izaBanchoMemory2.screenCountScreen4
        izaBancho.screenCountScreen5 = izaBanchoMemory2.screenCountScreen5
        izaBancho.screenCountScreen6 = izaBanchoMemory2.screenCountScreen6
        izaBancho.screenCountScreen7 = izaBanchoMemory2.screenCountScreen7
        izaBancho.screenCountScreen8 = izaBanchoMemory2.screenCountScreen8
        izaBancho.screenCountSum = izaBanchoMemory2.screenCountSum
        izaBancho.playGameSum = izaBanchoMemory2.playGameSum
        izaBancho.atCount = izaBanchoMemory2.atCount
        izaBancho.bonusCount = izaBanchoMemory2.bonusCount
        izaBancho.firstHitCount = izaBanchoMemory2.firstHitCount
        let memoryGameArrayData = decodeIntArray(from: izaBanchoMemory2.gameArrayData)
        saveArray(memoryGameArrayData, forKey: izaBancho.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: izaBanchoMemory2.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: izaBancho.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: izaBanchoMemory2.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: izaBancho.triggerArrayKey)
    }
    func loadMemory3() {
        izaBancho.screenCountDefault = izaBanchoMemory3.screenCountDefault
        izaBancho.screenCountScreen2 = izaBanchoMemory3.screenCountScreen2
        izaBancho.screenCountScreen3 = izaBanchoMemory3.screenCountScreen3
        izaBancho.screenCountScreen4 = izaBanchoMemory3.screenCountScreen4
        izaBancho.screenCountScreen5 = izaBanchoMemory3.screenCountScreen5
        izaBancho.screenCountScreen6 = izaBanchoMemory3.screenCountScreen6
        izaBancho.screenCountScreen7 = izaBanchoMemory3.screenCountScreen7
        izaBancho.screenCountScreen8 = izaBanchoMemory3.screenCountScreen8
        izaBancho.screenCountSum = izaBanchoMemory3.screenCountSum
        izaBancho.playGameSum = izaBanchoMemory3.playGameSum
        izaBancho.atCount = izaBanchoMemory3.atCount
        izaBancho.bonusCount = izaBanchoMemory3.bonusCount
        izaBancho.firstHitCount = izaBanchoMemory3.firstHitCount
        let memoryGameArrayData = decodeIntArray(from: izaBanchoMemory3.gameArrayData)
        saveArray(memoryGameArrayData, forKey: izaBancho.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: izaBanchoMemory3.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: izaBancho.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: izaBanchoMemory3.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: izaBancho.triggerArrayKey)
    }
}

#Preview {
    izaBanchoViewTop(
        ver330: Ver330(),
        ver340: Ver340(),
    )
}
