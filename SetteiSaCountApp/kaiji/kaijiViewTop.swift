//
//  kaijiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/11.
//

import SwiftUI

struct kaijiViewTop: View {
//    @ObservedObject var ver300: Ver300
//    @ObservedObject var ver271 = Ver271()
//    @ObservedObject var kaiji = Kaiji()
    @StateObject var kaiji = Kaiji()
    @State var isShowAlert: Bool = false
    @StateObject var kaijiMemory1 = KaijiMemory1()
    @StateObject var kaijiMemory2 = KaijiMemory2()
    @StateObject var kaijiMemory3 = KaijiMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "回胴黙示録カイジ 狂宴")
                }
                
                Section {
                    // 通常時モード
                    NavigationLink(destination: kaijiViewMode(
//                        ver300: ver300
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "モード推測"
//                            badgeStatus: ver300.kaijiMenuModeBadgeStatus
                        )
                    }
                    // 小役
                    NavigationLink(destination: kaijiViewKoyaku(kaiji: kaiji)) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "小役"
//                            badgeStatus: ver271.kaijiMenuKoyakuBadgeStatus
                        )
                    }
                    // ざわ高確
                    NavigationLink(destination: kaijiViewZawaKokaku(kaiji: kaiji)) {
                        unitLabelMenu(
                            imageSystemName: "bubble.left.and.exclamationmark.bubble.right.fill",
                            textBody: "ざわ高確"
                        )
                    }
                    // 閃き前兆
                    NavigationLink(destination: kaijiViewHirameki(kaiji: kaiji)) {
                        unitLabelMenu(
                            imageSystemName: "lightbulb.max",
                            textBody: "閃き前兆"
//                            badgeStatus: ver260.kaijiMenuHiramekiBadgeStatus
                        )
                    }
                    // CZ,AT初当り
                    NavigationLink(destination: kaijiViewFirstHit(kaiji: kaiji)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "CZ,ボーナス 初当り"
//                            badgeStatus: ver280.kaijiMenuFirstHitBadgeStatus
                        )
                    }
                    // 赤7BIG中のBAR揃い
                    NavigationLink(destination: kaijiViewRedBig()) {
                        unitLabelMenu(
                            imageSystemName: "7.circle.fill",
                            textBody: "赤7BIG中のBAR揃い"
//                            badgeStatus: ver270.kaijiMenuRedBigBadgeStatus
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: kaijiViewScreen(kaiji: kaiji)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
//                            badgeStatus: ver260.kaijiMenuScreenBadgeStatus
                        )
                    }
                    // トネガワラッシュ中の画面示唆
                    NavigationLink(
                        destination: kaijiViewTonegawaRush(
//                            ver300: ver300,
                            kaiji: kaiji
                        )
                    ) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "トネガワラッシュ中の画面示唆"
//                            badgeStatus: ver300.kaijiMenuTonegawaRushBadgeStatus
                        )
                    }
                    // ハンチョウラッシュ中の画面示唆
                    NavigationLink(
                        destination: kaijiViewHanchoRush(
//                            ver300: ver300,
                            kaiji: kaiji
                        )
                    ) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ハンチョウラッシュ中の画面示唆"
