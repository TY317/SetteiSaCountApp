//
//  magiaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import SwiftUI
import FirebaseAnalytics

struct magiaViewTop: View {
//    @ObservedObject var ver310: Ver310
//    @ObservedObject var magia = Magia()
    @StateObject var magia = Magia()
    @State var isShowAlert: Bool = false
    @StateObject var magiaMemory1 = MagiaMemory1()
    @StateObject var magiaMemory2 = MagiaMemory2()
    @StateObject var magiaMemory3 = MagiaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "マギアレコード")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: magiaViewNormal(
//                        ver310: ver310,
                        magia: magia
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
//                            badgeStatus: ver310.magiaMenuNormalBadgeStatus
                        )
                    }
                    // 初当り
                    NavigationLink(destination: magiaViewFirstHit(magia: magia)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り"
//                            badgeStatus: ver271.magiaMenuFirstHitBadgeStatus
                        )
                    }
                    // BIG終了画面
                    NavigationLink(destination: magiaViewBigScreen(
//                        ver300: ver300,
                        magia: magia
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面"
//                            badgeStatus: ver300.magiaMenuBonusScreenBadgeStatus
                        )
                    }
                    // ボーナス終了後ボイス
                    NavigationLink(destination: magiaViewVoice(
//                        ver310: ver310,
                        magia: magia
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "BIG終了後ボイス"
//                            badgeStatus: ver310.magiaMenuVoiceBadgeStatus
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: magiaViewAtScreen(magia: magia)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
//                            badgeStatus: ver271.magiaMenuAtScreenBadgeStatus
                        )
                    }
                    // ボーナス,AT後の高確スタート
                    NavigationLink(destination: magiaViewKokakuStart(magia: magia)) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "ビッグ,AT後の高確スタート"
