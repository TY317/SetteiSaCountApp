//
//  midoriDonViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI
import FirebaseAnalytics

struct midoriDonViewTop: View {
//    @ObservedObject var ver320: Ver320
//    @ObservedObject var ver310: Ver310
    @StateObject var midoriDon = MidoriDon()
    @State var isShowAlert: Bool = false
    @ObservedObject var midoriDonMemory1 = MidoriDonMemory1()
    @ObservedObject var midoriDonMemory2 = MidoriDonMemory2()
    @ObservedObject var midoriDonMemory3 = MidoriDonMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "緑ドン VIVA情熱南米編")
                }
                
                Section {
                    // 小役確率
                    NavigationLink(destination: midoriDonViewKoyaku(
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "小役確率"
                        )
                    }
                    
                    // 通常時レア役からの当選
                    NavigationLink {
                        midoriDonViewKoyakuBonus(
//                            ver320: ver320,
                            midoriDon: midoriDon
                        )
                    } label: {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時レア役からのボーナス当選"
//                            badgeStatus: ver320.midoriDonMenuKoyakuBonusBadgeStatus
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: midoriDonViewFirstHit(
//                        ver310: ver310,
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り"
//                            badgeStatus: ver310.midoriDonMenuFirstHitBadgeStatus
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: midoriDonViewBonusScreen(
//                        ver301: ver301,
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
//                            badgeStatus: ver301.midoriDonMenuScreenBadgeStatus
                        )
                    }
                    
                    // ボイス
                    NavigationLink(destination: midoriDonViewVoice(
//                        ver301: ver301,
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "X-RUSHチャレンジ失敗時のボイス"
//                            badgeStatus: ver301.midoriDonMenuVoiceBadgeStatus
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: midoriDonView95Ci(
                    midoriDon: midoriDon,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4763")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "緑ドン",
                screenClass: screenClass
            )
        }
//        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "緑ドン", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "midoriDonViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: midoriDonViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver320.midoriDonMachineIconBadgeStatus != "none" {
//                ver320.midoriDonMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(midoriDonSubViewLoadMemory(
                        midoriDon: midoriDon,
                        midoriDonMemory1: midoriDonMemory1,
                        midoriDonMemory2: midoriDonMemory2,
                        midoriDonMemory3: midoriDonMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(midoriDonSubViewSaveMemory(
                        midoriDon: midoriDon,
                        midoriDonMemory1: midoriDonMemory1,
                        midoriDonMemory2: midoriDonMemory2,
                        midoriDonMemory3: midoriDonMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct midoriDonSubViewSaveMemory: View {
    @ObservedObject var midoriDon: MidoriDon
    @ObservedObject var midoriDonMemory1: MidoriDonMemory1
    @ObservedObject var midoriDonMemory2: MidoriDonMemory2
    @ObservedObject var midoriDonMemory3: MidoriDonMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "緑ドン",
            selectedMemory: $midoriDon.selectedMemory,
            memoMemory1: $midoriDonMemory1.memo,
            dateDoubleMemory1: $midoriDonMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $midoriDonMemory2.memo,
            dateDoubleMemory2: $midoriDonMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $midoriDonMemory3.memo,
            dateDoubleMemory3: $midoriDonMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        midoriDonMemory1.totalGame = midoriDon.totalGame
        midoriDonMemory1.jakuRareCountCherry = midoriDon.jakuRareCountCherry
        midoriDonMemory1.jakuRareCountSuika = midoriDon.jakuRareCountSuika
        midoriDonMemory1.jakuRareCountSum = midoriDon.jakuRareCountSum
        midoriDonMemory1.bonusScreenCountScreen1 = midoriDon.bonusScreenCountScreen1
        midoriDonMemory1.bonusScreenCountScreen2 = midoriDon.bonusScreenCountScreen2
        midoriDonMemory1.bonusScreenCountScreen3 = midoriDon.bonusScreenCountScreen3
        midoriDonMemory1.bonusScreenCountScreen4 = midoriDon.bonusScreenCountScreen4
        midoriDonMemory1.bonusScreenCountScreen5 = midoriDon.bonusScreenCountScreen5
        midoriDonMemory1.bonusScreenCountScreen6 = midoriDon.bonusScreenCountScreen6
        midoriDonMemory1.bonusScreenCountSum = midoriDon.bonusScreenCountSum
        midoriDonMemory1.voiceCount1 = midoriDon.voiceCount1
        midoriDonMemory1.voiceCount2 = midoriDon.voiceCount2
        midoriDonMemory1.voiceCount3 = midoriDon.voiceCount3
        midoriDonMemory1.voiceCount4 = midoriDon.voiceCount4
        midoriDonMemory1.voiceCount5 = midoriDon.voiceCount5
        midoriDonMemory1.voiceCount6 = midoriDon.voiceCount6
        midoriDonMemory1.voiceCount7 = midoriDon.voiceCount7
        midoriDonMemory1.voiceCount8 = midoriDon.voiceCount8
        midoriDonMemory1.voiceCount9 = midoriDon.voiceCount9
        midoriDonMemory1.voiceCountSum = midoriDon.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDonMemory1.normalRareCountJakuCherry = midoriDon.normalRareCountJakuCherry
        midoriDonMemory1.normalRareCountJakuSuika = midoriDon.normalRareCountJakuSuika
        midoriDonMemory1.normalRareCountChance = midoriDon.normalRareCountChance
        midoriDonMemory1.normalRareCountKyoCherry = midoriDon.normalRareCountKyoCherry
        midoriDonMemory1.normalRareCountKyoSuika = midoriDon.normalRareCountKyoSuika
        midoriDonMemory1.normalRareHitCountJakuCherry = midoriDon.normalRareHitCountJakuCherry
        midoriDonMemory1.normalRareHitCountJakuSuika = midoriDon.normalRareHitCountJakuSuika
        midoriDonMemory1.normalRareHitCountChance = midoriDon.normalRareHitCountChance
        midoriDonMemory1.normalRareHitCountKyoCherry = midoriDon.normalRareHitCountKyoCherry
        midoriDonMemory1.normalRareHitCountKyoSuika = midoriDon.normalRareHitCountKyoSuika
    }
    func saveMemory2() {
        midoriDonMemory2.totalGame = midoriDon.totalGame
        midoriDonMemory2.jakuRareCountCherry = midoriDon.jakuRareCountCherry
        midoriDonMemory2.jakuRareCountSuika = midoriDon.jakuRareCountSuika
        midoriDonMemory2.jakuRareCountSum = midoriDon.jakuRareCountSum
        midoriDonMemory2.bonusScreenCountScreen1 = midoriDon.bonusScreenCountScreen1
        midoriDonMemory2.bonusScreenCountScreen2 = midoriDon.bonusScreenCountScreen2
        midoriDonMemory2.bonusScreenCountScreen3 = midoriDon.bonusScreenCountScreen3
        midoriDonMemory2.bonusScreenCountScreen4 = midoriDon.bonusScreenCountScreen4
        midoriDonMemory2.bonusScreenCountScreen5 = midoriDon.bonusScreenCountScreen5
        midoriDonMemory2.bonusScreenCountScreen6 = midoriDon.bonusScreenCountScreen6
        midoriDonMemory2.bonusScreenCountSum = midoriDon.bonusScreenCountSum
        midoriDonMemory2.voiceCount1 = midoriDon.voiceCount1
        midoriDonMemory2.voiceCount2 = midoriDon.voiceCount2
        midoriDonMemory2.voiceCount3 = midoriDon.voiceCount3
        midoriDonMemory2.voiceCount4 = midoriDon.voiceCount4
        midoriDonMemory2.voiceCount5 = midoriDon.voiceCount5
        midoriDonMemory2.voiceCount6 = midoriDon.voiceCount6
        midoriDonMemory2.voiceCount7 = midoriDon.voiceCount7
        midoriDonMemory2.voiceCount8 = midoriDon.voiceCount8
        midoriDonMemory2.voiceCount9 = midoriDon.voiceCount9
        midoriDonMemory2.voiceCountSum = midoriDon.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDonMemory2.normalRareCountJakuCherry = midoriDon.normalRareCountJakuCherry
        midoriDonMemory2.normalRareCountJakuSuika = midoriDon.normalRareCountJakuSuika
        midoriDonMemory2.normalRareCountChance = midoriDon.normalRareCountChance
        midoriDonMemory2.normalRareCountKyoCherry = midoriDon.normalRareCountKyoCherry
        midoriDonMemory2.normalRareCountKyoSuika = midoriDon.normalRareCountKyoSuika
        midoriDonMemory2.normalRareHitCountJakuCherry = midoriDon.normalRareHitCountJakuCherry
        midoriDonMemory2.normalRareHitCountJakuSuika = midoriDon.normalRareHitCountJakuSuika
        midoriDonMemory2.normalRareHitCountChance = midoriDon.normalRareHitCountChance
        midoriDonMemory2.normalRareHitCountKyoCherry = midoriDon.normalRareHitCountKyoCherry
        midoriDonMemory2.normalRareHitCountKyoSuika = midoriDon.normalRareHitCountKyoSuika
    }
    func saveMemory3() {
        midoriDonMemory3.totalGame = midoriDon.totalGame
        midoriDonMemory3.jakuRareCountCherry = midoriDon.jakuRareCountCherry
        midoriDonMemory3.jakuRareCountSuika = midoriDon.jakuRareCountSuika
        midoriDonMemory3.jakuRareCountSum = midoriDon.jakuRareCountSum
        midoriDonMemory3.bonusScreenCountScreen1 = midoriDon.bonusScreenCountScreen1
        midoriDonMemory3.bonusScreenCountScreen2 = midoriDon.bonusScreenCountScreen2
        midoriDonMemory3.bonusScreenCountScreen3 = midoriDon.bonusScreenCountScreen3
        midoriDonMemory3.bonusScreenCountScreen4 = midoriDon.bonusScreenCountScreen4
        midoriDonMemory3.bonusScreenCountScreen5 = midoriDon.bonusScreenCountScreen5
        midoriDonMemory3.bonusScreenCountScreen6 = midoriDon.bonusScreenCountScreen6
        midoriDonMemory3.bonusScreenCountSum = midoriDon.bonusScreenCountSum
        midoriDonMemory3.voiceCount1 = midoriDon.voiceCount1
        midoriDonMemory3.voiceCount2 = midoriDon.voiceCount2
        midoriDonMemory3.voiceCount3 = midoriDon.voiceCount3
        midoriDonMemory3.voiceCount4 = midoriDon.voiceCount4
        midoriDonMemory3.voiceCount5 = midoriDon.voiceCount5
        midoriDonMemory3.voiceCount6 = midoriDon.voiceCount6
        midoriDonMemory3.voiceCount7 = midoriDon.voiceCount7
        midoriDonMemory3.voiceCount8 = midoriDon.voiceCount8
        midoriDonMemory3.voiceCount9 = midoriDon.voiceCount9
        midoriDonMemory3.voiceCountSum = midoriDon.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDonMemory3.normalRareCountJakuCherry = midoriDon.normalRareCountJakuCherry
        midoriDonMemory3.normalRareCountJakuSuika = midoriDon.normalRareCountJakuSuika
        midoriDonMemory3.normalRareCountChance = midoriDon.normalRareCountChance
        midoriDonMemory3.normalRareCountKyoCherry = midoriDon.normalRareCountKyoCherry
        midoriDonMemory3.normalRareCountKyoSuika = midoriDon.normalRareCountKyoSuika
        midoriDonMemory3.normalRareHitCountJakuCherry = midoriDon.normalRareHitCountJakuCherry
        midoriDonMemory3.normalRareHitCountJakuSuika = midoriDon.normalRareHitCountJakuSuika
        midoriDonMemory3.normalRareHitCountChance = midoriDon.normalRareHitCountChance
        midoriDonMemory3.normalRareHitCountKyoCherry = midoriDon.normalRareHitCountKyoCherry
        midoriDonMemory3.normalRareHitCountKyoSuika = midoriDon.normalRareHitCountKyoSuika
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct midoriDonSubViewLoadMemory: View {
    @ObservedObject var midoriDon: MidoriDon
    @ObservedObject var midoriDonMemory1: MidoriDonMemory1
    @ObservedObject var midoriDonMemory2: MidoriDonMemory2
    @ObservedObject var midoriDonMemory3: MidoriDonMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "緑ドン",
            selectedMemory: $midoriDon.selectedMemory,
            memoMemory1: midoriDonMemory1.memo,
            dateDoubleMemory1: midoriDonMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: midoriDonMemory2.memo,
            dateDoubleMemory2: midoriDonMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: midoriDonMemory3.memo,
            dateDoubleMemory3: midoriDonMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        midoriDon.totalGame = midoriDonMemory1.totalGame
        midoriDon.jakuRareCountCherry = midoriDonMemory1.jakuRareCountCherry
        midoriDon.jakuRareCountSuika = midoriDonMemory1.jakuRareCountSuika
        midoriDon.jakuRareCountSum = midoriDonMemory1.jakuRareCountSum
        midoriDon.bonusScreenCountScreen1 = midoriDonMemory1.bonusScreenCountScreen1
        midoriDon.bonusScreenCountScreen2 = midoriDonMemory1.bonusScreenCountScreen2
        midoriDon.bonusScreenCountScreen3 = midoriDonMemory1.bonusScreenCountScreen3
        midoriDon.bonusScreenCountScreen4 = midoriDonMemory1.bonusScreenCountScreen4
        midoriDon.bonusScreenCountScreen5 = midoriDonMemory1.bonusScreenCountScreen5
        midoriDon.bonusScreenCountScreen6 = midoriDonMemory1.bonusScreenCountScreen6
        midoriDon.bonusScreenCountSum = midoriDonMemory1.bonusScreenCountSum
        midoriDon.voiceCount1 = midoriDonMemory1.voiceCount1
        midoriDon.voiceCount2 = midoriDonMemory1.voiceCount2
        midoriDon.voiceCount3 = midoriDonMemory1.voiceCount3
        midoriDon.voiceCount4 = midoriDonMemory1.voiceCount4
        midoriDon.voiceCount5 = midoriDonMemory1.voiceCount5
        midoriDon.voiceCount6 = midoriDonMemory1.voiceCount6
        midoriDon.voiceCount7 = midoriDonMemory1.voiceCount7
        midoriDon.voiceCount8 = midoriDonMemory1.voiceCount8
        midoriDon.voiceCount9 = midoriDonMemory1.voiceCount9
        midoriDon.voiceCountSum = midoriDonMemory1.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDon.normalRareCountJakuCherry = midoriDonMemory1.normalRareCountJakuCherry
        midoriDon.normalRareCountJakuSuika = midoriDonMemory1.normalRareCountJakuSuika
        midoriDon.normalRareCountChance = midoriDonMemory1.normalRareCountChance
        midoriDon.normalRareCountKyoCherry = midoriDonMemory1.normalRareCountKyoCherry
        midoriDon.normalRareCountKyoSuika = midoriDonMemory1.normalRareCountKyoSuika
        midoriDon.normalRareHitCountJakuCherry = midoriDonMemory1.normalRareHitCountJakuCherry
        midoriDon.normalRareHitCountJakuSuika = midoriDonMemory1.normalRareHitCountJakuSuika
        midoriDon.normalRareHitCountChance = midoriDonMemory1.normalRareHitCountChance
        midoriDon.normalRareHitCountKyoCherry = midoriDonMemory1.normalRareHitCountKyoCherry
        midoriDon.normalRareHitCountKyoSuika = midoriDonMemory1.normalRareHitCountKyoSuika
    }
    func loadMemory2() {
        midoriDon.totalGame = midoriDonMemory2.totalGame
        midoriDon.jakuRareCountCherry = midoriDonMemory2.jakuRareCountCherry
        midoriDon.jakuRareCountSuika = midoriDonMemory2.jakuRareCountSuika
        midoriDon.jakuRareCountSum = midoriDonMemory2.jakuRareCountSum
        midoriDon.bonusScreenCountScreen1 = midoriDonMemory2.bonusScreenCountScreen1
        midoriDon.bonusScreenCountScreen2 = midoriDonMemory2.bonusScreenCountScreen2
        midoriDon.bonusScreenCountScreen3 = midoriDonMemory2.bonusScreenCountScreen3
        midoriDon.bonusScreenCountScreen4 = midoriDonMemory2.bonusScreenCountScreen4
        midoriDon.bonusScreenCountScreen5 = midoriDonMemory2.bonusScreenCountScreen5
        midoriDon.bonusScreenCountScreen6 = midoriDonMemory2.bonusScreenCountScreen6
        midoriDon.bonusScreenCountSum = midoriDonMemory2.bonusScreenCountSum
        midoriDon.voiceCount1 = midoriDonMemory2.voiceCount1
        midoriDon.voiceCount2 = midoriDonMemory2.voiceCount2
        midoriDon.voiceCount3 = midoriDonMemory2.voiceCount3
        midoriDon.voiceCount4 = midoriDonMemory2.voiceCount4
        midoriDon.voiceCount5 = midoriDonMemory2.voiceCount5
        midoriDon.voiceCount6 = midoriDonMemory2.voiceCount6
        midoriDon.voiceCount7 = midoriDonMemory2.voiceCount7
        midoriDon.voiceCount8 = midoriDonMemory2.voiceCount8
        midoriDon.voiceCount9 = midoriDonMemory2.voiceCount9
        midoriDon.voiceCountSum = midoriDonMemory2.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDon.normalRareCountJakuCherry = midoriDonMemory2.normalRareCountJakuCherry
        midoriDon.normalRareCountJakuSuika = midoriDonMemory2.normalRareCountJakuSuika
        midoriDon.normalRareCountChance = midoriDonMemory2.normalRareCountChance
        midoriDon.normalRareCountKyoCherry = midoriDonMemory2.normalRareCountKyoCherry
        midoriDon.normalRareCountKyoSuika = midoriDonMemory2.normalRareCountKyoSuika
        midoriDon.normalRareHitCountJakuCherry = midoriDonMemory2.normalRareHitCountJakuCherry
        midoriDon.normalRareHitCountJakuSuika = midoriDonMemory2.normalRareHitCountJakuSuika
        midoriDon.normalRareHitCountChance = midoriDonMemory2.normalRareHitCountChance
        midoriDon.normalRareHitCountKyoCherry = midoriDonMemory2.normalRareHitCountKyoCherry
        midoriDon.normalRareHitCountKyoSuika = midoriDonMemory2.normalRareHitCountKyoSuika
    }
    func loadMemory3() {
        midoriDon.totalGame = midoriDonMemory3.totalGame
        midoriDon.jakuRareCountCherry = midoriDonMemory3.jakuRareCountCherry
        midoriDon.jakuRareCountSuika = midoriDonMemory3.jakuRareCountSuika
        midoriDon.jakuRareCountSum = midoriDonMemory3.jakuRareCountSum
        midoriDon.bonusScreenCountScreen1 = midoriDonMemory3.bonusScreenCountScreen1
        midoriDon.bonusScreenCountScreen2 = midoriDonMemory3.bonusScreenCountScreen2
        midoriDon.bonusScreenCountScreen3 = midoriDonMemory3.bonusScreenCountScreen3
        midoriDon.bonusScreenCountScreen4 = midoriDonMemory3.bonusScreenCountScreen4
        midoriDon.bonusScreenCountScreen5 = midoriDonMemory3.bonusScreenCountScreen5
        midoriDon.bonusScreenCountScreen6 = midoriDonMemory3.bonusScreenCountScreen6
        midoriDon.bonusScreenCountSum = midoriDonMemory3.bonusScreenCountSum
        midoriDon.voiceCount1 = midoriDonMemory3.voiceCount1
        midoriDon.voiceCount2 = midoriDonMemory3.voiceCount2
        midoriDon.voiceCount3 = midoriDonMemory3.voiceCount3
        midoriDon.voiceCount4 = midoriDonMemory3.voiceCount4
        midoriDon.voiceCount5 = midoriDonMemory3.voiceCount5
        midoriDon.voiceCount6 = midoriDonMemory3.voiceCount6
        midoriDon.voiceCount7 = midoriDonMemory3.voiceCount7
        midoriDon.voiceCount8 = midoriDonMemory3.voiceCount8
        midoriDon.voiceCount9 = midoriDonMemory3.voiceCount9
        midoriDon.voiceCountSum = midoriDonMemory3.voiceCountSum
        
        // /////////////////
        // ver3.2.0で追加
        // /////////////////
        midoriDon.normalRareCountJakuCherry = midoriDonMemory3.normalRareCountJakuCherry
        midoriDon.normalRareCountJakuSuika = midoriDonMemory3.normalRareCountJakuSuika
        midoriDon.normalRareCountChance = midoriDonMemory3.normalRareCountChance
        midoriDon.normalRareCountKyoCherry = midoriDonMemory3.normalRareCountKyoCherry
        midoriDon.normalRareCountKyoSuika = midoriDonMemory3.normalRareCountKyoSuika
        midoriDon.normalRareHitCountJakuCherry = midoriDonMemory3.normalRareHitCountJakuCherry
        midoriDon.normalRareHitCountJakuSuika = midoriDonMemory3.normalRareHitCountJakuSuika
        midoriDon.normalRareHitCountChance = midoriDonMemory3.normalRareHitCountChance
        midoriDon.normalRareHitCountKyoCherry = midoriDonMemory3.normalRareHitCountKyoCherry
        midoriDon.normalRareHitCountKyoSuika = midoriDonMemory3.normalRareHitCountKyoSuika
    }
}


#Preview {
    midoriDonViewTop(
//        ver320: Ver320()
//        ver310: Ver310()
    )
}
