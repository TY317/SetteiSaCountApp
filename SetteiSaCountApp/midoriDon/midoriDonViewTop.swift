//
//  midoriDonViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewTop: View {
    @ObservedObject var ver300: Ver300
    @ObservedObject var ver301: Ver301
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
                    
                    // 初当り
                    NavigationLink(destination: midoriDonViewFirstHit(
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り"
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: midoriDonViewBonusScreen(
                        ver301: ver301,
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: ver301.midoriDonMenuScreenBadgeStatus
                        )
                    }
                    
                    // ボイス
                    NavigationLink(destination: midoriDonViewVoice(
                        ver301: ver301,
                        midoriDon: midoriDon
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "X-RUSHチャレンジ失敗時のボイス",
                            badgeStatus: ver301.midoriDonMenuVoiceBadgeStatus
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
        .onAppear {
            if ver301.midoriDonMachineIconBadgeStatus != "none" {
                ver301.midoriDonMachineIconBadgeStatus = "none"
            }
        }
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
    }
}


#Preview {
    midoriDonViewTop(
        ver300: Ver300(),
        ver301: Ver301()
    )
}
