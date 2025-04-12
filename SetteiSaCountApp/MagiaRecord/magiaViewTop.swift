//
//  magiaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import SwiftUI

struct magiaViewTop: View {
    @ObservedObject var ver270 = Ver270()
    @ObservedObject var ver271 = Ver271()
    @ObservedObject var magia = Magia()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "マギアレコード")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: magiaViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: ver271.magiaMenuNormalBadgeStatus
                        )
                    }
                    // 初当り
                    NavigationLink(destination: magiaViewFirstHit()) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り",
                            badgeStatus: ver271.magiaMenuFirstHitBadgeStatus
                        )
                    }
                    // BIG終了画面
                    NavigationLink(destination: magiaViewBigScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面",
                            badgeStatus: ver271.magiaMenuBonusScreenBadgeStatus
                        )
                    }
                    // ボーナス終了後ボイス
                    NavigationLink(destination: magiaViewVoice()) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "BIG終了後ボイス"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: magiaViewAtScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: ver271.magiaMenuAtScreenBadgeStatus
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: magiaView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4745")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver271.magiaMachineIconBadgeStatus != "none" {
                ver271.magiaMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(magiaSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(magiaSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct magiaSubViewSaveMemory: View {
    @ObservedObject var magia = Magia()
    @ObservedObject var magiaMemory1 = MagiaMemory1()
    @ObservedObject var magiaMemory2 = MagiaMemory2()
    @ObservedObject var magiaMemory3 = MagiaMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "マギアレコード",
            selectedMemory: $magia.selectedMemory,
            memoMemory1: $magiaMemory1.memo,
            dateDoubleMemory1: $magiaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $magiaMemory2.memo,
            dateDoubleMemory2: $magiaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $magiaMemory3.memo,
            dateDoubleMemory3: $magiaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        magiaMemory1.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory1.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory1.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory1.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory1.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory1.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory1.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory1.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory1.normalPlayGame = magia.normalPlayGame
        magiaMemory1.bonusCountBig = magia.bonusCountBig
        magiaMemory1.bonusCountMitama = magia.bonusCountMitama
        magiaMemory1.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory1.bonusCountSum = magia.bonusCountSum
        magiaMemory1.atCount = magia.atCount
        magiaMemory1.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory1.atScreenCount356 = magia.atScreenCount356
        magiaMemory1.atScreenCount246 = magia.atScreenCount246
        magiaMemory1.atScreenCountSum = magia.atScreenCountSum
    }
    func saveMemory2() {
        magiaMemory2.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory2.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory2.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory2.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory2.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory2.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory2.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory2.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory2.normalPlayGame = magia.normalPlayGame
        magiaMemory2.bonusCountBig = magia.bonusCountBig
        magiaMemory2.bonusCountMitama = magia.bonusCountMitama
        magiaMemory2.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory2.bonusCountSum = magia.bonusCountSum
        magiaMemory2.atCount = magia.atCount
        magiaMemory2.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory2.atScreenCount356 = magia.atScreenCount356
        magiaMemory2.atScreenCount246 = magia.atScreenCount246
        magiaMemory2.atScreenCountSum = magia.atScreenCountSum
    }
    func saveMemory3() {
        magiaMemory3.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory3.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory3.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory3.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory3.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory3.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory3.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory3.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory3.normalPlayGame = magia.normalPlayGame
        magiaMemory3.bonusCountBig = magia.bonusCountBig
        magiaMemory3.bonusCountMitama = magia.bonusCountMitama
        magiaMemory3.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory3.bonusCountSum = magia.bonusCountSum
        magiaMemory3.atCount = magia.atCount
        magiaMemory3.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory3.atScreenCount356 = magia.atScreenCount356
        magiaMemory3.atScreenCount246 = magia.atScreenCount246
        magiaMemory3.atScreenCountSum = magia.atScreenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct magiaSubViewLoadMemory: View {
    @ObservedObject var magia = Magia()
    @ObservedObject var magiaMemory1 = MagiaMemory1()
    @ObservedObject var magiaMemory2 = MagiaMemory2()
    @ObservedObject var magiaMemory3 = MagiaMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "マギアレコード",
            selectedMemory: $magia.selectedMemory,
            memoMemory1: magiaMemory1.memo,
            dateDoubleMemory1: magiaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: magiaMemory2.memo,
            dateDoubleMemory2: magiaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: magiaMemory3.memo,
            dateDoubleMemory3: magiaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        magia.suikaCzCountSuika = magiaMemory1.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory1.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory1.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory1.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory1.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory1.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory1.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory1.bigScreenCountSum
        magia.normalPlayGame = magiaMemory1.normalPlayGame
        magia.bonusCountBig = magiaMemory1.bonusCountBig
        magia.bonusCountMitama = magiaMemory1.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory1.bonusCountEpisode
        magia.bonusCountSum = magiaMemory1.bonusCountSum
        magia.atCount = magiaMemory1.atCount
        magia.atScreenCountDefault = magiaMemory1.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory1.atScreenCount356
        magia.atScreenCount246 = magiaMemory1.atScreenCount246
        magia.atScreenCountSum = magiaMemory1.atScreenCountSum
    }
    func loadMemory2() {
        magia.suikaCzCountSuika = magiaMemory2.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory2.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory2.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory2.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory2.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory2.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory2.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory2.bigScreenCountSum
        magia.normalPlayGame = magiaMemory2.normalPlayGame
        magia.bonusCountBig = magiaMemory2.bonusCountBig
        magia.bonusCountMitama = magiaMemory2.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory2.bonusCountEpisode
        magia.bonusCountSum = magiaMemory2.bonusCountSum
        magia.atCount = magiaMemory2.atCount
        magia.atScreenCountDefault = magiaMemory2.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory2.atScreenCount356
        magia.atScreenCount246 = magiaMemory2.atScreenCount246
        magia.atScreenCountSum = magiaMemory2.atScreenCountSum
    }
    func loadMemory3() {
        magia.suikaCzCountSuika = magiaMemory3.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory3.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory3.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory3.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory3.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory3.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory3.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory3.bigScreenCountSum
        magia.normalPlayGame = magiaMemory3.normalPlayGame
        magia.bonusCountBig = magiaMemory3.bonusCountBig
        magia.bonusCountMitama = magiaMemory3.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory3.bonusCountEpisode
        magia.bonusCountSum = magiaMemory3.bonusCountSum
        magia.atCount = magiaMemory3.atCount
        magia.atScreenCountDefault = magiaMemory3.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory3.atScreenCount356
        magia.atScreenCount246 = magiaMemory3.atScreenCount246
        magia.atScreenCountSum = magiaMemory3.atScreenCountSum
    }
}

#Preview {
    magiaViewTop()
}
