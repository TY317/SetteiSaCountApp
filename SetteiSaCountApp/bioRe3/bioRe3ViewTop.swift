//
//  bioRe3ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct bioRe3ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var bioRe3 = BioRe3()
    @State var isShowAlert: Bool = false
    @StateObject var bioRe3Memory1 = BioRe3Memory1()
    @StateObject var bioRe3Memory2 = BioRe3Memory2()
    @StateObject var bioRe3Memory3 = BioRe3Memory3()
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    // 注意事項
//                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: bioRe3.machineName,
//                        titleFont: .title2,
//                    )
//                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: bioRe3ViewNormal(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.bioRe3MenuNormalBadge,
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: bioRe3ViewCz(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.bioRe3MenuCzBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: bioRe3ViewFirstHit(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.bioRe3MenuFirstHitBadge,
                        )
                    }
                    
                    // フィギュアコレクション
                    NavigationLink(destination: bioRe3ViewFigure(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.stand",
                            textBody: "フィギュアコレクション",
                            badgeStatus: common.bioRe3MenuFigureBadge,
                        )
                    }

                    // AT終了画面
//                    NavigationLink(destination: bioRe3ViewScreen(
//                        bioRe3: bioRe3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "signature",
//                            textBody: "ボーナス・AT終了画面",
//                            badgeStatus: common.bioRe3MenuScreenBadge,
//                        )
//                    }

                    // エンディング
                    NavigationLink(destination: bioRe3ViewFigure(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.bioRe3MenuEndingBadge,
                        )
                    }

