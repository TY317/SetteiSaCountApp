//
//  sevenSwordsViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/13.
//

import SwiftUI

struct sevenSwordsViewTop: View {
//    @ObservedObject var ver270 = Ver270()
//    @ObservedObject var sevenSwords = SevenSwords()
    @StateObject var sevenSwords = SevenSwords()
    @State var isShowAlert: Bool = false
    @StateObject var sevenSwordsMemory1 = SevenSwordsMemory1()
    @StateObject var sevenSwordsMemory2 = SevenSwordsMemory2()
    @StateObject var sevenSwordsMemory3 = SevenSwordsMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "七つの魔剣が支配する")
                }
                
                Section {
                    // ボーナス、ST初当り
                    NavigationLink(destination: sevenSwordsViewBonus(sevenSwords: sevenSwords)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,ST 初当り"
                        )
                    }
                    // キンバリーBONUS
                    NavigationLink(destination: sevenSwordsViewKimbaryChara(sevenSwords: sevenSwords)) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "キンバリーBONUS中のキャラ"
                        )
                    }
                    // プロローグBONUS
                    NavigationLink(destination: sevenSwordsViewPrologeScreen(sevenSwords: sevenSwords)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "プロローグBONUS終了画面"
                        )
                    }
                    // ST終了画面
                    NavigationLink(destination: sevenSwordsViewStScreen(sevenSwords: sevenSwords)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ST終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: sevenSwordsViewEnding(sevenSwords: sevenSwords)) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                    // ボイスカスタムでの示唆
                    NavigationLink(destination: sevenSwordsViewVoiceCustom()) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "ボイスカスタムでの示唆"
