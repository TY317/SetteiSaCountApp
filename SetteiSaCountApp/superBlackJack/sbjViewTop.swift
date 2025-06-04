//
//  sbjViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/02.
//

import SwiftUI
import FirebaseAnalytics

struct sbjViewTop: View {
//    @ObservedObject var ver310: Ver310
//    @ObservedObject var sbj = Sbj()
    @StateObject var sbj = Sbj()
    @State var isShowAlert: Bool = false
//    @ObservedObject var ver240 = Ver240()
    @StateObject var sbjMemory1 = SbjMemory1()
    @StateObject var sbjMemory2 = SbjMemory2()
    @StateObject var sbjMemory3 = SbjMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "スーパーブラックジャック", titleFont: .title2)
                }
                
                Section {
                    // 通常時の小役、高確、初当り
                    NavigationLink(destination: sbjViewNormal(
//                        ver310: ver310,
                        sbj: sbj
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時 小役、高確、初当り"
//                            badgeStatus: ver310.sbjMenuNormalBadgeStatus
                        )
                    }
                    // 規定ゲーム数でのステージ移行
                    NavigationLink(destination: sbjViewGameStageChange(sbj: sbj)) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "規定ゲーム数での移行"
//                            badgeStatus: ver240.sbjMenuGameStageChangeBadgeStatus
                        )
                    }
                    // ダイスチェック
                    NavigationLink(destination: sbjViewDiceCheck(sbj: sbj)) {
                        unitLabelMenu(
                            imageSystemName: "dice.fill",
                            textBody: "ダイスチェック"
//                            badgeStatus: ver230.sbjMenuDiceCheckBadgeStatus
                        )
                    }
                    // JAC中のトランプ
                    NavigationLink(destination: sbjViewJacTrump()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "JAC中のトランプ"
                        )
                    }
                    // ST終了画面
                    NavigationLink(destination: sbjViewEndScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面"
                        )
                    }
                    // ケロットトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: sbjView95Ci(sbj: sbj)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4712")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スーパーブラックジャック",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "スーパーブラックジャック", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "sbjViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: sbjViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver310.sbjMachineIconBadgeStatus != "none" {
