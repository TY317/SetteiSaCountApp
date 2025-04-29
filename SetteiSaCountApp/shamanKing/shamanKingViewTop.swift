//
//  shamanKingViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/23.
//

import SwiftUI

struct shamanKingViewTop: View {
//    @ObservedObject var ver270 = Ver270()
//    @ObservedObject var shamanKing = ShamanKing()
    @StateObject var shamanKing = ShamanKing()
    @State var isShowAlert: Bool = false
    @StateObject var shamanKingMemory1 = ShamanKingMemory1()
    @StateObject var shamanKingMemory2 = ShamanKingMemory2()
    @StateObject var shamanKingMemory3 = ShamanKingMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "シャーマンキング")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: shamanKingViewNormal(shamanKing: shamanKing)) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // CZ当選時の振分け
                    NavigationLink(destination: shamanKingViewCzFuriwake(shamanKing: shamanKing)) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "CZ当選時の振分け"
//                            badgeStatus: ver270.shamanKingMenuCzFuriwakeBadgeStatus
                        )
                    }
                    // 憑依合体バトル
                    NavigationLink(destination: shamanKingViewHyoiGattai(shamanKing: shamanKing)) {
                        unitLabelMenu(
                            imageSystemName: "figure.handball",
                            textBody: "憑依合体バトル"
                        )
                    }
                    // たまおのコックリさん占い
                    NavigationLink(destination: shamanKingViewKokkuri()) {
                        unitLabelMenu(
                            imageSystemName: "hand.draw.fill",
                            textBody: "たまおのコックリさん占い"
                        )
                    }
                    // ボーナス,AT 初当り
                    NavigationLink(destination: shamanKingViewHit(shamanKing: shamanKing)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: shamanKingViewScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: shamanKingViewEnding(shamanKing: shamanKing)) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: shamanKingView95Ci(shamanKing: shamanKing, selection: 7)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4719")
                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver270.shamanKingMachineIconBadgeStatus != "none" {
//                ver270.shamanKingMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(shamanKingSubViewLoadMemory(
                        shamanKing: shamanKing,
                        shamanKingMemory1: shamanKingMemory1,
                        shamanKingMemory2: shamanKingMemory2,
                        shamanKingMemory3: shamanKingMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(shamanKingSubViewSaveMemory(
                        shamanKing: shamanKing,
                        shamanKingMemory1: shamanKingMemory1,
                        shamanKingMemory2: shamanKingMemory2,
                        shamanKingMemory3: shamanKingMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct shamanKingSubViewSaveMemory: View {
    @ObservedObject var shamanKing: ShamanKing
    @ObservedObject var shamanKingMemory1: ShamanKingMemory1
    @ObservedObject var shamanKingMemory2: ShamanKingMemory2
    @ObservedObject var shamanKingMemory3: ShamanKingMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "シャーマンキング",
            selectedMemory: $shamanKing.selectedMemory,
            memoMemory1: $shamanKingMemory1.memo,
            dateDoubleMemory1: $shamanKingMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $shamanKingMemory2.memo,
            dateDoubleMemory2: $shamanKingMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $shamanKingMemory3.memo,
            dateDoubleMemory3: $shamanKingMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        shamanKingMemory1.jakuRareCount = shamanKing.jakuRareCount
        shamanKingMemory1.bonusKokakuCount = shamanKing.bonusKokakuCount
        shamanKingMemory1.replayCounterReplayCount = shamanKing.replayCounterReplayCount
        shamanKingMemory1.replayCounterCountSuccesss = shamanKing.replayCounterCountSuccesss
        shamanKingMemory1.hyoiCount78Lose = shamanKing.hyoiCount78Lose
        shamanKingMemory1.hyoiCount78Win = shamanKing.hyoiCount78Win
        shamanKingMemory1.hyoiCount78Sum = shamanKing.hyoiCount78Sum
        shamanKingMemory1.hyoiCount56Lose = shamanKing.hyoiCount56Lose
        shamanKingMemory1.hyoiCount56Win = shamanKing.hyoiCount56Win
        shamanKingMemory1.hyoiCount56Sum = shamanKing.hyoiCount56Sum
        shamanKingMemory1.hyoiCount4Lose = shamanKing.hyoiCount4Lose
        shamanKingMemory1.hyoiCount4Win = shamanKing.hyoiCount4Win
        shamanKingMemory1.hyoiCount4Sum = shamanKing.hyoiCount4Sum
        shamanKingMemory1.hyoiCount3Lose = shamanKing.hyoiCount3Lose
        shamanKingMemory1.hyoiCount3Win = shamanKing.hyoiCount3Win
        shamanKingMemory1.hyoiCount3Sum = shamanKing.hyoiCount3Sum
        shamanKingMemory1.inputGame = shamanKing.inputGame
        shamanKingMemory1.inputShamanBonusCount = shamanKing.inputShamanBonusCount
        shamanKingMemory1.inputEpisodeBonusCount = shamanKing.inputEpisodeBonusCount
        shamanKingMemory1.bonusCountSum = shamanKing.bonusCountSum
        shamanKingMemory1.inputShamanFightCount = shamanKing.inputShamanFightCount
        shamanKingMemory1.endingCountDefault = shamanKing.endingCountDefault
        shamanKingMemory1.endingCountGusuJaku = shamanKing.endingCountGusuJaku
        shamanKingMemory1.endingCountGusuKyo = shamanKing.endingCountGusuKyo
        shamanKingMemory1.endingCountKisuJaku = shamanKing.endingCountKisuJaku
        shamanKingMemory1.endingCountKisuKyo = shamanKing.endingCountKisuKyo
        shamanKingMemory1.endingCountOver2Sisa = shamanKing.endingCountOver2Sisa
        shamanKingMemory1.endingCountOver4Sisa = shamanKing.endingCountOver4Sisa
        shamanKingMemory1.endingCountOver2 = shamanKing.endingCountOver2
        shamanKingMemory1.endingCountOver4 = shamanKing.endingCountOver4
        shamanKingMemory1.endingCountOver5 = shamanKing.endingCountOver5
        shamanKingMemory1.endingCountOver6 = shamanKing.endingCountOver6
        shamanKingMemory1.endingCountSum = shamanKing.endingCountSum
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKingMemory1.czCountUnder600Ren = shamanKing.czCountUnder600Ren
        shamanKingMemory1.czCountUnder600Jun = shamanKing.czCountUnder600Jun
        shamanKingMemory1.czCountUnder600Ryunosuke = shamanKing.czCountUnder600Ryunosuke
        shamanKingMemory1.czCountUnder600Kokkuri = shamanKing.czCountUnder600Kokkuri
        shamanKingMemory1.czCountUnder600Sum = shamanKing.czCountUnder600Sum
        shamanKingMemory1.czCountOver600Ren = shamanKing.czCountOver600Ren
        shamanKingMemory1.czCountOver600Jun = shamanKing.czCountOver600Jun
        shamanKingMemory1.czCountOver600Ryunosuke = shamanKing.czCountOver600Ryunosuke
        shamanKingMemory1.czCountOver600Kokkuri = shamanKing.czCountOver600Kokkuri
        shamanKingMemory1.czCountOver600Sum = shamanKing.czCountOver600Sum
    }
    func saveMemory2() {
        shamanKingMemory2.jakuRareCount = shamanKing.jakuRareCount
        shamanKingMemory2.bonusKokakuCount = shamanKing.bonusKokakuCount
        shamanKingMemory2.replayCounterReplayCount = shamanKing.replayCounterReplayCount
        shamanKingMemory2.replayCounterCountSuccesss = shamanKing.replayCounterCountSuccesss
        shamanKingMemory2.hyoiCount78Lose = shamanKing.hyoiCount78Lose
        shamanKingMemory2.hyoiCount78Win = shamanKing.hyoiCount78Win
        shamanKingMemory2.hyoiCount78Sum = shamanKing.hyoiCount78Sum
        shamanKingMemory2.hyoiCount56Lose = shamanKing.hyoiCount56Lose
        shamanKingMemory2.hyoiCount56Win = shamanKing.hyoiCount56Win
        shamanKingMemory2.hyoiCount56Sum = shamanKing.hyoiCount56Sum
        shamanKingMemory2.hyoiCount4Lose = shamanKing.hyoiCount4Lose
        shamanKingMemory2.hyoiCount4Win = shamanKing.hyoiCount4Win
        shamanKingMemory2.hyoiCount4Sum = shamanKing.hyoiCount4Sum
        shamanKingMemory2.hyoiCount3Lose = shamanKing.hyoiCount3Lose
        shamanKingMemory2.hyoiCount3Win = shamanKing.hyoiCount3Win
        shamanKingMemory2.hyoiCount3Sum = shamanKing.hyoiCount3Sum
        shamanKingMemory2.inputGame = shamanKing.inputGame
        shamanKingMemory2.inputShamanBonusCount = shamanKing.inputShamanBonusCount
        shamanKingMemory2.inputEpisodeBonusCount = shamanKing.inputEpisodeBonusCount
        shamanKingMemory2.bonusCountSum = shamanKing.bonusCountSum
        shamanKingMemory2.inputShamanFightCount = shamanKing.inputShamanFightCount
        shamanKingMemory2.endingCountDefault = shamanKing.endingCountDefault
        shamanKingMemory2.endingCountGusuJaku = shamanKing.endingCountGusuJaku
        shamanKingMemory2.endingCountGusuKyo = shamanKing.endingCountGusuKyo
        shamanKingMemory2.endingCountKisuJaku = shamanKing.endingCountKisuJaku
        shamanKingMemory2.endingCountKisuKyo = shamanKing.endingCountKisuKyo
        shamanKingMemory2.endingCountOver2Sisa = shamanKing.endingCountOver2Sisa
        shamanKingMemory2.endingCountOver4Sisa = shamanKing.endingCountOver4Sisa
        shamanKingMemory2.endingCountOver2 = shamanKing.endingCountOver2
        shamanKingMemory2.endingCountOver4 = shamanKing.endingCountOver4
        shamanKingMemory2.endingCountOver5 = shamanKing.endingCountOver5
        shamanKingMemory2.endingCountOver6 = shamanKing.endingCountOver6
        shamanKingMemory2.endingCountSum = shamanKing.endingCountSum
        
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKingMemory2.czCountUnder600Ren = shamanKing.czCountUnder600Ren
        shamanKingMemory2.czCountUnder600Jun = shamanKing.czCountUnder600Jun
        shamanKingMemory2.czCountUnder600Ryunosuke = shamanKing.czCountUnder600Ryunosuke
        shamanKingMemory2.czCountUnder600Kokkuri = shamanKing.czCountUnder600Kokkuri
        shamanKingMemory2.czCountUnder600Sum = shamanKing.czCountUnder600Sum
        shamanKingMemory2.czCountOver600Ren = shamanKing.czCountOver600Ren
        shamanKingMemory2.czCountOver600Jun = shamanKing.czCountOver600Jun
        shamanKingMemory2.czCountOver600Ryunosuke = shamanKing.czCountOver600Ryunosuke
        shamanKingMemory2.czCountOver600Kokkuri = shamanKing.czCountOver600Kokkuri
        shamanKingMemory2.czCountOver600Sum = shamanKing.czCountOver600Sum
    }
    func saveMemory3() {
        shamanKingMemory3.jakuRareCount = shamanKing.jakuRareCount
        shamanKingMemory3.bonusKokakuCount = shamanKing.bonusKokakuCount
        shamanKingMemory3.replayCounterReplayCount = shamanKing.replayCounterReplayCount
        shamanKingMemory3.replayCounterCountSuccesss = shamanKing.replayCounterCountSuccesss
        shamanKingMemory3.hyoiCount78Lose = shamanKing.hyoiCount78Lose
        shamanKingMemory3.hyoiCount78Win = shamanKing.hyoiCount78Win
        shamanKingMemory3.hyoiCount78Sum = shamanKing.hyoiCount78Sum
        shamanKingMemory3.hyoiCount56Lose = shamanKing.hyoiCount56Lose
        shamanKingMemory3.hyoiCount56Win = shamanKing.hyoiCount56Win
        shamanKingMemory3.hyoiCount56Sum = shamanKing.hyoiCount56Sum
        shamanKingMemory3.hyoiCount4Lose = shamanKing.hyoiCount4Lose
        shamanKingMemory3.hyoiCount4Win = shamanKing.hyoiCount4Win
        shamanKingMemory3.hyoiCount4Sum = shamanKing.hyoiCount4Sum
        shamanKingMemory3.hyoiCount3Lose = shamanKing.hyoiCount3Lose
        shamanKingMemory3.hyoiCount3Win = shamanKing.hyoiCount3Win
        shamanKingMemory3.hyoiCount3Sum = shamanKing.hyoiCount3Sum
        shamanKingMemory3.inputGame = shamanKing.inputGame
        shamanKingMemory3.inputShamanBonusCount = shamanKing.inputShamanBonusCount
        shamanKingMemory3.inputEpisodeBonusCount = shamanKing.inputEpisodeBonusCount
        shamanKingMemory3.bonusCountSum = shamanKing.bonusCountSum
        shamanKingMemory3.inputShamanFightCount = shamanKing.inputShamanFightCount
        shamanKingMemory3.endingCountDefault = shamanKing.endingCountDefault
        shamanKingMemory3.endingCountGusuJaku = shamanKing.endingCountGusuJaku
        shamanKingMemory3.endingCountGusuKyo = shamanKing.endingCountGusuKyo
        shamanKingMemory3.endingCountKisuJaku = shamanKing.endingCountKisuJaku
        shamanKingMemory3.endingCountKisuKyo = shamanKing.endingCountKisuKyo
        shamanKingMemory3.endingCountOver2Sisa = shamanKing.endingCountOver2Sisa
        shamanKingMemory3.endingCountOver4Sisa = shamanKing.endingCountOver4Sisa
        shamanKingMemory3.endingCountOver2 = shamanKing.endingCountOver2
        shamanKingMemory3.endingCountOver4 = shamanKing.endingCountOver4
        shamanKingMemory3.endingCountOver5 = shamanKing.endingCountOver5
        shamanKingMemory3.endingCountOver6 = shamanKing.endingCountOver6
        shamanKingMemory3.endingCountSum = shamanKing.endingCountSum
        
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKingMemory3.czCountUnder600Ren = shamanKing.czCountUnder600Ren
        shamanKingMemory3.czCountUnder600Jun = shamanKing.czCountUnder600Jun
        shamanKingMemory3.czCountUnder600Ryunosuke = shamanKing.czCountUnder600Ryunosuke
        shamanKingMemory3.czCountUnder600Kokkuri = shamanKing.czCountUnder600Kokkuri
        shamanKingMemory3.czCountUnder600Sum = shamanKing.czCountUnder600Sum
        shamanKingMemory3.czCountOver600Ren = shamanKing.czCountOver600Ren
        shamanKingMemory3.czCountOver600Jun = shamanKing.czCountOver600Jun
        shamanKingMemory3.czCountOver600Ryunosuke = shamanKing.czCountOver600Ryunosuke
        shamanKingMemory3.czCountOver600Kokkuri = shamanKing.czCountOver600Kokkuri
        shamanKingMemory3.czCountOver600Sum = shamanKing.czCountOver600Sum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct shamanKingSubViewLoadMemory: View {
    @ObservedObject var shamanKing: ShamanKing
    @ObservedObject var shamanKingMemory1: ShamanKingMemory1
    @ObservedObject var shamanKingMemory2: ShamanKingMemory2
    @ObservedObject var shamanKingMemory3: ShamanKingMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "シャーマンキング",
            selectedMemory: $shamanKing.selectedMemory,
            memoMemory1: shamanKingMemory1.memo,
            dateDoubleMemory1: shamanKingMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: shamanKingMemory2.memo,
            dateDoubleMemory2: shamanKingMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: shamanKingMemory3.memo,
            dateDoubleMemory3: shamanKingMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        shamanKing.jakuRareCount = shamanKingMemory1.jakuRareCount
        shamanKing.bonusKokakuCount = shamanKingMemory1.bonusKokakuCount
        shamanKing.replayCounterReplayCount = shamanKingMemory1.replayCounterReplayCount
        shamanKing.replayCounterCountSuccesss = shamanKingMemory1.replayCounterCountSuccesss
        shamanKing.hyoiCount78Lose = shamanKingMemory1.hyoiCount78Lose
        shamanKing.hyoiCount78Win = shamanKingMemory1.hyoiCount78Win
        shamanKing.hyoiCount78Sum = shamanKingMemory1.hyoiCount78Sum
        shamanKing.hyoiCount56Lose = shamanKingMemory1.hyoiCount56Lose
        shamanKing.hyoiCount56Win = shamanKingMemory1.hyoiCount56Win
        shamanKing.hyoiCount56Sum = shamanKingMemory1.hyoiCount56Sum
        shamanKing.hyoiCount4Lose = shamanKingMemory1.hyoiCount4Lose
        shamanKing.hyoiCount4Win = shamanKingMemory1.hyoiCount4Win
        shamanKing.hyoiCount4Sum = shamanKingMemory1.hyoiCount4Sum
        shamanKing.hyoiCount3Lose = shamanKingMemory1.hyoiCount3Lose
        shamanKing.hyoiCount3Win = shamanKingMemory1.hyoiCount3Win
        shamanKing.hyoiCount3Sum = shamanKingMemory1.hyoiCount3Sum
        shamanKing.inputGame = shamanKingMemory1.inputGame
        shamanKing.inputShamanBonusCount = shamanKingMemory1.inputShamanBonusCount
        shamanKing.inputEpisodeBonusCount = shamanKingMemory1.inputEpisodeBonusCount
        shamanKing.bonusCountSum = shamanKingMemory1.bonusCountSum
        shamanKing.inputShamanFightCount = shamanKingMemory1.inputShamanFightCount
        shamanKing.endingCountDefault = shamanKingMemory1.endingCountDefault
        shamanKing.endingCountGusuJaku = shamanKingMemory1.endingCountGusuJaku
        shamanKing.endingCountGusuKyo = shamanKingMemory1.endingCountGusuKyo
        shamanKing.endingCountKisuJaku = shamanKingMemory1.endingCountKisuJaku
        shamanKing.endingCountKisuKyo = shamanKingMemory1.endingCountKisuKyo
        shamanKing.endingCountOver2Sisa = shamanKingMemory1.endingCountOver2Sisa
        shamanKing.endingCountOver4Sisa = shamanKingMemory1.endingCountOver4Sisa
        shamanKing.endingCountOver2 = shamanKingMemory1.endingCountOver2
        shamanKing.endingCountOver4 = shamanKingMemory1.endingCountOver4
        shamanKing.endingCountOver5 = shamanKingMemory1.endingCountOver5
        shamanKing.endingCountOver6 = shamanKingMemory1.endingCountOver6
        shamanKing.endingCountSum = shamanKingMemory1.endingCountSum
        
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKing.czCountUnder600Ren = shamanKingMemory1.czCountUnder600Ren
        shamanKing.czCountUnder600Jun = shamanKingMemory1.czCountUnder600Jun
        shamanKing.czCountUnder600Ryunosuke = shamanKingMemory1.czCountUnder600Ryunosuke
        shamanKing.czCountUnder600Kokkuri = shamanKingMemory1.czCountUnder600Kokkuri
        shamanKing.czCountUnder600Sum = shamanKingMemory1.czCountUnder600Sum
        shamanKing.czCountOver600Ren = shamanKingMemory1.czCountOver600Ren
        shamanKing.czCountOver600Jun = shamanKingMemory1.czCountOver600Jun
        shamanKing.czCountOver600Ryunosuke = shamanKingMemory1.czCountOver600Ryunosuke
        shamanKing.czCountOver600Kokkuri = shamanKingMemory1.czCountOver600Kokkuri
        shamanKing.czCountOver600Sum = shamanKingMemory1.czCountOver600Sum
    }
    func loadMemory2() {
        shamanKing.jakuRareCount = shamanKingMemory2.jakuRareCount
        shamanKing.bonusKokakuCount = shamanKingMemory2.bonusKokakuCount
        shamanKing.replayCounterReplayCount = shamanKingMemory2.replayCounterReplayCount
        shamanKing.replayCounterCountSuccesss = shamanKingMemory2.replayCounterCountSuccesss
        shamanKing.hyoiCount78Lose = shamanKingMemory2.hyoiCount78Lose
        shamanKing.hyoiCount78Win = shamanKingMemory2.hyoiCount78Win
        shamanKing.hyoiCount78Sum = shamanKingMemory2.hyoiCount78Sum
        shamanKing.hyoiCount56Lose = shamanKingMemory2.hyoiCount56Lose
        shamanKing.hyoiCount56Win = shamanKingMemory2.hyoiCount56Win
        shamanKing.hyoiCount56Sum = shamanKingMemory2.hyoiCount56Sum
        shamanKing.hyoiCount4Lose = shamanKingMemory2.hyoiCount4Lose
        shamanKing.hyoiCount4Win = shamanKingMemory2.hyoiCount4Win
        shamanKing.hyoiCount4Sum = shamanKingMemory2.hyoiCount4Sum
        shamanKing.hyoiCount3Lose = shamanKingMemory2.hyoiCount3Lose
        shamanKing.hyoiCount3Win = shamanKingMemory2.hyoiCount3Win
        shamanKing.hyoiCount3Sum = shamanKingMemory2.hyoiCount3Sum
        shamanKing.inputGame = shamanKingMemory2.inputGame
        shamanKing.inputShamanBonusCount = shamanKingMemory2.inputShamanBonusCount
        shamanKing.inputEpisodeBonusCount = shamanKingMemory2.inputEpisodeBonusCount
        shamanKing.bonusCountSum = shamanKingMemory2.bonusCountSum
        shamanKing.inputShamanFightCount = shamanKingMemory2.inputShamanFightCount
        shamanKing.endingCountDefault = shamanKingMemory2.endingCountDefault
        shamanKing.endingCountGusuJaku = shamanKingMemory2.endingCountGusuJaku
        shamanKing.endingCountGusuKyo = shamanKingMemory2.endingCountGusuKyo
        shamanKing.endingCountKisuJaku = shamanKingMemory2.endingCountKisuJaku
        shamanKing.endingCountKisuKyo = shamanKingMemory2.endingCountKisuKyo
        shamanKing.endingCountOver2Sisa = shamanKingMemory2.endingCountOver2Sisa
        shamanKing.endingCountOver4Sisa = shamanKingMemory2.endingCountOver4Sisa
        shamanKing.endingCountOver2 = shamanKingMemory2.endingCountOver2
        shamanKing.endingCountOver4 = shamanKingMemory2.endingCountOver4
        shamanKing.endingCountOver5 = shamanKingMemory2.endingCountOver5
        shamanKing.endingCountOver6 = shamanKingMemory2.endingCountOver6
        shamanKing.endingCountSum = shamanKingMemory2.endingCountSum
        
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKing.czCountUnder600Ren = shamanKingMemory2.czCountUnder600Ren
        shamanKing.czCountUnder600Jun = shamanKingMemory2.czCountUnder600Jun
        shamanKing.czCountUnder600Ryunosuke = shamanKingMemory2.czCountUnder600Ryunosuke
        shamanKing.czCountUnder600Kokkuri = shamanKingMemory2.czCountUnder600Kokkuri
        shamanKing.czCountUnder600Sum = shamanKingMemory2.czCountUnder600Sum
        shamanKing.czCountOver600Ren = shamanKingMemory2.czCountOver600Ren
        shamanKing.czCountOver600Jun = shamanKingMemory2.czCountOver600Jun
        shamanKing.czCountOver600Ryunosuke = shamanKingMemory2.czCountOver600Ryunosuke
        shamanKing.czCountOver600Kokkuri = shamanKingMemory2.czCountOver600Kokkuri
        shamanKing.czCountOver600Sum = shamanKingMemory2.czCountOver600Sum
    }
    func loadMemory3() {
        shamanKing.jakuRareCount = shamanKingMemory3.jakuRareCount
        shamanKing.bonusKokakuCount = shamanKingMemory3.bonusKokakuCount
        shamanKing.replayCounterReplayCount = shamanKingMemory3.replayCounterReplayCount
        shamanKing.replayCounterCountSuccesss = shamanKingMemory3.replayCounterCountSuccesss
        shamanKing.hyoiCount78Lose = shamanKingMemory3.hyoiCount78Lose
        shamanKing.hyoiCount78Win = shamanKingMemory3.hyoiCount78Win
        shamanKing.hyoiCount78Sum = shamanKingMemory3.hyoiCount78Sum
        shamanKing.hyoiCount56Lose = shamanKingMemory3.hyoiCount56Lose
        shamanKing.hyoiCount56Win = shamanKingMemory3.hyoiCount56Win
        shamanKing.hyoiCount56Sum = shamanKingMemory3.hyoiCount56Sum
        shamanKing.hyoiCount4Lose = shamanKingMemory3.hyoiCount4Lose
        shamanKing.hyoiCount4Win = shamanKingMemory3.hyoiCount4Win
        shamanKing.hyoiCount4Sum = shamanKingMemory3.hyoiCount4Sum
        shamanKing.hyoiCount3Lose = shamanKingMemory3.hyoiCount3Lose
        shamanKing.hyoiCount3Win = shamanKingMemory3.hyoiCount3Win
        shamanKing.hyoiCount3Sum = shamanKingMemory3.hyoiCount3Sum
        shamanKing.inputGame = shamanKingMemory3.inputGame
        shamanKing.inputShamanBonusCount = shamanKingMemory3.inputShamanBonusCount
        shamanKing.inputEpisodeBonusCount = shamanKingMemory3.inputEpisodeBonusCount
        shamanKing.bonusCountSum = shamanKingMemory3.bonusCountSum
        shamanKing.inputShamanFightCount = shamanKingMemory3.inputShamanFightCount
        shamanKing.endingCountDefault = shamanKingMemory3.endingCountDefault
        shamanKing.endingCountGusuJaku = shamanKingMemory3.endingCountGusuJaku
        shamanKing.endingCountGusuKyo = shamanKingMemory3.endingCountGusuKyo
        shamanKing.endingCountKisuJaku = shamanKingMemory3.endingCountKisuJaku
        shamanKing.endingCountKisuKyo = shamanKingMemory3.endingCountKisuKyo
        shamanKing.endingCountOver2Sisa = shamanKingMemory3.endingCountOver2Sisa
        shamanKing.endingCountOver4Sisa = shamanKingMemory3.endingCountOver4Sisa
        shamanKing.endingCountOver2 = shamanKingMemory3.endingCountOver2
        shamanKing.endingCountOver4 = shamanKingMemory3.endingCountOver4
        shamanKing.endingCountOver5 = shamanKingMemory3.endingCountOver5
        shamanKing.endingCountOver6 = shamanKingMemory3.endingCountOver6
        shamanKing.endingCountSum = shamanKingMemory3.endingCountSum
        
        // ///////////////////////
        // ver2.7.0で追加
        // CZ当選時の振分け
        // ///////////////////////
        shamanKing.czCountUnder600Ren = shamanKingMemory3.czCountUnder600Ren
        shamanKing.czCountUnder600Jun = shamanKingMemory3.czCountUnder600Jun
        shamanKing.czCountUnder600Ryunosuke = shamanKingMemory3.czCountUnder600Ryunosuke
        shamanKing.czCountUnder600Kokkuri = shamanKingMemory3.czCountUnder600Kokkuri
        shamanKing.czCountUnder600Sum = shamanKingMemory3.czCountUnder600Sum
        shamanKing.czCountOver600Ren = shamanKingMemory3.czCountOver600Ren
        shamanKing.czCountOver600Jun = shamanKingMemory3.czCountOver600Jun
        shamanKing.czCountOver600Ryunosuke = shamanKingMemory3.czCountOver600Ryunosuke
        shamanKing.czCountOver600Kokkuri = shamanKingMemory3.czCountOver600Kokkuri
        shamanKing.czCountOver600Sum = shamanKingMemory3.czCountOver600Sum
    }
}

#Preview {
    shamanKingViewTop()
}