//                    // おみくじ
//                    NavigationLink(destination: bioRe3ViewOmikuji(
//                        bioRe3: bioRe3,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.bioRe3MenuOmikujiBadge,
//                        )
//                    }
//
                    // AT中
                    NavigationLink(destination: bioRe3ViewDuringAt(
                        bioRe3: bioRe3,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "allergens.fill",
                            textBody: "AT中",
                            badgeStatus: common.bioRe3MenuDuringAtBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewEnteriseTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "エンタトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: bioRe3.machineName,
                        titleFont: .title,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: bioRe3View95Ci(
                    bioRe3: bioRe3,
                    selection: 4,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: bioRe3ViewBayes(
                    bioRe3: bioRe3,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.bioRe3MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4974")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($common.bioRe3MachineIconBadge)
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4974")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(bioRe3SubViewLoadMemory(
                    bioRe3: bioRe3,
                    bioRe3Memory1: bioRe3Memory1,
                    bioRe3Memory2: bioRe3Memory2,
                    bioRe3Memory3: bioRe3Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(bioRe3SubViewSaveMemory(
                    bioRe3: bioRe3,
                    bioRe3Memory1: bioRe3Memory1,
                    bioRe3Memory2: bioRe3Memory2,
                    bioRe3Memory3: bioRe3Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: bioRe3.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct bioRe3SubViewSaveMemory: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bioRe3Memory1: BioRe3Memory1
    @ObservedObject var bioRe3Memory2: BioRe3Memory2
    @ObservedObject var bioRe3Memory3: BioRe3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: bioRe3.machineName,
            selectedMemory: $bioRe3.selectedMemory,
            memoMemory1: $bioRe3Memory1.memo,
            dateDoubleMemory1: $bioRe3Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $bioRe3Memory2.memo,
            dateDoubleMemory2: $bioRe3Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $bioRe3Memory3.memo,
            dateDoubleMemory3: $bioRe3Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        bioRe3Memory1.normalGame = bioRe3.normalGame
        bioRe3Memory1.firstHitCountCz = bioRe3.firstHitCountCz
        bioRe3Memory1.firstHitCountAt = bioRe3.firstHitCountAt
        bioRe3Memory1.figureCountKisuJaku = bioRe3.figureCountKisuJaku
        bioRe3Memory1.figureCountKisuKyo = bioRe3.figureCountKisuKyo
        bioRe3Memory1.figureCountGusuJaku = bioRe3.figureCountGusuJaku
        bioRe3Memory1.figureCountGusuKyo = bioRe3.figureCountGusuKyo
        bioRe3Memory1.figureCountHighJaku = bioRe3.figureCountHighJaku
        bioRe3Memory1.figureCountHighChu = bioRe3.figureCountHighChu
        bioRe3Memory1.figureCountHighKyo = bioRe3.figureCountHighKyo
        bioRe3Memory1.figureCountOver2 = bioRe3.figureCountOver2
        bioRe3Memory1.figureCountOver4With16 = bioRe3.figureCountOver4With16
        bioRe3Memory1.figureCountOver4With15 = bioRe3.figureCountOver4With15
        bioRe3Memory1.figureCountSum = bioRe3.figureCountSum
        
        // ---------
        // ver3.27.1
        // ---------
        bioRe3Memory1.jakuRareCountJakuCherry = bioRe3.jakuRareCountJakuCherry
        bioRe3Memory1.jakuRareCountSuika = bioRe3.jakuRareCountSuika
        bioRe3Memory1.jakuRareCountKoyakuSum = bioRe3.jakuRareCountKoyakuSum
        bioRe3Memory1.jakuRareCountCzHit = bioRe3.jakuRareCountCzHit
        bioRe3Memory1.kyoRareCountKyoCherry = bioRe3.kyoRareCountKyoCherry
        bioRe3Memory1.kyoRareCountChance = bioRe3.kyoRareCountChance
        bioRe3Memory1.kyoRareCountKoyakuSum = bioRe3.kyoRareCountKoyakuSum
        bioRe3Memory1.kyoRareCountCzHit = bioRe3.kyoRareCountCzHit
        bioRe3Memory1.kyoRareCountAtHit = bioRe3.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3Memory1.shinonCountDrop = bioRe3.shinonCountDrop
        bioRe3Memory1.shinonCountStay = bioRe3.shinonCountStay
        bioRe3Memory1.shinonCountSum = bioRe3.shinonCountSum
    }
    func saveMemory2() {
        bioRe3Memory2.normalGame = bioRe3.normalGame
        bioRe3Memory2.firstHitCountCz = bioRe3.firstHitCountCz
        bioRe3Memory2.firstHitCountAt = bioRe3.firstHitCountAt
        bioRe3Memory2.figureCountKisuJaku = bioRe3.figureCountKisuJaku
        bioRe3Memory2.figureCountKisuKyo = bioRe3.figureCountKisuKyo
        bioRe3Memory2.figureCountGusuJaku = bioRe3.figureCountGusuJaku
        bioRe3Memory2.figureCountGusuKyo = bioRe3.figureCountGusuKyo
        bioRe3Memory2.figureCountHighJaku = bioRe3.figureCountHighJaku
        bioRe3Memory2.figureCountHighChu = bioRe3.figureCountHighChu
        bioRe3Memory2.figureCountHighKyo = bioRe3.figureCountHighKyo
        bioRe3Memory2.figureCountOver2 = bioRe3.figureCountOver2
        bioRe3Memory2.figureCountOver4With16 = bioRe3.figureCountOver4With16
        bioRe3Memory2.figureCountOver4With15 = bioRe3.figureCountOver4With15
        bioRe3Memory2.figureCountSum = bioRe3.figureCountSum
        
        // ---------
        // ver3.27.1
        // ---------
        bioRe3Memory2.jakuRareCountJakuCherry = bioRe3.jakuRareCountJakuCherry
        bioRe3Memory2.jakuRareCountSuika = bioRe3.jakuRareCountSuika
        bioRe3Memory2.jakuRareCountKoyakuSum = bioRe3.jakuRareCountKoyakuSum
        bioRe3Memory2.jakuRareCountCzHit = bioRe3.jakuRareCountCzHit
        bioRe3Memory2.kyoRareCountKyoCherry = bioRe3.kyoRareCountKyoCherry
        bioRe3Memory2.kyoRareCountChance = bioRe3.kyoRareCountChance
        bioRe3Memory2.kyoRareCountKoyakuSum = bioRe3.kyoRareCountKoyakuSum
        bioRe3Memory2.kyoRareCountCzHit = bioRe3.kyoRareCountCzHit
        bioRe3Memory2.kyoRareCountAtHit = bioRe3.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3Memory2.shinonCountDrop = bioRe3.shinonCountDrop
        bioRe3Memory2.shinonCountStay = bioRe3.shinonCountStay
        bioRe3Memory2.shinonCountSum = bioRe3.shinonCountSum
    }
    func saveMemory3() {
        bioRe3Memory3.normalGame = bioRe3.normalGame
        bioRe3Memory3.firstHitCountCz = bioRe3.firstHitCountCz
        bioRe3Memory3.firstHitCountAt = bioRe3.firstHitCountAt
        bioRe3Memory3.figureCountKisuJaku = bioRe3.figureCountKisuJaku
        bioRe3Memory3.figureCountKisuKyo = bioRe3.figureCountKisuKyo
        bioRe3Memory3.figureCountGusuJaku = bioRe3.figureCountGusuJaku
        bioRe3Memory3.figureCountGusuKyo = bioRe3.figureCountGusuKyo
        bioRe3Memory3.figureCountHighJaku = bioRe3.figureCountHighJaku
        bioRe3Memory3.figureCountHighChu = bioRe3.figureCountHighChu
        bioRe3Memory3.figureCountHighKyo = bioRe3.figureCountHighKyo
        bioRe3Memory3.figureCountOver2 = bioRe3.figureCountOver2
        bioRe3Memory3.figureCountOver4With16 = bioRe3.figureCountOver4With16
        bioRe3Memory3.figureCountOver4With15 = bioRe3.figureCountOver4With15
        bioRe3Memory3.figureCountSum = bioRe3.figureCountSum
        
        // ---------
        // ver3.27.1
        // ---------
        bioRe3Memory3.jakuRareCountJakuCherry = bioRe3.jakuRareCountJakuCherry
        bioRe3Memory3.jakuRareCountSuika = bioRe3.jakuRareCountSuika
        bioRe3Memory3.jakuRareCountKoyakuSum = bioRe3.jakuRareCountKoyakuSum
        bioRe3Memory3.jakuRareCountCzHit = bioRe3.jakuRareCountCzHit
        bioRe3Memory3.kyoRareCountKyoCherry = bioRe3.kyoRareCountKyoCherry
        bioRe3Memory3.kyoRareCountChance = bioRe3.kyoRareCountChance
        bioRe3Memory3.kyoRareCountKoyakuSum = bioRe3.kyoRareCountKoyakuSum
        bioRe3Memory3.kyoRareCountCzHit = bioRe3.kyoRareCountCzHit
        bioRe3Memory3.kyoRareCountAtHit = bioRe3.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3Memory3.shinonCountDrop = bioRe3.shinonCountDrop
        bioRe3Memory3.shinonCountStay = bioRe3.shinonCountStay
        bioRe3Memory3.shinonCountSum = bioRe3.shinonCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct bioRe3SubViewLoadMemory: View {
    @ObservedObject var bioRe3: BioRe3
    @ObservedObject var bioRe3Memory1: BioRe3Memory1
    @ObservedObject var bioRe3Memory2: BioRe3Memory2
    @ObservedObject var bioRe3Memory3: BioRe3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: bioRe3.machineName,
            selectedMemory: $bioRe3.selectedMemory,
            memoMemory1: bioRe3Memory1.memo,
            dateDoubleMemory1: bioRe3Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: bioRe3Memory2.memo,
            dateDoubleMemory2: bioRe3Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: bioRe3Memory3.memo,
            dateDoubleMemory3: bioRe3Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        bioRe3.normalGame = bioRe3Memory1.normalGame
        bioRe3.firstHitCountCz = bioRe3Memory1.firstHitCountCz
        bioRe3.firstHitCountAt = bioRe3Memory1.firstHitCountAt
        bioRe3.figureCountKisuJaku = bioRe3Memory1.figureCountKisuJaku
        bioRe3.figureCountKisuKyo = bioRe3Memory1.figureCountKisuKyo
        bioRe3.figureCountGusuJaku = bioRe3Memory1.figureCountGusuJaku
        bioRe3.figureCountGusuKyo = bioRe3Memory1.figureCountGusuKyo
        bioRe3.figureCountHighJaku = bioRe3Memory1.figureCountHighJaku
        bioRe3.figureCountHighChu = bioRe3Memory1.figureCountHighChu
        bioRe3.figureCountHighKyo = bioRe3Memory1.figureCountHighKyo
        bioRe3.figureCountOver2 = bioRe3Memory1.figureCountOver2
        bioRe3.figureCountOver4With16 = bioRe3Memory1.figureCountOver4With16
        bioRe3.figureCountOver4With15 = bioRe3Memory1.figureCountOver4With15
        bioRe3.figureCountSum = bioRe3Memory1.figureCountSum
        // ---------
        // ver3.27.1
        // ---------
        bioRe3.jakuRareCountJakuCherry = bioRe3Memory1.jakuRareCountJakuCherry
        bioRe3.jakuRareCountSuika = bioRe3Memory1.jakuRareCountSuika
        bioRe3.jakuRareCountKoyakuSum = bioRe3Memory1.jakuRareCountKoyakuSum
        bioRe3.jakuRareCountCzHit = bioRe3Memory1.jakuRareCountCzHit
        bioRe3.kyoRareCountKyoCherry = bioRe3Memory1.kyoRareCountKyoCherry
        bioRe3.kyoRareCountChance = bioRe3Memory1.kyoRareCountChance
        bioRe3.kyoRareCountKoyakuSum = bioRe3Memory1.kyoRareCountKoyakuSum
        bioRe3.kyoRareCountCzHit = bioRe3Memory1.kyoRareCountCzHit
        bioRe3.kyoRareCountAtHit = bioRe3Memory1.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3.shinonCountDrop = bioRe3Memory1.shinonCountDrop
        bioRe3.shinonCountStay = bioRe3Memory1.shinonCountStay
        bioRe3.shinonCountSum = bioRe3Memory1.shinonCountSum
    }
    func loadMemory2() {
        bioRe3.normalGame = bioRe3Memory2.normalGame
        bioRe3.firstHitCountCz = bioRe3Memory2.firstHitCountCz
        bioRe3.firstHitCountAt = bioRe3Memory2.firstHitCountAt
        bioRe3.figureCountKisuJaku = bioRe3Memory2.figureCountKisuJaku
        bioRe3.figureCountKisuKyo = bioRe3Memory2.figureCountKisuKyo
        bioRe3.figureCountGusuJaku = bioRe3Memory2.figureCountGusuJaku
        bioRe3.figureCountGusuKyo = bioRe3Memory2.figureCountGusuKyo
        bioRe3.figureCountHighJaku = bioRe3Memory2.figureCountHighJaku
        bioRe3.figureCountHighChu = bioRe3Memory2.figureCountHighChu
        bioRe3.figureCountHighKyo = bioRe3Memory2.figureCountHighKyo
        bioRe3.figureCountOver2 = bioRe3Memory2.figureCountOver2
        bioRe3.figureCountOver4With16 = bioRe3Memory2.figureCountOver4With16
        bioRe3.figureCountOver4With15 = bioRe3Memory2.figureCountOver4With15
        bioRe3.figureCountSum = bioRe3Memory2.figureCountSum
        
        // ---------
        // ver3.27.1
        // ---------
        bioRe3.jakuRareCountJakuCherry = bioRe3Memory2.jakuRareCountJakuCherry
        bioRe3.jakuRareCountSuika = bioRe3Memory2.jakuRareCountSuika
        bioRe3.jakuRareCountKoyakuSum = bioRe3Memory2.jakuRareCountKoyakuSum
        bioRe3.jakuRareCountCzHit = bioRe3Memory2.jakuRareCountCzHit
        bioRe3.kyoRareCountKyoCherry = bioRe3Memory2.kyoRareCountKyoCherry
        bioRe3.kyoRareCountChance = bioRe3Memory2.kyoRareCountChance
        bioRe3.kyoRareCountKoyakuSum = bioRe3Memory2.kyoRareCountKoyakuSum
        bioRe3.kyoRareCountCzHit = bioRe3Memory2.kyoRareCountCzHit
        bioRe3.kyoRareCountAtHit = bioRe3Memory2.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3.shinonCountDrop = bioRe3Memory2.shinonCountDrop
        bioRe3.shinonCountStay = bioRe3Memory2.shinonCountStay
        bioRe3.shinonCountSum = bioRe3Memory2.shinonCountSum
    }
    func loadMemory3() {
        bioRe3.normalGame = bioRe3Memory3.normalGame
        bioRe3.firstHitCountCz = bioRe3Memory3.firstHitCountCz
        bioRe3.firstHitCountAt = bioRe3Memory3.firstHitCountAt
        bioRe3.figureCountKisuJaku = bioRe3Memory3.figureCountKisuJaku
        bioRe3.figureCountKisuKyo = bioRe3Memory3.figureCountKisuKyo
        bioRe3.figureCountGusuJaku = bioRe3Memory3.figureCountGusuJaku
        bioRe3.figureCountGusuKyo = bioRe3Memory3.figureCountGusuKyo
        bioRe3.figureCountHighJaku = bioRe3Memory3.figureCountHighJaku
        bioRe3.figureCountHighChu = bioRe3Memory3.figureCountHighChu
        bioRe3.figureCountHighKyo = bioRe3Memory3.figureCountHighKyo
        bioRe3.figureCountOver2 = bioRe3Memory3.figureCountOver2
        bioRe3.figureCountOver4With16 = bioRe3Memory3.figureCountOver4With16
        bioRe3.figureCountOver4With15 = bioRe3Memory3.figureCountOver4With15
        bioRe3.figureCountSum = bioRe3Memory3.figureCountSum
        
        // ---------
        // ver3.27.1
        // ---------
        bioRe3.jakuRareCountJakuCherry = bioRe3Memory3.jakuRareCountJakuCherry
        bioRe3.jakuRareCountSuika = bioRe3Memory3.jakuRareCountSuika
        bioRe3.jakuRareCountKoyakuSum = bioRe3Memory3.jakuRareCountKoyakuSum
        bioRe3.jakuRareCountCzHit = bioRe3Memory3.jakuRareCountCzHit
        bioRe3.kyoRareCountKyoCherry = bioRe3Memory3.kyoRareCountKyoCherry
        bioRe3.kyoRareCountChance = bioRe3Memory3.kyoRareCountChance
        bioRe3.kyoRareCountKoyakuSum = bioRe3Memory3.kyoRareCountKoyakuSum
        bioRe3.kyoRareCountCzHit = bioRe3Memory3.kyoRareCountCzHit
        bioRe3.kyoRareCountAtHit = bioRe3Memory3.kyoRareCountAtHit
        
        // ---------
        // ver4.0.0
        // ---------
        bioRe3.shinonCountDrop = bioRe3Memory3.shinonCountDrop
        bioRe3.shinonCountStay = bioRe3Memory3.shinonCountStay
        bioRe3.shinonCountSum = bioRe3Memory3.shinonCountSum
    }
}

#Preview {
    bioRe3ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