//                ver310.sbjMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(sbjSubViewLoadMemory(
                        sbj: sbj,
                        sbjMemory1: sbjMemory1,
                        sbjMemory2: sbjMemory2,
                        sbjMemory3: sbjMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(sbjSubViewSaveMemory(
                        sbj: sbj,
                        sbjMemory1: sbjMemory1,
                        sbjMemory2: sbjMemory2,
                        sbjMemory3: sbjMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sbj.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct sbjSubViewSaveMemory: View {
    @ObservedObject var sbj: Sbj
    @ObservedObject var sbjMemory1: SbjMemory1
    @ObservedObject var sbjMemory2: SbjMemory2
    @ObservedObject var sbjMemory3: SbjMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "スーパーブラックジャック",
            selectedMemory: $sbj.selectedMemory,
            memoMemory1: $sbjMemory1.memo,
            dateDoubleMemory1: $sbjMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $sbjMemory2.memo,
            dateDoubleMemory2: $sbjMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $sbjMemory3.memo,
            dateDoubleMemory3: $sbjMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        sbjMemory1.kokakuCount = sbj.kokakuCount
        sbjMemory1.nextInputSumCount = sbj.nextInputSumCount
        sbjMemory1.nextInputSumDenominate = sbj.nextInputSumDenominate
        sbjMemory1.nextInputRbCount = sbj.nextInputRbCount
        sbjMemory1.nextInputRedBbCount = sbj.nextInputRedBbCount
        sbjMemory1.nextInputBlueBbCount = sbj.nextInputBlueBbCount
        sbjMemory1.bonusSum = sbj.bonusSum
        sbjMemory1.rioChanceCount = sbj.rioChanceCount
        sbjMemory1.diceLeftArrayData = sbj.diceLeftArrayData
        sbjMemory1.diceRightArrayData = sbj.diceRightArrayData
        sbjMemory1.suikaArrayData = sbj.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbjMemory1.normalChanceCount = sbj.normalChanceCount
        sbjMemory1.normalChanceKokakuCount = sbj.normalChanceKokakuCount
        sbjMemory1.normalChanceChokugekiCount = sbj.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbjMemory1.gameChangeCount100Miss = sbj.gameChangeCount100Miss
        sbjMemory1.gameChangeCount100China = sbj.gameChangeCount100China
        sbjMemory1.gameChangeCount100Kokaku = sbj.gameChangeCount100Kokaku
        sbjMemory1.gameChangeCount100Sum = sbj.gameChangeCount100Sum
        sbjMemory1.gameChangeCountGusuMiss = sbj.gameChangeCountGusuMiss
        sbjMemory1.gameChangeCountGusuChina = sbj.gameChangeCountGusuChina
        sbjMemory1.gameChangeCountGusuKokaku = sbj.gameChangeCountGusuKokaku
        sbjMemory1.gameChangeCountGusuSum = sbj.gameChangeCountGusuSum
        sbjMemory1.gameChangeCountKisuMiss = sbj.gameChangeCountKisuMiss
        sbjMemory1.gameChangeCountKisuChina = sbj.gameChangeCountKisuChina
        sbjMemory1.gameChangeCountKisuKokaku = sbj.gameChangeCountKisuKokaku
        sbjMemory1.gameChangeCountKisuSum = sbj.gameChangeCountKisuSum
    }
    func saveMemory2() {
        sbjMemory2.kokakuCount = sbj.kokakuCount
        sbjMemory2.nextInputSumCount = sbj.nextInputSumCount
        sbjMemory2.nextInputSumDenominate = sbj.nextInputSumDenominate
        sbjMemory2.nextInputRbCount = sbj.nextInputRbCount
        sbjMemory2.nextInputRedBbCount = sbj.nextInputRedBbCount
        sbjMemory2.nextInputBlueBbCount = sbj.nextInputBlueBbCount
        sbjMemory2.bonusSum = sbj.bonusSum
        sbjMemory2.rioChanceCount = sbj.rioChanceCount
        sbjMemory2.diceLeftArrayData = sbj.diceLeftArrayData
        sbjMemory2.diceRightArrayData = sbj.diceRightArrayData
        sbjMemory2.suikaArrayData = sbj.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbjMemory2.normalChanceCount = sbj.normalChanceCount
        sbjMemory2.normalChanceKokakuCount = sbj.normalChanceKokakuCount
        sbjMemory2.normalChanceChokugekiCount = sbj.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbjMemory2.gameChangeCount100Miss = sbj.gameChangeCount100Miss
        sbjMemory2.gameChangeCount100China = sbj.gameChangeCount100China
        sbjMemory2.gameChangeCount100Kokaku = sbj.gameChangeCount100Kokaku
        sbjMemory2.gameChangeCount100Sum = sbj.gameChangeCount100Sum
        sbjMemory2.gameChangeCountGusuMiss = sbj.gameChangeCountGusuMiss
        sbjMemory2.gameChangeCountGusuChina = sbj.gameChangeCountGusuChina
        sbjMemory2.gameChangeCountGusuKokaku = sbj.gameChangeCountGusuKokaku
        sbjMemory2.gameChangeCountGusuSum = sbj.gameChangeCountGusuSum
        sbjMemory2.gameChangeCountKisuMiss = sbj.gameChangeCountKisuMiss
        sbjMemory2.gameChangeCountKisuChina = sbj.gameChangeCountKisuChina
        sbjMemory2.gameChangeCountKisuKokaku = sbj.gameChangeCountKisuKokaku
        sbjMemory2.gameChangeCountKisuSum = sbj.gameChangeCountKisuSum
    }
    func saveMemory3() {
        sbjMemory3.kokakuCount = sbj.kokakuCount
        sbjMemory3.nextInputSumCount = sbj.nextInputSumCount
        sbjMemory3.nextInputSumDenominate = sbj.nextInputSumDenominate
        sbjMemory3.nextInputRbCount = sbj.nextInputRbCount
        sbjMemory3.nextInputRedBbCount = sbj.nextInputRedBbCount
        sbjMemory3.nextInputBlueBbCount = sbj.nextInputBlueBbCount
        sbjMemory3.bonusSum = sbj.bonusSum
        sbjMemory3.rioChanceCount = sbj.rioChanceCount
        sbjMemory3.diceLeftArrayData = sbj.diceLeftArrayData
        sbjMemory3.diceRightArrayData = sbj.diceRightArrayData
        sbjMemory3.suikaArrayData = sbj.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbjMemory3.normalChanceCount = sbj.normalChanceCount
        sbjMemory3.normalChanceKokakuCount = sbj.normalChanceKokakuCount
        sbjMemory3.normalChanceChokugekiCount = sbj.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbjMemory3.gameChangeCount100Miss = sbj.gameChangeCount100Miss
        sbjMemory3.gameChangeCount100China = sbj.gameChangeCount100China
        sbjMemory3.gameChangeCount100Kokaku = sbj.gameChangeCount100Kokaku
        sbjMemory3.gameChangeCount100Sum = sbj.gameChangeCount100Sum
        sbjMemory3.gameChangeCountGusuMiss = sbj.gameChangeCountGusuMiss
        sbjMemory3.gameChangeCountGusuChina = sbj.gameChangeCountGusuChina
        sbjMemory3.gameChangeCountGusuKokaku = sbj.gameChangeCountGusuKokaku
        sbjMemory3.gameChangeCountGusuSum = sbj.gameChangeCountGusuSum
        sbjMemory3.gameChangeCountKisuMiss = sbj.gameChangeCountKisuMiss
        sbjMemory3.gameChangeCountKisuChina = sbj.gameChangeCountKisuChina
        sbjMemory3.gameChangeCountKisuKokaku = sbj.gameChangeCountKisuKokaku
        sbjMemory3.gameChangeCountKisuSum = sbj.gameChangeCountKisuSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct sbjSubViewLoadMemory: View {
    @ObservedObject var sbj: Sbj
    @ObservedObject var sbjMemory1: SbjMemory1
    @ObservedObject var sbjMemory2: SbjMemory2
    @ObservedObject var sbjMemory3: SbjMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "スーパーブラックジャック",
            selectedMemory: $sbj.selectedMemory,
            memoMemory1: sbjMemory1.memo,
            dateDoubleMemory1: sbjMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: sbjMemory2.memo,
            dateDoubleMemory2: sbjMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: sbjMemory3.memo,
            dateDoubleMemory3: sbjMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        sbj.kokakuCount = sbjMemory1.kokakuCount
        sbj.nextInputSumCount = sbjMemory1.nextInputSumCount
        sbj.nextInputSumDenominate = sbjMemory1.nextInputSumDenominate
        sbj.nextInputRbCount = sbjMemory1.nextInputRbCount
        sbj.nextInputRedBbCount = sbjMemory1.nextInputRedBbCount
        sbj.nextInputBlueBbCount = sbjMemory1.nextInputBlueBbCount
        sbj.bonusSum = sbjMemory1.bonusSum
        sbj.rioChanceCount = sbjMemory1.rioChanceCount
        let memoryDiceLeftArray = decodeStringArray(from: sbjMemory1.diceLeftArrayData)
        saveArray(memoryDiceLeftArray, forKey: sbj.diceLeftArrayKey)
        let memoryDiceRightArray = decodeStringArray(from: sbjMemory1.diceRightArrayData)
        saveArray(memoryDiceRightArray, forKey: sbj.diceRightArrayKey)
        let memorySuikaArray = decodeIntArray(from: sbjMemory1.suikaArrayData)
        saveArray(memorySuikaArray, forKey: sbj.suikaArrayKey)
//        sbj.diceLeftArrayData = sbjMemory1.diceLeftArrayData
//        sbj.diceRightArrayData = sbjMemory1.diceRightArrayData
//        sbj.suikaArrayData = sbjMemory1.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory1.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory1.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory1.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbj.gameChangeCount100Miss = sbjMemory1.gameChangeCount100Miss
        sbj.gameChangeCount100China = sbjMemory1.gameChangeCount100China
        sbj.gameChangeCount100Kokaku = sbjMemory1.gameChangeCount100Kokaku
        sbj.gameChangeCount100Sum = sbjMemory1.gameChangeCount100Sum
        sbj.gameChangeCountGusuMiss = sbjMemory1.gameChangeCountGusuMiss
        sbj.gameChangeCountGusuChina = sbjMemory1.gameChangeCountGusuChina
        sbj.gameChangeCountGusuKokaku = sbjMemory1.gameChangeCountGusuKokaku
        sbj.gameChangeCountGusuSum = sbjMemory1.gameChangeCountGusuSum
        sbj.gameChangeCountKisuMiss = sbjMemory1.gameChangeCountKisuMiss
        sbj.gameChangeCountKisuChina = sbjMemory1.gameChangeCountKisuChina
        sbj.gameChangeCountKisuKokaku = sbjMemory1.gameChangeCountKisuKokaku
        sbj.gameChangeCountKisuSum = sbjMemory1.gameChangeCountKisuSum
    }
    func loadMemory2() {
        sbj.kokakuCount = sbjMemory2.kokakuCount
        sbj.nextInputSumCount = sbjMemory2.nextInputSumCount
        sbj.nextInputSumDenominate = sbjMemory2.nextInputSumDenominate
        sbj.nextInputRbCount = sbjMemory2.nextInputRbCount
        sbj.nextInputRedBbCount = sbjMemory2.nextInputRedBbCount
        sbj.nextInputBlueBbCount = sbjMemory2.nextInputBlueBbCount
        sbj.bonusSum = sbjMemory2.bonusSum
        sbj.rioChanceCount = sbjMemory2.rioChanceCount
        let memoryDiceLeftArray = decodeStringArray(from: sbjMemory2.diceLeftArrayData)
        saveArray(memoryDiceLeftArray, forKey: sbj.diceLeftArrayKey)
        let memoryDiceRightArray = decodeStringArray(from: sbjMemory2.diceRightArrayData)
        saveArray(memoryDiceRightArray, forKey: sbj.diceRightArrayKey)
        let memorySuikaArray = decodeIntArray(from: sbjMemory2.suikaArrayData)
        saveArray(memorySuikaArray, forKey: sbj.suikaArrayKey)
//        sbj.diceLeftArrayData = sbjMemory2.diceLeftArrayData
//        sbj.diceRightArrayData = sbjMemory2.diceRightArrayData
//        sbj.suikaArrayData = sbjMemory2.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory2.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory2.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory2.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbj.gameChangeCount100Miss = sbjMemory2.gameChangeCount100Miss
        sbj.gameChangeCount100China = sbjMemory2.gameChangeCount100China
        sbj.gameChangeCount100Kokaku = sbjMemory2.gameChangeCount100Kokaku
        sbj.gameChangeCount100Sum = sbjMemory2.gameChangeCount100Sum
        sbj.gameChangeCountGusuMiss = sbjMemory2.gameChangeCountGusuMiss
        sbj.gameChangeCountGusuChina = sbjMemory2.gameChangeCountGusuChina
        sbj.gameChangeCountGusuKokaku = sbjMemory2.gameChangeCountGusuKokaku
        sbj.gameChangeCountGusuSum = sbjMemory2.gameChangeCountGusuSum
        sbj.gameChangeCountKisuMiss = sbjMemory2.gameChangeCountKisuMiss
        sbj.gameChangeCountKisuChina = sbjMemory2.gameChangeCountKisuChina
        sbj.gameChangeCountKisuKokaku = sbjMemory2.gameChangeCountKisuKokaku
        sbj.gameChangeCountKisuSum = sbjMemory2.gameChangeCountKisuSum
    }
    func loadMemory3() {
        sbj.kokakuCount = sbjMemory3.kokakuCount
        sbj.nextInputSumCount = sbjMemory3.nextInputSumCount
        sbj.nextInputSumDenominate = sbjMemory3.nextInputSumDenominate
        sbj.nextInputRbCount = sbjMemory3.nextInputRbCount
        sbj.nextInputRedBbCount = sbjMemory3.nextInputRedBbCount
        sbj.nextInputBlueBbCount = sbjMemory3.nextInputBlueBbCount
        sbj.bonusSum = sbjMemory3.bonusSum
        sbj.rioChanceCount = sbjMemory3.rioChanceCount
        let memoryDiceLeftArray = decodeStringArray(from: sbjMemory3.diceLeftArrayData)
        saveArray(memoryDiceLeftArray, forKey: sbj.diceLeftArrayKey)
        let memoryDiceRightArray = decodeStringArray(from: sbjMemory3.diceRightArrayData)
        saveArray(memoryDiceRightArray, forKey: sbj.diceRightArrayKey)
        let memorySuikaArray = decodeIntArray(from: sbjMemory3.suikaArrayData)
        saveArray(memorySuikaArray, forKey: sbj.suikaArrayKey)
//        sbj.diceLeftArrayData = sbjMemory3.diceLeftArrayData
//        sbj.diceRightArrayData = sbjMemory3.diceRightArrayData
//        sbj.suikaArrayData = sbjMemory3.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory3.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory3.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory3.normalChanceChokugekiCount
        // ///////////////////////
        // ver240で追加、規定ゲーム数
        // ///////////////////////
        sbj.gameChangeCount100Miss = sbjMemory3.gameChangeCount100Miss
        sbj.gameChangeCount100China = sbjMemory3.gameChangeCount100China
        sbj.gameChangeCount100Kokaku = sbjMemory3.gameChangeCount100Kokaku
        sbj.gameChangeCount100Sum = sbjMemory3.gameChangeCount100Sum
        sbj.gameChangeCountGusuMiss = sbjMemory3.gameChangeCountGusuMiss
        sbj.gameChangeCountGusuChina = sbjMemory3.gameChangeCountGusuChina
        sbj.gameChangeCountGusuKokaku = sbjMemory3.gameChangeCountGusuKokaku
        sbj.gameChangeCountGusuSum = sbjMemory3.gameChangeCountGusuSum
        sbj.gameChangeCountKisuMiss = sbjMemory3.gameChangeCountKisuMiss
        sbj.gameChangeCountKisuChina = sbjMemory3.gameChangeCountKisuChina
        sbj.gameChangeCountKisuKokaku = sbjMemory3.gameChangeCountKisuKokaku
        sbj.gameChangeCountKisuSum = sbjMemory3.gameChangeCountKisuSum
    }
}

#Preview {
    sbjViewTop(
//        ver310: Ver310()
    )
}
