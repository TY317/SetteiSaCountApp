//
//  godzillaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewTop: View {
//    @ObservedObject var ver280 = Ver280()
//    @ObservedObject var godzilla = Godzilla()
    @StateObject var godzilla = Godzilla()
    @State var isShowAlert: Bool = false
    @StateObject var godzillaMemory1 = GodzillaMemory1()
    @StateObject var godzillaMemory2 = GodzillaMemory2()
    @StateObject var godzillaMemory3 = GodzillaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: godzillaViewNormal(godzilla: godzilla)) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 襲来ゾーン
                    NavigationLink(destination: godzillaViewCz(godzilla: godzilla)) {
                        unitLabelMenu(
                            imageSystemName: "lizard.fill",
                            textBody: "襲来ゾーン"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: godzillaViewFirstHit(godzilla: godzilla)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "CZ,AT 初当り"
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: godzillaViewScreen(godzilla: godzilla)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    // EXボーナス中のムービー
                    NavigationLink(destination: godzillaViewExMovie(godzilla: godzilla)) {
                        unitLabelMenu(
                            imageSystemName: "movieclapper.fill",
                            textBody: "EXボーナス中のムービー"
                        )
                    }
                    // トロフィー
                    NavigationLink(destination: commonViewGinchanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ギンちゃんトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ゴジラ")
                }
                
                // 設定推測グラフ
                NavigationLink(destination: godzillaView95Ci(godzilla: godzilla,selection: 5)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4752")
//                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver280.godzillaMachineIconBadgeStatus != "none" {
//                ver280.godzillaMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(godzillaSubViewLoadMemory(
                        godzilla: godzilla,
                        godzillaMemory1: godzillaMemory1,
                        godzillaMemory2: godzillaMemory2,
                        godzillaMemory3: godzillaMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(godzillaSubViewSaveMemory(
                        godzilla: godzilla,
                        godzillaMemory1: godzillaMemory1,
                        godzillaMemory2: godzillaMemory2,
                        godzillaMemory3: godzillaMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct godzillaSubViewSaveMemory: View {
    @ObservedObject var godzilla: Godzilla
    @ObservedObject var godzillaMemory1: GodzillaMemory1
    @ObservedObject var godzillaMemory2: GodzillaMemory2
    @ObservedObject var godzillaMemory3: GodzillaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ゴジラ",
            selectedMemory: $godzilla.selectedMemory,
            memoMemory1: $godzillaMemory1.memo,
            dateDoubleMemory1: $godzillaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $godzillaMemory2.memo,
            dateDoubleMemory2: $godzillaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $godzillaMemory3.memo,
            dateDoubleMemory3: $godzillaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        godzillaMemory1.tansakuCount = godzilla.tansakuCount
        godzillaMemory1.normalGame = godzilla.normalGame
        godzillaMemory1.czCharaCountRadon = godzilla.czCharaCountRadon
        godzillaMemory1.czCharaCountGaigan = godzilla.czCharaCountGaigan
        godzillaMemory1.czCharaCountBiorante = godzilla.czCharaCountBiorante
        godzillaMemory1.czCharaCountDestoroia = godzilla.czCharaCountDestoroia
        godzillaMemory1.czCharaCountKingGidora = godzilla.czCharaCountKingGidora
        godzillaMemory1.czCharaCountSum = godzilla.czCharaCountSum
        godzillaMemory1.czCountShurai = godzilla.czCountShurai
        godzillaMemory1.czCountBreakDown = godzilla.czCountBreakDown
        godzillaMemory1.czCountSum = godzilla.czCountSum
        godzillaMemory1.atCount = godzilla.atCount
        godzillaMemory1.bonusScreenCountDefault = godzilla.bonusScreenCountDefault
        godzillaMemory1.bonusScreenCountKisu = godzilla.bonusScreenCountKisu
        godzillaMemory1.bonusScreenCountGusu = godzilla.bonusScreenCountGusu
        godzillaMemory1.bonusScreenCountKisuHigh = godzilla.bonusScreenCountKisuHigh
        godzillaMemory1.bonusScreenCountGusuHigh = godzilla.bonusScreenCountGusuHigh
        godzillaMemory1.bonusScreenCount4Over = godzilla.bonusScreenCount4Over
        godzillaMemory1.bonusScreenCount5Over = godzilla.bonusScreenCount5Over
        godzillaMemory1.bonusScreenCount6Over = godzilla.bonusScreenCount6Over
        godzillaMemory1.bonusScreenCountSum = godzilla.bonusScreenCountSum
        godzillaMemory1.exMovieCountDefault = godzilla.exMovieCountDefault
        godzillaMemory1.exMovieCountHighJaku = godzilla.exMovieCountHighJaku
        godzillaMemory1.exMovieCountHighChu = godzilla.exMovieCountHighChu
        godzillaMemory1.exMovieCountHighKyo = godzilla.exMovieCountHighKyo
        godzillaMemory1.exMovieCount5Over = godzilla.exMovieCount5Over
        godzillaMemory1.exMovieCountSum = godzilla.exMovieCountSum
    }
    func saveMemory2() {
        godzillaMemory2.tansakuCount = godzilla.tansakuCount
        godzillaMemory2.normalGame = godzilla.normalGame
        godzillaMemory2.czCharaCountRadon = godzilla.czCharaCountRadon
        godzillaMemory2.czCharaCountGaigan = godzilla.czCharaCountGaigan
        godzillaMemory2.czCharaCountBiorante = godzilla.czCharaCountBiorante
        godzillaMemory2.czCharaCountDestoroia = godzilla.czCharaCountDestoroia
        godzillaMemory2.czCharaCountKingGidora = godzilla.czCharaCountKingGidora
        godzillaMemory2.czCharaCountSum = godzilla.czCharaCountSum
        godzillaMemory2.czCountShurai = godzilla.czCountShurai
        godzillaMemory2.czCountBreakDown = godzilla.czCountBreakDown
        godzillaMemory2.czCountSum = godzilla.czCountSum
        godzillaMemory2.atCount = godzilla.atCount
        godzillaMemory2.bonusScreenCountDefault = godzilla.bonusScreenCountDefault
        godzillaMemory2.bonusScreenCountKisu = godzilla.bonusScreenCountKisu
        godzillaMemory2.bonusScreenCountGusu = godzilla.bonusScreenCountGusu
        godzillaMemory2.bonusScreenCountKisuHigh = godzilla.bonusScreenCountKisuHigh
        godzillaMemory2.bonusScreenCountGusuHigh = godzilla.bonusScreenCountGusuHigh
        godzillaMemory2.bonusScreenCount4Over = godzilla.bonusScreenCount4Over
        godzillaMemory2.bonusScreenCount5Over = godzilla.bonusScreenCount5Over
        godzillaMemory2.bonusScreenCount6Over = godzilla.bonusScreenCount6Over
        godzillaMemory2.bonusScreenCountSum = godzilla.bonusScreenCountSum
        godzillaMemory2.exMovieCountDefault = godzilla.exMovieCountDefault
        godzillaMemory2.exMovieCountHighJaku = godzilla.exMovieCountHighJaku
        godzillaMemory2.exMovieCountHighChu = godzilla.exMovieCountHighChu
        godzillaMemory2.exMovieCountHighKyo = godzilla.exMovieCountHighKyo
        godzillaMemory2.exMovieCount5Over = godzilla.exMovieCount5Over
        godzillaMemory2.exMovieCountSum = godzilla.exMovieCountSum
    }
    func saveMemory3() {
        godzillaMemory3.tansakuCount = godzilla.tansakuCount
        godzillaMemory3.normalGame = godzilla.normalGame
        godzillaMemory3.czCharaCountRadon = godzilla.czCharaCountRadon
        godzillaMemory3.czCharaCountGaigan = godzilla.czCharaCountGaigan
        godzillaMemory3.czCharaCountBiorante = godzilla.czCharaCountBiorante
        godzillaMemory3.czCharaCountDestoroia = godzilla.czCharaCountDestoroia
        godzillaMemory3.czCharaCountKingGidora = godzilla.czCharaCountKingGidora
        godzillaMemory3.czCharaCountSum = godzilla.czCharaCountSum
        godzillaMemory3.czCountShurai = godzilla.czCountShurai
        godzillaMemory3.czCountBreakDown = godzilla.czCountBreakDown
        godzillaMemory3.czCountSum = godzilla.czCountSum
        godzillaMemory3.atCount = godzilla.atCount
        godzillaMemory3.bonusScreenCountDefault = godzilla.bonusScreenCountDefault
        godzillaMemory3.bonusScreenCountKisu = godzilla.bonusScreenCountKisu
        godzillaMemory3.bonusScreenCountGusu = godzilla.bonusScreenCountGusu
        godzillaMemory3.bonusScreenCountKisuHigh = godzilla.bonusScreenCountKisuHigh
        godzillaMemory3.bonusScreenCountGusuHigh = godzilla.bonusScreenCountGusuHigh
        godzillaMemory3.bonusScreenCount4Over = godzilla.bonusScreenCount4Over
        godzillaMemory3.bonusScreenCount5Over = godzilla.bonusScreenCount5Over
        godzillaMemory3.bonusScreenCount6Over = godzilla.bonusScreenCount6Over
        godzillaMemory3.bonusScreenCountSum = godzilla.bonusScreenCountSum
        godzillaMemory3.exMovieCountDefault = godzilla.exMovieCountDefault
        godzillaMemory3.exMovieCountHighJaku = godzilla.exMovieCountHighJaku
        godzillaMemory3.exMovieCountHighChu = godzilla.exMovieCountHighChu
        godzillaMemory3.exMovieCountHighKyo = godzilla.exMovieCountHighKyo
        godzillaMemory3.exMovieCount5Over = godzilla.exMovieCount5Over
        godzillaMemory3.exMovieCountSum = godzilla.exMovieCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct godzillaSubViewLoadMemory: View {
    @ObservedObject var godzilla: Godzilla
    @ObservedObject var godzillaMemory1: GodzillaMemory1
    @ObservedObject var godzillaMemory2: GodzillaMemory2
    @ObservedObject var godzillaMemory3: GodzillaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ゴジラ",
            selectedMemory: $godzilla.selectedMemory,
            memoMemory1: godzillaMemory1.memo,
            dateDoubleMemory1: godzillaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: godzillaMemory2.memo,
            dateDoubleMemory2: godzillaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: godzillaMemory3.memo,
            dateDoubleMemory3: godzillaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        godzilla.tansakuCount = godzillaMemory1.tansakuCount
        godzilla.normalGame = godzillaMemory1.normalGame
        godzilla.czCharaCountRadon = godzillaMemory1.czCharaCountRadon
        godzilla.czCharaCountGaigan = godzillaMemory1.czCharaCountGaigan
        godzilla.czCharaCountBiorante = godzillaMemory1.czCharaCountBiorante
        godzilla.czCharaCountDestoroia = godzillaMemory1.czCharaCountDestoroia
        godzilla.czCharaCountKingGidora = godzillaMemory1.czCharaCountKingGidora
        godzilla.czCharaCountSum = godzillaMemory1.czCharaCountSum
        godzilla.czCountShurai = godzillaMemory1.czCountShurai
        godzilla.czCountBreakDown = godzillaMemory1.czCountBreakDown
        godzilla.czCountSum = godzillaMemory1.czCountSum
        godzilla.atCount = godzillaMemory1.atCount
        godzilla.bonusScreenCountDefault = godzillaMemory1.bonusScreenCountDefault
        godzilla.bonusScreenCountKisu = godzillaMemory1.bonusScreenCountKisu
        godzilla.bonusScreenCountGusu = godzillaMemory1.bonusScreenCountGusu
        godzilla.bonusScreenCountKisuHigh = godzillaMemory1.bonusScreenCountKisuHigh
        godzilla.bonusScreenCountGusuHigh = godzillaMemory1.bonusScreenCountGusuHigh
        godzilla.bonusScreenCount4Over = godzillaMemory1.bonusScreenCount4Over
        godzilla.bonusScreenCount5Over = godzillaMemory1.bonusScreenCount5Over
        godzilla.bonusScreenCount6Over = godzillaMemory1.bonusScreenCount6Over
        godzilla.bonusScreenCountSum = godzillaMemory1.bonusScreenCountSum
        godzilla.exMovieCountDefault = godzillaMemory1.exMovieCountDefault
        godzilla.exMovieCountHighJaku = godzillaMemory1.exMovieCountHighJaku
        godzilla.exMovieCountHighChu = godzillaMemory1.exMovieCountHighChu
        godzilla.exMovieCountHighKyo = godzillaMemory1.exMovieCountHighKyo
        godzilla.exMovieCount5Over = godzillaMemory1.exMovieCount5Over
        godzilla.exMovieCountSum = godzillaMemory1.exMovieCountSum
    }
    func loadMemory2() {
        godzilla.tansakuCount = godzillaMemory2.tansakuCount
        godzilla.normalGame = godzillaMemory2.normalGame
        godzilla.czCharaCountRadon = godzillaMemory2.czCharaCountRadon
        godzilla.czCharaCountGaigan = godzillaMemory2.czCharaCountGaigan
        godzilla.czCharaCountBiorante = godzillaMemory2.czCharaCountBiorante
        godzilla.czCharaCountDestoroia = godzillaMemory2.czCharaCountDestoroia
        godzilla.czCharaCountKingGidora = godzillaMemory2.czCharaCountKingGidora
        godzilla.czCharaCountSum = godzillaMemory2.czCharaCountSum
        godzilla.czCountShurai = godzillaMemory2.czCountShurai
        godzilla.czCountBreakDown = godzillaMemory2.czCountBreakDown
        godzilla.czCountSum = godzillaMemory2.czCountSum
        godzilla.atCount = godzillaMemory2.atCount
        godzilla.bonusScreenCountDefault = godzillaMemory2.bonusScreenCountDefault
        godzilla.bonusScreenCountKisu = godzillaMemory2.bonusScreenCountKisu
        godzilla.bonusScreenCountGusu = godzillaMemory2.bonusScreenCountGusu
        godzilla.bonusScreenCountKisuHigh = godzillaMemory2.bonusScreenCountKisuHigh
        godzilla.bonusScreenCountGusuHigh = godzillaMemory2.bonusScreenCountGusuHigh
        godzilla.bonusScreenCount4Over = godzillaMemory2.bonusScreenCount4Over
        godzilla.bonusScreenCount5Over = godzillaMemory2.bonusScreenCount5Over
        godzilla.bonusScreenCount6Over = godzillaMemory2.bonusScreenCount6Over
        godzilla.bonusScreenCountSum = godzillaMemory2.bonusScreenCountSum
        godzilla.exMovieCountDefault = godzillaMemory2.exMovieCountDefault
        godzilla.exMovieCountHighJaku = godzillaMemory2.exMovieCountHighJaku
        godzilla.exMovieCountHighChu = godzillaMemory2.exMovieCountHighChu
        godzilla.exMovieCountHighKyo = godzillaMemory2.exMovieCountHighKyo
        godzilla.exMovieCount5Over = godzillaMemory2.exMovieCount5Over
        godzilla.exMovieCountSum = godzillaMemory2.exMovieCountSum
    }
    func loadMemory3() {
        godzilla.tansakuCount = godzillaMemory3.tansakuCount
        godzilla.normalGame = godzillaMemory3.normalGame
        godzilla.czCharaCountRadon = godzillaMemory3.czCharaCountRadon
        godzilla.czCharaCountGaigan = godzillaMemory3.czCharaCountGaigan
        godzilla.czCharaCountBiorante = godzillaMemory3.czCharaCountBiorante
        godzilla.czCharaCountDestoroia = godzillaMemory3.czCharaCountDestoroia
        godzilla.czCharaCountKingGidora = godzillaMemory3.czCharaCountKingGidora
        godzilla.czCharaCountSum = godzillaMemory3.czCharaCountSum
        godzilla.czCountShurai = godzillaMemory3.czCountShurai
        godzilla.czCountBreakDown = godzillaMemory3.czCountBreakDown
        godzilla.czCountSum = godzillaMemory3.czCountSum
        godzilla.atCount = godzillaMemory3.atCount
        godzilla.bonusScreenCountDefault = godzillaMemory3.bonusScreenCountDefault
        godzilla.bonusScreenCountKisu = godzillaMemory3.bonusScreenCountKisu
        godzilla.bonusScreenCountGusu = godzillaMemory3.bonusScreenCountGusu
        godzilla.bonusScreenCountKisuHigh = godzillaMemory3.bonusScreenCountKisuHigh
        godzilla.bonusScreenCountGusuHigh = godzillaMemory3.bonusScreenCountGusuHigh
        godzilla.bonusScreenCount4Over = godzillaMemory3.bonusScreenCount4Over
        godzilla.bonusScreenCount5Over = godzillaMemory3.bonusScreenCount5Over
        godzilla.bonusScreenCount6Over = godzillaMemory3.bonusScreenCount6Over
        godzilla.bonusScreenCountSum = godzillaMemory3.bonusScreenCountSum
        godzilla.exMovieCountDefault = godzillaMemory3.exMovieCountDefault
        godzilla.exMovieCountHighJaku = godzillaMemory3.exMovieCountHighJaku
        godzilla.exMovieCountHighChu = godzillaMemory3.exMovieCountHighChu
        godzilla.exMovieCountHighKyo = godzillaMemory3.exMovieCountHighKyo
        godzilla.exMovieCount5Over = godzillaMemory3.exMovieCount5Over
        godzilla.exMovieCountSum = godzillaMemory3.exMovieCountSum
    }
}

#Preview {
    godzillaViewTop()
}
