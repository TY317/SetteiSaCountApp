//
//  sbjViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/02.
//

import SwiftUI

struct sbjViewTop: View {
    @ObservedObject var sbj = Sbj()
    @State var isShowAlert: Bool = false
//    @ObservedObject var ver210 = Ver210()
    @ObservedObject var ver220 = Ver220()
    
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
                    NavigationLink(destination: sbjViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時 小役、高確、初当り",
                            badgeStatus: ver220.sbjUpdateBadgeStatus2
                        )
                    }
                    // ダイスチェック
                    NavigationLink(destination: sbjViewDiceCheck()) {
                        unitLabelMenu(
                            imageSystemName: "dice.fill",
                            textBody: "ダイスチェック"
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
                NavigationLink(destination: sbjView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4712")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver220.sbjUpdateBadgeStatus != "none" {
                ver220.sbjUpdateBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(sbjSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(sbjSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: sbj.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct sbjSubViewSaveMemory: View {
    @ObservedObject var sbj = Sbj()
    @ObservedObject var sbjMemory1 = SbjMemory1()
    @ObservedObject var sbjMemory2 = SbjMemory2()
    @ObservedObject var sbjMemory3 = SbjMemory3()
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
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct sbjSubViewLoadMemory: View {
    @ObservedObject var sbj = Sbj()
    @ObservedObject var sbjMemory1 = SbjMemory1()
    @ObservedObject var sbjMemory2 = SbjMemory2()
    @ObservedObject var sbjMemory3 = SbjMemory3()
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
        sbj.diceLeftArrayData = sbjMemory1.diceLeftArrayData
        sbj.diceRightArrayData = sbjMemory1.diceRightArrayData
        sbj.suikaArrayData = sbjMemory1.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory1.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory1.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory1.normalChanceChokugekiCount
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
        sbj.diceLeftArrayData = sbjMemory2.diceLeftArrayData
        sbj.diceRightArrayData = sbjMemory2.diceRightArrayData
        sbj.suikaArrayData = sbjMemory2.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory2.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory2.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory2.normalChanceChokugekiCount
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
        sbj.diceLeftArrayData = sbjMemory3.diceLeftArrayData
        sbj.diceRightArrayData = sbjMemory3.diceRightArrayData
        sbj.suikaArrayData = sbjMemory3.suikaArrayData
        // /////////////////////////
        // ver220で追加、通常チャンス目関連
        // /////////////////////////
        sbj.normalChanceCount = sbjMemory3.normalChanceCount
        sbj.normalChanceKokakuCount = sbjMemory3.normalChanceKokakuCount
        sbj.normalChanceChokugekiCount = sbjMemory3.normalChanceChokugekiCount
    }
}

#Preview {
    sbjViewTop()
}
