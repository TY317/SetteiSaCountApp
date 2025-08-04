//
//  reSwordViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordViewTop: View {
    @ObservedObject var ver360: Ver360
    @StateObject var reSword = ReSword()
    @State var isShowAlert: Bool = false
    @StateObject var reSwordMemory1 = ReSwordMemory1()
    @StateObject var reSwordMemory2 = ReSwordMemory2()
    @StateObject var reSwordMemory3 = ReSwordMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: reSword.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: reSwordViewNormal(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: reSwordViewCz(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "dot.scope",
                            textBody: "CZ デーモンバトル"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: reSwordViewFirstHit(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // フランボーナス中のキャラ紹介
                    NavigationLink(destination: reSwordViewFranChara(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "フランボーナス中のキャラ紹介"
                        )
                    }
                    
                    // X転剣ボーナス中のストーリー
                    NavigationLink(destination: reSwordViewStory(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "book.closed.fill",
                            textBody: "AT中"
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: reSwordViewAtScreen(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    
                    // トロフィー
                    NavigationLink(destination: commonViewArisuTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "アリストロフィー"
                        )
                    }
                }
                
//                // 設定推測グラフ
//                NavigationLink(destination: reSwordView95Ci(
//                    reSword: reSword,
//                    selection: 1
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4843"
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver360.reSwordMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(reSwordSubViewLoadMemory(
                        reSword: reSword,
                        reSwordMemory1: reSwordMemory1,
                        reSwordMemory2: reSwordMemory2,
                        reSwordMemory3: reSwordMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(reSwordSubViewSaveMemory(
                        reSword: reSword,
                        reSwordMemory1: reSwordMemory1,
                        reSwordMemory2: reSwordMemory2,
                        reSwordMemory3: reSwordMemory3
                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: reSword.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct reSwordSubViewSaveMemory: View {
    @ObservedObject var reSword: ReSword
    @ObservedObject var reSwordMemory1: ReSwordMemory1
    @ObservedObject var reSwordMemory2: ReSwordMemory2
    @ObservedObject var reSwordMemory3: ReSwordMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: reSword.machineName,
            selectedMemory: $reSword.selectedMemory,
            memoMemory1: $reSwordMemory1.memo,
            dateDoubleMemory1: $reSwordMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $reSwordMemory2.memo,
            dateDoubleMemory2: $reSwordMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $reSwordMemory3.memo,
            dateDoubleMemory3: $reSwordMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        reSwordMemory1.zoneCount350Miss = reSword.zoneCount350Miss
        reSwordMemory1.zoneCount350Hit = reSword.zoneCount350Hit
        reSwordMemory1.zoneCount350Sum = reSword.zoneCount350Sum
        reSwordMemory1.zoneCount650Miss = reSword.zoneCount650Miss
        reSwordMemory1.zoneCount650Hit = reSword.zoneCount650Hit
        reSwordMemory1.zoneCount650Sum = reSword.zoneCount650Sum
        reSwordMemory1.rareBonusCountJakuChanceMiss = reSword.rareBonusCountJakuChanceMiss
        reSwordMemory1.rareBonusCountJakuChanceHit = reSword.rareBonusCountJakuChanceHit
        reSwordMemory1.rareBonusCountJakuChanceSum = reSword.rareBonusCountJakuChanceSum
        reSwordMemory1.rareBonusCountSuikaMiss = reSword.rareBonusCountSuikaMiss
        reSwordMemory1.rareBonusCountSuikaHit = reSword.rareBonusCountSuikaHit
        reSwordMemory1.rareBonusCountSuikaSum = reSword.rareBonusCountSuikaSum
        reSwordMemory1.rareBonusCountKyoChanceMiss = reSword.rareBonusCountKyoChanceMiss
        reSwordMemory1.rareBonusCountKyoChanceHit = reSword.rareBonusCountKyoChanceHit
        reSwordMemory1.rareBonusCountKyoChanceSum = reSword.rareBonusCountKyoChanceSum
        reSwordMemory1.rareCzCountCherryJakuMiss = reSword.rareCzCountCherryJakuMiss
        reSwordMemory1.rareCzCountCherryJakuHit = reSword.rareCzCountCherryJakuHit
        reSwordMemory1.rareCzCountCherryJakuSum = reSword.rareCzCountCherryJakuSum
        reSwordMemory1.rareCzCountCherryKyoMiss = reSword.rareCzCountCherryKyoMiss
        reSwordMemory1.rareCzCountCherryKyoHit = reSword.rareCzCountCherryKyoHit
        reSwordMemory1.rareCzCountCherryKyoSum = reSword.rareCzCountCherryKyoSum
        reSwordMemory1.atScreenCount1 = reSword.atScreenCount1
        reSwordMemory1.atScreenCount2 = reSword.atScreenCount2
        reSwordMemory1.atScreenCount3 = reSword.atScreenCount3
        reSwordMemory1.atScreenCount4 = reSword.atScreenCount4
        reSwordMemory1.atScreenCount5 = reSword.atScreenCount5
        reSwordMemory1.atScreenCount6 = reSword.atScreenCount6
        reSwordMemory1.atScreenCountSum = reSword.atScreenCountSum
    }
    func saveMemory2() {
        reSwordMemory2.zoneCount350Miss = reSword.zoneCount350Miss
        reSwordMemory2.zoneCount350Hit = reSword.zoneCount350Hit
        reSwordMemory2.zoneCount350Sum = reSword.zoneCount350Sum
        reSwordMemory2.zoneCount650Miss = reSword.zoneCount650Miss
        reSwordMemory2.zoneCount650Hit = reSword.zoneCount650Hit
        reSwordMemory2.zoneCount650Sum = reSword.zoneCount650Sum
        reSwordMemory2.rareBonusCountJakuChanceMiss = reSword.rareBonusCountJakuChanceMiss
        reSwordMemory2.rareBonusCountJakuChanceHit = reSword.rareBonusCountJakuChanceHit
        reSwordMemory2.rareBonusCountJakuChanceSum = reSword.rareBonusCountJakuChanceSum
        reSwordMemory2.rareBonusCountSuikaMiss = reSword.rareBonusCountSuikaMiss
        reSwordMemory2.rareBonusCountSuikaHit = reSword.rareBonusCountSuikaHit
        reSwordMemory2.rareBonusCountSuikaSum = reSword.rareBonusCountSuikaSum
        reSwordMemory2.rareBonusCountKyoChanceMiss = reSword.rareBonusCountKyoChanceMiss
        reSwordMemory2.rareBonusCountKyoChanceHit = reSword.rareBonusCountKyoChanceHit
        reSwordMemory2.rareBonusCountKyoChanceSum = reSword.rareBonusCountKyoChanceSum
        reSwordMemory2.rareCzCountCherryJakuMiss = reSword.rareCzCountCherryJakuMiss
        reSwordMemory2.rareCzCountCherryJakuHit = reSword.rareCzCountCherryJakuHit
        reSwordMemory2.rareCzCountCherryJakuSum = reSword.rareCzCountCherryJakuSum
        reSwordMemory2.rareCzCountCherryKyoMiss = reSword.rareCzCountCherryKyoMiss
        reSwordMemory2.rareCzCountCherryKyoHit = reSword.rareCzCountCherryKyoHit
        reSwordMemory2.rareCzCountCherryKyoSum = reSword.rareCzCountCherryKyoSum
        reSwordMemory2.atScreenCount1 = reSword.atScreenCount1
        reSwordMemory2.atScreenCount2 = reSword.atScreenCount2
        reSwordMemory2.atScreenCount3 = reSword.atScreenCount3
        reSwordMemory2.atScreenCount4 = reSword.atScreenCount4
        reSwordMemory2.atScreenCount5 = reSword.atScreenCount5
        reSwordMemory2.atScreenCount6 = reSword.atScreenCount6
        reSwordMemory2.atScreenCountSum = reSword.atScreenCountSum
    }
    func saveMemory3() {
        reSwordMemory3.zoneCount350Miss = reSword.zoneCount350Miss
        reSwordMemory3.zoneCount350Hit = reSword.zoneCount350Hit
        reSwordMemory3.zoneCount350Sum = reSword.zoneCount350Sum
        reSwordMemory3.zoneCount650Miss = reSword.zoneCount650Miss
        reSwordMemory3.zoneCount650Hit = reSword.zoneCount650Hit
        reSwordMemory3.zoneCount650Sum = reSword.zoneCount650Sum
        reSwordMemory3.rareBonusCountJakuChanceMiss = reSword.rareBonusCountJakuChanceMiss
        reSwordMemory3.rareBonusCountJakuChanceHit = reSword.rareBonusCountJakuChanceHit
        reSwordMemory3.rareBonusCountJakuChanceSum = reSword.rareBonusCountJakuChanceSum
        reSwordMemory3.rareBonusCountSuikaMiss = reSword.rareBonusCountSuikaMiss
        reSwordMemory3.rareBonusCountSuikaHit = reSword.rareBonusCountSuikaHit
        reSwordMemory3.rareBonusCountSuikaSum = reSword.rareBonusCountSuikaSum
        reSwordMemory3.rareBonusCountKyoChanceMiss = reSword.rareBonusCountKyoChanceMiss
        reSwordMemory3.rareBonusCountKyoChanceHit = reSword.rareBonusCountKyoChanceHit
        reSwordMemory3.rareBonusCountKyoChanceSum = reSword.rareBonusCountKyoChanceSum
        reSwordMemory3.rareCzCountCherryJakuMiss = reSword.rareCzCountCherryJakuMiss
        reSwordMemory3.rareCzCountCherryJakuHit = reSword.rareCzCountCherryJakuHit
        reSwordMemory3.rareCzCountCherryJakuSum = reSword.rareCzCountCherryJakuSum
        reSwordMemory3.rareCzCountCherryKyoMiss = reSword.rareCzCountCherryKyoMiss
        reSwordMemory3.rareCzCountCherryKyoHit = reSword.rareCzCountCherryKyoHit
        reSwordMemory3.rareCzCountCherryKyoSum = reSword.rareCzCountCherryKyoSum
        reSwordMemory3.atScreenCount1 = reSword.atScreenCount1
        reSwordMemory3.atScreenCount2 = reSword.atScreenCount2
        reSwordMemory3.atScreenCount3 = reSword.atScreenCount3
        reSwordMemory3.atScreenCount4 = reSword.atScreenCount4
        reSwordMemory3.atScreenCount5 = reSword.atScreenCount5
        reSwordMemory3.atScreenCount6 = reSword.atScreenCount6
        reSwordMemory3.atScreenCountSum = reSword.atScreenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct reSwordSubViewLoadMemory: View {
    @ObservedObject var reSword: ReSword
    @ObservedObject var reSwordMemory1: ReSwordMemory1
    @ObservedObject var reSwordMemory2: ReSwordMemory2
    @ObservedObject var reSwordMemory3: ReSwordMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: reSword.machineName,
            selectedMemory: $reSword.selectedMemory,
            memoMemory1: reSwordMemory1.memo,
            dateDoubleMemory1: reSwordMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: reSwordMemory2.memo,
            dateDoubleMemory2: reSwordMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: reSwordMemory3.memo,
            dateDoubleMemory3: reSwordMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        reSword.zoneCount350Miss = reSwordMemory1.zoneCount350Miss
        reSword.zoneCount350Hit = reSwordMemory1.zoneCount350Hit
        reSword.zoneCount350Sum = reSwordMemory1.zoneCount350Sum
        reSword.zoneCount650Miss = reSwordMemory1.zoneCount650Miss
        reSword.zoneCount650Hit = reSwordMemory1.zoneCount650Hit
        reSword.zoneCount650Sum = reSwordMemory1.zoneCount650Sum
        reSword.rareBonusCountJakuChanceMiss = reSwordMemory1.rareBonusCountJakuChanceMiss
        reSword.rareBonusCountJakuChanceHit = reSwordMemory1.rareBonusCountJakuChanceHit
        reSword.rareBonusCountJakuChanceSum = reSwordMemory1.rareBonusCountJakuChanceSum
        reSword.rareBonusCountSuikaMiss = reSwordMemory1.rareBonusCountSuikaMiss
        reSword.rareBonusCountSuikaHit = reSwordMemory1.rareBonusCountSuikaHit
        reSword.rareBonusCountSuikaSum = reSwordMemory1.rareBonusCountSuikaSum
        reSword.rareBonusCountKyoChanceMiss = reSwordMemory1.rareBonusCountKyoChanceMiss
        reSword.rareBonusCountKyoChanceHit = reSwordMemory1.rareBonusCountKyoChanceHit
        reSword.rareBonusCountKyoChanceSum = reSwordMemory1.rareBonusCountKyoChanceSum
        reSword.rareCzCountCherryJakuMiss = reSwordMemory1.rareCzCountCherryJakuMiss
        reSword.rareCzCountCherryJakuHit = reSwordMemory1.rareCzCountCherryJakuHit
        reSword.rareCzCountCherryJakuSum = reSwordMemory1.rareCzCountCherryJakuSum
        reSword.rareCzCountCherryKyoMiss = reSwordMemory1.rareCzCountCherryKyoMiss
        reSword.rareCzCountCherryKyoHit = reSwordMemory1.rareCzCountCherryKyoHit
        reSword.rareCzCountCherryKyoSum = reSwordMemory1.rareCzCountCherryKyoSum
        reSword.atScreenCount1 = reSwordMemory1.atScreenCount1
        reSword.atScreenCount2 = reSwordMemory1.atScreenCount2
        reSword.atScreenCount3 = reSwordMemory1.atScreenCount3
        reSword.atScreenCount4 = reSwordMemory1.atScreenCount4
        reSword.atScreenCount5 = reSwordMemory1.atScreenCount5
        reSword.atScreenCount6 = reSwordMemory1.atScreenCount6
        reSword.atScreenCountSum = reSwordMemory1.atScreenCountSum
    }
    func loadMemory2() {
        reSword.zoneCount350Miss = reSwordMemory2.zoneCount350Miss
        reSword.zoneCount350Hit = reSwordMemory2.zoneCount350Hit
        reSword.zoneCount350Sum = reSwordMemory2.zoneCount350Sum
        reSword.zoneCount650Miss = reSwordMemory2.zoneCount650Miss
        reSword.zoneCount650Hit = reSwordMemory2.zoneCount650Hit
        reSword.zoneCount650Sum = reSwordMemory2.zoneCount650Sum
        reSword.rareBonusCountJakuChanceMiss = reSwordMemory2.rareBonusCountJakuChanceMiss
        reSword.rareBonusCountJakuChanceHit = reSwordMemory2.rareBonusCountJakuChanceHit
        reSword.rareBonusCountJakuChanceSum = reSwordMemory2.rareBonusCountJakuChanceSum
        reSword.rareBonusCountSuikaMiss = reSwordMemory2.rareBonusCountSuikaMiss
        reSword.rareBonusCountSuikaHit = reSwordMemory2.rareBonusCountSuikaHit
        reSword.rareBonusCountSuikaSum = reSwordMemory2.rareBonusCountSuikaSum
        reSword.rareBonusCountKyoChanceMiss = reSwordMemory2.rareBonusCountKyoChanceMiss
        reSword.rareBonusCountKyoChanceHit = reSwordMemory2.rareBonusCountKyoChanceHit
        reSword.rareBonusCountKyoChanceSum = reSwordMemory2.rareBonusCountKyoChanceSum
        reSword.rareCzCountCherryJakuMiss = reSwordMemory2.rareCzCountCherryJakuMiss
        reSword.rareCzCountCherryJakuHit = reSwordMemory2.rareCzCountCherryJakuHit
        reSword.rareCzCountCherryJakuSum = reSwordMemory2.rareCzCountCherryJakuSum
        reSword.rareCzCountCherryKyoMiss = reSwordMemory2.rareCzCountCherryKyoMiss
        reSword.rareCzCountCherryKyoHit = reSwordMemory2.rareCzCountCherryKyoHit
        reSword.rareCzCountCherryKyoSum = reSwordMemory2.rareCzCountCherryKyoSum
        reSword.atScreenCount1 = reSwordMemory2.atScreenCount1
        reSword.atScreenCount2 = reSwordMemory2.atScreenCount2
        reSword.atScreenCount3 = reSwordMemory2.atScreenCount3
        reSword.atScreenCount4 = reSwordMemory2.atScreenCount4
        reSword.atScreenCount5 = reSwordMemory2.atScreenCount5
        reSword.atScreenCount6 = reSwordMemory2.atScreenCount6
        reSword.atScreenCountSum = reSwordMemory2.atScreenCountSum
    }
    func loadMemory3() {
        reSword.zoneCount350Miss = reSwordMemory3.zoneCount350Miss
        reSword.zoneCount350Hit = reSwordMemory3.zoneCount350Hit
        reSword.zoneCount350Sum = reSwordMemory3.zoneCount350Sum
        reSword.zoneCount650Miss = reSwordMemory3.zoneCount650Miss
        reSword.zoneCount650Hit = reSwordMemory3.zoneCount650Hit
        reSword.zoneCount650Sum = reSwordMemory3.zoneCount650Sum
        reSword.rareBonusCountJakuChanceMiss = reSwordMemory3.rareBonusCountJakuChanceMiss
        reSword.rareBonusCountJakuChanceHit = reSwordMemory3.rareBonusCountJakuChanceHit
        reSword.rareBonusCountJakuChanceSum = reSwordMemory3.rareBonusCountJakuChanceSum
        reSword.rareBonusCountSuikaMiss = reSwordMemory3.rareBonusCountSuikaMiss
        reSword.rareBonusCountSuikaHit = reSwordMemory3.rareBonusCountSuikaHit
        reSword.rareBonusCountSuikaSum = reSwordMemory3.rareBonusCountSuikaSum
        reSword.rareBonusCountKyoChanceMiss = reSwordMemory3.rareBonusCountKyoChanceMiss
        reSword.rareBonusCountKyoChanceHit = reSwordMemory3.rareBonusCountKyoChanceHit
        reSword.rareBonusCountKyoChanceSum = reSwordMemory3.rareBonusCountKyoChanceSum
        reSword.rareCzCountCherryJakuMiss = reSwordMemory3.rareCzCountCherryJakuMiss
        reSword.rareCzCountCherryJakuHit = reSwordMemory3.rareCzCountCherryJakuHit
        reSword.rareCzCountCherryJakuSum = reSwordMemory3.rareCzCountCherryJakuSum
        reSword.rareCzCountCherryKyoMiss = reSwordMemory3.rareCzCountCherryKyoMiss
        reSword.rareCzCountCherryKyoHit = reSwordMemory3.rareCzCountCherryKyoHit
        reSword.rareCzCountCherryKyoSum = reSwordMemory3.rareCzCountCherryKyoSum
        reSword.atScreenCount1 = reSwordMemory3.atScreenCount1
        reSword.atScreenCount2 = reSwordMemory3.atScreenCount2
        reSword.atScreenCount3 = reSwordMemory3.atScreenCount3
        reSword.atScreenCount4 = reSwordMemory3.atScreenCount4
        reSword.atScreenCount5 = reSwordMemory3.atScreenCount5
        reSword.atScreenCount6 = reSwordMemory3.atScreenCount6
        reSword.atScreenCountSum = reSwordMemory3.atScreenCountSum
    }
}

#Preview {
    reSwordViewTop(
        ver360: Ver360(),
    )
}
