//
//  dmc5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5ViewTop: View {
    @ObservedObject var ver340: Ver340
    @ObservedObject var ver350: Ver350
    @StateObject var dmc5 = Dmc5()
    @State var isShowAlert: Bool = false
    @StateObject var dmc5Memory1 = Dmc5Memory1()
    @StateObject var dmc5Memory2 = Dmc5Memory2()
    @StateObject var dmc5Memory3 = Dmc5Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: dmc5ViewNormal(
                        dmc5: dmc5
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: dmc5ViewFristHit(
                        ver350: ver350,
                        dmc5: dmc5,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: ver350.dmc5MenuFirstHitBadgeStaus,
                        )
                    }
                    // DMCボーナス中のバトル当選
                    NavigationLink(destination: dmc5ViewDmcBonus(
                        ver350: ver350,
                        dmc5: dmc5,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.boxing",
                            textBody: "DMCボーナス中のバトル当選",
                            badgeStatus: ver350.dmc5MenuDMCBonusBadgeStaus,
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: dmc5ViewScreen(
                        dmc5: dmc5
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "DMCボーナス終了画面"
                        )
                    }
                    // 上位ST中のセリフ
                    NavigationLink(destination: dmc5ViewVoice(
                        dmc5: dmc5
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "上位ST中のセリフ"
                        )
                    }
                    // エンタトロフィー
                    NavigationLink(destination: commonViewEnteriseTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "エンタトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: dmc5.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: dmc5View95Ci(
                    dmc5: dmc5,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4814")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.dmc5MachineIconBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(dmc5SubViewLoadMemory(
                        dmc5: dmc5,
                        dmc5Memory1: dmc5Memory1,
                        dmc5Memory2: dmc5Memory2,
                        dmc5Memory3: dmc5Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(dmc5SubViewSaveMemory(
                        dmc5: dmc5,
                        dmc5Memory1: dmc5Memory1,
                        dmc5Memory2: dmc5Memory2,
                        dmc5Memory3: dmc5Memory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct dmc5SubViewSaveMemory: View {
    @ObservedObject var dmc5: Dmc5
    @ObservedObject var dmc5Memory1: Dmc5Memory1
    @ObservedObject var dmc5Memory2: Dmc5Memory2
    @ObservedObject var dmc5Memory3: Dmc5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: dmc5.machineName,
            selectedMemory: $dmc5.selectedMemory,
            memoMemory1: $dmc5Memory1.memo,
            dateDoubleMemory1: $dmc5Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $dmc5Memory2.memo,
            dateDoubleMemory2: $dmc5Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $dmc5Memory3.memo,
            dateDoubleMemory3: $dmc5Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        dmc5Memory1.normalGame = dmc5.normalGame
        dmc5Memory1.bonusCount = dmc5.bonusCount
        dmc5Memory1.stCount = dmc5.stCount
        dmc5Memory1.screenCountDefault = dmc5.screenCountDefault
        dmc5Memory1.screenCountKisu = dmc5.screenCountKisu
        dmc5Memory1.screenCountGusu = dmc5.screenCountGusu
        dmc5Memory1.screenCountHighJaku = dmc5.screenCountHighJaku
        dmc5Memory1.screenCountHighKyo = dmc5.screenCountHighKyo
        dmc5Memory1.screenCountNegate3 = dmc5.screenCountNegate3
        dmc5Memory1.screenCountNegate2 = dmc5.screenCountNegate2
        dmc5Memory1.screenCountNegate1 = dmc5.screenCountNegate1
        dmc5Memory1.screenCountOver4 = dmc5.screenCountOver4
        dmc5Memory1.screenCountOver5 = dmc5.screenCountOver5
        dmc5Memory1.screenCountOver6 = dmc5.screenCountOver6
        dmc5Memory1.screenCountSum = dmc5.screenCountSum
        
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        dmc5Memory1.gameArrayData = dmc5.gameArrayData
        dmc5Memory1.bonusKindArrayData = dmc5.bonusKindArrayData
        dmc5Memory1.triggerArrayData = dmc5.triggerArrayData
        dmc5Memory1.stHitArrayData = dmc5.stHitArrayData
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5Memory1.dmcBonusCountChance = dmc5.dmcBonusCountChance
        dmc5Memory1.dmcBonusCountBattle = dmc5.dmcBonusCountBattle
    }
    func saveMemory2() {
        dmc5Memory2.normalGame = dmc5.normalGame
        dmc5Memory2.bonusCount = dmc5.bonusCount
        dmc5Memory2.stCount = dmc5.stCount
        dmc5Memory2.screenCountDefault = dmc5.screenCountDefault
        dmc5Memory2.screenCountKisu = dmc5.screenCountKisu
        dmc5Memory2.screenCountGusu = dmc5.screenCountGusu
        dmc5Memory2.screenCountHighJaku = dmc5.screenCountHighJaku
        dmc5Memory2.screenCountHighKyo = dmc5.screenCountHighKyo
        dmc5Memory2.screenCountNegate3 = dmc5.screenCountNegate3
        dmc5Memory2.screenCountNegate2 = dmc5.screenCountNegate2
        dmc5Memory2.screenCountNegate1 = dmc5.screenCountNegate1
        dmc5Memory2.screenCountOver4 = dmc5.screenCountOver4
        dmc5Memory2.screenCountOver5 = dmc5.screenCountOver5
        dmc5Memory2.screenCountOver6 = dmc5.screenCountOver6
        dmc5Memory2.screenCountSum = dmc5.screenCountSum
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        dmc5Memory2.gameArrayData = dmc5.gameArrayData
        dmc5Memory2.bonusKindArrayData = dmc5.bonusKindArrayData
        dmc5Memory2.triggerArrayData = dmc5.triggerArrayData
        dmc5Memory2.stHitArrayData = dmc5.stHitArrayData
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5Memory2.dmcBonusCountChance = dmc5.dmcBonusCountChance
        dmc5Memory2.dmcBonusCountBattle = dmc5.dmcBonusCountBattle
    }
    func saveMemory3() {
        dmc5Memory3.normalGame = dmc5.normalGame
        dmc5Memory3.bonusCount = dmc5.bonusCount
        dmc5Memory3.stCount = dmc5.stCount
        dmc5Memory3.screenCountDefault = dmc5.screenCountDefault
        dmc5Memory3.screenCountKisu = dmc5.screenCountKisu
        dmc5Memory3.screenCountGusu = dmc5.screenCountGusu
        dmc5Memory3.screenCountHighJaku = dmc5.screenCountHighJaku
        dmc5Memory3.screenCountHighKyo = dmc5.screenCountHighKyo
        dmc5Memory3.screenCountNegate3 = dmc5.screenCountNegate3
        dmc5Memory3.screenCountNegate2 = dmc5.screenCountNegate2
        dmc5Memory3.screenCountNegate1 = dmc5.screenCountNegate1
        dmc5Memory3.screenCountOver4 = dmc5.screenCountOver4
        dmc5Memory3.screenCountOver5 = dmc5.screenCountOver5
        dmc5Memory3.screenCountOver6 = dmc5.screenCountOver6
        dmc5Memory3.screenCountSum = dmc5.screenCountSum
        
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        dmc5Memory3.gameArrayData = dmc5.gameArrayData
        dmc5Memory3.bonusKindArrayData = dmc5.bonusKindArrayData
        dmc5Memory3.triggerArrayData = dmc5.triggerArrayData
        dmc5Memory3.stHitArrayData = dmc5.stHitArrayData
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5Memory3.dmcBonusCountChance = dmc5.dmcBonusCountChance
        dmc5Memory3.dmcBonusCountBattle = dmc5.dmcBonusCountBattle
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct dmc5SubViewLoadMemory: View {
    @ObservedObject var dmc5: Dmc5
    @ObservedObject var dmc5Memory1: Dmc5Memory1
    @ObservedObject var dmc5Memory2: Dmc5Memory2
    @ObservedObject var dmc5Memory3: Dmc5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: dmc5.machineName,
            selectedMemory: $dmc5.selectedMemory,
            memoMemory1: dmc5Memory1.memo,
            dateDoubleMemory1: dmc5Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: dmc5Memory2.memo,
            dateDoubleMemory2: dmc5Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: dmc5Memory3.memo,
            dateDoubleMemory3: dmc5Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        dmc5.normalGame = dmc5Memory1.normalGame
        dmc5.bonusCount = dmc5Memory1.bonusCount
        dmc5.stCount = dmc5Memory1.stCount
        dmc5.screenCountDefault = dmc5Memory1.screenCountDefault
        dmc5.screenCountKisu = dmc5Memory1.screenCountKisu
        dmc5.screenCountGusu = dmc5Memory1.screenCountGusu
        dmc5.screenCountHighJaku = dmc5Memory1.screenCountHighJaku
        dmc5.screenCountHighKyo = dmc5Memory1.screenCountHighKyo
        dmc5.screenCountNegate3 = dmc5Memory1.screenCountNegate3
        dmc5.screenCountNegate2 = dmc5Memory1.screenCountNegate2
        dmc5.screenCountNegate1 = dmc5Memory1.screenCountNegate1
        dmc5.screenCountOver4 = dmc5Memory1.screenCountOver4
        dmc5.screenCountOver5 = dmc5Memory1.screenCountOver5
        dmc5.screenCountOver6 = dmc5Memory1.screenCountOver6
        dmc5.screenCountSum = dmc5Memory1.screenCountSum
        
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        let memoryGameArrayData = decodeIntArray(from: dmc5Memory1.gameArrayData)
        saveArray(memoryGameArrayData, forKey: dmc5.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: dmc5Memory1.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: dmc5.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: dmc5Memory1.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: dmc5.triggerArrayKey)
        let memoryStHitArrayData = decodeStringArray(from: dmc5Memory1.stHitArrayData)
        saveArray(memoryStHitArrayData, forKey: dmc5.stHitArrayKey)
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5.dmcBonusCountChance = dmc5Memory1.dmcBonusCountChance
        dmc5.dmcBonusCountBattle = dmc5Memory1.dmcBonusCountBattle
    }
    func loadMemory2() {
        dmc5.normalGame = dmc5Memory2.normalGame
        dmc5.bonusCount = dmc5Memory2.bonusCount
        dmc5.stCount = dmc5Memory2.stCount
        dmc5.screenCountDefault = dmc5Memory2.screenCountDefault
        dmc5.screenCountKisu = dmc5Memory2.screenCountKisu
        dmc5.screenCountGusu = dmc5Memory2.screenCountGusu
        dmc5.screenCountHighJaku = dmc5Memory2.screenCountHighJaku
        dmc5.screenCountHighKyo = dmc5Memory2.screenCountHighKyo
        dmc5.screenCountNegate3 = dmc5Memory2.screenCountNegate3
        dmc5.screenCountNegate2 = dmc5Memory2.screenCountNegate2
        dmc5.screenCountNegate1 = dmc5Memory2.screenCountNegate1
        dmc5.screenCountOver4 = dmc5Memory2.screenCountOver4
        dmc5.screenCountOver5 = dmc5Memory2.screenCountOver5
        dmc5.screenCountOver6 = dmc5Memory2.screenCountOver6
        dmc5.screenCountSum = dmc5Memory2.screenCountSum
        
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        let memoryGameArrayData = decodeIntArray(from: dmc5Memory2.gameArrayData)
        saveArray(memoryGameArrayData, forKey: dmc5.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: dmc5Memory2.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: dmc5.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: dmc5Memory2.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: dmc5.triggerArrayKey)
        let memoryStHitArrayData = decodeStringArray(from: dmc5Memory2.stHitArrayData)
        saveArray(memoryStHitArrayData, forKey: dmc5.stHitArrayKey)
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5.dmcBonusCountChance = dmc5Memory2.dmcBonusCountChance
        dmc5.dmcBonusCountBattle = dmc5Memory2.dmcBonusCountBattle
    }
    func loadMemory3() {
        dmc5.normalGame = dmc5Memory3.normalGame
        dmc5.bonusCount = dmc5Memory3.bonusCount
        dmc5.stCount = dmc5Memory3.stCount
        dmc5.screenCountDefault = dmc5Memory3.screenCountDefault
        dmc5.screenCountKisu = dmc5Memory3.screenCountKisu
        dmc5.screenCountGusu = dmc5Memory3.screenCountGusu
        dmc5.screenCountHighJaku = dmc5Memory3.screenCountHighJaku
        dmc5.screenCountHighKyo = dmc5Memory3.screenCountHighKyo
        dmc5.screenCountNegate3 = dmc5Memory3.screenCountNegate3
        dmc5.screenCountNegate2 = dmc5Memory3.screenCountNegate2
        dmc5.screenCountNegate1 = dmc5Memory3.screenCountNegate1
        dmc5.screenCountOver4 = dmc5Memory3.screenCountOver4
        dmc5.screenCountOver5 = dmc5Memory3.screenCountOver5
        dmc5.screenCountOver6 = dmc5Memory3.screenCountOver6
        dmc5.screenCountSum = dmc5Memory3.screenCountSum
        
        // //////////////////
        // ver3.4.0で追加
        // 初当り履歴
        // //////////////////
        // 選択肢の設定
        let memoryGameArrayData = decodeIntArray(from: dmc5Memory3.gameArrayData)
        saveArray(memoryGameArrayData, forKey: dmc5.gameArrayKey)
        let memoryBonusKindArrayData = decodeStringArray(from: dmc5Memory3.bonusKindArrayData)
        saveArray(memoryBonusKindArrayData, forKey: dmc5.bonusKindArrayKey)
        let memoryTriggerArrayData = decodeStringArray(from: dmc5Memory3.triggerArrayData)
        saveArray(memoryTriggerArrayData, forKey: dmc5.triggerArrayKey)
        let memoryStHitArrayData = decodeStringArray(from: dmc5Memory3.stHitArrayData)
        saveArray(memoryStHitArrayData, forKey: dmc5.stHitArrayKey)
        
        // ////////////////
        // ver3.5.0で追加
        // ////////////////
        dmc5.dmcBonusCountChance = dmc5Memory3.dmcBonusCountChance
        dmc5.dmcBonusCountBattle = dmc5Memory3.dmcBonusCountBattle
    }
}

#Preview {
    dmc5ViewTop(
        ver340: Ver340(),
        ver350: Ver350(),
    )
}