//                            badgeStatus: ver270.sevenSwordsMenuVoiceBadgeStatus
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: sevenSwordsView95Ci(sevenSwords: sevenSwords)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4709")
                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver270.sevenSwordsMachineIconBadgeStatus != "none" {
//                ver270.sevenSwordsMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(sevenSwordsSubViewLoadMemory(
                        sevenSwords: sevenSwords,
                        sevenSwordsMemory1: sevenSwordsMemory1,
                        sevenSwordsMemory2: sevenSwordsMemory2,
                        sevenSwordsMemory3: sevenSwordsMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(sevenSwordsSubViewSaveMemory(
                        sevenSwords: sevenSwords,
                        sevenSwordsMemory1: sevenSwordsMemory1,
                        sevenSwordsMemory2: sevenSwordsMemory2,
                        sevenSwordsMemory3: sevenSwordsMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct sevenSwordsSubViewSaveMemory: View {
    @ObservedObject var sevenSwords: SevenSwords
    @ObservedObject var sevenSwordsMemory1: SevenSwordsMemory1
    @ObservedObject var sevenSwordsMemory2: SevenSwordsMemory2
    @ObservedObject var sevenSwordsMemory3: SevenSwordsMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "七つの魔剣が支配する",
            selectedMemory: $sevenSwords.selectedMemory,
            memoMemory1: $sevenSwordsMemory1.memo,
            dateDoubleMemory1: $sevenSwordsMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $sevenSwordsMemory2.memo,
            dateDoubleMemory2: $sevenSwordsMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $sevenSwordsMemory3.memo,
            dateDoubleMemory3: $sevenSwordsMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        sevenSwordsMemory1.g250CountNoHit = sevenSwords.g250CountNoHit
        sevenSwordsMemory1.g250CountHit = sevenSwords.g250CountHit
        sevenSwordsMemory1.g250CountSum = sevenSwords.g250CountSum
        sevenSwordsMemory1.inputNormalGame = sevenSwords.inputNormalGame
        sevenSwordsMemory1.inputBonusCountProloge = sevenSwords.inputBonusCountProloge
        sevenSwordsMemory1.inputBonusCountKimbary = sevenSwords.inputBonusCountKimbary
        sevenSwordsMemory1.inputBonusCountSum = sevenSwords.inputBonusCountSum
        sevenSwordsMemory1.inputStCount = sevenSwords.inputStCount
        sevenSwordsMemory1.kimbaryCharacterCountDefault = sevenSwords.kimbaryCharacterCountDefault
        sevenSwordsMemory1.kimbaryCharacterCountKisu = sevenSwords.kimbaryCharacterCountKisu
        sevenSwordsMemory1.kimbaryCharacterCountGusu = sevenSwords.kimbaryCharacterCountGusu
        sevenSwordsMemory1.kimbaryCharacterCountHigh = sevenSwords.kimbaryCharacterCountHigh
        sevenSwordsMemory1.kimbaryCharacterCountKisuHigh = sevenSwords.kimbaryCharacterCountKisuHigh
        sevenSwordsMemory1.kimbaryCharacterCountGusuHigh = sevenSwords.kimbaryCharacterCountGusuHigh
        sevenSwordsMemory1.kimbaryCharacterCountHighKyo = sevenSwords.kimbaryCharacterCountHighKyo
        sevenSwordsMemory1.kimbaryCharacterCountSum = sevenSwords.kimbaryCharacterCountSum
        sevenSwordsMemory1.bonusScreenCountDefault = sevenSwords.bonusScreenCountDefault
        sevenSwordsMemory1.bonusScreenCountGusu = sevenSwords.bonusScreenCountGusu
        sevenSwordsMemory1.bonusScreenCountOver2 = sevenSwords.bonusScreenCountOver2
        sevenSwordsMemory1.bonusScreenCountOver3 = sevenSwords.bonusScreenCountOver3
        sevenSwordsMemory1.bonusScreenCountOver4 = sevenSwords.bonusScreenCountOver4
        sevenSwordsMemory1.bonusScreenCountOver6 = sevenSwords.bonusScreenCountOver6
        sevenSwordsMemory1.bonusScreenCountSum = sevenSwords.bonusScreenCountSum
        sevenSwordsMemory1.stScreenCountDefault = sevenSwords.stScreenCountDefault
        sevenSwordsMemory1.stScreenCountKisu = sevenSwords.stScreenCountKisu
        sevenSwordsMemory1.stScreenCountGusu = sevenSwords.stScreenCountGusu
        sevenSwordsMemory1.stScreenCountSum = sevenSwords.stScreenCountSum
        sevenSwordsMemory1.voiceCountDefault = sevenSwords.voiceCountDefault
        sevenSwordsMemory1.voiceCountKisu = sevenSwords.voiceCountKisu
        sevenSwordsMemory1.voiceCountGusu = sevenSwords.voiceCountGusu
        sevenSwordsMemory1.voiceCountOver2 = sevenSwords.voiceCountOver2
        sevenSwordsMemory1.voiceCountOver4 = sevenSwords.voiceCountOver4
        sevenSwordsMemory1.voiceCountOver6 = sevenSwords.voiceCountOver6
        sevenSwordsMemory1.voiceCountSum = sevenSwords.voiceCountSum
    }
    func saveMemory2() {
        sevenSwordsMemory2.g250CountNoHit = sevenSwords.g250CountNoHit
        sevenSwordsMemory2.g250CountHit = sevenSwords.g250CountHit
        sevenSwordsMemory2.g250CountSum = sevenSwords.g250CountSum
        sevenSwordsMemory2.inputNormalGame = sevenSwords.inputNormalGame
        sevenSwordsMemory2.inputBonusCountProloge = sevenSwords.inputBonusCountProloge
        sevenSwordsMemory2.inputBonusCountKimbary = sevenSwords.inputBonusCountKimbary
        sevenSwordsMemory2.inputBonusCountSum = sevenSwords.inputBonusCountSum
        sevenSwordsMemory2.inputStCount = sevenSwords.inputStCount
        sevenSwordsMemory2.kimbaryCharacterCountDefault = sevenSwords.kimbaryCharacterCountDefault
        sevenSwordsMemory2.kimbaryCharacterCountKisu = sevenSwords.kimbaryCharacterCountKisu
        sevenSwordsMemory2.kimbaryCharacterCountGusu = sevenSwords.kimbaryCharacterCountGusu
        sevenSwordsMemory2.kimbaryCharacterCountHigh = sevenSwords.kimbaryCharacterCountHigh
        sevenSwordsMemory2.kimbaryCharacterCountKisuHigh = sevenSwords.kimbaryCharacterCountKisuHigh
        sevenSwordsMemory2.kimbaryCharacterCountGusuHigh = sevenSwords.kimbaryCharacterCountGusuHigh
        sevenSwordsMemory2.kimbaryCharacterCountHighKyo = sevenSwords.kimbaryCharacterCountHighKyo
        sevenSwordsMemory2.kimbaryCharacterCountSum = sevenSwords.kimbaryCharacterCountSum
        sevenSwordsMemory2.bonusScreenCountDefault = sevenSwords.bonusScreenCountDefault
        sevenSwordsMemory2.bonusScreenCountGusu = sevenSwords.bonusScreenCountGusu
        sevenSwordsMemory2.bonusScreenCountOver2 = sevenSwords.bonusScreenCountOver2
        sevenSwordsMemory2.bonusScreenCountOver3 = sevenSwords.bonusScreenCountOver3
        sevenSwordsMemory2.bonusScreenCountOver4 = sevenSwords.bonusScreenCountOver4
        sevenSwordsMemory2.bonusScreenCountOver6 = sevenSwords.bonusScreenCountOver6
        sevenSwordsMemory2.bonusScreenCountSum = sevenSwords.bonusScreenCountSum
        sevenSwordsMemory2.stScreenCountDefault = sevenSwords.stScreenCountDefault
        sevenSwordsMemory2.stScreenCountKisu = sevenSwords.stScreenCountKisu
        sevenSwordsMemory2.stScreenCountGusu = sevenSwords.stScreenCountGusu
        sevenSwordsMemory2.stScreenCountSum = sevenSwords.stScreenCountSum
        sevenSwordsMemory2.voiceCountDefault = sevenSwords.voiceCountDefault
        sevenSwordsMemory2.voiceCountKisu = sevenSwords.voiceCountKisu
        sevenSwordsMemory2.voiceCountGusu = sevenSwords.voiceCountGusu
        sevenSwordsMemory2.voiceCountOver2 = sevenSwords.voiceCountOver2
        sevenSwordsMemory2.voiceCountOver4 = sevenSwords.voiceCountOver4
        sevenSwordsMemory2.voiceCountOver6 = sevenSwords.voiceCountOver6
        sevenSwordsMemory2.voiceCountSum = sevenSwords.voiceCountSum
    }
    func saveMemory3() {
        sevenSwordsMemory3.g250CountNoHit = sevenSwords.g250CountNoHit
        sevenSwordsMemory3.g250CountHit = sevenSwords.g250CountHit
        sevenSwordsMemory3.g250CountSum = sevenSwords.g250CountSum
        sevenSwordsMemory3.inputNormalGame = sevenSwords.inputNormalGame
        sevenSwordsMemory3.inputBonusCountProloge = sevenSwords.inputBonusCountProloge
        sevenSwordsMemory3.inputBonusCountKimbary = sevenSwords.inputBonusCountKimbary
        sevenSwordsMemory3.inputBonusCountSum = sevenSwords.inputBonusCountSum
        sevenSwordsMemory3.inputStCount = sevenSwords.inputStCount
        sevenSwordsMemory3.kimbaryCharacterCountDefault = sevenSwords.kimbaryCharacterCountDefault
        sevenSwordsMemory3.kimbaryCharacterCountKisu = sevenSwords.kimbaryCharacterCountKisu
        sevenSwordsMemory3.kimbaryCharacterCountGusu = sevenSwords.kimbaryCharacterCountGusu
        sevenSwordsMemory3.kimbaryCharacterCountHigh = sevenSwords.kimbaryCharacterCountHigh
        sevenSwordsMemory3.kimbaryCharacterCountKisuHigh = sevenSwords.kimbaryCharacterCountKisuHigh
        sevenSwordsMemory3.kimbaryCharacterCountGusuHigh = sevenSwords.kimbaryCharacterCountGusuHigh
        sevenSwordsMemory3.kimbaryCharacterCountHighKyo = sevenSwords.kimbaryCharacterCountHighKyo
        sevenSwordsMemory3.kimbaryCharacterCountSum = sevenSwords.kimbaryCharacterCountSum
        sevenSwordsMemory3.bonusScreenCountDefault = sevenSwords.bonusScreenCountDefault
        sevenSwordsMemory3.bonusScreenCountGusu = sevenSwords.bonusScreenCountGusu
        sevenSwordsMemory3.bonusScreenCountOver2 = sevenSwords.bonusScreenCountOver2
        sevenSwordsMemory3.bonusScreenCountOver3 = sevenSwords.bonusScreenCountOver3
        sevenSwordsMemory3.bonusScreenCountOver4 = sevenSwords.bonusScreenCountOver4
        sevenSwordsMemory3.bonusScreenCountOver6 = sevenSwords.bonusScreenCountOver6
        sevenSwordsMemory3.bonusScreenCountSum = sevenSwords.bonusScreenCountSum
        sevenSwordsMemory3.stScreenCountDefault = sevenSwords.stScreenCountDefault
        sevenSwordsMemory3.stScreenCountKisu = sevenSwords.stScreenCountKisu
        sevenSwordsMemory3.stScreenCountGusu = sevenSwords.stScreenCountGusu
        sevenSwordsMemory3.stScreenCountSum = sevenSwords.stScreenCountSum
        sevenSwordsMemory3.voiceCountDefault = sevenSwords.voiceCountDefault
        sevenSwordsMemory3.voiceCountKisu = sevenSwords.voiceCountKisu
        sevenSwordsMemory3.voiceCountGusu = sevenSwords.voiceCountGusu
        sevenSwordsMemory3.voiceCountOver2 = sevenSwords.voiceCountOver2
        sevenSwordsMemory3.voiceCountOver4 = sevenSwords.voiceCountOver4
        sevenSwordsMemory3.voiceCountOver6 = sevenSwords.voiceCountOver6
        sevenSwordsMemory3.voiceCountSum = sevenSwords.voiceCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct sevenSwordsSubViewLoadMemory: View {
    @ObservedObject var sevenSwords: SevenSwords
    @ObservedObject var sevenSwordsMemory1: SevenSwordsMemory1
    @ObservedObject var sevenSwordsMemory2: SevenSwordsMemory2
    @ObservedObject var sevenSwordsMemory3: SevenSwordsMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "七つの魔剣が支配する",
            selectedMemory: $sevenSwords.selectedMemory,
            memoMemory1: sevenSwordsMemory1.memo,
            dateDoubleMemory1: sevenSwordsMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: sevenSwordsMemory2.memo,
            dateDoubleMemory2: sevenSwordsMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: sevenSwordsMemory3.memo,
            dateDoubleMemory3: sevenSwordsMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        sevenSwords.g250CountNoHit = sevenSwordsMemory1.g250CountNoHit
        sevenSwords.g250CountHit = sevenSwordsMemory1.g250CountHit
        sevenSwords.g250CountSum = sevenSwordsMemory1.g250CountSum
        sevenSwords.inputNormalGame = sevenSwordsMemory1.inputNormalGame
        sevenSwords.inputBonusCountProloge = sevenSwordsMemory1.inputBonusCountProloge
        sevenSwords.inputBonusCountKimbary = sevenSwordsMemory1.inputBonusCountKimbary
        sevenSwords.inputBonusCountSum = sevenSwordsMemory1.inputBonusCountSum
        sevenSwords.inputStCount = sevenSwordsMemory1.inputStCount
        sevenSwords.kimbaryCharacterCountDefault = sevenSwordsMemory1.kimbaryCharacterCountDefault
        sevenSwords.kimbaryCharacterCountKisu = sevenSwordsMemory1.kimbaryCharacterCountKisu
        sevenSwords.kimbaryCharacterCountGusu = sevenSwordsMemory1.kimbaryCharacterCountGusu
        sevenSwords.kimbaryCharacterCountHigh = sevenSwordsMemory1.kimbaryCharacterCountHigh
        sevenSwords.kimbaryCharacterCountKisuHigh = sevenSwordsMemory1.kimbaryCharacterCountKisuHigh
        sevenSwords.kimbaryCharacterCountGusuHigh = sevenSwordsMemory1.kimbaryCharacterCountGusuHigh
        sevenSwords.kimbaryCharacterCountHighKyo = sevenSwordsMemory1.kimbaryCharacterCountHighKyo
        sevenSwords.kimbaryCharacterCountSum = sevenSwordsMemory1.kimbaryCharacterCountSum
        sevenSwords.bonusScreenCountDefault = sevenSwordsMemory1.bonusScreenCountDefault
        sevenSwords.bonusScreenCountGusu = sevenSwordsMemory1.bonusScreenCountGusu
        sevenSwords.bonusScreenCountOver2 = sevenSwordsMemory1.bonusScreenCountOver2
        sevenSwords.bonusScreenCountOver3 = sevenSwordsMemory1.bonusScreenCountOver3
        sevenSwords.bonusScreenCountOver4 = sevenSwordsMemory1.bonusScreenCountOver4
        sevenSwords.bonusScreenCountOver6 = sevenSwordsMemory1.bonusScreenCountOver6
        sevenSwords.bonusScreenCountSum = sevenSwordsMemory1.bonusScreenCountSum
        sevenSwords.stScreenCountDefault = sevenSwordsMemory1.stScreenCountDefault
        sevenSwords.stScreenCountKisu = sevenSwordsMemory1.stScreenCountKisu
        sevenSwords.stScreenCountGusu = sevenSwordsMemory1.stScreenCountGusu
        sevenSwords.stScreenCountSum = sevenSwordsMemory1.stScreenCountSum
        sevenSwords.voiceCountDefault = sevenSwordsMemory1.voiceCountDefault
        sevenSwords.voiceCountKisu = sevenSwordsMemory1.voiceCountKisu
        sevenSwords.voiceCountGusu = sevenSwordsMemory1.voiceCountGusu
        sevenSwords.voiceCountOver2 = sevenSwordsMemory1.voiceCountOver2
        sevenSwords.voiceCountOver4 = sevenSwordsMemory1.voiceCountOver4
        sevenSwords.voiceCountOver6 = sevenSwordsMemory1.voiceCountOver6
        sevenSwords.voiceCountSum = sevenSwordsMemory1.voiceCountSum
    }
    func loadMemory2() {
        sevenSwords.g250CountNoHit = sevenSwordsMemory2.g250CountNoHit
        sevenSwords.g250CountHit = sevenSwordsMemory2.g250CountHit
        sevenSwords.g250CountSum = sevenSwordsMemory2.g250CountSum
        sevenSwords.inputNormalGame = sevenSwordsMemory2.inputNormalGame
        sevenSwords.inputBonusCountProloge = sevenSwordsMemory2.inputBonusCountProloge
        sevenSwords.inputBonusCountKimbary = sevenSwordsMemory2.inputBonusCountKimbary
        sevenSwords.inputBonusCountSum = sevenSwordsMemory2.inputBonusCountSum
        sevenSwords.inputStCount = sevenSwordsMemory2.inputStCount
        sevenSwords.kimbaryCharacterCountDefault = sevenSwordsMemory2.kimbaryCharacterCountDefault
        sevenSwords.kimbaryCharacterCountKisu = sevenSwordsMemory2.kimbaryCharacterCountKisu
        sevenSwords.kimbaryCharacterCountGusu = sevenSwordsMemory2.kimbaryCharacterCountGusu
        sevenSwords.kimbaryCharacterCountHigh = sevenSwordsMemory2.kimbaryCharacterCountHigh
        sevenSwords.kimbaryCharacterCountKisuHigh = sevenSwordsMemory2.kimbaryCharacterCountKisuHigh
        sevenSwords.kimbaryCharacterCountGusuHigh = sevenSwordsMemory2.kimbaryCharacterCountGusuHigh
        sevenSwords.kimbaryCharacterCountHighKyo = sevenSwordsMemory2.kimbaryCharacterCountHighKyo
        sevenSwords.kimbaryCharacterCountSum = sevenSwordsMemory2.kimbaryCharacterCountSum
        sevenSwords.bonusScreenCountDefault = sevenSwordsMemory2.bonusScreenCountDefault
        sevenSwords.bonusScreenCountGusu = sevenSwordsMemory2.bonusScreenCountGusu
        sevenSwords.bonusScreenCountOver2 = sevenSwordsMemory2.bonusScreenCountOver2
        sevenSwords.bonusScreenCountOver3 = sevenSwordsMemory2.bonusScreenCountOver3
        sevenSwords.bonusScreenCountOver4 = sevenSwordsMemory2.bonusScreenCountOver4
        sevenSwords.bonusScreenCountOver6 = sevenSwordsMemory2.bonusScreenCountOver6
        sevenSwords.bonusScreenCountSum = sevenSwordsMemory2.bonusScreenCountSum
        sevenSwords.stScreenCountDefault = sevenSwordsMemory2.stScreenCountDefault
        sevenSwords.stScreenCountKisu = sevenSwordsMemory2.stScreenCountKisu
        sevenSwords.stScreenCountGusu = sevenSwordsMemory2.stScreenCountGusu
        sevenSwords.stScreenCountSum = sevenSwordsMemory2.stScreenCountSum
        sevenSwords.voiceCountDefault = sevenSwordsMemory2.voiceCountDefault
        sevenSwords.voiceCountKisu = sevenSwordsMemory2.voiceCountKisu
        sevenSwords.voiceCountGusu = sevenSwordsMemory2.voiceCountGusu
        sevenSwords.voiceCountOver2 = sevenSwordsMemory2.voiceCountOver2
        sevenSwords.voiceCountOver4 = sevenSwordsMemory2.voiceCountOver4
        sevenSwords.voiceCountOver6 = sevenSwordsMemory2.voiceCountOver6
        sevenSwords.voiceCountSum = sevenSwordsMemory2.voiceCountSum
    }
    func loadMemory3() {
        sevenSwords.g250CountNoHit = sevenSwordsMemory3.g250CountNoHit
        sevenSwords.g250CountHit = sevenSwordsMemory3.g250CountHit
        sevenSwords.g250CountSum = sevenSwordsMemory3.g250CountSum
        sevenSwords.inputNormalGame = sevenSwordsMemory3.inputNormalGame
        sevenSwords.inputBonusCountProloge = sevenSwordsMemory3.inputBonusCountProloge
        sevenSwords.inputBonusCountKimbary = sevenSwordsMemory3.inputBonusCountKimbary
        sevenSwords.inputBonusCountSum = sevenSwordsMemory3.inputBonusCountSum
        sevenSwords.inputStCount = sevenSwordsMemory3.inputStCount
        sevenSwords.kimbaryCharacterCountDefault = sevenSwordsMemory3.kimbaryCharacterCountDefault
        sevenSwords.kimbaryCharacterCountKisu = sevenSwordsMemory3.kimbaryCharacterCountKisu
        sevenSwords.kimbaryCharacterCountGusu = sevenSwordsMemory3.kimbaryCharacterCountGusu
        sevenSwords.kimbaryCharacterCountHigh = sevenSwordsMemory3.kimbaryCharacterCountHigh
        sevenSwords.kimbaryCharacterCountKisuHigh = sevenSwordsMemory3.kimbaryCharacterCountKisuHigh
        sevenSwords.kimbaryCharacterCountGusuHigh = sevenSwordsMemory3.kimbaryCharacterCountGusuHigh
        sevenSwords.kimbaryCharacterCountHighKyo = sevenSwordsMemory3.kimbaryCharacterCountHighKyo
        sevenSwords.kimbaryCharacterCountSum = sevenSwordsMemory3.kimbaryCharacterCountSum
        sevenSwords.bonusScreenCountDefault = sevenSwordsMemory3.bonusScreenCountDefault
        sevenSwords.bonusScreenCountGusu = sevenSwordsMemory3.bonusScreenCountGusu
        sevenSwords.bonusScreenCountOver2 = sevenSwordsMemory3.bonusScreenCountOver2
        sevenSwords.bonusScreenCountOver3 = sevenSwordsMemory3.bonusScreenCountOver3
        sevenSwords.bonusScreenCountOver4 = sevenSwordsMemory3.bonusScreenCountOver4
        sevenSwords.bonusScreenCountOver6 = sevenSwordsMemory3.bonusScreenCountOver6
        sevenSwords.bonusScreenCountSum = sevenSwordsMemory3.bonusScreenCountSum
        sevenSwords.stScreenCountDefault = sevenSwordsMemory3.stScreenCountDefault
        sevenSwords.stScreenCountKisu = sevenSwordsMemory3.stScreenCountKisu
        sevenSwords.stScreenCountGusu = sevenSwordsMemory3.stScreenCountGusu
        sevenSwords.stScreenCountSum = sevenSwordsMemory3.stScreenCountSum
        sevenSwords.voiceCountDefault = sevenSwordsMemory3.voiceCountDefault
        sevenSwords.voiceCountKisu = sevenSwordsMemory3.voiceCountKisu
        sevenSwords.voiceCountGusu = sevenSwordsMemory3.voiceCountGusu
        sevenSwords.voiceCountOver2 = sevenSwordsMemory3.voiceCountOver2
        sevenSwords.voiceCountOver4 = sevenSwordsMemory3.voiceCountOver4
        sevenSwords.voiceCountOver6 = sevenSwordsMemory3.voiceCountOver6
        sevenSwords.voiceCountSum = sevenSwordsMemory3.voiceCountSum
    }
}

#Preview {
    sevenSwordsViewTop()
}
