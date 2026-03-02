//
//  kabaneriUnatoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import SwiftUI

struct kabaneriUnatoViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var kabaneriUnato = KabaneriUnato()
    @State var isShowAlert: Bool = false
    @StateObject var kabaneriUnatoMemory1 = KabaneriUnatoMemory1()
    @StateObject var kabaneriUnatoMemory2 = KabaneriUnatoMemory2()
    @StateObject var kabaneriUnatoMemory3 = KabaneriUnatoMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: kabaneriUnato.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: kabaneriUnatoViewNormal(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kabaneriUnatoMenuNormalBadge,
                        )
                    }
                    
                    // 初あたり
                    NavigationLink(destination: kabaneriUnatoViewFirstHit(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kabaneriUnatoMenuFirstHitBadge,
                        )
                    }
                    
                    // カバネリボーナス
                    NavigationLink(destination: kabaneriUnatoViewKabaneriBonus(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "カバネリボーナス",
                            badgeStatus: common.kabaneriUnatoMenuKabaneriBonusBadge,
                        )
                    }
                    
                    // ST終了画面
                    NavigationLink(destination: kabaneriUnatoViewScreen(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ST終了画面",
                            badgeStatus: common.kabaneriUnatoMenuScreenBadge,
                        )
                    }
                    
                    // おみくじ
                    NavigationLink(destination: kabaneriUnatoViewOmikuji(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "tag.fill",
                            textBody: "おみくじ",
                            badgeStatus: common.kabaneriUnatoMenuOmikujiBadge,
                        )
                    }
                    
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: kabaneriUnatoView95Ci(
                    kabaneriUnato: kabaneriUnato,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: kabaneriUnatoViewBayes(
                    kabaneriUnato: kabaneriUnato,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.kabaneriUnatoMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4930")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©カバネリ製作委員会")
                    Text("©Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(kabaneriUnatoSubViewLoadMemory(
                    kabaneriUnato: kabaneriUnato,
                    kabaneriUnatoMemory1: kabaneriUnatoMemory1,
                    kabaneriUnatoMemory2: kabaneriUnatoMemory2,
                    kabaneriUnatoMemory3: kabaneriUnatoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(kabaneriUnatoSubViewSaveMemory(
                    kabaneriUnato: kabaneriUnato,
                    kabaneriUnatoMemory1: kabaneriUnatoMemory1,
                    kabaneriUnatoMemory2: kabaneriUnatoMemory2,
                    kabaneriUnatoMemory3: kabaneriUnatoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kabaneriUnato.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kabaneriUnatoSubViewSaveMemory: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @ObservedObject var kabaneriUnatoMemory1: KabaneriUnatoMemory1
    @ObservedObject var kabaneriUnatoMemory2: KabaneriUnatoMemory2
    @ObservedObject var kabaneriUnatoMemory3: KabaneriUnatoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: kabaneriUnato.machineName,
            selectedMemory: $kabaneriUnato.selectedMemory,
            memoMemory1: $kabaneriUnatoMemory1.memo,
            dateDoubleMemory1: $kabaneriUnatoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kabaneriUnatoMemory2.memo,
            dateDoubleMemory2: $kabaneriUnatoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kabaneriUnatoMemory3.memo,
            dateDoubleMemory3: $kabaneriUnatoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kabaneriUnatoMemory1.flushCountMiss = kabaneriUnato.flushCountMiss
        kabaneriUnatoMemory1.flushCountHit = kabaneriUnato.flushCountHit
        kabaneriUnatoMemory1.flushCountSum = kabaneriUnato.flushCountSum
        kabaneriUnatoMemory1.voiceCount35Sisa = kabaneriUnato.voiceCount35Sisa
        kabaneriUnatoMemory1.voiceCountGusu = kabaneriUnato.voiceCountGusu
        kabaneriUnatoMemory1.voiceCountHighJaku = kabaneriUnato.voiceCountHighJaku
        kabaneriUnatoMemory1.voiceCountHighChu = kabaneriUnato.voiceCountHighChu
        kabaneriUnatoMemory1.voiceCountHighKyo = kabaneriUnato.voiceCountHighKyo
        kabaneriUnatoMemory1.voiceCountOver2 = kabaneriUnato.voiceCountOver2
        kabaneriUnatoMemory1.voiceCountOver5 = kabaneriUnato.voiceCountOver5
        kabaneriUnatoMemory1.voiceCountSum = kabaneriUnato.voiceCountSum
        kabaneriUnatoMemory1.voiceCountHighSum = kabaneriUnato.voiceCountHighSum
        kabaneriUnatoMemory1.charaCount35Sisa = kabaneriUnato.charaCount35Sisa
        kabaneriUnatoMemory1.charaCountGusu = kabaneriUnato.charaCountGusu
        kabaneriUnatoMemory1.charaCountOver4 = kabaneriUnato.charaCountOver4
        kabaneriUnatoMemory1.charaCountSum = kabaneriUnato.charaCountSum
        kabaneriUnatoMemory1.screenCountDefault = kabaneriUnato.screenCountDefault
        kabaneriUnatoMemory1.screenCountHigh = kabaneriUnato.screenCountHigh
        kabaneriUnatoMemory1.screenCountOver6 = kabaneriUnato.screenCountOver6
        kabaneriUnatoMemory1.screenCountSum = kabaneriUnato.screenCountSum
        kabaneriUnatoMemory1.omikujiCount1 = kabaneriUnato.omikujiCount1
        kabaneriUnatoMemory1.omikujiCount2 = kabaneriUnato.omikujiCount2
        kabaneriUnatoMemory1.omikujiCount3 = kabaneriUnato.omikujiCount3
        kabaneriUnatoMemory1.omikujiCount4 = kabaneriUnato.omikujiCount4
        kabaneriUnatoMemory1.omikujiCount5 = kabaneriUnato.omikujiCount5
        kabaneriUnatoMemory1.omikujiCount6 = kabaneriUnato.omikujiCount6
        kabaneriUnatoMemory1.omikujiCountOver2 = kabaneriUnato.omikujiCountOver2
        kabaneriUnatoMemory1.omikujiCountOver4 = kabaneriUnato.omikujiCountOver4
        kabaneriUnatoMemory1.omikujiCountOver6 = kabaneriUnato.omikujiCountOver6
        kabaneriUnatoMemory1.omikujiCountSum = kabaneriUnato.omikujiCountSum
    }
    func saveMemory2() {
        kabaneriUnatoMemory2.flushCountMiss = kabaneriUnato.flushCountMiss
        kabaneriUnatoMemory2.flushCountHit = kabaneriUnato.flushCountHit
        kabaneriUnatoMemory2.flushCountSum = kabaneriUnato.flushCountSum
        kabaneriUnatoMemory2.voiceCount35Sisa = kabaneriUnato.voiceCount35Sisa
        kabaneriUnatoMemory2.voiceCountGusu = kabaneriUnato.voiceCountGusu
        kabaneriUnatoMemory2.voiceCountHighJaku = kabaneriUnato.voiceCountHighJaku
        kabaneriUnatoMemory2.voiceCountHighChu = kabaneriUnato.voiceCountHighChu
        kabaneriUnatoMemory2.voiceCountHighKyo = kabaneriUnato.voiceCountHighKyo
        kabaneriUnatoMemory2.voiceCountOver2 = kabaneriUnato.voiceCountOver2
        kabaneriUnatoMemory2.voiceCountOver5 = kabaneriUnato.voiceCountOver5
        kabaneriUnatoMemory2.voiceCountSum = kabaneriUnato.voiceCountSum
        kabaneriUnatoMemory2.voiceCountHighSum = kabaneriUnato.voiceCountHighSum
        kabaneriUnatoMemory2.charaCount35Sisa = kabaneriUnato.charaCount35Sisa
        kabaneriUnatoMemory2.charaCountGusu = kabaneriUnato.charaCountGusu
        kabaneriUnatoMemory2.charaCountOver4 = kabaneriUnato.charaCountOver4
        kabaneriUnatoMemory2.charaCountSum = kabaneriUnato.charaCountSum
        kabaneriUnatoMemory2.screenCountDefault = kabaneriUnato.screenCountDefault
        kabaneriUnatoMemory2.screenCountHigh = kabaneriUnato.screenCountHigh
        kabaneriUnatoMemory2.screenCountOver6 = kabaneriUnato.screenCountOver6
        kabaneriUnatoMemory2.screenCountSum = kabaneriUnato.screenCountSum
        kabaneriUnatoMemory2.omikujiCount1 = kabaneriUnato.omikujiCount1
        kabaneriUnatoMemory2.omikujiCount2 = kabaneriUnato.omikujiCount2
        kabaneriUnatoMemory2.omikujiCount3 = kabaneriUnato.omikujiCount3
        kabaneriUnatoMemory2.omikujiCount4 = kabaneriUnato.omikujiCount4
        kabaneriUnatoMemory2.omikujiCount5 = kabaneriUnato.omikujiCount5
        kabaneriUnatoMemory2.omikujiCount6 = kabaneriUnato.omikujiCount6
        kabaneriUnatoMemory2.omikujiCountOver2 = kabaneriUnato.omikujiCountOver2
        kabaneriUnatoMemory2.omikujiCountOver4 = kabaneriUnato.omikujiCountOver4
        kabaneriUnatoMemory2.omikujiCountOver6 = kabaneriUnato.omikujiCountOver6
        kabaneriUnatoMemory2.omikujiCountSum = kabaneriUnato.omikujiCountSum
    }
    func saveMemory3() {
        kabaneriUnatoMemory3.flushCountMiss = kabaneriUnato.flushCountMiss
        kabaneriUnatoMemory3.flushCountHit = kabaneriUnato.flushCountHit
        kabaneriUnatoMemory3.flushCountSum = kabaneriUnato.flushCountSum
        kabaneriUnatoMemory3.voiceCount35Sisa = kabaneriUnato.voiceCount35Sisa
        kabaneriUnatoMemory3.voiceCountGusu = kabaneriUnato.voiceCountGusu
        kabaneriUnatoMemory3.voiceCountHighJaku = kabaneriUnato.voiceCountHighJaku
        kabaneriUnatoMemory3.voiceCountHighChu = kabaneriUnato.voiceCountHighChu
        kabaneriUnatoMemory3.voiceCountHighKyo = kabaneriUnato.voiceCountHighKyo
        kabaneriUnatoMemory3.voiceCountOver2 = kabaneriUnato.voiceCountOver2
        kabaneriUnatoMemory3.voiceCountOver5 = kabaneriUnato.voiceCountOver5
        kabaneriUnatoMemory3.voiceCountSum = kabaneriUnato.voiceCountSum
        kabaneriUnatoMemory3.voiceCountHighSum = kabaneriUnato.voiceCountHighSum
        kabaneriUnatoMemory3.charaCount35Sisa = kabaneriUnato.charaCount35Sisa
        kabaneriUnatoMemory3.charaCountGusu = kabaneriUnato.charaCountGusu
        kabaneriUnatoMemory3.charaCountOver4 = kabaneriUnato.charaCountOver4
        kabaneriUnatoMemory3.charaCountSum = kabaneriUnato.charaCountSum
        kabaneriUnatoMemory3.screenCountDefault = kabaneriUnato.screenCountDefault
        kabaneriUnatoMemory3.screenCountHigh = kabaneriUnato.screenCountHigh
        kabaneriUnatoMemory3.screenCountOver6 = kabaneriUnato.screenCountOver6
        kabaneriUnatoMemory3.screenCountSum = kabaneriUnato.screenCountSum
        kabaneriUnatoMemory3.omikujiCount1 = kabaneriUnato.omikujiCount1
        kabaneriUnatoMemory3.omikujiCount2 = kabaneriUnato.omikujiCount2
        kabaneriUnatoMemory3.omikujiCount3 = kabaneriUnato.omikujiCount3
        kabaneriUnatoMemory3.omikujiCount4 = kabaneriUnato.omikujiCount4
        kabaneriUnatoMemory3.omikujiCount5 = kabaneriUnato.omikujiCount5
        kabaneriUnatoMemory3.omikujiCount6 = kabaneriUnato.omikujiCount6
        kabaneriUnatoMemory3.omikujiCountOver2 = kabaneriUnato.omikujiCountOver2
        kabaneriUnatoMemory3.omikujiCountOver4 = kabaneriUnato.omikujiCountOver4
        kabaneriUnatoMemory3.omikujiCountOver6 = kabaneriUnato.omikujiCountOver6
        kabaneriUnatoMemory3.omikujiCountSum = kabaneriUnato.omikujiCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct kabaneriUnatoSubViewLoadMemory: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @ObservedObject var kabaneriUnatoMemory1: KabaneriUnatoMemory1
    @ObservedObject var kabaneriUnatoMemory2: KabaneriUnatoMemory2
    @ObservedObject var kabaneriUnatoMemory3: KabaneriUnatoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: kabaneriUnato.machineName,
            selectedMemory: $kabaneriUnato.selectedMemory,
            memoMemory1: kabaneriUnatoMemory1.memo,
            dateDoubleMemory1: kabaneriUnatoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kabaneriUnatoMemory2.memo,
            dateDoubleMemory2: kabaneriUnatoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kabaneriUnatoMemory3.memo,
            dateDoubleMemory3: kabaneriUnatoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        kabaneriUnato.flushCountMiss = kabaneriUnatoMemory1.flushCountMiss
        kabaneriUnato.flushCountHit = kabaneriUnatoMemory1.flushCountHit
        kabaneriUnato.flushCountSum = kabaneriUnatoMemory1.flushCountSum
        kabaneriUnato.voiceCount35Sisa = kabaneriUnatoMemory1.voiceCount35Sisa
        kabaneriUnato.voiceCountGusu = kabaneriUnatoMemory1.voiceCountGusu
        kabaneriUnato.voiceCountHighJaku = kabaneriUnatoMemory1.voiceCountHighJaku
        kabaneriUnato.voiceCountHighChu = kabaneriUnatoMemory1.voiceCountHighChu
        kabaneriUnato.voiceCountHighKyo = kabaneriUnatoMemory1.voiceCountHighKyo
        kabaneriUnato.voiceCountOver2 = kabaneriUnatoMemory1.voiceCountOver2
        kabaneriUnato.voiceCountOver5 = kabaneriUnatoMemory1.voiceCountOver5
        kabaneriUnato.voiceCountSum = kabaneriUnatoMemory1.voiceCountSum
        kabaneriUnato.voiceCountHighSum = kabaneriUnatoMemory1.voiceCountHighSum
        kabaneriUnato.charaCount35Sisa = kabaneriUnatoMemory1.charaCount35Sisa
        kabaneriUnato.charaCountGusu = kabaneriUnatoMemory1.charaCountGusu
        kabaneriUnato.charaCountOver4 = kabaneriUnatoMemory1.charaCountOver4
        kabaneriUnato.charaCountSum = kabaneriUnatoMemory1.charaCountSum
        kabaneriUnato.screenCountDefault = kabaneriUnatoMemory1.screenCountDefault
        kabaneriUnato.screenCountHigh = kabaneriUnatoMemory1.screenCountHigh
        kabaneriUnato.screenCountOver6 = kabaneriUnatoMemory1.screenCountOver6
        kabaneriUnato.screenCountSum = kabaneriUnatoMemory1.screenCountSum
        kabaneriUnato.omikujiCount1 = kabaneriUnatoMemory1.omikujiCount1
        kabaneriUnato.omikujiCount2 = kabaneriUnatoMemory1.omikujiCount2
        kabaneriUnato.omikujiCount3 = kabaneriUnatoMemory1.omikujiCount3
        kabaneriUnato.omikujiCount4 = kabaneriUnatoMemory1.omikujiCount4
        kabaneriUnato.omikujiCount5 = kabaneriUnatoMemory1.omikujiCount5
        kabaneriUnato.omikujiCount6 = kabaneriUnatoMemory1.omikujiCount6
        kabaneriUnato.omikujiCountOver2 = kabaneriUnatoMemory1.omikujiCountOver2
        kabaneriUnato.omikujiCountOver4 = kabaneriUnatoMemory1.omikujiCountOver4
        kabaneriUnato.omikujiCountOver6 = kabaneriUnatoMemory1.omikujiCountOver6
        kabaneriUnato.omikujiCountSum = kabaneriUnatoMemory1.omikujiCountSum
    }
    func loadMemory2() {
        kabaneriUnato.flushCountMiss = kabaneriUnatoMemory2.flushCountMiss
        kabaneriUnato.flushCountHit = kabaneriUnatoMemory2.flushCountHit
        kabaneriUnato.flushCountSum = kabaneriUnatoMemory2.flushCountSum
        kabaneriUnato.voiceCount35Sisa = kabaneriUnatoMemory2.voiceCount35Sisa
        kabaneriUnato.voiceCountGusu = kabaneriUnatoMemory2.voiceCountGusu
        kabaneriUnato.voiceCountHighJaku = kabaneriUnatoMemory2.voiceCountHighJaku
        kabaneriUnato.voiceCountHighChu = kabaneriUnatoMemory2.voiceCountHighChu
        kabaneriUnato.voiceCountHighKyo = kabaneriUnatoMemory2.voiceCountHighKyo
        kabaneriUnato.voiceCountOver2 = kabaneriUnatoMemory2.voiceCountOver2
        kabaneriUnato.voiceCountOver5 = kabaneriUnatoMemory2.voiceCountOver5
        kabaneriUnato.voiceCountSum = kabaneriUnatoMemory2.voiceCountSum
        kabaneriUnato.voiceCountHighSum = kabaneriUnatoMemory2.voiceCountHighSum
        kabaneriUnato.charaCount35Sisa = kabaneriUnatoMemory2.charaCount35Sisa
        kabaneriUnato.charaCountGusu = kabaneriUnatoMemory2.charaCountGusu
        kabaneriUnato.charaCountOver4 = kabaneriUnatoMemory2.charaCountOver4
        kabaneriUnato.charaCountSum = kabaneriUnatoMemory2.charaCountSum
        kabaneriUnato.screenCountDefault = kabaneriUnatoMemory2.screenCountDefault
        kabaneriUnato.screenCountHigh = kabaneriUnatoMemory2.screenCountHigh
        kabaneriUnato.screenCountOver6 = kabaneriUnatoMemory2.screenCountOver6
        kabaneriUnato.screenCountSum = kabaneriUnatoMemory2.screenCountSum
        kabaneriUnato.omikujiCount1 = kabaneriUnatoMemory2.omikujiCount1
        kabaneriUnato.omikujiCount2 = kabaneriUnatoMemory2.omikujiCount2
        kabaneriUnato.omikujiCount3 = kabaneriUnatoMemory2.omikujiCount3
        kabaneriUnato.omikujiCount4 = kabaneriUnatoMemory2.omikujiCount4
        kabaneriUnato.omikujiCount5 = kabaneriUnatoMemory2.omikujiCount5
        kabaneriUnato.omikujiCount6 = kabaneriUnatoMemory2.omikujiCount6
        kabaneriUnato.omikujiCountOver2 = kabaneriUnatoMemory2.omikujiCountOver2
        kabaneriUnato.omikujiCountOver4 = kabaneriUnatoMemory2.omikujiCountOver4
        kabaneriUnato.omikujiCountOver6 = kabaneriUnatoMemory2.omikujiCountOver6
        kabaneriUnato.omikujiCountSum = kabaneriUnatoMemory2.omikujiCountSum
    }
    func loadMemory3() {
        kabaneriUnato.flushCountMiss = kabaneriUnatoMemory3.flushCountMiss
        kabaneriUnato.flushCountHit = kabaneriUnatoMemory3.flushCountHit
        kabaneriUnato.flushCountSum = kabaneriUnatoMemory3.flushCountSum
        kabaneriUnato.voiceCount35Sisa = kabaneriUnatoMemory3.voiceCount35Sisa
        kabaneriUnato.voiceCountGusu = kabaneriUnatoMemory3.voiceCountGusu
        kabaneriUnato.voiceCountHighJaku = kabaneriUnatoMemory3.voiceCountHighJaku
        kabaneriUnato.voiceCountHighChu = kabaneriUnatoMemory3.voiceCountHighChu
        kabaneriUnato.voiceCountHighKyo = kabaneriUnatoMemory3.voiceCountHighKyo
        kabaneriUnato.voiceCountOver2 = kabaneriUnatoMemory3.voiceCountOver2
        kabaneriUnato.voiceCountOver5 = kabaneriUnatoMemory3.voiceCountOver5
        kabaneriUnato.voiceCountSum = kabaneriUnatoMemory3.voiceCountSum
        kabaneriUnato.voiceCountHighSum = kabaneriUnatoMemory3.voiceCountHighSum
        kabaneriUnato.charaCount35Sisa = kabaneriUnatoMemory3.charaCount35Sisa
        kabaneriUnato.charaCountGusu = kabaneriUnatoMemory3.charaCountGusu
        kabaneriUnato.charaCountOver4 = kabaneriUnatoMemory3.charaCountOver4
        kabaneriUnato.charaCountSum = kabaneriUnatoMemory3.charaCountSum
        kabaneriUnato.screenCountDefault = kabaneriUnatoMemory3.screenCountDefault
        kabaneriUnato.screenCountHigh = kabaneriUnatoMemory3.screenCountHigh
        kabaneriUnato.screenCountOver6 = kabaneriUnatoMemory3.screenCountOver6
        kabaneriUnato.screenCountSum = kabaneriUnatoMemory3.screenCountSum
        kabaneriUnato.omikujiCount1 = kabaneriUnatoMemory3.omikujiCount1
        kabaneriUnato.omikujiCount2 = kabaneriUnatoMemory3.omikujiCount2
        kabaneriUnato.omikujiCount3 = kabaneriUnatoMemory3.omikujiCount3
        kabaneriUnato.omikujiCount4 = kabaneriUnatoMemory3.omikujiCount4
        kabaneriUnato.omikujiCount5 = kabaneriUnatoMemory3.omikujiCount5
        kabaneriUnato.omikujiCount6 = kabaneriUnatoMemory3.omikujiCount6
        kabaneriUnato.omikujiCountOver2 = kabaneriUnatoMemory3.omikujiCountOver2
        kabaneriUnato.omikujiCountOver4 = kabaneriUnatoMemory3.omikujiCountOver4
        kabaneriUnato.omikujiCountOver6 = kabaneriUnatoMemory3.omikujiCountOver6
        kabaneriUnato.omikujiCountSum = kabaneriUnatoMemory3.omikujiCountSum
    }
}

#Preview {
    kabaneriUnatoViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