//                            badgeStatus: ver280.magiaKokakuStartBadgeStatus
                        )
                    }
                    // ストーリーのキャラ紹介
                    NavigationLink(destination: magiaViewStoryChara(
//                        ver310: ver310
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "ストーリーのキャラ紹介"
//                            badgeStatus: ver310.magiaMenuStoryCharaBadgeStatus
                        )
                    }
                    // エンディング
                    NavigationLink(destination: magiaViewEnding(
//                        ver310: ver310,
                        magia: magia
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
//                            badgeStatus: ver310.magiaMenuEndingBadgeStatus
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: magiaView95Ci(magia: magia)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4745")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "マギアレコード", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "magiaViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: magiaViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver310.magiaMachineIconBadgeStatus != "none" {
//                ver310.magiaMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(magiaSubViewLoadMemory(
                        magia: magia,
                        magiaMemory1: magiaMemory1,
                        magiaMemory2: magiaMemory2,
                        magiaMemory3: magiaMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(magiaSubViewSaveMemory(
                        magia: magia,
                        magiaMemory1: magiaMemory1,
                        magiaMemory2: magiaMemory2,
                        magiaMemory3: magiaMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct magiaSubViewSaveMemory: View {
    @ObservedObject var magia: Magia
    @ObservedObject var magiaMemory1: MagiaMemory1
    @ObservedObject var magiaMemory2: MagiaMemory2
    @ObservedObject var magiaMemory3: MagiaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "マギアレコード",
            selectedMemory: $magia.selectedMemory,
            memoMemory1: $magiaMemory1.memo,
            dateDoubleMemory1: $magiaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $magiaMemory2.memo,
            dateDoubleMemory2: $magiaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $magiaMemory3.memo,
            dateDoubleMemory3: $magiaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        magiaMemory1.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory1.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory1.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory1.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory1.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory1.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory1.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory1.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory1.normalPlayGame = magia.normalPlayGame
        magiaMemory1.bonusCountBig = magia.bonusCountBig
        magiaMemory1.bonusCountMitama = magia.bonusCountMitama
        magiaMemory1.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory1.bonusCountSum = magia.bonusCountSum
        magiaMemory1.atCount = magia.atCount
        magiaMemory1.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory1.atScreenCount356 = magia.atScreenCount356
        magiaMemory1.atScreenCount246 = magia.atScreenCount246
        magiaMemory1.atScreenCountSum = magia.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magiaMemory1.kokakuStartAfterAtCountNone = magia.kokakuStartAfterAtCountNone
        magiaMemory1.kokakuStartAfterAtCountHit = magia.kokakuStartAfterAtCountHit
        magiaMemory1.kokakuStartAfterAtCountSum = magia.kokakuStartAfterAtCountSum
        magiaMemory1.kokakuStartAfterBonusCountNone = magia.kokakuStartAfterBonusCountNone
        magiaMemory1.kokakuStartAfterBonusCountHit = magia.kokakuStartAfterBonusCountHit
        magiaMemory1.kokakuStartAfterBonusCountSum = magia.kokakuStartAfterBonusCountSum
        magiaMemory1.endingCountKisu = magia.endingCountKisu
        magiaMemory1.endingCountGusu = magia.endingCountGusu
        magiaMemory1.endingCountHigh = magia.endingCountHigh
        magiaMemory1.endingCountSum = magia.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magiaMemory1.bigScreenCountOver2 = magia.bigScreenCountOver2
        magiaMemory1.bigScreenCountOver4 = magia.bigScreenCountOver4
        magiaMemory1.bigScreenCountOver5 = magia.bigScreenCountOver5
        magiaMemory1.bigScreenCountOver6 = magia.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magiaMemory1.endingCountKisuKyo = magia.endingCountKisuKyo
        magiaMemory1.endingCountGusuKyo = magia.endingCountGusuKyo
        magiaMemory1.endingCountHighKyo = magia.endingCountHighKyo
        magiaMemory1.endingCountNegate2 = magia.endingCountNegate2
        magiaMemory1.endingCountNegate3 = magia.endingCountNegate3
        magiaMemory1.endingCountNegate4 = magia.endingCountNegate4
        magiaMemory1.endingCountNegate1High = magia.endingCountNegate1High
        magiaMemory1.endingCountNegate4High = magia.endingCountNegate4High
        magiaMemory1.endingCountOver4 = magia.endingCountOver4
        magiaMemory1.atScreenCountOver6 = magia.atScreenCountOver6
        magiaMemory1.mgmTransferCountIroha = magia.mgmTransferCountIroha
        magiaMemory1.mgmTransferCountYachiyo = magia.mgmTransferCountYachiyo
        magiaMemory1.mgmTransferCountTsuruno = magia.mgmTransferCountTsuruno
        magiaMemory1.mgmTransferCountFerishia = magia.mgmTransferCountFerishia
        magiaMemory1.mgmTransferCountSana = magia.mgmTransferCountSana
        magiaMemory1.mgmTransferCountKuroe = magia.mgmTransferCountKuroe
        magiaMemory1.mgmTransferCountSum = magia.mgmTransferCountSum
        magiaMemory1.mgmRisingCountIroha = magia.mgmRisingCountIroha
        magiaMemory1.mgmRisingCountYachiyo = magia.mgmRisingCountYachiyo
        magiaMemory1.mgmRisingCountTsuruno = magia.mgmRisingCountTsuruno
        magiaMemory1.mgmRisingCountFerishia = magia.mgmRisingCountFerishia
        magiaMemory1.mgmRisingCountSana = magia.mgmRisingCountSana
        magiaMemory1.mgmRisingCountKuroe = magia.mgmRisingCountKuroe
        magiaMemory1.mgmRisingCountSum = magia.mgmRisingCountSum
    }
    func saveMemory2() {
        magiaMemory2.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory2.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory2.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory2.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory2.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory2.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory2.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory2.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory2.normalPlayGame = magia.normalPlayGame
        magiaMemory2.bonusCountBig = magia.bonusCountBig
        magiaMemory2.bonusCountMitama = magia.bonusCountMitama
        magiaMemory2.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory2.bonusCountSum = magia.bonusCountSum
        magiaMemory2.atCount = magia.atCount
        magiaMemory2.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory2.atScreenCount356 = magia.atScreenCount356
        magiaMemory2.atScreenCount246 = magia.atScreenCount246
        magiaMemory2.atScreenCountSum = magia.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magiaMemory2.kokakuStartAfterAtCountNone = magia.kokakuStartAfterAtCountNone
        magiaMemory2.kokakuStartAfterAtCountHit = magia.kokakuStartAfterAtCountHit
        magiaMemory2.kokakuStartAfterAtCountSum = magia.kokakuStartAfterAtCountSum
        magiaMemory2.kokakuStartAfterBonusCountNone = magia.kokakuStartAfterBonusCountNone
        magiaMemory2.kokakuStartAfterBonusCountHit = magia.kokakuStartAfterBonusCountHit
        magiaMemory2.kokakuStartAfterBonusCountSum = magia.kokakuStartAfterBonusCountSum
        magiaMemory2.endingCountKisu = magia.endingCountKisu
        magiaMemory2.endingCountGusu = magia.endingCountGusu
        magiaMemory2.endingCountHigh = magia.endingCountHigh
        magiaMemory2.endingCountSum = magia.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magiaMemory2.bigScreenCountOver2 = magia.bigScreenCountOver2
        magiaMemory2.bigScreenCountOver4 = magia.bigScreenCountOver4
        magiaMemory2.bigScreenCountOver5 = magia.bigScreenCountOver5
        magiaMemory2.bigScreenCountOver6 = magia.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magiaMemory2.endingCountKisuKyo = magia.endingCountKisuKyo
        magiaMemory2.endingCountGusuKyo = magia.endingCountGusuKyo
        magiaMemory2.endingCountHighKyo = magia.endingCountHighKyo
        magiaMemory2.endingCountNegate2 = magia.endingCountNegate2
        magiaMemory2.endingCountNegate3 = magia.endingCountNegate3
        magiaMemory2.endingCountNegate4 = magia.endingCountNegate4
        magiaMemory2.endingCountNegate1High = magia.endingCountNegate1High
        magiaMemory2.endingCountNegate4High = magia.endingCountNegate4High
        magiaMemory2.endingCountOver4 = magia.endingCountOver4
        magiaMemory2.atScreenCountOver6 = magia.atScreenCountOver6
        magiaMemory2.mgmTransferCountIroha = magia.mgmTransferCountIroha
        magiaMemory2.mgmTransferCountYachiyo = magia.mgmTransferCountYachiyo
        magiaMemory2.mgmTransferCountTsuruno = magia.mgmTransferCountTsuruno
        magiaMemory2.mgmTransferCountFerishia = magia.mgmTransferCountFerishia
        magiaMemory2.mgmTransferCountSana = magia.mgmTransferCountSana
        magiaMemory2.mgmTransferCountKuroe = magia.mgmTransferCountKuroe
        magiaMemory2.mgmTransferCountSum = magia.mgmTransferCountSum
        magiaMemory2.mgmRisingCountIroha = magia.mgmRisingCountIroha
        magiaMemory2.mgmRisingCountYachiyo = magia.mgmRisingCountYachiyo
        magiaMemory2.mgmRisingCountTsuruno = magia.mgmRisingCountTsuruno
        magiaMemory2.mgmRisingCountFerishia = magia.mgmRisingCountFerishia
        magiaMemory2.mgmRisingCountSana = magia.mgmRisingCountSana
        magiaMemory2.mgmRisingCountKuroe = magia.mgmRisingCountKuroe
        magiaMemory2.mgmRisingCountSum = magia.mgmRisingCountSum
    }
    func saveMemory3() {
        magiaMemory3.suikaCzCountSuika = magia.suikaCzCountSuika
        magiaMemory3.suikaCzCountCz = magia.suikaCzCountCz
        magiaMemory3.bigScreenCountDefault = magia.bigScreenCountDefault
        magiaMemory3.bigScreenCount356 = magia.bigScreenCount356
        magiaMemory3.bigScreenCount246 = magia.bigScreenCount246
        magiaMemory3.bigScreenCountHigh1 = magia.bigScreenCountHigh1
        magiaMemory3.bigScreenCountHigh2 = magia.bigScreenCountHigh2
        magiaMemory3.bigScreenCountSum = magia.bigScreenCountSum
        magiaMemory3.normalPlayGame = magia.normalPlayGame
        magiaMemory3.bonusCountBig = magia.bonusCountBig
        magiaMemory3.bonusCountMitama = magia.bonusCountMitama
        magiaMemory3.bonusCountEpisode = magia.bonusCountEpisode
        magiaMemory3.bonusCountSum = magia.bonusCountSum
        magiaMemory3.atCount = magia.atCount
        magiaMemory3.atScreenCountDefault = magia.atScreenCountDefault
        magiaMemory3.atScreenCount356 = magia.atScreenCount356
        magiaMemory3.atScreenCount246 = magia.atScreenCount246
        magiaMemory3.atScreenCountSum = magia.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magiaMemory3.kokakuStartAfterAtCountNone = magia.kokakuStartAfterAtCountNone
        magiaMemory3.kokakuStartAfterAtCountHit = magia.kokakuStartAfterAtCountHit
        magiaMemory3.kokakuStartAfterAtCountSum = magia.kokakuStartAfterAtCountSum
        magiaMemory3.kokakuStartAfterBonusCountNone = magia.kokakuStartAfterBonusCountNone
        magiaMemory3.kokakuStartAfterBonusCountHit = magia.kokakuStartAfterBonusCountHit
        magiaMemory3.kokakuStartAfterBonusCountSum = magia.kokakuStartAfterBonusCountSum
        magiaMemory3.endingCountKisu = magia.endingCountKisu
        magiaMemory3.endingCountGusu = magia.endingCountGusu
        magiaMemory3.endingCountHigh = magia.endingCountHigh
        magiaMemory3.endingCountSum = magia.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magiaMemory3.bigScreenCountOver2 = magia.bigScreenCountOver2
        magiaMemory3.bigScreenCountOver4 = magia.bigScreenCountOver4
        magiaMemory3.bigScreenCountOver5 = magia.bigScreenCountOver5
        magiaMemory3.bigScreenCountOver6 = magia.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magiaMemory3.endingCountKisuKyo = magia.endingCountKisuKyo
        magiaMemory3.endingCountGusuKyo = magia.endingCountGusuKyo
        magiaMemory3.endingCountHighKyo = magia.endingCountHighKyo
        magiaMemory3.endingCountNegate2 = magia.endingCountNegate2
        magiaMemory3.endingCountNegate3 = magia.endingCountNegate3
        magiaMemory3.endingCountNegate4 = magia.endingCountNegate4
        magiaMemory3.endingCountNegate1High = magia.endingCountNegate1High
        magiaMemory3.endingCountNegate4High = magia.endingCountNegate4High
        magiaMemory3.endingCountOver4 = magia.endingCountOver4
        magiaMemory3.atScreenCountOver6 = magia.atScreenCountOver6
        magiaMemory3.mgmTransferCountIroha = magia.mgmTransferCountIroha
        magiaMemory3.mgmTransferCountYachiyo = magia.mgmTransferCountYachiyo
        magiaMemory3.mgmTransferCountTsuruno = magia.mgmTransferCountTsuruno
        magiaMemory3.mgmTransferCountFerishia = magia.mgmTransferCountFerishia
        magiaMemory3.mgmTransferCountSana = magia.mgmTransferCountSana
        magiaMemory3.mgmTransferCountKuroe = magia.mgmTransferCountKuroe
        magiaMemory3.mgmTransferCountSum = magia.mgmTransferCountSum
        magiaMemory3.mgmRisingCountIroha = magia.mgmRisingCountIroha
        magiaMemory3.mgmRisingCountYachiyo = magia.mgmRisingCountYachiyo
        magiaMemory3.mgmRisingCountTsuruno = magia.mgmRisingCountTsuruno
        magiaMemory3.mgmRisingCountFerishia = magia.mgmRisingCountFerishia
        magiaMemory3.mgmRisingCountSana = magia.mgmRisingCountSana
        magiaMemory3.mgmRisingCountKuroe = magia.mgmRisingCountKuroe
        magiaMemory3.mgmRisingCountSum = magia.mgmRisingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct magiaSubViewLoadMemory: View {
    @ObservedObject var magia: Magia
    @ObservedObject var magiaMemory1: MagiaMemory1
    @ObservedObject var magiaMemory2: MagiaMemory2
    @ObservedObject var magiaMemory3: MagiaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "マギアレコード",
            selectedMemory: $magia.selectedMemory,
            memoMemory1: magiaMemory1.memo,
            dateDoubleMemory1: magiaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: magiaMemory2.memo,
            dateDoubleMemory2: magiaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: magiaMemory3.memo,
            dateDoubleMemory3: magiaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        magia.suikaCzCountSuika = magiaMemory1.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory1.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory1.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory1.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory1.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory1.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory1.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory1.bigScreenCountSum
        magia.normalPlayGame = magiaMemory1.normalPlayGame
        magia.bonusCountBig = magiaMemory1.bonusCountBig
        magia.bonusCountMitama = magiaMemory1.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory1.bonusCountEpisode
        magia.bonusCountSum = magiaMemory1.bonusCountSum
        magia.atCount = magiaMemory1.atCount
        magia.atScreenCountDefault = magiaMemory1.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory1.atScreenCount356
        magia.atScreenCount246 = magiaMemory1.atScreenCount246
        magia.atScreenCountSum = magiaMemory1.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magia.kokakuStartAfterAtCountNone = magiaMemory1.kokakuStartAfterAtCountNone
        magia.kokakuStartAfterAtCountHit = magiaMemory1.kokakuStartAfterAtCountHit
        magia.kokakuStartAfterAtCountSum = magiaMemory1.kokakuStartAfterAtCountSum
        magia.kokakuStartAfterBonusCountNone = magiaMemory1.kokakuStartAfterBonusCountNone
        magia.kokakuStartAfterBonusCountHit = magiaMemory1.kokakuStartAfterBonusCountHit
        magia.kokakuStartAfterBonusCountSum = magiaMemory1.kokakuStartAfterBonusCountSum
        magia.endingCountKisu = magiaMemory1.endingCountKisu
        magia.endingCountGusu = magiaMemory1.endingCountGusu
        magia.endingCountHigh = magiaMemory1.endingCountHigh
        magia.endingCountSum = magiaMemory1.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magia.bigScreenCountOver2 = magiaMemory1.bigScreenCountOver2
        magia.bigScreenCountOver4 = magiaMemory1.bigScreenCountOver4
        magia.bigScreenCountOver5 = magiaMemory1.bigScreenCountOver5
        magia.bigScreenCountOver6 = magiaMemory1.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magia.endingCountKisuKyo = magiaMemory1.endingCountKisuKyo
        magia.endingCountGusuKyo = magiaMemory1.endingCountGusuKyo
        magia.endingCountHighKyo = magiaMemory1.endingCountHighKyo
        magia.endingCountNegate2 = magiaMemory1.endingCountNegate2
        magia.endingCountNegate3 = magiaMemory1.endingCountNegate3
        magia.endingCountNegate4 = magiaMemory1.endingCountNegate4
        magia.endingCountNegate1High = magiaMemory1.endingCountNegate1High
        magia.endingCountNegate4High = magiaMemory1.endingCountNegate4High
        magia.endingCountOver4 = magiaMemory1.endingCountOver4
        magia.atScreenCountOver6 = magiaMemory1.atScreenCountOver6
        magia.mgmTransferCountIroha = magiaMemory1.mgmTransferCountIroha
        magia.mgmTransferCountYachiyo = magiaMemory1.mgmTransferCountYachiyo
        magia.mgmTransferCountTsuruno = magiaMemory1.mgmTransferCountTsuruno
        magia.mgmTransferCountFerishia = magiaMemory1.mgmTransferCountFerishia
        magia.mgmTransferCountSana = magiaMemory1.mgmTransferCountSana
        magia.mgmTransferCountKuroe = magiaMemory1.mgmTransferCountKuroe
        magia.mgmTransferCountSum = magiaMemory1.mgmTransferCountSum
        magia.mgmRisingCountIroha = magiaMemory1.mgmRisingCountIroha
        magia.mgmRisingCountYachiyo = magiaMemory1.mgmRisingCountYachiyo
        magia.mgmRisingCountTsuruno = magiaMemory1.mgmRisingCountTsuruno
        magia.mgmRisingCountFerishia = magiaMemory1.mgmRisingCountFerishia
        magia.mgmRisingCountSana = magiaMemory1.mgmRisingCountSana
        magia.mgmRisingCountKuroe = magiaMemory1.mgmRisingCountKuroe
        magia.mgmRisingCountSum = magiaMemory1.mgmRisingCountSum
    }
    func loadMemory2() {
        magia.suikaCzCountSuika = magiaMemory2.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory2.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory2.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory2.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory2.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory2.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory2.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory2.bigScreenCountSum
        magia.normalPlayGame = magiaMemory2.normalPlayGame
        magia.bonusCountBig = magiaMemory2.bonusCountBig
        magia.bonusCountMitama = magiaMemory2.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory2.bonusCountEpisode
        magia.bonusCountSum = magiaMemory2.bonusCountSum
        magia.atCount = magiaMemory2.atCount
        magia.atScreenCountDefault = magiaMemory2.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory2.atScreenCount356
        magia.atScreenCount246 = magiaMemory2.atScreenCount246
        magia.atScreenCountSum = magiaMemory2.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magia.kokakuStartAfterAtCountNone = magiaMemory2.kokakuStartAfterAtCountNone
        magia.kokakuStartAfterAtCountHit = magiaMemory2.kokakuStartAfterAtCountHit
        magia.kokakuStartAfterAtCountSum = magiaMemory2.kokakuStartAfterAtCountSum
        magia.kokakuStartAfterBonusCountNone = magiaMemory2.kokakuStartAfterBonusCountNone
        magia.kokakuStartAfterBonusCountHit = magiaMemory2.kokakuStartAfterBonusCountHit
        magia.kokakuStartAfterBonusCountSum = magiaMemory2.kokakuStartAfterBonusCountSum
        magia.endingCountKisu = magiaMemory2.endingCountKisu
        magia.endingCountGusu = magiaMemory2.endingCountGusu
        magia.endingCountHigh = magiaMemory2.endingCountHigh
        magia.endingCountSum = magiaMemory2.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magia.bigScreenCountOver2 = magiaMemory2.bigScreenCountOver2
        magia.bigScreenCountOver4 = magiaMemory2.bigScreenCountOver4
        magia.bigScreenCountOver5 = magiaMemory2.bigScreenCountOver5
        magia.bigScreenCountOver6 = magiaMemory2.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magia.endingCountKisuKyo = magiaMemory2.endingCountKisuKyo
        magia.endingCountGusuKyo = magiaMemory2.endingCountGusuKyo
        magia.endingCountHighKyo = magiaMemory2.endingCountHighKyo
        magia.endingCountNegate2 = magiaMemory2.endingCountNegate2
        magia.endingCountNegate3 = magiaMemory2.endingCountNegate3
        magia.endingCountNegate4 = magiaMemory2.endingCountNegate4
        magia.endingCountNegate1High = magiaMemory2.endingCountNegate1High
        magia.endingCountNegate4High = magiaMemory2.endingCountNegate4High
        magia.endingCountOver4 = magiaMemory2.endingCountOver4
        magia.atScreenCountOver6 = magiaMemory2.atScreenCountOver6
        magia.mgmTransferCountIroha = magiaMemory2.mgmTransferCountIroha
        magia.mgmTransferCountYachiyo = magiaMemory2.mgmTransferCountYachiyo
        magia.mgmTransferCountTsuruno = magiaMemory2.mgmTransferCountTsuruno
        magia.mgmTransferCountFerishia = magiaMemory2.mgmTransferCountFerishia
        magia.mgmTransferCountSana = magiaMemory2.mgmTransferCountSana
        magia.mgmTransferCountKuroe = magiaMemory2.mgmTransferCountKuroe
        magia.mgmTransferCountSum = magiaMemory2.mgmTransferCountSum
        magia.mgmRisingCountIroha = magiaMemory2.mgmRisingCountIroha
        magia.mgmRisingCountYachiyo = magiaMemory2.mgmRisingCountYachiyo
        magia.mgmRisingCountTsuruno = magiaMemory2.mgmRisingCountTsuruno
        magia.mgmRisingCountFerishia = magiaMemory2.mgmRisingCountFerishia
        magia.mgmRisingCountSana = magiaMemory2.mgmRisingCountSana
        magia.mgmRisingCountKuroe = magiaMemory2.mgmRisingCountKuroe
        magia.mgmRisingCountSum = magiaMemory2.mgmRisingCountSum
    }
    func loadMemory3() {
        magia.suikaCzCountSuika = magiaMemory3.suikaCzCountSuika
        magia.suikaCzCountCz = magiaMemory3.suikaCzCountCz
        magia.bigScreenCountDefault = magiaMemory3.bigScreenCountDefault
        magia.bigScreenCount356 = magiaMemory3.bigScreenCount356
        magia.bigScreenCount246 = magiaMemory3.bigScreenCount246
        magia.bigScreenCountHigh1 = magiaMemory3.bigScreenCountHigh1
        magia.bigScreenCountHigh2 = magiaMemory3.bigScreenCountHigh2
        magia.bigScreenCountSum = magiaMemory3.bigScreenCountSum
        magia.normalPlayGame = magiaMemory3.normalPlayGame
        magia.bonusCountBig = magiaMemory3.bonusCountBig
        magia.bonusCountMitama = magiaMemory3.bonusCountMitama
        magia.bonusCountEpisode = magiaMemory3.bonusCountEpisode
        magia.bonusCountSum = magiaMemory3.bonusCountSum
        magia.atCount = magiaMemory3.atCount
        magia.atScreenCountDefault = magiaMemory3.atScreenCountDefault
        magia.atScreenCount356 = magiaMemory3.atScreenCount356
        magia.atScreenCount246 = magiaMemory3.atScreenCount246
        magia.atScreenCountSum = magiaMemory3.atScreenCountSum
        
        // ///////////////////////
        // ver2.8.0で追加
        // ///////////////////////
        magia.kokakuStartAfterAtCountNone = magiaMemory3.kokakuStartAfterAtCountNone
        magia.kokakuStartAfterAtCountHit = magiaMemory3.kokakuStartAfterAtCountHit
        magia.kokakuStartAfterAtCountSum = magiaMemory3.kokakuStartAfterAtCountSum
        magia.kokakuStartAfterBonusCountNone = magiaMemory3.kokakuStartAfterBonusCountNone
        magia.kokakuStartAfterBonusCountHit = magiaMemory3.kokakuStartAfterBonusCountHit
        magia.kokakuStartAfterBonusCountSum = magiaMemory3.kokakuStartAfterBonusCountSum
        magia.endingCountKisu = magiaMemory3.endingCountKisu
        magia.endingCountGusu = magiaMemory3.endingCountGusu
        magia.endingCountHigh = magiaMemory3.endingCountHigh
        magia.endingCountSum = magiaMemory3.endingCountSum
        
        // ///////////////////
        // ver3.0.0で追加
        // ///////////////////
        magia.bigScreenCountOver2 = magiaMemory3.bigScreenCountOver2
        magia.bigScreenCountOver4 = magiaMemory3.bigScreenCountOver4
        magia.bigScreenCountOver5 = magiaMemory3.bigScreenCountOver5
        magia.bigScreenCountOver6 = magiaMemory3.bigScreenCountOver6
        
        // //////////////
        // ver3.1.0で追加
        // //////////////
        magia.endingCountKisuKyo = magiaMemory3.endingCountKisuKyo
        magia.endingCountGusuKyo = magiaMemory3.endingCountGusuKyo
        magia.endingCountHighKyo = magiaMemory3.endingCountHighKyo
        magia.endingCountNegate2 = magiaMemory3.endingCountNegate2
        magia.endingCountNegate3 = magiaMemory3.endingCountNegate3
        magia.endingCountNegate4 = magiaMemory3.endingCountNegate4
        magia.endingCountNegate1High = magiaMemory3.endingCountNegate1High
        magia.endingCountNegate4High = magiaMemory3.endingCountNegate4High
        magia.endingCountOver4 = magiaMemory3.endingCountOver4
        magia.atScreenCountOver6 = magiaMemory3.atScreenCountOver6
        magia.mgmTransferCountIroha = magiaMemory3.mgmTransferCountIroha
        magia.mgmTransferCountYachiyo = magiaMemory3.mgmTransferCountYachiyo
        magia.mgmTransferCountTsuruno = magiaMemory3.mgmTransferCountTsuruno
        magia.mgmTransferCountFerishia = magiaMemory3.mgmTransferCountFerishia
        magia.mgmTransferCountSana = magiaMemory3.mgmTransferCountSana
        magia.mgmTransferCountKuroe = magiaMemory3.mgmTransferCountKuroe
        magia.mgmTransferCountSum = magiaMemory3.mgmTransferCountSum
        magia.mgmRisingCountIroha = magiaMemory3.mgmRisingCountIroha
        magia.mgmRisingCountYachiyo = magiaMemory3.mgmRisingCountYachiyo
        magia.mgmRisingCountTsuruno = magiaMemory3.mgmRisingCountTsuruno
        magia.mgmRisingCountFerishia = magiaMemory3.mgmRisingCountFerishia
        magia.mgmRisingCountSana = magiaMemory3.mgmRisingCountSana
        magia.mgmRisingCountKuroe = magiaMemory3.mgmRisingCountKuroe
        magia.mgmRisingCountSum = magiaMemory3.mgmRisingCountSum
    }
}

#Preview {
    magiaViewTop(
//        ver310: Ver310()
    )
}
