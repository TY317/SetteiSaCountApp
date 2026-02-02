//
//  kokakukidotaiViewtop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct kokakukidotaiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var kokakukidotai = Kokakukidotai()
    @State var isShowAlert: Bool = false
    @StateObject var kokakukidotaiMemory1 = KokakukidotaiMemory1()
    @StateObject var kokakukidotaiMemory2 = KokakukidotaiMemory2()
    @StateObject var kokakukidotaiMemory3 = KokakukidotaiMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: kokakukidotai.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: kokakukidotaiViewNormal(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kokakukidotaiMenuNormalBadge,
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: kokakukidotaiViewCz(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.kokakukidotaiMenuCzBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: kokakukidotaiViewFirstHit(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kokakukidotaiMenuFirstHitBadge,
                        )
                    }
                    
                    // 示唆ウィンドウ
                    NavigationLink(destination: kokakukidotaiViewScreen(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "示唆ウィンドウ",
                            badgeStatus: common.kokakukidotaiMenuScreenBadge,
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: kokakukidotaiViewAt(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "AT中",
                            badgeStatus: common.kokakukidotaiMenuAtBadge,
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
                NavigationLink(destination: kokakukidotaiView95Ci(
                    kokakukidotai: kokakukidotai,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: kokakukidotaiViewBayes(
                    kokakukidotai: kokakukidotai,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.kokakukidotaiMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4931")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎士郎正宗・Production I.G／講談社・攻殻機動隊製作委員会")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(kokakukidotaiSubViewLoadMemory(
                    kokakukidotai: kokakukidotai,
                    kokakukidotaiMemory1: kokakukidotaiMemory1,
                    kokakukidotaiMemory2: kokakukidotaiMemory2,
                    kokakukidotaiMemory3: kokakukidotaiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(kokakukidotaiSubViewSaveMemory(
                    kokakukidotai: kokakukidotai,
                    kokakukidotaiMemory1: kokakukidotaiMemory1,
                    kokakukidotaiMemory2: kokakukidotaiMemory2,
                    kokakukidotaiMemory3: kokakukidotaiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kokakukidotai.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kokakukidotaiSubViewSaveMemory: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var kokakukidotaiMemory1: KokakukidotaiMemory1
    @ObservedObject var kokakukidotaiMemory2: KokakukidotaiMemory2
    @ObservedObject var kokakukidotaiMemory3: KokakukidotaiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: kokakukidotai.machineName,
            selectedMemory: $kokakukidotai.selectedMemory,
            memoMemory1: $kokakukidotaiMemory1.memo,
            dateDoubleMemory1: $kokakukidotaiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kokakukidotaiMemory2.memo,
            dateDoubleMemory2: $kokakukidotaiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kokakukidotaiMemory3.memo,
            dateDoubleMemory3: $kokakukidotaiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kokakukidotaiMemory1.iedeCountMiss = kokakukidotai.iedeCountMiss
        kokakukidotaiMemory1.iedeCountSuccess = kokakukidotai.iedeCountSuccess
        kokakukidotaiMemory1.iedeCountSum = kokakukidotai.iedeCountSum
        kokakukidotaiMemory1.normalGame = kokakukidotai.normalGame
        kokakukidotaiMemory1.firstHitCountAt = kokakukidotai.firstHitCountAt
        kokakukidotaiMemory1.firstHitCountCz = kokakukidotai.firstHitCountCz
        kokakukidotaiMemory1.screenCountDefault = kokakukidotai.screenCountDefault
        kokakukidotaiMemory1.screenCountHighJaku = kokakukidotai.screenCountHighJaku
        kokakukidotaiMemory1.screenCountKisu = kokakukidotai.screenCountKisu
        kokakukidotaiMemory1.screenCountGusu = kokakukidotai.screenCountGusu
        kokakukidotaiMemory1.screenCountHighMode = kokakukidotai.screenCountHighMode
        kokakukidotaiMemory1.screenCountOverB = kokakukidotai.screenCountOverB
        kokakukidotaiMemory1.screenCountOverC = kokakukidotai.screenCountOverC
        kokakukidotaiMemory1.screenCountOverCKyo = kokakukidotai.screenCountOverCKyo
        kokakukidotaiMemory1.screenCountOverD4 = kokakukidotai.screenCountOverD4
        kokakukidotaiMemory1.screenCountWhiteEdge = kokakukidotai.screenCountWhiteEdge
        kokakukidotaiMemory1.screenCountSum = kokakukidotai.screenCountSum
        kokakukidotaiMemory1.rebootCountMiss = kokakukidotai.rebootCountMiss
        kokakukidotaiMemory1.rebootCountSuccess = kokakukidotai.rebootCountSuccess
        kokakukidotaiMemory1.rebootCountSum = kokakukidotai.rebootCountSum
    }
    func saveMemory2() {
        kokakukidotaiMemory2.iedeCountMiss = kokakukidotai.iedeCountMiss
        kokakukidotaiMemory2.iedeCountSuccess = kokakukidotai.iedeCountSuccess
        kokakukidotaiMemory2.iedeCountSum = kokakukidotai.iedeCountSum
        kokakukidotaiMemory2.normalGame = kokakukidotai.normalGame
        kokakukidotaiMemory2.firstHitCountAt = kokakukidotai.firstHitCountAt
        kokakukidotaiMemory2.firstHitCountCz = kokakukidotai.firstHitCountCz
        kokakukidotaiMemory2.screenCountDefault = kokakukidotai.screenCountDefault
        kokakukidotaiMemory2.screenCountHighJaku = kokakukidotai.screenCountHighJaku
        kokakukidotaiMemory2.screenCountKisu = kokakukidotai.screenCountKisu
        kokakukidotaiMemory2.screenCountGusu = kokakukidotai.screenCountGusu
        kokakukidotaiMemory2.screenCountHighMode = kokakukidotai.screenCountHighMode
        kokakukidotaiMemory2.screenCountOverB = kokakukidotai.screenCountOverB
        kokakukidotaiMemory2.screenCountOverC = kokakukidotai.screenCountOverC
        kokakukidotaiMemory2.screenCountOverCKyo = kokakukidotai.screenCountOverCKyo
        kokakukidotaiMemory2.screenCountOverD4 = kokakukidotai.screenCountOverD4
        kokakukidotaiMemory2.screenCountWhiteEdge = kokakukidotai.screenCountWhiteEdge
        kokakukidotaiMemory2.screenCountSum = kokakukidotai.screenCountSum
        kokakukidotaiMemory2.rebootCountMiss = kokakukidotai.rebootCountMiss
        kokakukidotaiMemory2.rebootCountSuccess = kokakukidotai.rebootCountSuccess
        kokakukidotaiMemory2.rebootCountSum = kokakukidotai.rebootCountSum
    }
    func saveMemory3() {
        kokakukidotaiMemory3.iedeCountMiss = kokakukidotai.iedeCountMiss
        kokakukidotaiMemory3.iedeCountSuccess = kokakukidotai.iedeCountSuccess
        kokakukidotaiMemory3.iedeCountSum = kokakukidotai.iedeCountSum
        kokakukidotaiMemory3.normalGame = kokakukidotai.normalGame
        kokakukidotaiMemory3.firstHitCountAt = kokakukidotai.firstHitCountAt
        kokakukidotaiMemory3.firstHitCountCz = kokakukidotai.firstHitCountCz
        kokakukidotaiMemory3.screenCountDefault = kokakukidotai.screenCountDefault
        kokakukidotaiMemory3.screenCountHighJaku = kokakukidotai.screenCountHighJaku
        kokakukidotaiMemory3.screenCountKisu = kokakukidotai.screenCountKisu
        kokakukidotaiMemory3.screenCountGusu = kokakukidotai.screenCountGusu
        kokakukidotaiMemory3.screenCountHighMode = kokakukidotai.screenCountHighMode
        kokakukidotaiMemory3.screenCountOverB = kokakukidotai.screenCountOverB
        kokakukidotaiMemory3.screenCountOverC = kokakukidotai.screenCountOverC
        kokakukidotaiMemory3.screenCountOverCKyo = kokakukidotai.screenCountOverCKyo
        kokakukidotaiMemory3.screenCountOverD4 = kokakukidotai.screenCountOverD4
        kokakukidotaiMemory3.screenCountWhiteEdge = kokakukidotai.screenCountWhiteEdge
        kokakukidotaiMemory3.screenCountSum = kokakukidotai.screenCountSum
        kokakukidotaiMemory3.rebootCountMiss = kokakukidotai.rebootCountMiss
        kokakukidotaiMemory3.rebootCountSuccess = kokakukidotai.rebootCountSuccess
        kokakukidotaiMemory3.rebootCountSum = kokakukidotai.rebootCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct kokakukidotaiSubViewLoadMemory: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var kokakukidotaiMemory1: KokakukidotaiMemory1
    @ObservedObject var kokakukidotaiMemory2: KokakukidotaiMemory2
    @ObservedObject var kokakukidotaiMemory3: KokakukidotaiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: kokakukidotai.machineName,
            selectedMemory: $kokakukidotai.selectedMemory,
            memoMemory1: kokakukidotaiMemory1.memo,
            dateDoubleMemory1: kokakukidotaiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kokakukidotaiMemory2.memo,
            dateDoubleMemory2: kokakukidotaiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kokakukidotaiMemory3.memo,
            dateDoubleMemory3: kokakukidotaiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        kokakukidotai.iedeCountMiss = kokakukidotaiMemory1.iedeCountMiss
        kokakukidotai.iedeCountSuccess = kokakukidotaiMemory1.iedeCountSuccess
        kokakukidotai.iedeCountSum = kokakukidotaiMemory1.iedeCountSum
        kokakukidotai.normalGame = kokakukidotaiMemory1.normalGame
        kokakukidotai.firstHitCountAt = kokakukidotaiMemory1.firstHitCountAt
        kokakukidotai.firstHitCountCz = kokakukidotaiMemory1.firstHitCountCz
        kokakukidotai.screenCountDefault = kokakukidotaiMemory1.screenCountDefault
        kokakukidotai.screenCountHighJaku = kokakukidotaiMemory1.screenCountHighJaku
        kokakukidotai.screenCountKisu = kokakukidotaiMemory1.screenCountKisu
        kokakukidotai.screenCountGusu = kokakukidotaiMemory1.screenCountGusu
        kokakukidotai.screenCountHighMode = kokakukidotaiMemory1.screenCountHighMode
        kokakukidotai.screenCountOverB = kokakukidotaiMemory1.screenCountOverB
        kokakukidotai.screenCountOverC = kokakukidotaiMemory1.screenCountOverC
        kokakukidotai.screenCountOverCKyo = kokakukidotaiMemory1.screenCountOverCKyo
        kokakukidotai.screenCountOverD4 = kokakukidotaiMemory1.screenCountOverD4
        kokakukidotai.screenCountWhiteEdge = kokakukidotaiMemory1.screenCountWhiteEdge
        kokakukidotai.screenCountSum = kokakukidotaiMemory1.screenCountSum
        kokakukidotai.rebootCountMiss = kokakukidotaiMemory1.rebootCountMiss
        kokakukidotai.rebootCountSuccess = kokakukidotaiMemory1.rebootCountSuccess
        kokakukidotai.rebootCountSum = kokakukidotaiMemory1.rebootCountSum
    }
    func loadMemory2() {
        kokakukidotai.iedeCountMiss = kokakukidotaiMemory2.iedeCountMiss
        kokakukidotai.iedeCountSuccess = kokakukidotaiMemory2.iedeCountSuccess
        kokakukidotai.iedeCountSum = kokakukidotaiMemory2.iedeCountSum
        kokakukidotai.normalGame = kokakukidotaiMemory2.normalGame
        kokakukidotai.firstHitCountAt = kokakukidotaiMemory2.firstHitCountAt
        kokakukidotai.firstHitCountCz = kokakukidotaiMemory2.firstHitCountCz
        kokakukidotai.screenCountDefault = kokakukidotaiMemory2.screenCountDefault
        kokakukidotai.screenCountHighJaku = kokakukidotaiMemory2.screenCountHighJaku
        kokakukidotai.screenCountKisu = kokakukidotaiMemory2.screenCountKisu
        kokakukidotai.screenCountGusu = kokakukidotaiMemory2.screenCountGusu
        kokakukidotai.screenCountHighMode = kokakukidotaiMemory2.screenCountHighMode
        kokakukidotai.screenCountOverB = kokakukidotaiMemory2.screenCountOverB
        kokakukidotai.screenCountOverC = kokakukidotaiMemory2.screenCountOverC
        kokakukidotai.screenCountOverCKyo = kokakukidotaiMemory2.screenCountOverCKyo
        kokakukidotai.screenCountOverD4 = kokakukidotaiMemory2.screenCountOverD4
        kokakukidotai.screenCountWhiteEdge = kokakukidotaiMemory2.screenCountWhiteEdge
        kokakukidotai.screenCountSum = kokakukidotaiMemory2.screenCountSum
        kokakukidotai.rebootCountMiss = kokakukidotaiMemory2.rebootCountMiss
        kokakukidotai.rebootCountSuccess = kokakukidotaiMemory2.rebootCountSuccess
        kokakukidotai.rebootCountSum = kokakukidotaiMemory2.rebootCountSum
    }
    func loadMemory3() {
        kokakukidotai.iedeCountMiss = kokakukidotaiMemory3.iedeCountMiss
        kokakukidotai.iedeCountSuccess = kokakukidotaiMemory3.iedeCountSuccess
        kokakukidotai.iedeCountSum = kokakukidotaiMemory3.iedeCountSum
        kokakukidotai.normalGame = kokakukidotaiMemory3.normalGame
        kokakukidotai.firstHitCountAt = kokakukidotaiMemory3.firstHitCountAt
        kokakukidotai.firstHitCountCz = kokakukidotaiMemory3.firstHitCountCz
        kokakukidotai.screenCountDefault = kokakukidotaiMemory3.screenCountDefault
        kokakukidotai.screenCountHighJaku = kokakukidotaiMemory3.screenCountHighJaku
        kokakukidotai.screenCountKisu = kokakukidotaiMemory3.screenCountKisu
        kokakukidotai.screenCountGusu = kokakukidotaiMemory3.screenCountGusu
        kokakukidotai.screenCountHighMode = kokakukidotaiMemory3.screenCountHighMode
        kokakukidotai.screenCountOverB = kokakukidotaiMemory3.screenCountOverB
        kokakukidotai.screenCountOverC = kokakukidotaiMemory3.screenCountOverC
        kokakukidotai.screenCountOverCKyo = kokakukidotaiMemory3.screenCountOverCKyo
        kokakukidotai.screenCountOverD4 = kokakukidotaiMemory3.screenCountOverD4
        kokakukidotai.screenCountWhiteEdge = kokakukidotaiMemory3.screenCountWhiteEdge
        kokakukidotai.screenCountSum = kokakukidotaiMemory3.screenCountSum
        kokakukidotai.rebootCountMiss = kokakukidotaiMemory3.rebootCountMiss
        kokakukidotai.rebootCountSuccess = kokakukidotaiMemory3.rebootCountSuccess
        kokakukidotai.rebootCountSum = kokakukidotaiMemory3.rebootCountSum
    }
}

#Preview {
    kokakukidotaiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
