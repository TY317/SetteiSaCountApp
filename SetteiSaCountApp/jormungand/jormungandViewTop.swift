//
//  jormungandViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var jormungand = Jormungand()
    @State var isShowAlert: Bool = false
    @StateObject var jormungandMemory1 = JormungandMemory1()
    @StateObject var jormungandMemory2 = JormungandMemory2()
    @StateObject var jormungandMemory3 = JormungandMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: jormungand.machineName,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: jormungandViewNormal(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.jormungandMenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: jormungandViewCz(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.jormungandMenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
                    NavigationLink(destination: jormungandViewFirstHit(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.jormungandMenuFirstHitBadge,
                        )
                    }
                    
                    // REG
                    NavigationLink(destination: jormungandViewReg(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "REG",
                            badgeStatus: common.jormungandMenuRegBadge,
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: jormungandViewScreen(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.jormungandMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: jormungandViewEnding(
                        jormungand: jormungand,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.jormungandMenuEndingBadge,
                        )
                    }
//
//                    // おみくじ
//                    NavigationLink(destination: jormungandViewOmikuji(
//                        jormungand: jormungand,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.jormungandMenuOmikujiBadge,
//                        )
//                    }
//
//                    // サミートロフィー
//                    NavigationLink(destination: commonViewSammyTrophy()) {
//                        unitLabelMenu(
//                            imageSystemName: "trophy.fill",
//                            textBody: "サミートロフィー"
//                        )
//                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: jormungandView95Ci(
                    jormungand: jormungand,
                    selection: 3,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: jormungandViewBayes(
                    jormungand: jormungand,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.jormungandMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4970")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©2012 高橋慶太郎・小学館／ヨルムンガンド製作委員会")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(jormungandSubViewLoadMemory(
                    jormungand: jormungand,
                    jormungandMemory1: jormungandMemory1,
                    jormungandMemory2: jormungandMemory2,
                    jormungandMemory3: jormungandMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(jormungandSubViewSaveMemory(
                    jormungand: jormungand,
                    jormungandMemory1: jormungandMemory1,
                    jormungandMemory2: jormungandMemory2,
                    jormungandMemory3: jormungandMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: jormungand.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct jormungandSubViewSaveMemory: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var jormungandMemory1: JormungandMemory1
    @ObservedObject var jormungandMemory2: JormungandMemory2
    @ObservedObject var jormungandMemory3: JormungandMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: jormungand.machineName,
            selectedMemory: $jormungand.selectedMemory,
            memoMemory1: $jormungandMemory1.memo,
            dateDoubleMemory1: $jormungandMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $jormungandMemory2.memo,
            dateDoubleMemory2: $jormungandMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $jormungandMemory3.memo,
            dateDoubleMemory3: $jormungandMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        jormungandMemory1.rareCzCountChance = jormungand.rareCzCountChance
        jormungandMemory1.rareCzCountChanceHit = jormungand.rareCzCountChanceHit
        jormungandMemory1.rareCzCountKyoCherry = jormungand.rareCzCountKyoCherry
        jormungandMemory1.rareCzCountKyoCherryHit = jormungand.rareCzCountKyoCherryHit
        jormungandMemory1.tenjoCountMiss = jormungand.tenjoCountMiss
        jormungandMemory1.tenjoCountHit = jormungand.tenjoCountHit
        jormungandMemory1.tenjoCountSum = jormungand.tenjoCountSum
        jormungandMemory1.cardCountDefault = jormungand.cardCountDefault
        jormungandMemory1.cardCountKisu = jormungand.cardCountKisu
        jormungandMemory1.cardCountGusu = jormungand.cardCountGusu
        jormungandMemory1.cardCountHighJaku = jormungand.cardCountHighJaku
        jormungandMemory1.cardCountModeCJaku = jormungand.cardCountModeCJaku
        jormungandMemory1.cardCountHighKyo = jormungand.cardCountHighKyo
        jormungandMemory1.cardCountModeCKyo = jormungand.cardCountModeCKyo
        jormungandMemory1.cardCountGusuFix = jormungand.cardCountGusuFix
        jormungandMemory1.cardCountModeD = jormungand.cardCountModeD
        jormungandMemory1.cardCountHorobi = jormungand.cardCountHorobi
        jormungandMemory1.cardCountSum = jormungand.cardCountSum
        jormungandMemory1.normalGame = jormungand.normalGame
        jormungandMemory1.firstHitCountCz = jormungand.firstHitCountCz
        jormungandMemory1.firstHitCountAt = jormungand.firstHitCountAt
        jormungandMemory1.screenCountDefault = jormungand.screenCountDefault
        jormungandMemory1.screenCountHigh = jormungand.screenCountHigh
        jormungandMemory1.screenCountKisu = jormungand.screenCountKisu
        jormungandMemory1.screenCountGusu = jormungand.screenCountGusu
        jormungandMemory1.screenCountNegate2 = jormungand.screenCountNegate2
        jormungandMemory1.screenCountGusuFix = jormungand.screenCountGusuFix
        jormungandMemory1.screenCountOver4 = jormungand.screenCountOver4
        jormungandMemory1.screenCountOver6 = jormungand.screenCountOver6
        jormungandMemory1.screenCountSum = jormungand.screenCountSum
        jormungandMemory1.charaCountKisu = jormungand.charaCountKisu
        jormungandMemory1.charaCountGusu = jormungand.charaCountGusu
        jormungandMemory1.charaCountHigh = jormungand.charaCountHigh
        jormungandMemory1.charaCountOver2 = jormungand.charaCountOver2
        jormungandMemory1.charaCountOver4 = jormungand.charaCountOver4
        jormungandMemory1.charaCountOver6 = jormungand.charaCountOver6
        jormungandMemory1.charaCountSum = jormungand.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungandMemory1.chara3CountKisu = jormungand.chara3CountKisu
        jormungandMemory1.chara3CountGusu = jormungand.chara3CountGusu
        jormungandMemory1.chara3CountHigh = jormungand.chara3CountHigh
        jormungandMemory1.chara3CountOver2 = jormungand.chara3CountOver2
        jormungandMemory1.chara3CountOver4 = jormungand.chara3CountOver4
        jormungandMemory1.chara3CountOver6 = jormungand.chara3CountOver6
        jormungandMemory1.chara3CountSum = jormungand.chara3CountSum
        jormungandMemory1.rareCzCountJakuRare = jormungand.rareCzCountJakuRare
        jormungandMemory1.rareCzCountJakuRareHit = jormungand.rareCzCountJakuRareHit
    }
    func saveMemory2() {
        jormungandMemory2.rareCzCountChance = jormungand.rareCzCountChance
        jormungandMemory2.rareCzCountChanceHit = jormungand.rareCzCountChanceHit
        jormungandMemory2.rareCzCountKyoCherry = jormungand.rareCzCountKyoCherry
        jormungandMemory2.rareCzCountKyoCherryHit = jormungand.rareCzCountKyoCherryHit
        jormungandMemory2.tenjoCountMiss = jormungand.tenjoCountMiss
        jormungandMemory2.tenjoCountHit = jormungand.tenjoCountHit
        jormungandMemory2.tenjoCountSum = jormungand.tenjoCountSum
        jormungandMemory2.cardCountDefault = jormungand.cardCountDefault
        jormungandMemory2.cardCountKisu = jormungand.cardCountKisu
        jormungandMemory2.cardCountGusu = jormungand.cardCountGusu
        jormungandMemory2.cardCountHighJaku = jormungand.cardCountHighJaku
        jormungandMemory2.cardCountModeCJaku = jormungand.cardCountModeCJaku
        jormungandMemory2.cardCountHighKyo = jormungand.cardCountHighKyo
        jormungandMemory2.cardCountModeCKyo = jormungand.cardCountModeCKyo
        jormungandMemory2.cardCountGusuFix = jormungand.cardCountGusuFix
        jormungandMemory2.cardCountModeD = jormungand.cardCountModeD
        jormungandMemory2.cardCountHorobi = jormungand.cardCountHorobi
        jormungandMemory2.cardCountSum = jormungand.cardCountSum
        jormungandMemory2.normalGame = jormungand.normalGame
        jormungandMemory2.firstHitCountCz = jormungand.firstHitCountCz
        jormungandMemory2.firstHitCountAt = jormungand.firstHitCountAt
        jormungandMemory2.screenCountDefault = jormungand.screenCountDefault
        jormungandMemory2.screenCountHigh = jormungand.screenCountHigh
        jormungandMemory2.screenCountKisu = jormungand.screenCountKisu
        jormungandMemory2.screenCountGusu = jormungand.screenCountGusu
        jormungandMemory2.screenCountNegate2 = jormungand.screenCountNegate2
        jormungandMemory2.screenCountGusuFix = jormungand.screenCountGusuFix
        jormungandMemory2.screenCountOver4 = jormungand.screenCountOver4
        jormungandMemory2.screenCountOver6 = jormungand.screenCountOver6
        jormungandMemory2.screenCountSum = jormungand.screenCountSum
        jormungandMemory2.charaCountKisu = jormungand.charaCountKisu
        jormungandMemory2.charaCountGusu = jormungand.charaCountGusu
        jormungandMemory2.charaCountHigh = jormungand.charaCountHigh
        jormungandMemory2.charaCountOver2 = jormungand.charaCountOver2
        jormungandMemory2.charaCountOver4 = jormungand.charaCountOver4
        jormungandMemory2.charaCountOver6 = jormungand.charaCountOver6
        jormungandMemory2.charaCountSum = jormungand.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungandMemory2.chara3CountKisu = jormungand.chara3CountKisu
        jormungandMemory2.chara3CountGusu = jormungand.chara3CountGusu
        jormungandMemory2.chara3CountHigh = jormungand.chara3CountHigh
        jormungandMemory2.chara3CountOver2 = jormungand.chara3CountOver2
        jormungandMemory2.chara3CountOver4 = jormungand.chara3CountOver4
        jormungandMemory2.chara3CountOver6 = jormungand.chara3CountOver6
        jormungandMemory2.chara3CountSum = jormungand.chara3CountSum
        jormungandMemory2.rareCzCountJakuRare = jormungand.rareCzCountJakuRare
        jormungandMemory2.rareCzCountJakuRareHit = jormungand.rareCzCountJakuRareHit
    }
    func saveMemory3() {
        jormungandMemory3.rareCzCountChance = jormungand.rareCzCountChance
        jormungandMemory3.rareCzCountChanceHit = jormungand.rareCzCountChanceHit
        jormungandMemory3.rareCzCountKyoCherry = jormungand.rareCzCountKyoCherry
        jormungandMemory3.rareCzCountKyoCherryHit = jormungand.rareCzCountKyoCherryHit
        jormungandMemory3.tenjoCountMiss = jormungand.tenjoCountMiss
        jormungandMemory3.tenjoCountHit = jormungand.tenjoCountHit
        jormungandMemory3.tenjoCountSum = jormungand.tenjoCountSum
        jormungandMemory3.cardCountDefault = jormungand.cardCountDefault
        jormungandMemory3.cardCountKisu = jormungand.cardCountKisu
        jormungandMemory3.cardCountGusu = jormungand.cardCountGusu
        jormungandMemory3.cardCountHighJaku = jormungand.cardCountHighJaku
        jormungandMemory3.cardCountModeCJaku = jormungand.cardCountModeCJaku
        jormungandMemory3.cardCountHighKyo = jormungand.cardCountHighKyo
        jormungandMemory3.cardCountModeCKyo = jormungand.cardCountModeCKyo
        jormungandMemory3.cardCountGusuFix = jormungand.cardCountGusuFix
        jormungandMemory3.cardCountModeD = jormungand.cardCountModeD
        jormungandMemory3.cardCountHorobi = jormungand.cardCountHorobi
        jormungandMemory3.cardCountSum = jormungand.cardCountSum
        jormungandMemory3.normalGame = jormungand.normalGame
        jormungandMemory3.firstHitCountCz = jormungand.firstHitCountCz
        jormungandMemory3.firstHitCountAt = jormungand.firstHitCountAt
        jormungandMemory3.screenCountDefault = jormungand.screenCountDefault
        jormungandMemory3.screenCountHigh = jormungand.screenCountHigh
        jormungandMemory3.screenCountKisu = jormungand.screenCountKisu
        jormungandMemory3.screenCountGusu = jormungand.screenCountGusu
        jormungandMemory3.screenCountNegate2 = jormungand.screenCountNegate2
        jormungandMemory3.screenCountGusuFix = jormungand.screenCountGusuFix
        jormungandMemory3.screenCountOver4 = jormungand.screenCountOver4
        jormungandMemory3.screenCountOver6 = jormungand.screenCountOver6
        jormungandMemory3.screenCountSum = jormungand.screenCountSum
        jormungandMemory3.charaCountKisu = jormungand.charaCountKisu
        jormungandMemory3.charaCountGusu = jormungand.charaCountGusu
        jormungandMemory3.charaCountHigh = jormungand.charaCountHigh
        jormungandMemory3.charaCountOver2 = jormungand.charaCountOver2
        jormungandMemory3.charaCountOver4 = jormungand.charaCountOver4
        jormungandMemory3.charaCountOver6 = jormungand.charaCountOver6
        jormungandMemory3.charaCountSum = jormungand.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungandMemory3.chara3CountKisu = jormungand.chara3CountKisu
        jormungandMemory3.chara3CountGusu = jormungand.chara3CountGusu
        jormungandMemory3.chara3CountHigh = jormungand.chara3CountHigh
        jormungandMemory3.chara3CountOver2 = jormungand.chara3CountOver2
        jormungandMemory3.chara3CountOver4 = jormungand.chara3CountOver4
        jormungandMemory3.chara3CountOver6 = jormungand.chara3CountOver6
        jormungandMemory3.chara3CountSum = jormungand.chara3CountSum
        jormungandMemory3.rareCzCountJakuRare = jormungand.rareCzCountJakuRare
        jormungandMemory3.rareCzCountJakuRareHit = jormungand.rareCzCountJakuRareHit
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct jormungandSubViewLoadMemory: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var jormungandMemory1: JormungandMemory1
    @ObservedObject var jormungandMemory2: JormungandMemory2
    @ObservedObject var jormungandMemory3: JormungandMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: jormungand.machineName,
            selectedMemory: $jormungand.selectedMemory,
            memoMemory1: jormungandMemory1.memo,
            dateDoubleMemory1: jormungandMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: jormungandMemory2.memo,
            dateDoubleMemory2: jormungandMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: jormungandMemory3.memo,
            dateDoubleMemory3: jormungandMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        jormungand.rareCzCountChance = jormungandMemory1.rareCzCountChance
        jormungand.rareCzCountChanceHit = jormungandMemory1.rareCzCountChanceHit
        jormungand.rareCzCountKyoCherry = jormungandMemory1.rareCzCountKyoCherry
        jormungand.rareCzCountKyoCherryHit = jormungandMemory1.rareCzCountKyoCherryHit
        jormungand.tenjoCountMiss = jormungandMemory1.tenjoCountMiss
        jormungand.tenjoCountHit = jormungandMemory1.tenjoCountHit
        jormungand.tenjoCountSum = jormungandMemory1.tenjoCountSum
        jormungand.cardCountDefault = jormungandMemory1.cardCountDefault
        jormungand.cardCountKisu = jormungandMemory1.cardCountKisu
        jormungand.cardCountGusu = jormungandMemory1.cardCountGusu
        jormungand.cardCountHighJaku = jormungandMemory1.cardCountHighJaku
        jormungand.cardCountModeCJaku = jormungandMemory1.cardCountModeCJaku
        jormungand.cardCountHighKyo = jormungandMemory1.cardCountHighKyo
        jormungand.cardCountModeCKyo = jormungandMemory1.cardCountModeCKyo
        jormungand.cardCountGusuFix = jormungandMemory1.cardCountGusuFix
        jormungand.cardCountModeD = jormungandMemory1.cardCountModeD
        jormungand.cardCountHorobi = jormungandMemory1.cardCountHorobi
        jormungand.cardCountSum = jormungandMemory1.cardCountSum
        jormungand.normalGame = jormungandMemory1.normalGame
        jormungand.firstHitCountCz = jormungandMemory1.firstHitCountCz
        jormungand.firstHitCountAt = jormungandMemory1.firstHitCountAt
        jormungand.screenCountDefault = jormungandMemory1.screenCountDefault
        jormungand.screenCountHigh = jormungandMemory1.screenCountHigh
        jormungand.screenCountKisu = jormungandMemory1.screenCountKisu
        jormungand.screenCountGusu = jormungandMemory1.screenCountGusu
        jormungand.screenCountNegate2 = jormungandMemory1.screenCountNegate2
        jormungand.screenCountGusuFix = jormungandMemory1.screenCountGusuFix
        jormungand.screenCountOver4 = jormungandMemory1.screenCountOver4
        jormungand.screenCountOver6 = jormungandMemory1.screenCountOver6
        jormungand.screenCountSum = jormungandMemory1.screenCountSum
        jormungand.charaCountKisu = jormungandMemory1.charaCountKisu
        jormungand.charaCountGusu = jormungandMemory1.charaCountGusu
        jormungand.charaCountHigh = jormungandMemory1.charaCountHigh
        jormungand.charaCountOver2 = jormungandMemory1.charaCountOver2
        jormungand.charaCountOver4 = jormungandMemory1.charaCountOver4
        jormungand.charaCountOver6 = jormungandMemory1.charaCountOver6
        jormungand.charaCountSum = jormungandMemory1.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungand.chara3CountKisu = jormungandMemory1.chara3CountKisu
        jormungand.chara3CountGusu = jormungandMemory1.chara3CountGusu
        jormungand.chara3CountHigh = jormungandMemory1.chara3CountHigh
        jormungand.chara3CountOver2 = jormungandMemory1.chara3CountOver2
        jormungand.chara3CountOver4 = jormungandMemory1.chara3CountOver4
        jormungand.chara3CountOver6 = jormungandMemory1.chara3CountOver6
        jormungand.chara3CountSum = jormungandMemory1.chara3CountSum
        jormungand.rareCzCountJakuRare = jormungandMemory1.rareCzCountJakuRare
        jormungand.rareCzCountJakuRareHit = jormungandMemory1.rareCzCountJakuRareHit
    }
    func loadMemory2() {
        jormungand.rareCzCountChance = jormungandMemory2.rareCzCountChance
        jormungand.rareCzCountChanceHit = jormungandMemory2.rareCzCountChanceHit
        jormungand.rareCzCountKyoCherry = jormungandMemory2.rareCzCountKyoCherry
        jormungand.rareCzCountKyoCherryHit = jormungandMemory2.rareCzCountKyoCherryHit
        jormungand.tenjoCountMiss = jormungandMemory2.tenjoCountMiss
        jormungand.tenjoCountHit = jormungandMemory2.tenjoCountHit
        jormungand.tenjoCountSum = jormungandMemory2.tenjoCountSum
        jormungand.cardCountDefault = jormungandMemory2.cardCountDefault
        jormungand.cardCountKisu = jormungandMemory2.cardCountKisu
        jormungand.cardCountGusu = jormungandMemory2.cardCountGusu
        jormungand.cardCountHighJaku = jormungandMemory2.cardCountHighJaku
        jormungand.cardCountModeCJaku = jormungandMemory2.cardCountModeCJaku
        jormungand.cardCountHighKyo = jormungandMemory2.cardCountHighKyo
        jormungand.cardCountModeCKyo = jormungandMemory2.cardCountModeCKyo
        jormungand.cardCountGusuFix = jormungandMemory2.cardCountGusuFix
        jormungand.cardCountModeD = jormungandMemory2.cardCountModeD
        jormungand.cardCountHorobi = jormungandMemory2.cardCountHorobi
        jormungand.cardCountSum = jormungandMemory2.cardCountSum
        jormungand.normalGame = jormungandMemory2.normalGame
        jormungand.firstHitCountCz = jormungandMemory2.firstHitCountCz
        jormungand.firstHitCountAt = jormungandMemory2.firstHitCountAt
        jormungand.screenCountDefault = jormungandMemory2.screenCountDefault
        jormungand.screenCountHigh = jormungandMemory2.screenCountHigh
        jormungand.screenCountKisu = jormungandMemory2.screenCountKisu
        jormungand.screenCountGusu = jormungandMemory2.screenCountGusu
        jormungand.screenCountNegate2 = jormungandMemory2.screenCountNegate2
        jormungand.screenCountGusuFix = jormungandMemory2.screenCountGusuFix
        jormungand.screenCountOver4 = jormungandMemory2.screenCountOver4
        jormungand.screenCountOver6 = jormungandMemory2.screenCountOver6
        jormungand.screenCountSum = jormungandMemory2.screenCountSum
        jormungand.charaCountKisu = jormungandMemory2.charaCountKisu
        jormungand.charaCountGusu = jormungandMemory2.charaCountGusu
        jormungand.charaCountHigh = jormungandMemory2.charaCountHigh
        jormungand.charaCountOver2 = jormungandMemory2.charaCountOver2
        jormungand.charaCountOver4 = jormungandMemory2.charaCountOver4
        jormungand.charaCountOver6 = jormungandMemory2.charaCountOver6
        jormungand.charaCountSum = jormungandMemory2.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungand.chara3CountKisu = jormungandMemory2.chara3CountKisu
        jormungand.chara3CountGusu = jormungandMemory2.chara3CountGusu
        jormungand.chara3CountHigh = jormungandMemory2.chara3CountHigh
        jormungand.chara3CountOver2 = jormungandMemory2.chara3CountOver2
        jormungand.chara3CountOver4 = jormungandMemory2.chara3CountOver4
        jormungand.chara3CountOver6 = jormungandMemory2.chara3CountOver6
        jormungand.chara3CountSum = jormungandMemory2.chara3CountSum
        jormungand.rareCzCountJakuRare = jormungandMemory2.rareCzCountJakuRare
        jormungand.rareCzCountJakuRareHit = jormungandMemory2.rareCzCountJakuRareHit
    }
    func loadMemory3() {
        jormungand.rareCzCountChance = jormungandMemory3.rareCzCountChance
        jormungand.rareCzCountChanceHit = jormungandMemory3.rareCzCountChanceHit
        jormungand.rareCzCountKyoCherry = jormungandMemory3.rareCzCountKyoCherry
        jormungand.rareCzCountKyoCherryHit = jormungandMemory3.rareCzCountKyoCherryHit
        jormungand.tenjoCountMiss = jormungandMemory3.tenjoCountMiss
        jormungand.tenjoCountHit = jormungandMemory3.tenjoCountHit
        jormungand.tenjoCountSum = jormungandMemory3.tenjoCountSum
        jormungand.cardCountDefault = jormungandMemory3.cardCountDefault
        jormungand.cardCountKisu = jormungandMemory3.cardCountKisu
        jormungand.cardCountGusu = jormungandMemory3.cardCountGusu
        jormungand.cardCountHighJaku = jormungandMemory3.cardCountHighJaku
        jormungand.cardCountModeCJaku = jormungandMemory3.cardCountModeCJaku
        jormungand.cardCountHighKyo = jormungandMemory3.cardCountHighKyo
        jormungand.cardCountModeCKyo = jormungandMemory3.cardCountModeCKyo
        jormungand.cardCountGusuFix = jormungandMemory3.cardCountGusuFix
        jormungand.cardCountModeD = jormungandMemory3.cardCountModeD
        jormungand.cardCountHorobi = jormungandMemory3.cardCountHorobi
        jormungand.cardCountSum = jormungandMemory3.cardCountSum
        jormungand.normalGame = jormungandMemory3.normalGame
        jormungand.firstHitCountCz = jormungandMemory3.firstHitCountCz
        jormungand.firstHitCountAt = jormungandMemory3.firstHitCountAt
        jormungand.screenCountDefault = jormungandMemory3.screenCountDefault
        jormungand.screenCountHigh = jormungandMemory3.screenCountHigh
        jormungand.screenCountKisu = jormungandMemory3.screenCountKisu
        jormungand.screenCountGusu = jormungandMemory3.screenCountGusu
        jormungand.screenCountNegate2 = jormungandMemory3.screenCountNegate2
        jormungand.screenCountGusuFix = jormungandMemory3.screenCountGusuFix
        jormungand.screenCountOver4 = jormungandMemory3.screenCountOver4
        jormungand.screenCountOver6 = jormungandMemory3.screenCountOver6
        jormungand.screenCountSum = jormungandMemory3.screenCountSum
        jormungand.charaCountKisu = jormungandMemory3.charaCountKisu
        jormungand.charaCountGusu = jormungandMemory3.charaCountGusu
        jormungand.charaCountHigh = jormungandMemory3.charaCountHigh
        jormungand.charaCountOver2 = jormungandMemory3.charaCountOver2
        jormungand.charaCountOver4 = jormungandMemory3.charaCountOver4
        jormungand.charaCountOver6 = jormungandMemory3.charaCountOver6
        jormungand.charaCountSum = jormungandMemory3.charaCountSum
        
        // --------
        // ver3.24.1
        // --------
        jormungand.chara3CountKisu = jormungandMemory3.chara3CountKisu
        jormungand.chara3CountGusu = jormungandMemory3.chara3CountGusu
        jormungand.chara3CountHigh = jormungandMemory3.chara3CountHigh
        jormungand.chara3CountOver2 = jormungandMemory3.chara3CountOver2
        jormungand.chara3CountOver4 = jormungandMemory3.chara3CountOver4
        jormungand.chara3CountOver6 = jormungandMemory3.chara3CountOver6
        jormungand.chara3CountSum = jormungandMemory3.chara3CountSum
        jormungand.rareCzCountJakuRare = jormungandMemory3.rareCzCountJakuRare
        jormungand.rareCzCountJakuRareHit = jormungandMemory3.rareCzCountJakuRareHit
    }
}

#Preview {
    jormungandViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