//                            badgeStatus: ver300.kaijiMenuHanchoRushBadgeStatus
                        )
                    }
                    // エンディング
                    NavigationLink(destination: kaijiViewEnding(
//                        ver300: ver300,
                        kaiji: kaiji
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
//                            badgeStatus: ver300.kaijiMenuVoiceBadgeStatus
                        )
                    }
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                } header: {
//                    unitLabelMachineTopTitle(machineName: "回胴黙示録カイジ 狂宴")
                }
                // 設定推測グラフ
                NavigationLink(destination: kaijiView95Ci(kaiji: kaiji, selection: 4)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4734")
//                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver300.kaijiMachineIconBadgeStatus != "none" {
//                ver300.kaijiMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(kaijiSubViewLoadMemory(
                        kaiji: kaiji,
                        kaijiMemory1: kaijiMemory1,
                        kaijiMemory2: kaijiMemory2,
                        kaijiMemory3: kaijiMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(kaijiSubViewSaveMemory(
                        kaiji: kaiji,
                        kaijiMemory1: kaijiMemory1,
                        kaijiMemory2: kaijiMemory2,
                        kaijiMemory3: kaijiMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kaijiSubViewSaveMemory: View {
    @ObservedObject var kaiji: Kaiji
    @ObservedObject var kaijiMemory1: KaijiMemory1
    @ObservedObject var kaijiMemory2: KaijiMemory2
    @ObservedObject var kaijiMemory3: KaijiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "回胴黙示録カイジ 狂宴",
            selectedMemory: $kaiji.selectedMemory,
            memoMemory1: $kaijiMemory1.memo,
            dateDoubleMemory1: $kaijiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kaijiMemory2.memo,
            dateDoubleMemory2: $kaijiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kaijiMemory3.memo,
            dateDoubleMemory3: $kaijiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kaijiMemory1.zawaKokakuCountJakuRare = kaiji.zawaKokakuCountJakuRare
        kaijiMemory1.zawaKokakuCountMove = kaiji.zawaKokakuCountMove
        kaijiMemory1.hiramekiCountBlueMiss = kaiji.hiramekiCountBlueMiss
        kaijiMemory1.hiramekiCountBlueSuccess = kaiji.hiramekiCountBlueSuccess
        kaijiMemory1.hiramekiCountBlueSum = kaiji.hiramekiCountBlueSum
        kaijiMemory1.hiramekiCountYellowMiss = kaiji.hiramekiCountYellowMiss
        kaijiMemory1.hiramekiCountYellowSuccess = kaiji.hiramekiCountYellowSuccess
        kaijiMemory1.hiramekiCountYellowSum = kaiji.hiramekiCountYellowSum
        kaijiMemory1.hiramekiCountGreenMiss = kaiji.hiramekiCountGreenMiss
        kaijiMemory1.hiramekiCountGreenSuccess = kaiji.hiramekiCountGreenSuccess
        kaijiMemory1.hiramekiCountGreenSum = kaiji.hiramekiCountGreenSum
        kaijiMemory1.hiramekiCountRedMiss = kaiji.hiramekiCountRedMiss
        kaijiMemory1.hiramekiCountRedSuccess = kaiji.hiramekiCountRedSuccess
        kaijiMemory1.hiramekiCountRedSum = kaiji.hiramekiCountRedSum
        kaijiMemory1.playNormalGame = kaiji.playNormalGame
        kaijiMemory1.czCount = kaiji.czCount
        kaijiMemory1.atCount = kaiji.atCount
        kaijiMemory1.screenCountDefault = kaiji.screenCountDefault
        kaijiMemory1.screenCountGusu = kaiji.screenCountGusu
        kaijiMemory1.screenCountShower = kaiji.screenCountShower
        kaijiMemory1.screenCountOver2 = kaiji.screenCountOver2
        kaijiMemory1.screenCountTonegawa = kaiji.screenCountTonegawa
        kaijiMemory1.screenCountHancho = kaiji.screenCountHancho
        kaijiMemory1.screenCountMikoko = kaiji.screenCountMikoko
        kaijiMemory1.screenCountBunny = kaiji.screenCountBunny
        kaijiMemory1.screenCountSenyo = kaiji.screenCountSenyo
        kaijiMemory1.screenCountSum = kaiji.screenCountSum
        kaijiMemory1.endingCountKisu = kaiji.endingCountKisu
        kaijiMemory1.endingCountGusu = kaiji.endingCountGusu
        kaijiMemory1.endingCountMaryoku = kaiji.endingCountMaryoku
        kaijiMemory1.endingCountOver4 = kaiji.endingCountOver4
        kaijiMemory1.endingCountTeiai = kaiji.endingCountTeiai
        kaijiMemory1.endingCountSum = kaiji.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaijiMemory1.totalGame = kaiji.totalGame
        kaijiMemory1.koyakuCountSuika = kaiji.koyakuCountSuika
        kaijiMemory1.koyakuCountJakuCherry = kaiji.koyakuCountJakuCherry
        kaijiMemory1.koyakuCountJakuChance = kaiji.koyakuCountJakuChance
        kaijiMemory1.koyakuCountKyoCherry = kaiji.koyakuCountKyoCherry
        kaijiMemory1.koyakuCountSum = kaiji.koyakuCountSum
    }
    func saveMemory2() {
        kaijiMemory2.zawaKokakuCountJakuRare = kaiji.zawaKokakuCountJakuRare
        kaijiMemory2.zawaKokakuCountMove = kaiji.zawaKokakuCountMove
        kaijiMemory2.hiramekiCountBlueMiss = kaiji.hiramekiCountBlueMiss
        kaijiMemory2.hiramekiCountBlueSuccess = kaiji.hiramekiCountBlueSuccess
        kaijiMemory2.hiramekiCountBlueSum = kaiji.hiramekiCountBlueSum
        kaijiMemory2.hiramekiCountYellowMiss = kaiji.hiramekiCountYellowMiss
        kaijiMemory2.hiramekiCountYellowSuccess = kaiji.hiramekiCountYellowSuccess
        kaijiMemory2.hiramekiCountYellowSum = kaiji.hiramekiCountYellowSum
        kaijiMemory2.hiramekiCountGreenMiss = kaiji.hiramekiCountGreenMiss
        kaijiMemory2.hiramekiCountGreenSuccess = kaiji.hiramekiCountGreenSuccess
        kaijiMemory2.hiramekiCountGreenSum = kaiji.hiramekiCountGreenSum
        kaijiMemory2.hiramekiCountRedMiss = kaiji.hiramekiCountRedMiss
        kaijiMemory2.hiramekiCountRedSuccess = kaiji.hiramekiCountRedSuccess
        kaijiMemory2.hiramekiCountRedSum = kaiji.hiramekiCountRedSum
        kaijiMemory2.playNormalGame = kaiji.playNormalGame
        kaijiMemory2.czCount = kaiji.czCount
        kaijiMemory2.atCount = kaiji.atCount
        kaijiMemory2.screenCountDefault = kaiji.screenCountDefault
        kaijiMemory2.screenCountGusu = kaiji.screenCountGusu
        kaijiMemory2.screenCountShower = kaiji.screenCountShower
        kaijiMemory2.screenCountOver2 = kaiji.screenCountOver2
        kaijiMemory2.screenCountTonegawa = kaiji.screenCountTonegawa
        kaijiMemory2.screenCountHancho = kaiji.screenCountHancho
        kaijiMemory2.screenCountMikoko = kaiji.screenCountMikoko
        kaijiMemory2.screenCountBunny = kaiji.screenCountBunny
        kaijiMemory2.screenCountSenyo = kaiji.screenCountSenyo
        kaijiMemory2.screenCountSum = kaiji.screenCountSum
        kaijiMemory2.endingCountKisu = kaiji.endingCountKisu
        kaijiMemory2.endingCountGusu = kaiji.endingCountGusu
        kaijiMemory2.endingCountMaryoku = kaiji.endingCountMaryoku
        kaijiMemory2.endingCountOver4 = kaiji.endingCountOver4
        kaijiMemory2.endingCountTeiai = kaiji.endingCountTeiai
        kaijiMemory2.endingCountSum = kaiji.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaijiMemory2.totalGame = kaiji.totalGame
        kaijiMemory2.koyakuCountSuika = kaiji.koyakuCountSuika
        kaijiMemory2.koyakuCountJakuCherry = kaiji.koyakuCountJakuCherry
        kaijiMemory2.koyakuCountJakuChance = kaiji.koyakuCountJakuChance
        kaijiMemory2.koyakuCountKyoCherry = kaiji.koyakuCountKyoCherry
        kaijiMemory2.koyakuCountSum = kaiji.koyakuCountSum
    }
    func saveMemory3() {
        kaijiMemory3.zawaKokakuCountJakuRare = kaiji.zawaKokakuCountJakuRare
        kaijiMemory3.zawaKokakuCountMove = kaiji.zawaKokakuCountMove
        kaijiMemory3.hiramekiCountBlueMiss = kaiji.hiramekiCountBlueMiss
        kaijiMemory3.hiramekiCountBlueSuccess = kaiji.hiramekiCountBlueSuccess
        kaijiMemory3.hiramekiCountBlueSum = kaiji.hiramekiCountBlueSum
        kaijiMemory3.hiramekiCountYellowMiss = kaiji.hiramekiCountYellowMiss
        kaijiMemory3.hiramekiCountYellowSuccess = kaiji.hiramekiCountYellowSuccess
        kaijiMemory3.hiramekiCountYellowSum = kaiji.hiramekiCountYellowSum
        kaijiMemory3.hiramekiCountGreenMiss = kaiji.hiramekiCountGreenMiss
        kaijiMemory3.hiramekiCountGreenSuccess = kaiji.hiramekiCountGreenSuccess
        kaijiMemory3.hiramekiCountGreenSum = kaiji.hiramekiCountGreenSum
        kaijiMemory3.hiramekiCountRedMiss = kaiji.hiramekiCountRedMiss
        kaijiMemory3.hiramekiCountRedSuccess = kaiji.hiramekiCountRedSuccess
        kaijiMemory3.hiramekiCountRedSum = kaiji.hiramekiCountRedSum
        kaijiMemory3.playNormalGame = kaiji.playNormalGame
        kaijiMemory3.czCount = kaiji.czCount
        kaijiMemory3.atCount = kaiji.atCount
        kaijiMemory3.screenCountDefault = kaiji.screenCountDefault
        kaijiMemory3.screenCountGusu = kaiji.screenCountGusu
        kaijiMemory3.screenCountShower = kaiji.screenCountShower
        kaijiMemory3.screenCountOver2 = kaiji.screenCountOver2
        kaijiMemory3.screenCountTonegawa = kaiji.screenCountTonegawa
        kaijiMemory3.screenCountHancho = kaiji.screenCountHancho
        kaijiMemory3.screenCountMikoko = kaiji.screenCountMikoko
        kaijiMemory3.screenCountBunny = kaiji.screenCountBunny
        kaijiMemory3.screenCountSenyo = kaiji.screenCountSenyo
        kaijiMemory3.screenCountSum = kaiji.screenCountSum
        kaijiMemory3.endingCountKisu = kaiji.endingCountKisu
        kaijiMemory3.endingCountGusu = kaiji.endingCountGusu
        kaijiMemory3.endingCountMaryoku = kaiji.endingCountMaryoku
        kaijiMemory3.endingCountOver4 = kaiji.endingCountOver4
        kaijiMemory3.endingCountTeiai = kaiji.endingCountTeiai
        kaijiMemory3.endingCountSum = kaiji.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaijiMemory3.totalGame = kaiji.totalGame
        kaijiMemory3.koyakuCountSuika = kaiji.koyakuCountSuika
        kaijiMemory3.koyakuCountJakuCherry = kaiji.koyakuCountJakuCherry
        kaijiMemory3.koyakuCountJakuChance = kaiji.koyakuCountJakuChance
        kaijiMemory3.koyakuCountKyoCherry = kaiji.koyakuCountKyoCherry
        kaijiMemory3.koyakuCountSum = kaiji.koyakuCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct kaijiSubViewLoadMemory: View {
    @ObservedObject var kaiji: Kaiji
    @ObservedObject var kaijiMemory1: KaijiMemory1
    @ObservedObject var kaijiMemory2: KaijiMemory2
    @ObservedObject var kaijiMemory3: KaijiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "回胴黙示録カイジ 狂宴",
            selectedMemory: $kaiji.selectedMemory,
            memoMemory1: kaijiMemory1.memo,
            dateDoubleMemory1: kaijiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kaijiMemory2.memo,
            dateDoubleMemory2: kaijiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kaijiMemory3.memo,
            dateDoubleMemory3: kaijiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        kaiji.zawaKokakuCountJakuRare = kaijiMemory1.zawaKokakuCountJakuRare
        kaiji.zawaKokakuCountMove = kaijiMemory1.zawaKokakuCountMove
        kaiji.hiramekiCountBlueMiss = kaijiMemory1.hiramekiCountBlueMiss
        kaiji.hiramekiCountBlueSuccess = kaijiMemory1.hiramekiCountBlueSuccess
        kaiji.hiramekiCountBlueSum = kaijiMemory1.hiramekiCountBlueSum
        kaiji.hiramekiCountYellowMiss = kaijiMemory1.hiramekiCountYellowMiss
        kaiji.hiramekiCountYellowSuccess = kaijiMemory1.hiramekiCountYellowSuccess
        kaiji.hiramekiCountYellowSum = kaijiMemory1.hiramekiCountYellowSum
        kaiji.hiramekiCountGreenMiss = kaijiMemory1.hiramekiCountGreenMiss
        kaiji.hiramekiCountGreenSuccess = kaijiMemory1.hiramekiCountGreenSuccess
        kaiji.hiramekiCountGreenSum = kaijiMemory1.hiramekiCountGreenSum
        kaiji.hiramekiCountRedMiss = kaijiMemory1.hiramekiCountRedMiss
        kaiji.hiramekiCountRedSuccess = kaijiMemory1.hiramekiCountRedSuccess
        kaiji.hiramekiCountRedSum = kaijiMemory1.hiramekiCountRedSum
        kaiji.playNormalGame = kaijiMemory1.playNormalGame
        kaiji.czCount = kaijiMemory1.czCount
        kaiji.atCount = kaijiMemory1.atCount
        kaiji.screenCountDefault = kaijiMemory1.screenCountDefault
        kaiji.screenCountGusu = kaijiMemory1.screenCountGusu
        kaiji.screenCountShower = kaijiMemory1.screenCountShower
        kaiji.screenCountOver2 = kaijiMemory1.screenCountOver2
        kaiji.screenCountTonegawa = kaijiMemory1.screenCountTonegawa
        kaiji.screenCountHancho = kaijiMemory1.screenCountHancho
        kaiji.screenCountMikoko = kaijiMemory1.screenCountMikoko
        kaiji.screenCountBunny = kaijiMemory1.screenCountBunny
        kaiji.screenCountSenyo = kaijiMemory1.screenCountSenyo
        kaiji.screenCountSum = kaijiMemory1.screenCountSum
        kaiji.endingCountKisu = kaijiMemory1.endingCountKisu
        kaiji.endingCountGusu = kaijiMemory1.endingCountGusu
        kaiji.endingCountMaryoku = kaijiMemory1.endingCountMaryoku
        kaiji.endingCountOver4 = kaijiMemory1.endingCountOver4
        kaiji.endingCountTeiai = kaijiMemory1.endingCountTeiai
        kaiji.endingCountSum = kaijiMemory1.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaiji.totalGame = kaijiMemory1.totalGame
        kaiji.koyakuCountSuika = kaijiMemory1.koyakuCountSuika
        kaiji.koyakuCountJakuCherry = kaijiMemory1.koyakuCountJakuCherry
        kaiji.koyakuCountJakuChance = kaijiMemory1.koyakuCountJakuChance
        kaiji.koyakuCountKyoCherry = kaijiMemory1.koyakuCountKyoCherry
        kaiji.koyakuCountSum = kaijiMemory1.koyakuCountSum
    }
    func loadMemory2() {
        kaiji.zawaKokakuCountJakuRare = kaijiMemory2.zawaKokakuCountJakuRare
        kaiji.zawaKokakuCountMove = kaijiMemory2.zawaKokakuCountMove
        kaiji.hiramekiCountBlueMiss = kaijiMemory2.hiramekiCountBlueMiss
        kaiji.hiramekiCountBlueSuccess = kaijiMemory2.hiramekiCountBlueSuccess
        kaiji.hiramekiCountBlueSum = kaijiMemory2.hiramekiCountBlueSum
        kaiji.hiramekiCountYellowMiss = kaijiMemory2.hiramekiCountYellowMiss
        kaiji.hiramekiCountYellowSuccess = kaijiMemory2.hiramekiCountYellowSuccess
        kaiji.hiramekiCountYellowSum = kaijiMemory2.hiramekiCountYellowSum
        kaiji.hiramekiCountGreenMiss = kaijiMemory2.hiramekiCountGreenMiss
        kaiji.hiramekiCountGreenSuccess = kaijiMemory2.hiramekiCountGreenSuccess
        kaiji.hiramekiCountGreenSum = kaijiMemory2.hiramekiCountGreenSum
        kaiji.hiramekiCountRedMiss = kaijiMemory2.hiramekiCountRedMiss
        kaiji.hiramekiCountRedSuccess = kaijiMemory2.hiramekiCountRedSuccess
        kaiji.hiramekiCountRedSum = kaijiMemory2.hiramekiCountRedSum
        kaiji.playNormalGame = kaijiMemory2.playNormalGame
        kaiji.czCount = kaijiMemory2.czCount
        kaiji.atCount = kaijiMemory2.atCount
        kaiji.screenCountDefault = kaijiMemory2.screenCountDefault
        kaiji.screenCountGusu = kaijiMemory2.screenCountGusu
        kaiji.screenCountShower = kaijiMemory2.screenCountShower
        kaiji.screenCountOver2 = kaijiMemory2.screenCountOver2
        kaiji.screenCountTonegawa = kaijiMemory2.screenCountTonegawa
        kaiji.screenCountHancho = kaijiMemory2.screenCountHancho
        kaiji.screenCountMikoko = kaijiMemory2.screenCountMikoko
        kaiji.screenCountBunny = kaijiMemory2.screenCountBunny
        kaiji.screenCountSenyo = kaijiMemory2.screenCountSenyo
        kaiji.screenCountSum = kaijiMemory2.screenCountSum
        kaiji.endingCountKisu = kaijiMemory2.endingCountKisu
        kaiji.endingCountGusu = kaijiMemory2.endingCountGusu
        kaiji.endingCountMaryoku = kaijiMemory2.endingCountMaryoku
        kaiji.endingCountOver4 = kaijiMemory2.endingCountOver4
        kaiji.endingCountTeiai = kaijiMemory2.endingCountTeiai
        kaiji.endingCountSum = kaijiMemory2.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaiji.totalGame = kaijiMemory2.totalGame
        kaiji.koyakuCountSuika = kaijiMemory2.koyakuCountSuika
        kaiji.koyakuCountJakuCherry = kaijiMemory2.koyakuCountJakuCherry
        kaiji.koyakuCountJakuChance = kaijiMemory2.koyakuCountJakuChance
        kaiji.koyakuCountKyoCherry = kaijiMemory2.koyakuCountKyoCherry
        kaiji.koyakuCountSum = kaijiMemory2.koyakuCountSum
    }
    func loadMemory3() {
        kaiji.zawaKokakuCountJakuRare = kaijiMemory3.zawaKokakuCountJakuRare
        kaiji.zawaKokakuCountMove = kaijiMemory3.zawaKokakuCountMove
        kaiji.hiramekiCountBlueMiss = kaijiMemory3.hiramekiCountBlueMiss
        kaiji.hiramekiCountBlueSuccess = kaijiMemory3.hiramekiCountBlueSuccess
        kaiji.hiramekiCountBlueSum = kaijiMemory3.hiramekiCountBlueSum
        kaiji.hiramekiCountYellowMiss = kaijiMemory3.hiramekiCountYellowMiss
        kaiji.hiramekiCountYellowSuccess = kaijiMemory3.hiramekiCountYellowSuccess
        kaiji.hiramekiCountYellowSum = kaijiMemory3.hiramekiCountYellowSum
        kaiji.hiramekiCountGreenMiss = kaijiMemory3.hiramekiCountGreenMiss
        kaiji.hiramekiCountGreenSuccess = kaijiMemory3.hiramekiCountGreenSuccess
        kaiji.hiramekiCountGreenSum = kaijiMemory3.hiramekiCountGreenSum
        kaiji.hiramekiCountRedMiss = kaijiMemory3.hiramekiCountRedMiss
        kaiji.hiramekiCountRedSuccess = kaijiMemory3.hiramekiCountRedSuccess
        kaiji.hiramekiCountRedSum = kaijiMemory3.hiramekiCountRedSum
        kaiji.playNormalGame = kaijiMemory3.playNormalGame
        kaiji.czCount = kaijiMemory3.czCount
        kaiji.atCount = kaijiMemory3.atCount
        kaiji.screenCountDefault = kaijiMemory3.screenCountDefault
        kaiji.screenCountGusu = kaijiMemory3.screenCountGusu
        kaiji.screenCountShower = kaijiMemory3.screenCountShower
        kaiji.screenCountOver2 = kaijiMemory3.screenCountOver2
        kaiji.screenCountTonegawa = kaijiMemory3.screenCountTonegawa
        kaiji.screenCountHancho = kaijiMemory3.screenCountHancho
        kaiji.screenCountMikoko = kaijiMemory3.screenCountMikoko
        kaiji.screenCountBunny = kaijiMemory3.screenCountBunny
        kaiji.screenCountSenyo = kaijiMemory3.screenCountSenyo
        kaiji.screenCountSum = kaijiMemory3.screenCountSum
        kaiji.endingCountKisu = kaijiMemory3.endingCountKisu
        kaiji.endingCountGusu = kaijiMemory3.endingCountGusu
        kaiji.endingCountMaryoku = kaijiMemory3.endingCountMaryoku
        kaiji.endingCountOver4 = kaijiMemory3.endingCountOver4
        kaiji.endingCountTeiai = kaijiMemory3.endingCountTeiai
        kaiji.endingCountSum = kaijiMemory3.endingCountSum
        
        // /////////////////////
        // 小役、ver271で追加
        // /////////////////////
        kaiji.totalGame = kaijiMemory3.totalGame
        kaiji.koyakuCountSuika = kaijiMemory3.koyakuCountSuika
        kaiji.koyakuCountJakuCherry = kaijiMemory3.koyakuCountJakuCherry
        kaiji.koyakuCountJakuChance = kaijiMemory3.koyakuCountJakuChance
        kaiji.koyakuCountKyoCherry = kaijiMemory3.koyakuCountKyoCherry
        kaiji.koyakuCountSum = kaijiMemory3.koyakuCountSum
    }
}

#Preview {
    kaijiViewTop(
//        ver300: Ver300()
    )
}
