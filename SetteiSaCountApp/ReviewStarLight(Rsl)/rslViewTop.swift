//
//  rslViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/24.
//

import SwiftUI

struct rslViewTop: View {
//    @ObservedObject var ver260 = Ver260()
//    @ObservedObject var rsl = Rsl()
    @StateObject var rsl = Rsl()
    @State var isShowAlert: Bool = false
    @StateObject var rslMemory1 = RslMemory1()
    @StateObject var rslMemory2 = RslMemory2()
    @StateObject var rslMemory3 = RslMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 小役停止形
                    NavigationLink(destination: rslViewKoyakuStyle()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "小役停止形"
                        )
                    }
                    // CZ,ボーナス、AT初当り
                    NavigationLink(destination: rslViewFirstHit(rsl: rsl)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "CZ,ボーナス,AT 初当り"
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: rslViewScreen(rsl: rsl)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    // AT終了後ボイス
                    NavigationLink(destination: rslViewVoice(rsl: rsl)) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "AT終了後ボイス"
                        )
                    }
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: "レビュースタァライト")
                }
                // 設定推測グラフ
                NavigationLink(destination: rslView95Ci(rsl: rsl)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4706")
                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver260.rslMachineIconBadgeStatus != "none" {
//                ver260.rslMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(rslSubViewLoadMemory(
                        rsl: rsl,
                        rslMemory1: rslMemory1,
                        rslMemory2: rslMemory2,
                        rslMemory3: rslMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(rslSubViewSaveMemory(
                        rsl: rsl,
                        rslMemory1: rslMemory1,
                        rslMemory2: rslMemory2,
                        rslMemory3: rslMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rsl.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct rslSubViewSaveMemory: View {
    @ObservedObject var rsl: Rsl
    @ObservedObject var rslMemory1: RslMemory1
    @ObservedObject var rslMemory2: RslMemory2
    @ObservedObject var rslMemory3: RslMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "レビュースタァライト",
            selectedMemory: $rsl.selectedMemory,
            memoMemory1: $rslMemory1.memo,
            dateDoubleMemory1: $rslMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $rslMemory2.memo,
            dateDoubleMemory2: $rslMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $rslMemory3.memo,
            dateDoubleMemory3: $rslMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        rslMemory1.totalGame = rsl.totalGame
        rslMemory1.normalGame = rsl.normalGame
        rslMemory1.bigCount = rsl.bigCount
        rslMemory1.regCount = rsl.regCount
        rslMemory1.czCount = rsl.czCount
        rslMemory1.atCount = rsl.atCount
        rslMemory1.regCountChance = rsl.regCountChance
        rslMemory1.regCountKirameki = rsl.regCountKirameki
        rslMemory1.regCountSuika = rsl.regCountSuika
        rslMemory1.regCount3YakuSum = rsl.regCount3YakuSum
        rslMemory1.screenCountDefault = rsl.screenCountDefault
        rslMemory1.screenCountHighJaku = rsl.screenCountHighJaku
        rslMemory1.screenCountHighKyo = rsl.screenCountHighKyo
        rslMemory1.screenCountOver2 = rsl.screenCountOver2
        rslMemory1.screenCountOver4 = rsl.screenCountOver4
        rslMemory1.screenCountOver5 = rsl.screenCountOver5
        rslMemory1.screenCountOver6 = rsl.screenCountOver6
        rslMemory1.screenCountSum = rsl.screenCountSum
        rslMemory1.voiceCountDefault = rsl.voiceCountDefault
        rslMemory1.voiceCountHighJaku = rsl.voiceCountHighJaku
        rslMemory1.voiceCountHighKyo = rsl.voiceCountHighKyo
        rslMemory1.voiceCountOver2 = rsl.voiceCountOver2
        rslMemory1.voiceCountOver4 = rsl.voiceCountOver4
        rslMemory1.voiceCountOver6 = rsl.voiceCountOver6
        rslMemory1.voiceCountSum = rsl.voiceCountSum
    }
    func saveMemory2() {
        rslMemory2.totalGame = rsl.totalGame
        rslMemory2.normalGame = rsl.normalGame
        rslMemory2.bigCount = rsl.bigCount
        rslMemory2.regCount = rsl.regCount
        rslMemory2.czCount = rsl.czCount
        rslMemory2.atCount = rsl.atCount
        rslMemory2.regCountChance = rsl.regCountChance
        rslMemory2.regCountKirameki = rsl.regCountKirameki
        rslMemory2.regCountSuika = rsl.regCountSuika
        rslMemory2.regCount3YakuSum = rsl.regCount3YakuSum
        rslMemory2.screenCountDefault = rsl.screenCountDefault
        rslMemory2.screenCountHighJaku = rsl.screenCountHighJaku
        rslMemory2.screenCountHighKyo = rsl.screenCountHighKyo
        rslMemory2.screenCountOver2 = rsl.screenCountOver2
        rslMemory2.screenCountOver4 = rsl.screenCountOver4
        rslMemory2.screenCountOver5 = rsl.screenCountOver5
        rslMemory2.screenCountOver6 = rsl.screenCountOver6
        rslMemory2.screenCountSum = rsl.screenCountSum
        rslMemory2.voiceCountDefault = rsl.voiceCountDefault
        rslMemory2.voiceCountHighJaku = rsl.voiceCountHighJaku
        rslMemory2.voiceCountHighKyo = rsl.voiceCountHighKyo
        rslMemory2.voiceCountOver2 = rsl.voiceCountOver2
        rslMemory2.voiceCountOver4 = rsl.voiceCountOver4
        rslMemory2.voiceCountOver6 = rsl.voiceCountOver6
        rslMemory2.voiceCountSum = rsl.voiceCountSum
    }
    func saveMemory3() {
        rslMemory3.totalGame = rsl.totalGame
        rslMemory3.normalGame = rsl.normalGame
        rslMemory3.bigCount = rsl.bigCount
        rslMemory3.regCount = rsl.regCount
        rslMemory3.czCount = rsl.czCount
        rslMemory3.atCount = rsl.atCount
        rslMemory3.regCountChance = rsl.regCountChance
        rslMemory3.regCountKirameki = rsl.regCountKirameki
        rslMemory3.regCountSuika = rsl.regCountSuika
        rslMemory3.regCount3YakuSum = rsl.regCount3YakuSum
        rslMemory3.screenCountDefault = rsl.screenCountDefault
        rslMemory3.screenCountHighJaku = rsl.screenCountHighJaku
        rslMemory3.screenCountHighKyo = rsl.screenCountHighKyo
        rslMemory3.screenCountOver2 = rsl.screenCountOver2
        rslMemory3.screenCountOver4 = rsl.screenCountOver4
        rslMemory3.screenCountOver5 = rsl.screenCountOver5
        rslMemory3.screenCountOver6 = rsl.screenCountOver6
        rslMemory3.screenCountSum = rsl.screenCountSum
        rslMemory3.voiceCountDefault = rsl.voiceCountDefault
        rslMemory3.voiceCountHighJaku = rsl.voiceCountHighJaku
        rslMemory3.voiceCountHighKyo = rsl.voiceCountHighKyo
        rslMemory3.voiceCountOver2 = rsl.voiceCountOver2
        rslMemory3.voiceCountOver4 = rsl.voiceCountOver4
        rslMemory3.voiceCountOver6 = rsl.voiceCountOver6
        rslMemory3.voiceCountSum = rsl.voiceCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct rslSubViewLoadMemory: View {
    @ObservedObject var rsl: Rsl
    @ObservedObject var rslMemory1: RslMemory1
    @ObservedObject var rslMemory2: RslMemory2
    @ObservedObject var rslMemory3: RslMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "レビュースタァライト",
            selectedMemory: $rsl.selectedMemory,
            memoMemory1: rslMemory1.memo,
            dateDoubleMemory1: rslMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: rslMemory2.memo,
            dateDoubleMemory2: rslMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: rslMemory3.memo,
            dateDoubleMemory3: rslMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        rsl.totalGame = rslMemory1.totalGame
        rsl.normalGame = rslMemory1.normalGame
        rsl.bigCount = rslMemory1.bigCount
        rsl.regCount = rslMemory1.regCount
        rsl.czCount = rslMemory1.czCount
        rsl.atCount = rslMemory1.atCount
        rsl.regCountChance = rslMemory1.regCountChance
        rsl.regCountKirameki = rslMemory1.regCountKirameki
        rsl.regCountSuika = rslMemory1.regCountSuika
        rsl.regCount3YakuSum = rslMemory1.regCount3YakuSum
        rsl.screenCountDefault = rslMemory1.screenCountDefault
        rsl.screenCountHighJaku = rslMemory1.screenCountHighJaku
        rsl.screenCountHighKyo = rslMemory1.screenCountHighKyo
        rsl.screenCountOver2 = rslMemory1.screenCountOver2
        rsl.screenCountOver4 = rslMemory1.screenCountOver4
        rsl.screenCountOver5 = rslMemory1.screenCountOver5
        rsl.screenCountOver6 = rslMemory1.screenCountOver6
        rsl.screenCountSum = rslMemory1.screenCountSum
        rsl.voiceCountDefault = rslMemory1.voiceCountDefault
        rsl.voiceCountHighJaku = rslMemory1.voiceCountHighJaku
        rsl.voiceCountHighKyo = rslMemory1.voiceCountHighKyo
        rsl.voiceCountOver2 = rslMemory1.voiceCountOver2
        rsl.voiceCountOver4 = rslMemory1.voiceCountOver4
        rsl.voiceCountOver6 = rslMemory1.voiceCountOver6
        rsl.voiceCountSum = rslMemory1.voiceCountSum
    }
    func loadMemory2() {
        rsl.totalGame = rslMemory2.totalGame
        rsl.normalGame = rslMemory2.normalGame
        rsl.bigCount = rslMemory2.bigCount
        rsl.regCount = rslMemory2.regCount
        rsl.czCount = rslMemory2.czCount
        rsl.atCount = rslMemory2.atCount
        rsl.regCountChance = rslMemory2.regCountChance
        rsl.regCountKirameki = rslMemory2.regCountKirameki
        rsl.regCountSuika = rslMemory2.regCountSuika
        rsl.regCount3YakuSum = rslMemory2.regCount3YakuSum
        rsl.screenCountDefault = rslMemory2.screenCountDefault
        rsl.screenCountHighJaku = rslMemory2.screenCountHighJaku
        rsl.screenCountHighKyo = rslMemory2.screenCountHighKyo
        rsl.screenCountOver2 = rslMemory2.screenCountOver2
        rsl.screenCountOver4 = rslMemory2.screenCountOver4
        rsl.screenCountOver5 = rslMemory2.screenCountOver5
        rsl.screenCountOver6 = rslMemory2.screenCountOver6
        rsl.screenCountSum = rslMemory2.screenCountSum
        rsl.voiceCountDefault = rslMemory2.voiceCountDefault
        rsl.voiceCountHighJaku = rslMemory2.voiceCountHighJaku
        rsl.voiceCountHighKyo = rslMemory2.voiceCountHighKyo
        rsl.voiceCountOver2 = rslMemory2.voiceCountOver2
        rsl.voiceCountOver4 = rslMemory2.voiceCountOver4
        rsl.voiceCountOver6 = rslMemory2.voiceCountOver6
        rsl.voiceCountSum = rslMemory2.voiceCountSum
    }
    func loadMemory3() {
        rsl.totalGame = rslMemory3.totalGame
        rsl.normalGame = rslMemory3.normalGame
        rsl.bigCount = rslMemory3.bigCount
        rsl.regCount = rslMemory3.regCount
        rsl.czCount = rslMemory3.czCount
        rsl.atCount = rslMemory3.atCount
        rsl.regCountChance = rslMemory3.regCountChance
        rsl.regCountKirameki = rslMemory3.regCountKirameki
        rsl.regCountSuika = rslMemory3.regCountSuika
        rsl.regCount3YakuSum = rslMemory3.regCount3YakuSum
        rsl.screenCountDefault = rslMemory3.screenCountDefault
        rsl.screenCountHighJaku = rslMemory3.screenCountHighJaku
        rsl.screenCountHighKyo = rslMemory3.screenCountHighKyo
        rsl.screenCountOver2 = rslMemory3.screenCountOver2
        rsl.screenCountOver4 = rslMemory3.screenCountOver4
        rsl.screenCountOver5 = rslMemory3.screenCountOver5
        rsl.screenCountOver6 = rslMemory3.screenCountOver6
        rsl.screenCountSum = rslMemory3.screenCountSum
        rsl.voiceCountDefault = rslMemory3.voiceCountDefault
        rsl.voiceCountHighJaku = rslMemory3.voiceCountHighJaku
        rsl.voiceCountHighKyo = rslMemory3.voiceCountHighKyo
        rsl.voiceCountOver2 = rslMemory3.voiceCountOver2
        rsl.voiceCountOver4 = rslMemory3.voiceCountOver4
        rsl.voiceCountOver6 = rslMemory3.voiceCountOver6
        rsl.voiceCountSum = rslMemory3.voiceCountSum
    }
}


#Preview {
    rslViewTop()
}
