//
//  enenViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import SwiftUI

struct enenViewTop: View {
    @ObservedObject var ver370: Ver370
    @StateObject var enen = Enen()
    @State var isShowAlert: Bool = false
    @StateObject var enenMemory1 = EnenMemory1()
    @StateObject var enenMemory2 = EnenMemory2()
    @StateObject var enenMemory3 = EnenMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: enenViewNormal(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // REG中のキャラ
                    NavigationLink(destination: enenViewRegChara(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.3.fill",
                            textBody: "REG中のキャラ"
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: enenViewRegScreen(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "REG終了画面"
                        )
                    }
                    // 伝道者の影
                    NavigationLink(destination: enenViewDendosha(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "ant.fill",
                            textBody: "伝道者の影"
                        )
                    }
                    // 炎炎ボーナス終了画面
                    NavigationLink(destination: enenViewBigScreen(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "炎炎ボーナス終了画面"
                        )
                    }
                    // アドラバースト
                    NavigationLink(destination: enenViewAdora(
                        enen: enen,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flame.fill",
                            textBody: "アドラバースト"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: enen.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: enenView95Ci(
                    enen: enen,
                    selection: 1
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4555"
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver370.enenMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(enenSubViewLoadMemory(
                        enen: enen,
                        enenMemory1: enenMemory1,
                        enenMemory2: enenMemory2,
                        enenMemory3: enenMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(enenSubViewSaveMemory(
                        enen: enen,
                        enenMemory1: enenMemory1,
                        enenMemory2: enenMemory2,
                        enenMemory3: enenMemory3
                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: enen.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct enenSubViewSaveMemory: View {
    @ObservedObject var enen: Enen
    @ObservedObject var enenMemory1: EnenMemory1
    @ObservedObject var enenMemory2: EnenMemory2
    @ObservedObject var enenMemory3: EnenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: enen.machineName,
            selectedMemory: $enen.selectedMemory,
            memoMemory1: $enenMemory1.memo,
            dateDoubleMemory1: $enenMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $enenMemory2.memo,
            dateDoubleMemory2: $enenMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $enenMemory3.memo,
            dateDoubleMemory3: $enenMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        enenMemory1.rareBonusCountJuji = enen.rareBonusCountJuji
        enenMemory1.rareBonusCountJujiHit = enen.rareBonusCountJujiHit
        enenMemory1.rareBonusCountKyoCherry = enen.rareBonusCountKyoCherry
        enenMemory1.rareBonusCountKyoCherryHit = enen.rareBonusCountKyoCherryHit
        enenMemory1.charaCountDefault = enen.charaCountDefault
        enenMemory1.charaCount25Sisa = enen.charaCount25Sisa
        enenMemory1.charaCount146Sisa = enen.charaCount146Sisa
        enenMemory1.charaCountNegate1 = enen.charaCountNegate1
        enenMemory1.charaCountNegate2 = enen.charaCountNegate2
        enenMemory1.charaCountNegate4 = enen.charaCountNegate4
        enenMemory1.charaCountNegate5 = enen.charaCountNegate5
        enenMemory1.charaCountOver6 = enen.charaCountOver6
        enenMemory1.charaCountOver4 = enen.charaCountOver4
        enenMemory1.charaCountOver5 = enen.charaCountOver5
        enenMemory1.charaCountSum = enen.charaCountSum
        enenMemory1.regScreenCountDefault = enen.regScreenCountDefault
        enenMemory1.regScreenCountHighJaku = enen.regScreenCountHighJaku
        enenMemory1.regScreenCountHighKyo = enen.regScreenCountHighKyo
        enenMemory1.regScreenCountOver4 = enen.regScreenCountOver4
        enenMemory1.regScreenCountOver5 = enen.regScreenCountOver5
        enenMemory1.regScreenCountOver6 = enen.regScreenCountOver6
        enenMemory1.regScreenCountSum = enen.regScreenCountSum
        enenMemory1.dendoshaCountJuji = enen.dendoshaCountJuji
        enenMemory1.dendoshaCountJujiHit = enen.dendoshaCountJujiHit
        enenMemory1.dendoshaCountJakuRare = enen.dendoshaCountJakuRare
        enenMemory1.dendoshaCountJakuRareHit = enen.dendoshaCountJakuRareHit
        enenMemory1.bigScreenCountDefault = enen.bigScreenCountDefault
        enenMemory1.bigScreenCountHighJaku = enen.bigScreenCountHighJaku
        enenMemory1.bigScreenCountHighKyo = enen.bigScreenCountHighKyo
        enenMemory1.bigScreenCountOver4 = enen.bigScreenCountOver4
        enenMemory1.bigScreenCountOver5 = enen.bigScreenCountOver5
        enenMemory1.bigScreenCountOver6 = enen.bigScreenCountOver6
        enenMemory1.bigScreenCountSum = enen.bigScreenCountSum
        enenMemory1.adoraCount25Sisa = enen.adoraCount25Sisa
        enenMemory1.adoraCount146Sisa = enen.adoraCount146Sisa
        enenMemory1.adoraCountOver2 = enen.adoraCountOver2
        enenMemory1.adoraCount146Fix = enen.adoraCount146Fix
        enenMemory1.adoraCountOver4 = enen.adoraCountOver4
        enenMemory1.adoraCountOver5 = enen.adoraCountOver5
        enenMemory1.adoraCountSum = enen.adoraCountSum
    }
    func saveMemory2() {
        enenMemory2.rareBonusCountJuji = enen.rareBonusCountJuji
        enenMemory2.rareBonusCountJujiHit = enen.rareBonusCountJujiHit
        enenMemory2.rareBonusCountKyoCherry = enen.rareBonusCountKyoCherry
        enenMemory2.rareBonusCountKyoCherryHit = enen.rareBonusCountKyoCherryHit
        enenMemory2.charaCountDefault = enen.charaCountDefault
        enenMemory2.charaCount25Sisa = enen.charaCount25Sisa
        enenMemory2.charaCount146Sisa = enen.charaCount146Sisa
        enenMemory2.charaCountNegate1 = enen.charaCountNegate1
        enenMemory2.charaCountNegate2 = enen.charaCountNegate2
        enenMemory2.charaCountNegate4 = enen.charaCountNegate4
        enenMemory2.charaCountNegate5 = enen.charaCountNegate5
        enenMemory2.charaCountOver6 = enen.charaCountOver6
        enenMemory2.charaCountOver4 = enen.charaCountOver4
        enenMemory2.charaCountOver5 = enen.charaCountOver5
        enenMemory2.charaCountSum = enen.charaCountSum
        enenMemory2.regScreenCountDefault = enen.regScreenCountDefault
        enenMemory2.regScreenCountHighJaku = enen.regScreenCountHighJaku
        enenMemory2.regScreenCountHighKyo = enen.regScreenCountHighKyo
        enenMemory2.regScreenCountOver4 = enen.regScreenCountOver4
        enenMemory2.regScreenCountOver5 = enen.regScreenCountOver5
        enenMemory2.regScreenCountOver6 = enen.regScreenCountOver6
        enenMemory2.regScreenCountSum = enen.regScreenCountSum
        enenMemory2.dendoshaCountJuji = enen.dendoshaCountJuji
        enenMemory2.dendoshaCountJujiHit = enen.dendoshaCountJujiHit
        enenMemory2.dendoshaCountJakuRare = enen.dendoshaCountJakuRare
        enenMemory2.dendoshaCountJakuRareHit = enen.dendoshaCountJakuRareHit
        enenMemory2.bigScreenCountDefault = enen.bigScreenCountDefault
        enenMemory2.bigScreenCountHighJaku = enen.bigScreenCountHighJaku
        enenMemory2.bigScreenCountHighKyo = enen.bigScreenCountHighKyo
        enenMemory2.bigScreenCountOver4 = enen.bigScreenCountOver4
        enenMemory2.bigScreenCountOver5 = enen.bigScreenCountOver5
        enenMemory2.bigScreenCountOver6 = enen.bigScreenCountOver6
        enenMemory2.bigScreenCountSum = enen.bigScreenCountSum
        enenMemory2.adoraCount25Sisa = enen.adoraCount25Sisa
        enenMemory2.adoraCount146Sisa = enen.adoraCount146Sisa
        enenMemory2.adoraCountOver2 = enen.adoraCountOver2
        enenMemory2.adoraCount146Fix = enen.adoraCount146Fix
        enenMemory2.adoraCountOver4 = enen.adoraCountOver4
        enenMemory2.adoraCountOver5 = enen.adoraCountOver5
        enenMemory2.adoraCountSum = enen.adoraCountSum
    }
    func saveMemory3() {
        enenMemory3.rareBonusCountJuji = enen.rareBonusCountJuji
        enenMemory3.rareBonusCountJujiHit = enen.rareBonusCountJujiHit
        enenMemory3.rareBonusCountKyoCherry = enen.rareBonusCountKyoCherry
        enenMemory3.rareBonusCountKyoCherryHit = enen.rareBonusCountKyoCherryHit
        enenMemory3.charaCountDefault = enen.charaCountDefault
        enenMemory3.charaCount25Sisa = enen.charaCount25Sisa
        enenMemory3.charaCount146Sisa = enen.charaCount146Sisa
        enenMemory3.charaCountNegate1 = enen.charaCountNegate1
        enenMemory3.charaCountNegate2 = enen.charaCountNegate2
        enenMemory3.charaCountNegate4 = enen.charaCountNegate4
        enenMemory3.charaCountNegate5 = enen.charaCountNegate5
        enenMemory3.charaCountOver6 = enen.charaCountOver6
        enenMemory3.charaCountOver4 = enen.charaCountOver4
        enenMemory3.charaCountOver5 = enen.charaCountOver5
        enenMemory3.charaCountSum = enen.charaCountSum
        enenMemory3.regScreenCountDefault = enen.regScreenCountDefault
        enenMemory3.regScreenCountHighJaku = enen.regScreenCountHighJaku
        enenMemory3.regScreenCountHighKyo = enen.regScreenCountHighKyo
        enenMemory3.regScreenCountOver4 = enen.regScreenCountOver4
        enenMemory3.regScreenCountOver5 = enen.regScreenCountOver5
        enenMemory3.regScreenCountOver6 = enen.regScreenCountOver6
        enenMemory3.regScreenCountSum = enen.regScreenCountSum
        enenMemory3.dendoshaCountJuji = enen.dendoshaCountJuji
        enenMemory3.dendoshaCountJujiHit = enen.dendoshaCountJujiHit
        enenMemory3.dendoshaCountJakuRare = enen.dendoshaCountJakuRare
        enenMemory3.dendoshaCountJakuRareHit = enen.dendoshaCountJakuRareHit
        enenMemory3.bigScreenCountDefault = enen.bigScreenCountDefault
        enenMemory3.bigScreenCountHighJaku = enen.bigScreenCountHighJaku
        enenMemory3.bigScreenCountHighKyo = enen.bigScreenCountHighKyo
        enenMemory3.bigScreenCountOver4 = enen.bigScreenCountOver4
        enenMemory3.bigScreenCountOver5 = enen.bigScreenCountOver5
        enenMemory3.bigScreenCountOver6 = enen.bigScreenCountOver6
        enenMemory3.bigScreenCountSum = enen.bigScreenCountSum
        enenMemory3.adoraCount25Sisa = enen.adoraCount25Sisa
        enenMemory3.adoraCount146Sisa = enen.adoraCount146Sisa
        enenMemory3.adoraCountOver2 = enen.adoraCountOver2
        enenMemory3.adoraCount146Fix = enen.adoraCount146Fix
        enenMemory3.adoraCountOver4 = enen.adoraCountOver4
        enenMemory3.adoraCountOver5 = enen.adoraCountOver5
        enenMemory3.adoraCountSum = enen.adoraCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct enenSubViewLoadMemory: View {
    @ObservedObject var enen: Enen
    @ObservedObject var enenMemory1: EnenMemory1
    @ObservedObject var enenMemory2: EnenMemory2
    @ObservedObject var enenMemory3: EnenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: enen.machineName,
            selectedMemory: $enen.selectedMemory,
            memoMemory1: enenMemory1.memo,
            dateDoubleMemory1: enenMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: enenMemory2.memo,
            dateDoubleMemory2: enenMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: enenMemory3.memo,
            dateDoubleMemory3: enenMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        enen.rareBonusCountJuji = enenMemory1.rareBonusCountJuji
        enen.rareBonusCountJujiHit = enenMemory1.rareBonusCountJujiHit
        enen.rareBonusCountKyoCherry = enenMemory1.rareBonusCountKyoCherry
        enen.rareBonusCountKyoCherryHit = enenMemory1.rareBonusCountKyoCherryHit
        enen.charaCountDefault = enenMemory1.charaCountDefault
        enen.charaCount25Sisa = enenMemory1.charaCount25Sisa
        enen.charaCount146Sisa = enenMemory1.charaCount146Sisa
        enen.charaCountNegate1 = enenMemory1.charaCountNegate1
        enen.charaCountNegate2 = enenMemory1.charaCountNegate2
        enen.charaCountNegate4 = enenMemory1.charaCountNegate4
        enen.charaCountNegate5 = enenMemory1.charaCountNegate5
        enen.charaCountOver6 = enenMemory1.charaCountOver6
        enen.charaCountOver4 = enenMemory1.charaCountOver4
        enen.charaCountOver5 = enenMemory1.charaCountOver5
        enen.charaCountSum = enenMemory1.charaCountSum
        enen.regScreenCountDefault = enenMemory1.regScreenCountDefault
        enen.regScreenCountHighJaku = enenMemory1.regScreenCountHighJaku
        enen.regScreenCountHighKyo = enenMemory1.regScreenCountHighKyo
        enen.regScreenCountOver4 = enenMemory1.regScreenCountOver4
        enen.regScreenCountOver5 = enenMemory1.regScreenCountOver5
        enen.regScreenCountOver6 = enenMemory1.regScreenCountOver6
        enen.regScreenCountSum = enenMemory1.regScreenCountSum
        enen.dendoshaCountJuji = enenMemory1.dendoshaCountJuji
        enen.dendoshaCountJujiHit = enenMemory1.dendoshaCountJujiHit
        enen.dendoshaCountJakuRare = enenMemory1.dendoshaCountJakuRare
        enen.dendoshaCountJakuRareHit = enenMemory1.dendoshaCountJakuRareHit
        enen.bigScreenCountDefault = enenMemory1.bigScreenCountDefault
        enen.bigScreenCountHighJaku = enenMemory1.bigScreenCountHighJaku
        enen.bigScreenCountHighKyo = enenMemory1.bigScreenCountHighKyo
        enen.bigScreenCountOver4 = enenMemory1.bigScreenCountOver4
        enen.bigScreenCountOver5 = enenMemory1.bigScreenCountOver5
        enen.bigScreenCountOver6 = enenMemory1.bigScreenCountOver6
        enen.bigScreenCountSum = enenMemory1.bigScreenCountSum
        enen.adoraCount25Sisa = enenMemory1.adoraCount25Sisa
        enen.adoraCount146Sisa = enenMemory1.adoraCount146Sisa
        enen.adoraCountOver2 = enenMemory1.adoraCountOver2
        enen.adoraCount146Fix = enenMemory1.adoraCount146Fix
        enen.adoraCountOver4 = enenMemory1.adoraCountOver4
        enen.adoraCountOver5 = enenMemory1.adoraCountOver5
        enen.adoraCountSum = enenMemory1.adoraCountSum
    }
    func loadMemory2() {
        enen.rareBonusCountJuji = enenMemory2.rareBonusCountJuji
        enen.rareBonusCountJujiHit = enenMemory2.rareBonusCountJujiHit
        enen.rareBonusCountKyoCherry = enenMemory2.rareBonusCountKyoCherry
        enen.rareBonusCountKyoCherryHit = enenMemory2.rareBonusCountKyoCherryHit
        enen.charaCountDefault = enenMemory2.charaCountDefault
        enen.charaCount25Sisa = enenMemory2.charaCount25Sisa
        enen.charaCount146Sisa = enenMemory2.charaCount146Sisa
        enen.charaCountNegate1 = enenMemory2.charaCountNegate1
        enen.charaCountNegate2 = enenMemory2.charaCountNegate2
        enen.charaCountNegate4 = enenMemory2.charaCountNegate4
        enen.charaCountNegate5 = enenMemory2.charaCountNegate5
        enen.charaCountOver6 = enenMemory2.charaCountOver6
        enen.charaCountOver4 = enenMemory2.charaCountOver4
        enen.charaCountOver5 = enenMemory2.charaCountOver5
        enen.charaCountSum = enenMemory2.charaCountSum
        enen.regScreenCountDefault = enenMemory2.regScreenCountDefault
        enen.regScreenCountHighJaku = enenMemory2.regScreenCountHighJaku
        enen.regScreenCountHighKyo = enenMemory2.regScreenCountHighKyo
        enen.regScreenCountOver4 = enenMemory2.regScreenCountOver4
        enen.regScreenCountOver5 = enenMemory2.regScreenCountOver5
        enen.regScreenCountOver6 = enenMemory2.regScreenCountOver6
        enen.regScreenCountSum = enenMemory2.regScreenCountSum
        enen.dendoshaCountJuji = enenMemory2.dendoshaCountJuji
        enen.dendoshaCountJujiHit = enenMemory2.dendoshaCountJujiHit
        enen.dendoshaCountJakuRare = enenMemory2.dendoshaCountJakuRare
        enen.dendoshaCountJakuRareHit = enenMemory2.dendoshaCountJakuRareHit
        enen.bigScreenCountDefault = enenMemory2.bigScreenCountDefault
        enen.bigScreenCountHighJaku = enenMemory2.bigScreenCountHighJaku
        enen.bigScreenCountHighKyo = enenMemory2.bigScreenCountHighKyo
        enen.bigScreenCountOver4 = enenMemory2.bigScreenCountOver4
        enen.bigScreenCountOver5 = enenMemory2.bigScreenCountOver5
        enen.bigScreenCountOver6 = enenMemory2.bigScreenCountOver6
        enen.bigScreenCountSum = enenMemory2.bigScreenCountSum
        enen.adoraCount25Sisa = enenMemory2.adoraCount25Sisa
        enen.adoraCount146Sisa = enenMemory2.adoraCount146Sisa
        enen.adoraCountOver2 = enenMemory2.adoraCountOver2
        enen.adoraCount146Fix = enenMemory2.adoraCount146Fix
        enen.adoraCountOver4 = enenMemory2.adoraCountOver4
        enen.adoraCountOver5 = enenMemory2.adoraCountOver5
        enen.adoraCountSum = enenMemory2.adoraCountSum
    }
    func loadMemory3() {
        enen.rareBonusCountJuji = enenMemory3.rareBonusCountJuji
        enen.rareBonusCountJujiHit = enenMemory3.rareBonusCountJujiHit
        enen.rareBonusCountKyoCherry = enenMemory3.rareBonusCountKyoCherry
        enen.rareBonusCountKyoCherryHit = enenMemory3.rareBonusCountKyoCherryHit
        enen.charaCountDefault = enenMemory3.charaCountDefault
        enen.charaCount25Sisa = enenMemory3.charaCount25Sisa
        enen.charaCount146Sisa = enenMemory3.charaCount146Sisa
        enen.charaCountNegate1 = enenMemory3.charaCountNegate1
        enen.charaCountNegate2 = enenMemory3.charaCountNegate2
        enen.charaCountNegate4 = enenMemory3.charaCountNegate4
        enen.charaCountNegate5 = enenMemory3.charaCountNegate5
        enen.charaCountOver6 = enenMemory3.charaCountOver6
        enen.charaCountOver4 = enenMemory3.charaCountOver4
        enen.charaCountOver5 = enenMemory3.charaCountOver5
        enen.charaCountSum = enenMemory3.charaCountSum
        enen.regScreenCountDefault = enenMemory3.regScreenCountDefault
        enen.regScreenCountHighJaku = enenMemory3.regScreenCountHighJaku
        enen.regScreenCountHighKyo = enenMemory3.regScreenCountHighKyo
        enen.regScreenCountOver4 = enenMemory3.regScreenCountOver4
        enen.regScreenCountOver5 = enenMemory3.regScreenCountOver5
        enen.regScreenCountOver6 = enenMemory3.regScreenCountOver6
        enen.regScreenCountSum = enenMemory3.regScreenCountSum
        enen.dendoshaCountJuji = enenMemory3.dendoshaCountJuji
        enen.dendoshaCountJujiHit = enenMemory3.dendoshaCountJujiHit
        enen.dendoshaCountJakuRare = enenMemory3.dendoshaCountJakuRare
        enen.dendoshaCountJakuRareHit = enenMemory3.dendoshaCountJakuRareHit
        enen.bigScreenCountDefault = enenMemory3.bigScreenCountDefault
        enen.bigScreenCountHighJaku = enenMemory3.bigScreenCountHighJaku
        enen.bigScreenCountHighKyo = enenMemory3.bigScreenCountHighKyo
        enen.bigScreenCountOver4 = enenMemory3.bigScreenCountOver4
        enen.bigScreenCountOver5 = enenMemory3.bigScreenCountOver5
        enen.bigScreenCountOver6 = enenMemory3.bigScreenCountOver6
        enen.bigScreenCountSum = enenMemory3.bigScreenCountSum
        enen.adoraCount25Sisa = enenMemory3.adoraCount25Sisa
        enen.adoraCount146Sisa = enenMemory3.adoraCount146Sisa
        enen.adoraCountOver2 = enenMemory3.adoraCountOver2
        enen.adoraCount146Fix = enenMemory3.adoraCount146Fix
        enen.adoraCountOver4 = enenMemory3.adoraCountOver4
        enen.adoraCountOver5 = enenMemory3.adoraCountOver5
        enen.adoraCountSum = enenMemory3.adoraCountSum
    }
}

#Preview {
    enenViewTop(
        ver370: Ver370(),
    )
}
