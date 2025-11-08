//
//  newOni3ViewTop.swift
//  SetteiSaCountApp
//
//  newOni3ted by 横田徹 on 2025/10/05.
//

import SwiftUI

struct newOni3ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var newOni3 = NewOni3()
    @State var isShowAlert: Bool = false
    @StateObject var newOni3Memory1 = NewOni3Memory1()
    @StateObject var newOni3Memory2 = NewOni3Memory2()
    @StateObject var newOni3Memory3 = NewOni3Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                // //// メニュー
                Section {
                    // 通常時
                    NavigationLink(destination: newOni3ViewNormal(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: newOni3ViewFirstHit(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // 蒼剣ボーナス
                    NavigationLink(destination: newOni3ViewBonus(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "蒼剣ボーナス",
                            badgeStatus: common.newOni3MenuBonusBadge,
                        )
                    }
                    // 鬼ボーナス
                    NavigationLink(destination: newOni3ViewOniBonus(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "鬼ボーナス"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: newOni3ViewScreen(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: newOni3ViewEnding(
                        newOni3: newOni3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: newOni3.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: newOni3View95Ci(
                    newOni3: newOni3,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: newOni3ViewBayes(
                    newOni3: newOni3,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4880")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎CAPCOM")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.newOni3MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(newOni3SubViewLoadMemory(
                    newOni3: newOni3,
                    newOni3Memory1: newOni3Memory1,
                    newOni3Memory2: newOni3Memory2,
                    newOni3Memory3: newOni3Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(newOni3SubViewSaveMemory(
                    newOni3: newOni3,
                    newOni3Memory1: newOni3Memory1,
                    newOni3Memory2: newOni3Memory2,
                    newOni3Memory3: newOni3Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: newOni3.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct newOni3SubViewSaveMemory: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var newOni3Memory1: NewOni3Memory1
    @ObservedObject var newOni3Memory2: NewOni3Memory2
    @ObservedObject var newOni3Memory3: NewOni3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: newOni3.machineName,
            selectedMemory: $newOni3.selectedMemory,
            memoMemory1: $newOni3Memory1.memo,
            dateDoubleMemory1: $newOni3Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $newOni3Memory2.memo,
            dateDoubleMemory2: $newOni3Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $newOni3Memory3.memo,
            dateDoubleMemory3: $newOni3Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        newOni3Memory1.kokakuCountJakuCherry = newOni3.kokakuCountJakuCherry
        newOni3Memory1.kokakuCountJakuSuika = newOni3.kokakuCountJakuSuika
        newOni3Memory1.kokakuCountJakuSum = newOni3.kokakuCountJakuSum
        newOni3Memory1.kokakuCountIkou = newOni3.kokakuCountIkou
        newOni3Memory1.normalGame = newOni3.normalGame
        newOni3Memory1.firstHitCountAt = newOni3.firstHitCountAt
        newOni3Memory1.screenCountDefault = newOni3.screenCountDefault
        newOni3Memory1.screenCountKisu = newOni3.screenCountKisu
        newOni3Memory1.screenCountGusu = newOni3.screenCountGusu
        newOni3Memory1.screenCountHigh = newOni3.screenCountHigh
        newOni3Memory1.screenCountOver2 = newOni3.screenCountOver2
        newOni3Memory1.screenCountOver3 = newOni3.screenCountOver3
        newOni3Memory1.screenCountOver4 = newOni3.screenCountOver4
        newOni3Memory1.screenCountOver5 = newOni3.screenCountOver5
        newOni3Memory1.screenCountOver6 = newOni3.screenCountOver6
        newOni3Memory1.screenCountSum = newOni3.screenCountSum
        newOni3Memory1.personSenarioCountMikata = newOni3.personSenarioCountMikata
        newOni3Memory1.personSenarioCountTeki = newOni3.personSenarioCountTeki
        newOni3Memory1.personSenarioCountSum = newOni3.personSenarioCountSum
        newOni3Memory1.personFinalCountDefault = newOni3.personFinalCountDefault
        newOni3Memory1.personFinalCountHigh = newOni3.personFinalCountHigh
        newOni3Memory1.personFinalCountOver2 = newOni3.personFinalCountOver2
        newOni3Memory1.personFinalCountOver3 = newOni3.personFinalCountOver3
        newOni3Memory1.personFinalCountOver4 = newOni3.personFinalCountOver4
        newOni3Memory1.personFinalCountOver5 = newOni3.personFinalCountOver5
        newOni3Memory1.personFinalCountOver6 = newOni3.personFinalCountOver6
        newOni3Memory1.personFinalCountSum = newOni3.personFinalCountSum
        newOni3Memory1.endingCountDefault = newOni3.endingCountDefault
        newOni3Memory1.endingCountKisuJaku = newOni3.endingCountKisuJaku
        newOni3Memory1.endingCountGusuJaku = newOni3.endingCountGusuJaku
        newOni3Memory1.endingCountKisuKyo = newOni3.endingCountKisuKyo
        newOni3Memory1.endingCountGusuKyo = newOni3.endingCountGusuKyo
        newOni3Memory1.endingCountNegate2 = newOni3.endingCountNegate2
        newOni3Memory1.endingCountNegate3 = newOni3.endingCountNegate3
        newOni3Memory1.endingCountNegate4 = newOni3.endingCountNegate4
        newOni3Memory1.endingCountOver2 = newOni3.endingCountOver2
        newOni3Memory1.endingCountOver3 = newOni3.endingCountOver3
        newOni3Memory1.endingCountOver4 = newOni3.endingCountOver4
        newOni3Memory1.endingCountOver5 = newOni3.endingCountOver5
        newOni3Memory1.endingCountOver6 = newOni3.endingCountOver6
        newOni3Memory1.endingCountSum = newOni3.endingCountSum
    }
    func saveMemory2() {
        newOni3Memory2.kokakuCountJakuCherry = newOni3.kokakuCountJakuCherry
        newOni3Memory2.kokakuCountJakuSuika = newOni3.kokakuCountJakuSuika
        newOni3Memory2.kokakuCountJakuSum = newOni3.kokakuCountJakuSum
        newOni3Memory2.kokakuCountIkou = newOni3.kokakuCountIkou
        newOni3Memory2.normalGame = newOni3.normalGame
        newOni3Memory2.firstHitCountAt = newOni3.firstHitCountAt
        newOni3Memory2.screenCountDefault = newOni3.screenCountDefault
        newOni3Memory2.screenCountKisu = newOni3.screenCountKisu
        newOni3Memory2.screenCountGusu = newOni3.screenCountGusu
        newOni3Memory2.screenCountHigh = newOni3.screenCountHigh
        newOni3Memory2.screenCountOver2 = newOni3.screenCountOver2
        newOni3Memory2.screenCountOver3 = newOni3.screenCountOver3
        newOni3Memory2.screenCountOver4 = newOni3.screenCountOver4
        newOni3Memory2.screenCountOver5 = newOni3.screenCountOver5
        newOni3Memory2.screenCountOver6 = newOni3.screenCountOver6
        newOni3Memory2.screenCountSum = newOni3.screenCountSum
        newOni3Memory2.personSenarioCountMikata = newOni3.personSenarioCountMikata
        newOni3Memory2.personSenarioCountTeki = newOni3.personSenarioCountTeki
        newOni3Memory2.personSenarioCountSum = newOni3.personSenarioCountSum
        newOni3Memory2.personFinalCountDefault = newOni3.personFinalCountDefault
        newOni3Memory2.personFinalCountHigh = newOni3.personFinalCountHigh
        newOni3Memory2.personFinalCountOver2 = newOni3.personFinalCountOver2
        newOni3Memory2.personFinalCountOver3 = newOni3.personFinalCountOver3
        newOni3Memory2.personFinalCountOver4 = newOni3.personFinalCountOver4
        newOni3Memory2.personFinalCountOver5 = newOni3.personFinalCountOver5
        newOni3Memory2.personFinalCountOver6 = newOni3.personFinalCountOver6
        newOni3Memory2.personFinalCountSum = newOni3.personFinalCountSum
        newOni3Memory2.endingCountDefault = newOni3.endingCountDefault
        newOni3Memory2.endingCountKisuJaku = newOni3.endingCountKisuJaku
        newOni3Memory2.endingCountGusuJaku = newOni3.endingCountGusuJaku
        newOni3Memory2.endingCountKisuKyo = newOni3.endingCountKisuKyo
        newOni3Memory2.endingCountGusuKyo = newOni3.endingCountGusuKyo
        newOni3Memory2.endingCountNegate2 = newOni3.endingCountNegate2
        newOni3Memory2.endingCountNegate3 = newOni3.endingCountNegate3
        newOni3Memory2.endingCountNegate4 = newOni3.endingCountNegate4
        newOni3Memory2.endingCountOver2 = newOni3.endingCountOver2
        newOni3Memory2.endingCountOver3 = newOni3.endingCountOver3
        newOni3Memory2.endingCountOver4 = newOni3.endingCountOver4
        newOni3Memory2.endingCountOver5 = newOni3.endingCountOver5
        newOni3Memory2.endingCountOver6 = newOni3.endingCountOver6
        newOni3Memory2.endingCountSum = newOni3.endingCountSum
    }
    func saveMemory3() {
        newOni3Memory3.kokakuCountJakuCherry = newOni3.kokakuCountJakuCherry
        newOni3Memory3.kokakuCountJakuSuika = newOni3.kokakuCountJakuSuika
        newOni3Memory3.kokakuCountJakuSum = newOni3.kokakuCountJakuSum
        newOni3Memory3.kokakuCountIkou = newOni3.kokakuCountIkou
        newOni3Memory3.normalGame = newOni3.normalGame
        newOni3Memory3.firstHitCountAt = newOni3.firstHitCountAt
        newOni3Memory3.screenCountDefault = newOni3.screenCountDefault
        newOni3Memory3.screenCountKisu = newOni3.screenCountKisu
        newOni3Memory3.screenCountGusu = newOni3.screenCountGusu
        newOni3Memory3.screenCountHigh = newOni3.screenCountHigh
        newOni3Memory3.screenCountOver2 = newOni3.screenCountOver2
        newOni3Memory3.screenCountOver3 = newOni3.screenCountOver3
        newOni3Memory3.screenCountOver4 = newOni3.screenCountOver4
        newOni3Memory3.screenCountOver5 = newOni3.screenCountOver5
        newOni3Memory3.screenCountOver6 = newOni3.screenCountOver6
        newOni3Memory3.screenCountSum = newOni3.screenCountSum
        newOni3Memory3.personSenarioCountMikata = newOni3.personSenarioCountMikata
        newOni3Memory3.personSenarioCountTeki = newOni3.personSenarioCountTeki
        newOni3Memory3.personSenarioCountSum = newOni3.personSenarioCountSum
        newOni3Memory3.personFinalCountDefault = newOni3.personFinalCountDefault
        newOni3Memory3.personFinalCountHigh = newOni3.personFinalCountHigh
        newOni3Memory3.personFinalCountOver2 = newOni3.personFinalCountOver2
        newOni3Memory3.personFinalCountOver3 = newOni3.personFinalCountOver3
        newOni3Memory3.personFinalCountOver4 = newOni3.personFinalCountOver4
        newOni3Memory3.personFinalCountOver5 = newOni3.personFinalCountOver5
        newOni3Memory3.personFinalCountOver6 = newOni3.personFinalCountOver6
        newOni3Memory3.personFinalCountSum = newOni3.personFinalCountSum
        newOni3Memory3.endingCountDefault = newOni3.endingCountDefault
        newOni3Memory3.endingCountKisuJaku = newOni3.endingCountKisuJaku
        newOni3Memory3.endingCountGusuJaku = newOni3.endingCountGusuJaku
        newOni3Memory3.endingCountKisuKyo = newOni3.endingCountKisuKyo
        newOni3Memory3.endingCountGusuKyo = newOni3.endingCountGusuKyo
        newOni3Memory3.endingCountNegate2 = newOni3.endingCountNegate2
        newOni3Memory3.endingCountNegate3 = newOni3.endingCountNegate3
        newOni3Memory3.endingCountNegate4 = newOni3.endingCountNegate4
        newOni3Memory3.endingCountOver2 = newOni3.endingCountOver2
        newOni3Memory3.endingCountOver3 = newOni3.endingCountOver3
        newOni3Memory3.endingCountOver4 = newOni3.endingCountOver4
        newOni3Memory3.endingCountOver5 = newOni3.endingCountOver5
        newOni3Memory3.endingCountOver6 = newOni3.endingCountOver6
        newOni3Memory3.endingCountSum = newOni3.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct newOni3SubViewLoadMemory: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var newOni3Memory1: NewOni3Memory1
    @ObservedObject var newOni3Memory2: NewOni3Memory2
    @ObservedObject var newOni3Memory3: NewOni3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: newOni3.machineName,
            selectedMemory: $newOni3.selectedMemory,
            memoMemory1: newOni3Memory1.memo,
            dateDoubleMemory1: newOni3Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: newOni3Memory2.memo,
            dateDoubleMemory2: newOni3Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: newOni3Memory3.memo,
            dateDoubleMemory3: newOni3Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        newOni3.kokakuCountJakuCherry = newOni3Memory1.kokakuCountJakuCherry
        newOni3.kokakuCountJakuSuika = newOni3Memory1.kokakuCountJakuSuika
        newOni3.kokakuCountJakuSum = newOni3Memory1.kokakuCountJakuSum
        newOni3.kokakuCountIkou = newOni3Memory1.kokakuCountIkou
        newOni3.normalGame = newOni3Memory1.normalGame
        newOni3.firstHitCountAt = newOni3Memory1.firstHitCountAt
        newOni3.screenCountDefault = newOni3Memory1.screenCountDefault
        newOni3.screenCountKisu = newOni3Memory1.screenCountKisu
        newOni3.screenCountGusu = newOni3Memory1.screenCountGusu
        newOni3.screenCountHigh = newOni3Memory1.screenCountHigh
        newOni3.screenCountOver2 = newOni3Memory1.screenCountOver2
        newOni3.screenCountOver3 = newOni3Memory1.screenCountOver3
        newOni3.screenCountOver4 = newOni3Memory1.screenCountOver4
        newOni3.screenCountOver5 = newOni3Memory1.screenCountOver5
        newOni3.screenCountOver6 = newOni3Memory1.screenCountOver6
        newOni3.screenCountSum = newOni3Memory1.screenCountSum
        newOni3.personSenarioCountMikata = newOni3Memory1.personSenarioCountMikata
        newOni3.personSenarioCountTeki = newOni3Memory1.personSenarioCountTeki
        newOni3.personSenarioCountSum = newOni3Memory1.personSenarioCountSum
        newOni3.personFinalCountDefault = newOni3Memory1.personFinalCountDefault
        newOni3.personFinalCountHigh = newOni3Memory1.personFinalCountHigh
        newOni3.personFinalCountOver2 = newOni3Memory1.personFinalCountOver2
        newOni3.personFinalCountOver3 = newOni3Memory1.personFinalCountOver3
        newOni3.personFinalCountOver4 = newOni3Memory1.personFinalCountOver4
        newOni3.personFinalCountOver5 = newOni3Memory1.personFinalCountOver5
        newOni3.personFinalCountOver6 = newOni3Memory1.personFinalCountOver6
        newOni3.personFinalCountSum = newOni3Memory1.personFinalCountSum
        newOni3.endingCountDefault = newOni3Memory1.endingCountDefault
        newOni3.endingCountKisuJaku = newOni3Memory1.endingCountKisuJaku
        newOni3.endingCountGusuJaku = newOni3Memory1.endingCountGusuJaku
        newOni3.endingCountKisuKyo = newOni3Memory1.endingCountKisuKyo
        newOni3.endingCountGusuKyo = newOni3Memory1.endingCountGusuKyo
        newOni3.endingCountNegate2 = newOni3Memory1.endingCountNegate2
        newOni3.endingCountNegate3 = newOni3Memory1.endingCountNegate3
        newOni3.endingCountNegate4 = newOni3Memory1.endingCountNegate4
        newOni3.endingCountOver2 = newOni3Memory1.endingCountOver2
        newOni3.endingCountOver3 = newOni3Memory1.endingCountOver3
        newOni3.endingCountOver4 = newOni3Memory1.endingCountOver4
        newOni3.endingCountOver5 = newOni3Memory1.endingCountOver5
        newOni3.endingCountOver6 = newOni3Memory1.endingCountOver6
        newOni3.endingCountSum = newOni3Memory1.endingCountSum
    }
    func loadMemory2() {
        newOni3.kokakuCountJakuCherry = newOni3Memory2.kokakuCountJakuCherry
        newOni3.kokakuCountJakuSuika = newOni3Memory2.kokakuCountJakuSuika
        newOni3.kokakuCountJakuSum = newOni3Memory2.kokakuCountJakuSum
        newOni3.kokakuCountIkou = newOni3Memory2.kokakuCountIkou
        newOni3.normalGame = newOni3Memory2.normalGame
        newOni3.firstHitCountAt = newOni3Memory2.firstHitCountAt
        newOni3.screenCountDefault = newOni3Memory2.screenCountDefault
        newOni3.screenCountKisu = newOni3Memory2.screenCountKisu
        newOni3.screenCountGusu = newOni3Memory2.screenCountGusu
        newOni3.screenCountHigh = newOni3Memory2.screenCountHigh
        newOni3.screenCountOver2 = newOni3Memory2.screenCountOver2
        newOni3.screenCountOver3 = newOni3Memory2.screenCountOver3
        newOni3.screenCountOver4 = newOni3Memory2.screenCountOver4
        newOni3.screenCountOver5 = newOni3Memory2.screenCountOver5
        newOni3.screenCountOver6 = newOni3Memory2.screenCountOver6
        newOni3.screenCountSum = newOni3Memory2.screenCountSum
        newOni3.personSenarioCountMikata = newOni3Memory2.personSenarioCountMikata
        newOni3.personSenarioCountTeki = newOni3Memory2.personSenarioCountTeki
        newOni3.personSenarioCountSum = newOni3Memory2.personSenarioCountSum
        newOni3.personFinalCountDefault = newOni3Memory2.personFinalCountDefault
        newOni3.personFinalCountHigh = newOni3Memory2.personFinalCountHigh
        newOni3.personFinalCountOver2 = newOni3Memory2.personFinalCountOver2
        newOni3.personFinalCountOver3 = newOni3Memory2.personFinalCountOver3
        newOni3.personFinalCountOver4 = newOni3Memory2.personFinalCountOver4
        newOni3.personFinalCountOver5 = newOni3Memory2.personFinalCountOver5
        newOni3.personFinalCountOver6 = newOni3Memory2.personFinalCountOver6
        newOni3.personFinalCountSum = newOni3Memory2.personFinalCountSum
        newOni3.endingCountDefault = newOni3Memory2.endingCountDefault
        newOni3.endingCountKisuJaku = newOni3Memory2.endingCountKisuJaku
        newOni3.endingCountGusuJaku = newOni3Memory2.endingCountGusuJaku
        newOni3.endingCountKisuKyo = newOni3Memory2.endingCountKisuKyo
        newOni3.endingCountGusuKyo = newOni3Memory2.endingCountGusuKyo
        newOni3.endingCountNegate2 = newOni3Memory2.endingCountNegate2
        newOni3.endingCountNegate3 = newOni3Memory2.endingCountNegate3
        newOni3.endingCountNegate4 = newOni3Memory2.endingCountNegate4
        newOni3.endingCountOver2 = newOni3Memory2.endingCountOver2
        newOni3.endingCountOver3 = newOni3Memory2.endingCountOver3
        newOni3.endingCountOver4 = newOni3Memory2.endingCountOver4
        newOni3.endingCountOver5 = newOni3Memory2.endingCountOver5
        newOni3.endingCountOver6 = newOni3Memory2.endingCountOver6
        newOni3.endingCountSum = newOni3Memory2.endingCountSum
    }
    func loadMemory3() {
        newOni3.kokakuCountJakuCherry = newOni3Memory3.kokakuCountJakuCherry
        newOni3.kokakuCountJakuSuika = newOni3Memory3.kokakuCountJakuSuika
        newOni3.kokakuCountJakuSum = newOni3Memory3.kokakuCountJakuSum
        newOni3.kokakuCountIkou = newOni3Memory3.kokakuCountIkou
        newOni3.normalGame = newOni3Memory3.normalGame
        newOni3.firstHitCountAt = newOni3Memory3.firstHitCountAt
        newOni3.screenCountDefault = newOni3Memory3.screenCountDefault
        newOni3.screenCountKisu = newOni3Memory3.screenCountKisu
        newOni3.screenCountGusu = newOni3Memory3.screenCountGusu
        newOni3.screenCountHigh = newOni3Memory3.screenCountHigh
        newOni3.screenCountOver2 = newOni3Memory3.screenCountOver2
        newOni3.screenCountOver3 = newOni3Memory3.screenCountOver3
        newOni3.screenCountOver4 = newOni3Memory3.screenCountOver4
        newOni3.screenCountOver5 = newOni3Memory3.screenCountOver5
        newOni3.screenCountOver6 = newOni3Memory3.screenCountOver6
        newOni3.screenCountSum = newOni3Memory3.screenCountSum
        newOni3.personSenarioCountMikata = newOni3Memory3.personSenarioCountMikata
        newOni3.personSenarioCountTeki = newOni3Memory3.personSenarioCountTeki
        newOni3.personSenarioCountSum = newOni3Memory3.personSenarioCountSum
        newOni3.personFinalCountDefault = newOni3Memory3.personFinalCountDefault
        newOni3.personFinalCountHigh = newOni3Memory3.personFinalCountHigh
        newOni3.personFinalCountOver2 = newOni3Memory3.personFinalCountOver2
        newOni3.personFinalCountOver3 = newOni3Memory3.personFinalCountOver3
        newOni3.personFinalCountOver4 = newOni3Memory3.personFinalCountOver4
        newOni3.personFinalCountOver5 = newOni3Memory3.personFinalCountOver5
        newOni3.personFinalCountOver6 = newOni3Memory3.personFinalCountOver6
        newOni3.personFinalCountSum = newOni3Memory3.personFinalCountSum
        newOni3.endingCountDefault = newOni3Memory3.endingCountDefault
        newOni3.endingCountKisuJaku = newOni3Memory3.endingCountKisuJaku
        newOni3.endingCountGusuJaku = newOni3Memory3.endingCountGusuJaku
        newOni3.endingCountKisuKyo = newOni3Memory3.endingCountKisuKyo
        newOni3.endingCountGusuKyo = newOni3Memory3.endingCountGusuKyo
        newOni3.endingCountNegate2 = newOni3Memory3.endingCountNegate2
        newOni3.endingCountNegate3 = newOni3Memory3.endingCountNegate3
        newOni3.endingCountNegate4 = newOni3Memory3.endingCountNegate4
        newOni3.endingCountOver2 = newOni3Memory3.endingCountOver2
        newOni3.endingCountOver3 = newOni3Memory3.endingCountOver3
        newOni3.endingCountOver4 = newOni3Memory3.endingCountOver4
        newOni3.endingCountOver5 = newOni3Memory3.endingCountOver5
        newOni3.endingCountOver6 = newOni3Memory3.endingCountOver6
        newOni3.endingCountSum = newOni3Memory3.endingCountSum
    }
}


#Preview {
    newOni3ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
