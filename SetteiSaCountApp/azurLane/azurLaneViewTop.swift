//
//  azurLaneViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import SwiftUI

struct azurLaneViewTop: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var azurLane = AzurLane()
    @State var isShowAlert: Bool = false
    @StateObject var azurLaneMemory1 = AzurLaneMemory1()
    @StateObject var azurLaneMemory2 = AzurLaneMemory2()
    @StateObject var azurLaneMemory3 = AzurLaneMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ぱちログの利用を前提としています\n遊技前にぱちログを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: azurLane.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: azurLaneViewNormal(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: azurLaneViewFirstHit(
                        ver391: ver391,
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: ver391.azurLaneMenuFirstHitBadge,
                        )
                    }
                    // ボーナス中 加賀バトル
                    NavigationLink(destination: azurLaneViewKaga(
                        ver391: ver391,
                        azurLane: azurLane,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.3",
                            textBody: "ボーナス中 加賀バトル",
                            badgeStatus: ver391.azurLaneMenuKagaBadge,
                        )
                    }
                    // ボーナス中 明石チャレンジ
                    NavigationLink(destination: azurLaneViewAkashi(
                        ver391: ver391,
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "wrench.adjustable.fill",
                            textBody: "ボーナス中 明石チャレンジ",
                            badgeStatus: ver391.azurLaneMenuAkashiBadge,
                        )
                    }
                    // ボーナス、AT終了画面
                    NavigationLink(destination: azurLaneViewScreen(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス,AT終了画面"
                        )
                    }
                    // AT終了後の高確スタート
                    NavigationLink(destination: azurLaneViewKokakuStart(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "AT終了後の高確スタート"
                        )
                    }
                    // 玉ちゃんトロフィー
                    NavigationLink(destination: commonViewTamachanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "玉ちゃんトロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: azurLaneView95Ci(
                    azurLane: azurLane,
                    selection: 1
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: azurLaneViewBayes(
                    azurLane: azurLane,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4847")
                
                // コピーライト
                unitSectionCopyright {
                    Text("© Manjuu Co., Ltd., YongShi Co.,Ltd. & Yostar, Inc.／アニメ「アズールレーン」製作委員会")
                    Text("©︎KYORAKU")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.azurLaneMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(azurLaneSubViewLoadMemory(
                        azurLane: azurLane,
                        azurLaneMemory1: azurLaneMemory1,
                        azurLaneMemory2: azurLaneMemory2,
                        azurLaneMemory3: azurLaneMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(azurLaneSubViewSaveMemory(
                        azurLane: azurLane,
                        azurLaneMemory1: azurLaneMemory1,
                        azurLaneMemory2: azurLaneMemory2,
                        azurLaneMemory3: azurLaneMemory3
                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: azurLane.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct azurLaneSubViewSaveMemory: View {
    @ObservedObject var azurLane: AzurLane
    @ObservedObject var azurLaneMemory1: AzurLaneMemory1
    @ObservedObject var azurLaneMemory2: AzurLaneMemory2
    @ObservedObject var azurLaneMemory3: AzurLaneMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: azurLane.machineName,
            selectedMemory: $azurLane.selectedMemory,
            memoMemory1: $azurLaneMemory1.memo,
            dateDoubleMemory1: $azurLaneMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $azurLaneMemory2.memo,
            dateDoubleMemory2: $azurLaneMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $azurLaneMemory3.memo,
            dateDoubleMemory3: $azurLaneMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        azurLaneMemory1.koyakuCountJakuCherry = azurLane.koyakuCountJakuCherry
        azurLaneMemory1.koyakuCountJakuSuika = azurLane.koyakuCountJakuSuika
        azurLaneMemory1.koyakuCountSum = azurLane.koyakuCountSum
        azurLaneMemory1.gameNumberStart = azurLane.gameNumberStart
        azurLaneMemory1.gameNumberCurrent = azurLane.gameNumberCurrent
        azurLaneMemory1.gameNumberPlay = azurLane.gameNumberPlay
        azurLaneMemory1.bonusCount = azurLane.bonusCount
        azurLaneMemory1.atCount = azurLane.atCount
        azurLaneMemory1.gameNormalNumberStart = azurLane.gameNormalNumberStart
        azurLaneMemory1.gameNormalNumberCurrent = azurLane.gameNormalNumberCurrent
        azurLaneMemory1.gameNormalNumberPlay = azurLane.gameNormalNumberPlay
        azurLaneMemory1.kagaCountDefault = azurLane.kagaCountDefault
        azurLaneMemory1.kagaCountKisu = azurLane.kagaCountKisu
        azurLaneMemory1.kagaCountGusu = azurLane.kagaCountGusu
        azurLaneMemory1.kagaCount46sisa = azurLane.kagaCount46sisa
        azurLaneMemory1.kagaCount56sisa = azurLane.kagaCount56sisa
        azurLaneMemory1.kagaCountSum = azurLane.kagaCountSum
        azurLaneMemory1.screenCountDefault = azurLane.screenCountDefault
        azurLaneMemory1.screenCountHighJaku = azurLane.screenCountHighJaku
        azurLaneMemory1.screenCountHighKyo = azurLane.screenCountHighKyo
        azurLaneMemory1.screenCountOver2 = azurLane.screenCountOver2
        azurLaneMemory1.screenCountOver4 = azurLane.screenCountOver4
        azurLaneMemory1.screenCountOver6 = azurLane.screenCountOver6
        azurLaneMemory1.screenCountRemain3Sisa = azurLane.screenCountRemain3Sisa
        azurLaneMemory1.screenCountRemain5 = azurLane.screenCountRemain5
        azurLaneMemory1.screenCountRemain3 = azurLane.screenCountRemain3
        azurLaneMemory1.screenCountRemain1 = azurLane.screenCountRemain1
        azurLaneMemory1.screenCountSum = azurLane.screenCountSum
        azurLaneMemory1.startModeCountNormal = azurLane.startModeCountNormal
        azurLaneMemory1.startModeCountHigh = azurLane.startModeCountHigh
        azurLaneMemory1.startModeCountChoHigh = azurLane.startModeCountChoHigh
        azurLaneMemory1.startModeCountSum = azurLane.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLaneMemory1.bonusCountWhite = azurLane.bonusCountWhite
        azurLaneMemory1.bonusCountBlue = azurLane.bonusCountBlue
        azurLaneMemory1.akashiCountKisu = azurLane.akashiCountKisu
        azurLaneMemory1.akashiCountGusu = azurLane.akashiCountGusu
        azurLaneMemory1.akashiCountLast = azurLane.akashiCountLast
        azurLaneMemory1.akashiCountSum = azurLane.akashiCountSum
    }
    func saveMemory2() {
        azurLaneMemory2.koyakuCountJakuCherry = azurLane.koyakuCountJakuCherry
        azurLaneMemory2.koyakuCountJakuSuika = azurLane.koyakuCountJakuSuika
        azurLaneMemory2.koyakuCountSum = azurLane.koyakuCountSum
        azurLaneMemory2.gameNumberStart = azurLane.gameNumberStart
        azurLaneMemory2.gameNumberCurrent = azurLane.gameNumberCurrent
        azurLaneMemory2.gameNumberPlay = azurLane.gameNumberPlay
        azurLaneMemory2.bonusCount = azurLane.bonusCount
        azurLaneMemory2.atCount = azurLane.atCount
        azurLaneMemory2.gameNormalNumberStart = azurLane.gameNormalNumberStart
        azurLaneMemory2.gameNormalNumberCurrent = azurLane.gameNormalNumberCurrent
        azurLaneMemory2.gameNormalNumberPlay = azurLane.gameNormalNumberPlay
        azurLaneMemory2.kagaCountDefault = azurLane.kagaCountDefault
        azurLaneMemory2.kagaCountKisu = azurLane.kagaCountKisu
        azurLaneMemory2.kagaCountGusu = azurLane.kagaCountGusu
        azurLaneMemory2.kagaCount46sisa = azurLane.kagaCount46sisa
        azurLaneMemory2.kagaCount56sisa = azurLane.kagaCount56sisa
        azurLaneMemory2.kagaCountSum = azurLane.kagaCountSum
        azurLaneMemory2.screenCountDefault = azurLane.screenCountDefault
        azurLaneMemory2.screenCountHighJaku = azurLane.screenCountHighJaku
        azurLaneMemory2.screenCountHighKyo = azurLane.screenCountHighKyo
        azurLaneMemory2.screenCountOver2 = azurLane.screenCountOver2
        azurLaneMemory2.screenCountOver4 = azurLane.screenCountOver4
        azurLaneMemory2.screenCountOver6 = azurLane.screenCountOver6
        azurLaneMemory2.screenCountRemain3Sisa = azurLane.screenCountRemain3Sisa
        azurLaneMemory2.screenCountRemain5 = azurLane.screenCountRemain5
        azurLaneMemory2.screenCountRemain3 = azurLane.screenCountRemain3
        azurLaneMemory2.screenCountRemain1 = azurLane.screenCountRemain1
        azurLaneMemory2.screenCountSum = azurLane.screenCountSum
        azurLaneMemory2.startModeCountNormal = azurLane.startModeCountNormal
        azurLaneMemory2.startModeCountHigh = azurLane.startModeCountHigh
        azurLaneMemory2.startModeCountChoHigh = azurLane.startModeCountChoHigh
        azurLaneMemory2.startModeCountSum = azurLane.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLaneMemory2.bonusCountWhite = azurLane.bonusCountWhite
        azurLaneMemory2.bonusCountBlue = azurLane.bonusCountBlue
        azurLaneMemory2.akashiCountKisu = azurLane.akashiCountKisu
        azurLaneMemory2.akashiCountGusu = azurLane.akashiCountGusu
        azurLaneMemory2.akashiCountLast = azurLane.akashiCountLast
        azurLaneMemory2.akashiCountSum = azurLane.akashiCountSum
    }
    func saveMemory3() {
        azurLaneMemory3.koyakuCountJakuCherry = azurLane.koyakuCountJakuCherry
        azurLaneMemory3.koyakuCountJakuSuika = azurLane.koyakuCountJakuSuika
        azurLaneMemory3.koyakuCountSum = azurLane.koyakuCountSum
        azurLaneMemory3.gameNumberStart = azurLane.gameNumberStart
        azurLaneMemory3.gameNumberCurrent = azurLane.gameNumberCurrent
        azurLaneMemory3.gameNumberPlay = azurLane.gameNumberPlay
        azurLaneMemory3.bonusCount = azurLane.bonusCount
        azurLaneMemory3.atCount = azurLane.atCount
        azurLaneMemory3.gameNormalNumberStart = azurLane.gameNormalNumberStart
        azurLaneMemory3.gameNormalNumberCurrent = azurLane.gameNormalNumberCurrent
        azurLaneMemory3.gameNormalNumberPlay = azurLane.gameNormalNumberPlay
        azurLaneMemory3.kagaCountDefault = azurLane.kagaCountDefault
        azurLaneMemory3.kagaCountKisu = azurLane.kagaCountKisu
        azurLaneMemory3.kagaCountGusu = azurLane.kagaCountGusu
        azurLaneMemory3.kagaCount46sisa = azurLane.kagaCount46sisa
        azurLaneMemory3.kagaCount56sisa = azurLane.kagaCount56sisa
        azurLaneMemory3.kagaCountSum = azurLane.kagaCountSum
        azurLaneMemory3.screenCountDefault = azurLane.screenCountDefault
        azurLaneMemory3.screenCountHighJaku = azurLane.screenCountHighJaku
        azurLaneMemory3.screenCountHighKyo = azurLane.screenCountHighKyo
        azurLaneMemory3.screenCountOver2 = azurLane.screenCountOver2
        azurLaneMemory3.screenCountOver4 = azurLane.screenCountOver4
        azurLaneMemory3.screenCountOver6 = azurLane.screenCountOver6
        azurLaneMemory3.screenCountRemain3Sisa = azurLane.screenCountRemain3Sisa
        azurLaneMemory3.screenCountRemain5 = azurLane.screenCountRemain5
        azurLaneMemory3.screenCountRemain3 = azurLane.screenCountRemain3
        azurLaneMemory3.screenCountRemain1 = azurLane.screenCountRemain1
        azurLaneMemory3.screenCountSum = azurLane.screenCountSum
        azurLaneMemory3.startModeCountNormal = azurLane.startModeCountNormal
        azurLaneMemory3.startModeCountHigh = azurLane.startModeCountHigh
        azurLaneMemory3.startModeCountChoHigh = azurLane.startModeCountChoHigh
        azurLaneMemory3.startModeCountSum = azurLane.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLaneMemory3.bonusCountWhite = azurLane.bonusCountWhite
        azurLaneMemory3.bonusCountBlue = azurLane.bonusCountBlue
        azurLaneMemory3.akashiCountKisu = azurLane.akashiCountKisu
        azurLaneMemory3.akashiCountGusu = azurLane.akashiCountGusu
        azurLaneMemory3.akashiCountLast = azurLane.akashiCountLast
        azurLaneMemory3.akashiCountSum = azurLane.akashiCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct azurLaneSubViewLoadMemory: View {
    @ObservedObject var azurLane: AzurLane
    @ObservedObject var azurLaneMemory1: AzurLaneMemory1
    @ObservedObject var azurLaneMemory2: AzurLaneMemory2
    @ObservedObject var azurLaneMemory3: AzurLaneMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: azurLane.machineName,
            selectedMemory: $azurLane.selectedMemory,
            memoMemory1: azurLaneMemory1.memo,
            dateDoubleMemory1: azurLaneMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: azurLaneMemory2.memo,
            dateDoubleMemory2: azurLaneMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: azurLaneMemory3.memo,
            dateDoubleMemory3: azurLaneMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        azurLane.koyakuCountJakuCherry = azurLaneMemory1.koyakuCountJakuCherry
        azurLane.koyakuCountJakuSuika = azurLaneMemory1.koyakuCountJakuSuika
        azurLane.koyakuCountSum = azurLaneMemory1.koyakuCountSum
        azurLane.gameNumberStart = azurLaneMemory1.gameNumberStart
        azurLane.gameNumberCurrent = azurLaneMemory1.gameNumberCurrent
        azurLane.gameNumberPlay = azurLaneMemory1.gameNumberPlay
        azurLane.bonusCount = azurLaneMemory1.bonusCount
        azurLane.atCount = azurLaneMemory1.atCount
        azurLane.gameNormalNumberStart = azurLaneMemory1.gameNormalNumberStart
        azurLane.gameNormalNumberCurrent = azurLaneMemory1.gameNormalNumberCurrent
        azurLane.gameNormalNumberPlay = azurLaneMemory1.gameNormalNumberPlay
        azurLane.kagaCountDefault = azurLaneMemory1.kagaCountDefault
        azurLane.kagaCountKisu = azurLaneMemory1.kagaCountKisu
        azurLane.kagaCountGusu = azurLaneMemory1.kagaCountGusu
        azurLane.kagaCount46sisa = azurLaneMemory1.kagaCount46sisa
        azurLane.kagaCount56sisa = azurLaneMemory1.kagaCount56sisa
        azurLane.kagaCountSum = azurLaneMemory1.kagaCountSum
        azurLane.screenCountDefault = azurLaneMemory1.screenCountDefault
        azurLane.screenCountHighJaku = azurLaneMemory1.screenCountHighJaku
        azurLane.screenCountHighKyo = azurLaneMemory1.screenCountHighKyo
        azurLane.screenCountOver2 = azurLaneMemory1.screenCountOver2
        azurLane.screenCountOver4 = azurLaneMemory1.screenCountOver4
        azurLane.screenCountOver6 = azurLaneMemory1.screenCountOver6
        azurLane.screenCountRemain3Sisa = azurLaneMemory1.screenCountRemain3Sisa
        azurLane.screenCountRemain5 = azurLaneMemory1.screenCountRemain5
        azurLane.screenCountRemain3 = azurLaneMemory1.screenCountRemain3
        azurLane.screenCountRemain1 = azurLaneMemory1.screenCountRemain1
        azurLane.screenCountSum = azurLaneMemory1.screenCountSum
        azurLane.startModeCountNormal = azurLaneMemory1.startModeCountNormal
        azurLane.startModeCountHigh = azurLaneMemory1.startModeCountHigh
        azurLane.startModeCountChoHigh = azurLaneMemory1.startModeCountChoHigh
        azurLane.startModeCountSum = azurLaneMemory1.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLane.bonusCountWhite = azurLaneMemory1.bonusCountWhite
        azurLane.bonusCountBlue = azurLaneMemory1.bonusCountBlue
        azurLane.akashiCountKisu = azurLaneMemory1.akashiCountKisu
        azurLane.akashiCountGusu = azurLaneMemory1.akashiCountGusu
        azurLane.akashiCountLast = azurLaneMemory1.akashiCountLast
        azurLane.akashiCountSum = azurLaneMemory1.akashiCountSum
    }
    func loadMemory2() {
        azurLane.koyakuCountJakuCherry = azurLaneMemory2.koyakuCountJakuCherry
        azurLane.koyakuCountJakuSuika = azurLaneMemory2.koyakuCountJakuSuika
        azurLane.koyakuCountSum = azurLaneMemory2.koyakuCountSum
        azurLane.gameNumberStart = azurLaneMemory2.gameNumberStart
        azurLane.gameNumberCurrent = azurLaneMemory2.gameNumberCurrent
        azurLane.gameNumberPlay = azurLaneMemory2.gameNumberPlay
        azurLane.bonusCount = azurLaneMemory2.bonusCount
        azurLane.atCount = azurLaneMemory2.atCount
        azurLane.gameNormalNumberStart = azurLaneMemory2.gameNormalNumberStart
        azurLane.gameNormalNumberCurrent = azurLaneMemory2.gameNormalNumberCurrent
        azurLane.gameNormalNumberPlay = azurLaneMemory2.gameNormalNumberPlay
        azurLane.kagaCountDefault = azurLaneMemory2.kagaCountDefault
        azurLane.kagaCountKisu = azurLaneMemory2.kagaCountKisu
        azurLane.kagaCountGusu = azurLaneMemory2.kagaCountGusu
        azurLane.kagaCount46sisa = azurLaneMemory2.kagaCount46sisa
        azurLane.kagaCount56sisa = azurLaneMemory2.kagaCount56sisa
        azurLane.kagaCountSum = azurLaneMemory2.kagaCountSum
        azurLane.screenCountDefault = azurLaneMemory2.screenCountDefault
        azurLane.screenCountHighJaku = azurLaneMemory2.screenCountHighJaku
        azurLane.screenCountHighKyo = azurLaneMemory2.screenCountHighKyo
        azurLane.screenCountOver2 = azurLaneMemory2.screenCountOver2
        azurLane.screenCountOver4 = azurLaneMemory2.screenCountOver4
        azurLane.screenCountOver6 = azurLaneMemory2.screenCountOver6
        azurLane.screenCountRemain3Sisa = azurLaneMemory2.screenCountRemain3Sisa
        azurLane.screenCountRemain5 = azurLaneMemory2.screenCountRemain5
        azurLane.screenCountRemain3 = azurLaneMemory2.screenCountRemain3
        azurLane.screenCountRemain1 = azurLaneMemory2.screenCountRemain1
        azurLane.screenCountSum = azurLaneMemory2.screenCountSum
        azurLane.startModeCountNormal = azurLaneMemory2.startModeCountNormal
        azurLane.startModeCountHigh = azurLaneMemory2.startModeCountHigh
        azurLane.startModeCountChoHigh = azurLaneMemory2.startModeCountChoHigh
        azurLane.startModeCountSum = azurLaneMemory2.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLane.bonusCountWhite = azurLaneMemory2.bonusCountWhite
        azurLane.bonusCountBlue = azurLaneMemory2.bonusCountBlue
        azurLane.akashiCountKisu = azurLaneMemory2.akashiCountKisu
        azurLane.akashiCountGusu = azurLaneMemory2.akashiCountGusu
        azurLane.akashiCountLast = azurLaneMemory2.akashiCountLast
        azurLane.akashiCountSum = azurLaneMemory2.akashiCountSum
    }
    func loadMemory3() {
        azurLane.koyakuCountJakuCherry = azurLaneMemory3.koyakuCountJakuCherry
        azurLane.koyakuCountJakuSuika = azurLaneMemory3.koyakuCountJakuSuika
        azurLane.koyakuCountSum = azurLaneMemory3.koyakuCountSum
        azurLane.gameNumberStart = azurLaneMemory3.gameNumberStart
        azurLane.gameNumberCurrent = azurLaneMemory3.gameNumberCurrent
        azurLane.gameNumberPlay = azurLaneMemory3.gameNumberPlay
        azurLane.bonusCount = azurLaneMemory3.bonusCount
        azurLane.atCount = azurLaneMemory3.atCount
        azurLane.gameNormalNumberStart = azurLaneMemory3.gameNormalNumberStart
        azurLane.gameNormalNumberCurrent = azurLaneMemory3.gameNormalNumberCurrent
        azurLane.gameNormalNumberPlay = azurLaneMemory3.gameNormalNumberPlay
        azurLane.kagaCountDefault = azurLaneMemory3.kagaCountDefault
        azurLane.kagaCountKisu = azurLaneMemory3.kagaCountKisu
        azurLane.kagaCountGusu = azurLaneMemory3.kagaCountGusu
        azurLane.kagaCount46sisa = azurLaneMemory3.kagaCount46sisa
        azurLane.kagaCount56sisa = azurLaneMemory3.kagaCount56sisa
        azurLane.kagaCountSum = azurLaneMemory3.kagaCountSum
        azurLane.screenCountDefault = azurLaneMemory3.screenCountDefault
        azurLane.screenCountHighJaku = azurLaneMemory3.screenCountHighJaku
        azurLane.screenCountHighKyo = azurLaneMemory3.screenCountHighKyo
        azurLane.screenCountOver2 = azurLaneMemory3.screenCountOver2
        azurLane.screenCountOver4 = azurLaneMemory3.screenCountOver4
        azurLane.screenCountOver6 = azurLaneMemory3.screenCountOver6
        azurLane.screenCountRemain3Sisa = azurLaneMemory3.screenCountRemain3Sisa
        azurLane.screenCountRemain5 = azurLaneMemory3.screenCountRemain5
        azurLane.screenCountRemain3 = azurLaneMemory3.screenCountRemain3
        azurLane.screenCountRemain1 = azurLaneMemory3.screenCountRemain1
        azurLane.screenCountSum = azurLaneMemory3.screenCountSum
        azurLane.startModeCountNormal = azurLaneMemory3.startModeCountNormal
        azurLane.startModeCountHigh = azurLaneMemory3.startModeCountHigh
        azurLane.startModeCountChoHigh = azurLaneMemory3.startModeCountChoHigh
        azurLane.startModeCountSum = azurLaneMemory3.startModeCountSum
        
        // //////////////
        // ver3.9.1で追加
        // //////////////
        azurLane.bonusCountWhite = azurLaneMemory3.bonusCountWhite
        azurLane.bonusCountBlue = azurLaneMemory3.bonusCountBlue
        azurLane.akashiCountKisu = azurLaneMemory3.akashiCountKisu
        azurLane.akashiCountGusu = azurLaneMemory3.akashiCountGusu
        azurLane.akashiCountLast = azurLaneMemory3.akashiCountLast
        azurLane.akashiCountSum = azurLaneMemory3.akashiCountSum
    }
}

#Preview {
    azurLaneViewTop(
        ver391: Ver391(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
