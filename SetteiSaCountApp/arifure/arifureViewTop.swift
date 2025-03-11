//
//  arifureViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/02.
//

import SwiftUI

struct arifureViewTop: View {
    @ObservedObject var ver240 = Ver240()
    @ObservedObject var arifure = Arifure()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時、弱レア役からの引き金高確移行率、CZ当選率（100Gでの当選率をカウント）
                    NavigationLink(destination: arifureViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // ボーナス、AT初当り、初当り確率と１００G以内の当選率、ミュウからのAT当選率
                    NavigationLink(destination: arifureViewHistory()) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "ボーナス,AT 初当り")
                    }
                    // ミュウボーナス、キャラ紹介
                    NavigationLink(destination: arifureViewCharacter()) {
                        unitLabelMenu(
                            imageSystemName: "person.3.fill",
                            textBody: "ミュウボーナス中のキャラ紹介"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: arifureViewScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // AT終了後の高確移行率
                    NavigationLink(destination: arifureViewAfterAtKokaku()) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "AT終了後の高確移行"
                        )
                    }
                    // エンディング、レア役時のキャラ
                    NavigationLink(destination: arifureViewEnding()) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ありふれた職業で世界最強", titleFont: .title2)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: arifureView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4715")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver240.arifureMachineIconBadgeStatus != "none" {
                ver240.arifureMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(arifureSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(arifureSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct arifureSubViewSaveMemory: View {
    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifureMemory1 = ArifureMemory1()
    @ObservedObject var arifureMemory2 = ArifureMemory2()
    @ObservedObject var arifureMemory3 = ArifureMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ありふれた職業で世界最強",
            selectedMemory: $arifure.selectedMemory,
            memoMemory1: $arifureMemory1.memo,
            dateDoubleMemory1: $arifureMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $arifureMemory2.memo,
            dateDoubleMemory2: $arifureMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $arifureMemory3.memo,
            dateDoubleMemory3: $arifureMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        arifureMemory1.jakuCherryCount = arifure.jakuCherryCount
        arifureMemory1.jakuCherryKokakuCount = arifure.jakuCherryKokakuCount
        arifureMemory1.jakuChanceCount = arifure.jakuChanceCount
        arifureMemory1.jakuChanceKokakuCount = arifure.jakuChanceKokakuCount
        arifureMemory1.kokakuSuikaCount = arifure.kokakuSuikaCount
        arifureMemory1.kokakuSuikaKokakuCount = arifure.kokakuSuikaKokakuCount
        arifureMemory1.cz100GCountMiss = arifure.cz100GCountMiss
        arifureMemory1.cz100GCountHit = arifure.cz100GCountHit
        arifureMemory1.cz100GCountSum = arifure.cz100GCountSum
        arifureMemory1.inputGame = arifure.inputGame
        arifureMemory1.gameArrayData = arifure.gameArrayData
        arifureMemory1.kindArrayData = arifure.kindArrayData
        arifureMemory1.atHitArrayData = arifure.atHitArrayData
        arifureMemory1.playGameSum = arifure.playGameSum
        arifureMemory1.myuBonusCountAll = arifure.myuBonusCountAll
        arifureMemory1.myuBonusCountAtHit = arifure.myuBonusCountAtHit
        arifureMemory1.atCount = arifure.atCount
        arifureMemory1.hitUnder100gCount = arifure.hitUnder100gCount
        arifureMemory1.hitCountAll = arifure.hitCountAll
        arifureMemory1.charaCountGusu = arifure.charaCountGusu
        arifureMemory1.charaCountKisu = arifure.charaCountKisu
        arifureMemory1.charaCountHighJaku = arifure.charaCountHighJaku
        arifureMemory1.charaCountHighKyo = arifure.charaCountHighKyo
        arifureMemory1.charaCountGusuKyo = arifure.charaCountGusuKyo
        arifureMemory1.charaCountOver2 = arifure.charaCountOver2
        arifureMemory1.charaCountOver2Kyo = arifure.charaCountOver2Kyo
        arifureMemory1.charaCountOver2Gusu = arifure.charaCountOver2Gusu
        arifureMemory1.charaCountAt = arifure.charaCountAt
        arifureMemory1.charaCountOver4 = arifure.charaCountOver4
        arifureMemory1.charaCountOver5 = arifure.charaCountOver5
        arifureMemory1.charaCountOver6 = arifure.charaCountOver6
        arifureMemory1.charaCountSum = arifure.charaCountSum
        arifureMemory1.endScreenCountDefault = arifure.endScreenCountDefault
        arifureMemory1.endScreenCountHigh = arifure.endScreenCountHigh
        arifureMemory1.endScreenCountOver4 = arifure.endScreenCountOver4
        arifureMemory1.endScreenCountOver5 = arifure.endScreenCountOver5
        arifureMemory1.endScreenCountOver6 = arifure.endScreenCountOver6
        arifureMemory1.endScreenCountSum = arifure.endScreenCountSum
        arifureMemory1.afterKokakuCountMiss = arifure.afterKokakuCountMiss
        arifureMemory1.afterKokakuCountHit = arifure.afterKokakuCountHit
        arifureMemory1.afterKokakuCountSum = arifure.afterKokakuCountSum
        arifureMemory1.endingCountKisu = arifure.endingCountKisu
        arifureMemory1.endingCountGusu = arifure.endingCountGusu
        arifureMemory1.endingCountHighJaku = arifure.endingCountHighJaku
        arifureMemory1.endingCountHighKyo = arifure.endingCountHighKyo
        arifureMemory1.endingCountOver4 = arifure.endingCountOver4
        arifureMemory1.endingCountOver5 = arifure.endingCountOver5
        arifureMemory1.endingCountOver6 = arifure.endingCountOver6
        arifureMemory1.endingCountSum = arifure.endingCountSum
    }
    func saveMemory2() {
        arifureMemory2.jakuCherryCount = arifure.jakuCherryCount
        arifureMemory2.jakuCherryKokakuCount = arifure.jakuCherryKokakuCount
        arifureMemory2.jakuChanceCount = arifure.jakuChanceCount
        arifureMemory2.jakuChanceKokakuCount = arifure.jakuChanceKokakuCount
        arifureMemory2.kokakuSuikaCount = arifure.kokakuSuikaCount
        arifureMemory2.kokakuSuikaKokakuCount = arifure.kokakuSuikaKokakuCount
        arifureMemory2.cz100GCountMiss = arifure.cz100GCountMiss
        arifureMemory2.cz100GCountHit = arifure.cz100GCountHit
        arifureMemory2.cz100GCountSum = arifure.cz100GCountSum
        arifureMemory2.inputGame = arifure.inputGame
        arifureMemory2.gameArrayData = arifure.gameArrayData
        arifureMemory2.kindArrayData = arifure.kindArrayData
        arifureMemory2.atHitArrayData = arifure.atHitArrayData
        arifureMemory2.playGameSum = arifure.playGameSum
        arifureMemory2.myuBonusCountAll = arifure.myuBonusCountAll
        arifureMemory2.myuBonusCountAtHit = arifure.myuBonusCountAtHit
        arifureMemory2.atCount = arifure.atCount
        arifureMemory2.hitUnder100gCount = arifure.hitUnder100gCount
        arifureMemory2.hitCountAll = arifure.hitCountAll
        arifureMemory2.charaCountGusu = arifure.charaCountGusu
        arifureMemory2.charaCountKisu = arifure.charaCountKisu
        arifureMemory2.charaCountHighJaku = arifure.charaCountHighJaku
        arifureMemory2.charaCountHighKyo = arifure.charaCountHighKyo
        arifureMemory2.charaCountGusuKyo = arifure.charaCountGusuKyo
        arifureMemory2.charaCountOver2 = arifure.charaCountOver2
        arifureMemory2.charaCountOver2Kyo = arifure.charaCountOver2Kyo
        arifureMemory2.charaCountOver2Gusu = arifure.charaCountOver2Gusu
        arifureMemory2.charaCountAt = arifure.charaCountAt
        arifureMemory2.charaCountOver4 = arifure.charaCountOver4
        arifureMemory2.charaCountOver5 = arifure.charaCountOver5
        arifureMemory2.charaCountOver6 = arifure.charaCountOver6
        arifureMemory2.charaCountSum = arifure.charaCountSum
        arifureMemory2.endScreenCountDefault = arifure.endScreenCountDefault
        arifureMemory2.endScreenCountHigh = arifure.endScreenCountHigh
        arifureMemory2.endScreenCountOver4 = arifure.endScreenCountOver4
        arifureMemory2.endScreenCountOver5 = arifure.endScreenCountOver5
        arifureMemory2.endScreenCountOver6 = arifure.endScreenCountOver6
        arifureMemory2.endScreenCountSum = arifure.endScreenCountSum
        arifureMemory2.afterKokakuCountMiss = arifure.afterKokakuCountMiss
        arifureMemory2.afterKokakuCountHit = arifure.afterKokakuCountHit
        arifureMemory2.afterKokakuCountSum = arifure.afterKokakuCountSum
        arifureMemory2.endingCountKisu = arifure.endingCountKisu
        arifureMemory2.endingCountGusu = arifure.endingCountGusu
        arifureMemory2.endingCountHighJaku = arifure.endingCountHighJaku
        arifureMemory2.endingCountHighKyo = arifure.endingCountHighKyo
        arifureMemory2.endingCountOver4 = arifure.endingCountOver4
        arifureMemory2.endingCountOver5 = arifure.endingCountOver5
        arifureMemory2.endingCountOver6 = arifure.endingCountOver6
        arifureMemory2.endingCountSum = arifure.endingCountSum
    }
    func saveMemory3() {
        arifureMemory3.jakuCherryCount = arifure.jakuCherryCount
        arifureMemory3.jakuCherryKokakuCount = arifure.jakuCherryKokakuCount
        arifureMemory3.jakuChanceCount = arifure.jakuChanceCount
        arifureMemory3.jakuChanceKokakuCount = arifure.jakuChanceKokakuCount
        arifureMemory3.kokakuSuikaCount = arifure.kokakuSuikaCount
        arifureMemory3.kokakuSuikaKokakuCount = arifure.kokakuSuikaKokakuCount
        arifureMemory3.cz100GCountMiss = arifure.cz100GCountMiss
        arifureMemory3.cz100GCountHit = arifure.cz100GCountHit
        arifureMemory3.cz100GCountSum = arifure.cz100GCountSum
        arifureMemory3.inputGame = arifure.inputGame
        arifureMemory3.gameArrayData = arifure.gameArrayData
        arifureMemory3.kindArrayData = arifure.kindArrayData
        arifureMemory3.atHitArrayData = arifure.atHitArrayData
        arifureMemory3.playGameSum = arifure.playGameSum
        arifureMemory3.myuBonusCountAll = arifure.myuBonusCountAll
        arifureMemory3.myuBonusCountAtHit = arifure.myuBonusCountAtHit
        arifureMemory3.atCount = arifure.atCount
        arifureMemory3.hitUnder100gCount = arifure.hitUnder100gCount
        arifureMemory3.hitCountAll = arifure.hitCountAll
        arifureMemory3.charaCountGusu = arifure.charaCountGusu
        arifureMemory3.charaCountKisu = arifure.charaCountKisu
        arifureMemory3.charaCountHighJaku = arifure.charaCountHighJaku
        arifureMemory3.charaCountHighKyo = arifure.charaCountHighKyo
        arifureMemory3.charaCountGusuKyo = arifure.charaCountGusuKyo
        arifureMemory3.charaCountOver2 = arifure.charaCountOver2
        arifureMemory3.charaCountOver2Kyo = arifure.charaCountOver2Kyo
        arifureMemory3.charaCountOver2Gusu = arifure.charaCountOver2Gusu
        arifureMemory3.charaCountAt = arifure.charaCountAt
        arifureMemory3.charaCountOver4 = arifure.charaCountOver4
        arifureMemory3.charaCountOver5 = arifure.charaCountOver5
        arifureMemory3.charaCountOver6 = arifure.charaCountOver6
        arifureMemory3.charaCountSum = arifure.charaCountSum
        arifureMemory3.endScreenCountDefault = arifure.endScreenCountDefault
        arifureMemory3.endScreenCountHigh = arifure.endScreenCountHigh
        arifureMemory3.endScreenCountOver4 = arifure.endScreenCountOver4
        arifureMemory3.endScreenCountOver5 = arifure.endScreenCountOver5
        arifureMemory3.endScreenCountOver6 = arifure.endScreenCountOver6
        arifureMemory3.endScreenCountSum = arifure.endScreenCountSum
        arifureMemory3.afterKokakuCountMiss = arifure.afterKokakuCountMiss
        arifureMemory3.afterKokakuCountHit = arifure.afterKokakuCountHit
        arifureMemory3.afterKokakuCountSum = arifure.afterKokakuCountSum
        arifureMemory3.endingCountKisu = arifure.endingCountKisu
        arifureMemory3.endingCountGusu = arifure.endingCountGusu
        arifureMemory3.endingCountHighJaku = arifure.endingCountHighJaku
        arifureMemory3.endingCountHighKyo = arifure.endingCountHighKyo
        arifureMemory3.endingCountOver4 = arifure.endingCountOver4
        arifureMemory3.endingCountOver5 = arifure.endingCountOver5
        arifureMemory3.endingCountOver6 = arifure.endingCountOver6
        arifureMemory3.endingCountSum = arifure.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct arifureSubViewLoadMemory: View {
    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifureMemory1 = ArifureMemory1()
    @ObservedObject var arifureMemory2 = ArifureMemory2()
    @ObservedObject var arifureMemory3 = ArifureMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ありふれた職業で世界最強",
            selectedMemory: $arifure.selectedMemory,
            memoMemory1: arifureMemory1.memo,
            dateDoubleMemory1: arifureMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: arifureMemory2.memo,
            dateDoubleMemory2: arifureMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: arifureMemory3.memo,
            dateDoubleMemory3: arifureMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        arifure.jakuCherryCount = arifureMemory1.jakuCherryCount
        arifure.jakuCherryKokakuCount = arifureMemory1.jakuCherryKokakuCount
        arifure.jakuChanceCount = arifureMemory1.jakuChanceCount
        arifure.jakuChanceKokakuCount = arifureMemory1.jakuChanceKokakuCount
        arifure.kokakuSuikaCount = arifureMemory1.kokakuSuikaCount
        arifure.kokakuSuikaKokakuCount = arifureMemory1.kokakuSuikaKokakuCount
        arifure.cz100GCountMiss = arifureMemory1.cz100GCountMiss
        arifure.cz100GCountHit = arifureMemory1.cz100GCountHit
        arifure.cz100GCountSum = arifureMemory1.cz100GCountSum
        arifure.inputGame = arifureMemory1.inputGame
        arifure.gameArrayData = arifureMemory1.gameArrayData
        arifure.kindArrayData = arifureMemory1.kindArrayData
        arifure.atHitArrayData = arifureMemory1.atHitArrayData
        arifure.playGameSum = arifureMemory1.playGameSum
        arifure.myuBonusCountAll = arifureMemory1.myuBonusCountAll
        arifure.myuBonusCountAtHit = arifureMemory1.myuBonusCountAtHit
        arifure.atCount = arifureMemory1.atCount
        arifure.hitUnder100gCount = arifureMemory1.hitUnder100gCount
        arifure.hitCountAll = arifureMemory1.hitCountAll
        arifure.charaCountGusu = arifureMemory1.charaCountGusu
        arifure.charaCountKisu = arifureMemory1.charaCountKisu
        arifure.charaCountHighJaku = arifureMemory1.charaCountHighJaku
        arifure.charaCountHighKyo = arifureMemory1.charaCountHighKyo
        arifure.charaCountGusuKyo = arifureMemory1.charaCountGusuKyo
        arifure.charaCountOver2 = arifureMemory1.charaCountOver2
        arifure.charaCountOver2Kyo = arifureMemory1.charaCountOver2Kyo
        arifure.charaCountOver2Gusu = arifureMemory1.charaCountOver2Gusu
        arifure.charaCountAt = arifureMemory1.charaCountAt
        arifure.charaCountOver4 = arifureMemory1.charaCountOver4
        arifure.charaCountOver5 = arifureMemory1.charaCountOver5
        arifure.charaCountOver6 = arifureMemory1.charaCountOver6
        arifure.charaCountSum = arifureMemory1.charaCountSum
        arifure.endScreenCountDefault = arifureMemory1.endScreenCountDefault
        arifure.endScreenCountHigh = arifureMemory1.endScreenCountHigh
        arifure.endScreenCountOver4 = arifureMemory1.endScreenCountOver4
        arifure.endScreenCountOver5 = arifureMemory1.endScreenCountOver5
        arifure.endScreenCountOver6 = arifureMemory1.endScreenCountOver6
        arifure.endScreenCountSum = arifureMemory1.endScreenCountSum
        arifure.afterKokakuCountMiss = arifureMemory1.afterKokakuCountMiss
        arifure.afterKokakuCountHit = arifureMemory1.afterKokakuCountHit
        arifure.afterKokakuCountSum = arifureMemory1.afterKokakuCountSum
        arifure.endingCountKisu = arifureMemory1.endingCountKisu
        arifure.endingCountGusu = arifureMemory1.endingCountGusu
        arifure.endingCountHighJaku = arifureMemory1.endingCountHighJaku
        arifure.endingCountHighKyo = arifureMemory1.endingCountHighKyo
        arifure.endingCountOver4 = arifureMemory1.endingCountOver4
        arifure.endingCountOver5 = arifureMemory1.endingCountOver5
        arifure.endingCountOver6 = arifureMemory1.endingCountOver6
        arifure.endingCountSum = arifureMemory1.endingCountSum
    }
    func loadMemory2() {
        arifure.jakuCherryCount = arifureMemory2.jakuCherryCount
        arifure.jakuCherryKokakuCount = arifureMemory2.jakuCherryKokakuCount
        arifure.jakuChanceCount = arifureMemory2.jakuChanceCount
        arifure.jakuChanceKokakuCount = arifureMemory2.jakuChanceKokakuCount
        arifure.kokakuSuikaCount = arifureMemory2.kokakuSuikaCount
        arifure.kokakuSuikaKokakuCount = arifureMemory2.kokakuSuikaKokakuCount
        arifure.cz100GCountMiss = arifureMemory2.cz100GCountMiss
        arifure.cz100GCountHit = arifureMemory2.cz100GCountHit
        arifure.cz100GCountSum = arifureMemory2.cz100GCountSum
        arifure.inputGame = arifureMemory2.inputGame
        arifure.gameArrayData = arifureMemory2.gameArrayData
        arifure.kindArrayData = arifureMemory2.kindArrayData
        arifure.atHitArrayData = arifureMemory2.atHitArrayData
        arifure.playGameSum = arifureMemory2.playGameSum
        arifure.myuBonusCountAll = arifureMemory2.myuBonusCountAll
        arifure.myuBonusCountAtHit = arifureMemory2.myuBonusCountAtHit
        arifure.atCount = arifureMemory2.atCount
        arifure.hitUnder100gCount = arifureMemory2.hitUnder100gCount
        arifure.hitCountAll = arifureMemory2.hitCountAll
        arifure.charaCountGusu = arifureMemory2.charaCountGusu
        arifure.charaCountKisu = arifureMemory2.charaCountKisu
        arifure.charaCountHighJaku = arifureMemory2.charaCountHighJaku
        arifure.charaCountHighKyo = arifureMemory2.charaCountHighKyo
        arifure.charaCountGusuKyo = arifureMemory2.charaCountGusuKyo
        arifure.charaCountOver2 = arifureMemory2.charaCountOver2
        arifure.charaCountOver2Kyo = arifureMemory2.charaCountOver2Kyo
        arifure.charaCountOver2Gusu = arifureMemory2.charaCountOver2Gusu
        arifure.charaCountAt = arifureMemory2.charaCountAt
        arifure.charaCountOver4 = arifureMemory2.charaCountOver4
        arifure.charaCountOver5 = arifureMemory2.charaCountOver5
        arifure.charaCountOver6 = arifureMemory2.charaCountOver6
        arifure.charaCountSum = arifureMemory2.charaCountSum
        arifure.endScreenCountDefault = arifureMemory2.endScreenCountDefault
        arifure.endScreenCountHigh = arifureMemory2.endScreenCountHigh
        arifure.endScreenCountOver4 = arifureMemory2.endScreenCountOver4
        arifure.endScreenCountOver5 = arifureMemory2.endScreenCountOver5
        arifure.endScreenCountOver6 = arifureMemory2.endScreenCountOver6
        arifure.endScreenCountSum = arifureMemory2.endScreenCountSum
        arifure.afterKokakuCountMiss = arifureMemory2.afterKokakuCountMiss
        arifure.afterKokakuCountHit = arifureMemory2.afterKokakuCountHit
        arifure.afterKokakuCountSum = arifureMemory2.afterKokakuCountSum
        arifure.endingCountKisu = arifureMemory2.endingCountKisu
        arifure.endingCountGusu = arifureMemory2.endingCountGusu
        arifure.endingCountHighJaku = arifureMemory2.endingCountHighJaku
        arifure.endingCountHighKyo = arifureMemory2.endingCountHighKyo
        arifure.endingCountOver4 = arifureMemory2.endingCountOver4
        arifure.endingCountOver5 = arifureMemory2.endingCountOver5
        arifure.endingCountOver6 = arifureMemory2.endingCountOver6
        arifure.endingCountSum = arifureMemory2.endingCountSum
    }
    func loadMemory3() {
        arifure.jakuCherryCount = arifureMemory3.jakuCherryCount
        arifure.jakuCherryKokakuCount = arifureMemory3.jakuCherryKokakuCount
        arifure.jakuChanceCount = arifureMemory3.jakuChanceCount
        arifure.jakuChanceKokakuCount = arifureMemory3.jakuChanceKokakuCount
        arifure.kokakuSuikaCount = arifureMemory3.kokakuSuikaCount
        arifure.kokakuSuikaKokakuCount = arifureMemory3.kokakuSuikaKokakuCount
        arifure.cz100GCountMiss = arifureMemory3.cz100GCountMiss
        arifure.cz100GCountHit = arifureMemory3.cz100GCountHit
        arifure.cz100GCountSum = arifureMemory3.cz100GCountSum
        arifure.inputGame = arifureMemory3.inputGame
        arifure.gameArrayData = arifureMemory3.gameArrayData
        arifure.kindArrayData = arifureMemory3.kindArrayData
        arifure.atHitArrayData = arifureMemory3.atHitArrayData
        arifure.playGameSum = arifureMemory3.playGameSum
        arifure.myuBonusCountAll = arifureMemory3.myuBonusCountAll
        arifure.myuBonusCountAtHit = arifureMemory3.myuBonusCountAtHit
        arifure.atCount = arifureMemory3.atCount
        arifure.hitUnder100gCount = arifureMemory3.hitUnder100gCount
        arifure.hitCountAll = arifureMemory3.hitCountAll
        arifure.charaCountGusu = arifureMemory3.charaCountGusu
        arifure.charaCountKisu = arifureMemory3.charaCountKisu
        arifure.charaCountHighJaku = arifureMemory3.charaCountHighJaku
        arifure.charaCountHighKyo = arifureMemory3.charaCountHighKyo
        arifure.charaCountGusuKyo = arifureMemory3.charaCountGusuKyo
        arifure.charaCountOver2 = arifureMemory3.charaCountOver2
        arifure.charaCountOver2Kyo = arifureMemory3.charaCountOver2Kyo
        arifure.charaCountOver2Gusu = arifureMemory3.charaCountOver2Gusu
        arifure.charaCountAt = arifureMemory3.charaCountAt
        arifure.charaCountOver4 = arifureMemory3.charaCountOver4
        arifure.charaCountOver5 = arifureMemory3.charaCountOver5
        arifure.charaCountOver6 = arifureMemory3.charaCountOver6
        arifure.charaCountSum = arifureMemory3.charaCountSum
        arifure.endScreenCountDefault = arifureMemory3.endScreenCountDefault
        arifure.endScreenCountHigh = arifureMemory3.endScreenCountHigh
        arifure.endScreenCountOver4 = arifureMemory3.endScreenCountOver4
        arifure.endScreenCountOver5 = arifureMemory3.endScreenCountOver5
        arifure.endScreenCountOver6 = arifureMemory3.endScreenCountOver6
        arifure.endScreenCountSum = arifureMemory3.endScreenCountSum
        arifure.afterKokakuCountMiss = arifureMemory3.afterKokakuCountMiss
        arifure.afterKokakuCountHit = arifureMemory3.afterKokakuCountHit
        arifure.afterKokakuCountSum = arifureMemory3.afterKokakuCountSum
        arifure.endingCountKisu = arifureMemory3.endingCountKisu
        arifure.endingCountGusu = arifureMemory3.endingCountGusu
        arifure.endingCountHighJaku = arifureMemory3.endingCountHighJaku
        arifure.endingCountHighKyo = arifureMemory3.endingCountHighKyo
        arifure.endingCountOver4 = arifureMemory3.endingCountOver4
        arifure.endingCountOver5 = arifureMemory3.endingCountOver5
        arifure.endingCountOver6 = arifureMemory3.endingCountOver6
        arifure.endingCountSum = arifureMemory3.endingCountSum
    }
}

#Preview {
    arifureViewTop()
}
