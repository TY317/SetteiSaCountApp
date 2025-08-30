//
//  bioViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/11.
//

import SwiftUI
import FirebaseAnalytics

struct bioViewTop: View {
//    @ObservedObject var ver370: Ver370
    @StateObject var bio = Bio()
    @State var isShowAlert: Bool = false
    @StateObject var bioMemory1 = BioMemory1()
    @StateObject var bioMemory2 = BioMemory2()
    @StateObject var bioMemory3 = BioMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: bioViewNormal(bio: bio)) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // CZ,AT初当り
                    NavigationLink(destination: bioViewHistory(bio: bio)) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "CZ,AT初当り"
                        )
                    }
                    // AT中
                    NavigationLink(destination: bioViewAt(
//                        ver370: ver370,
                        bio: bio,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "allergens.fill",
                            textBody: "AT開始時",
//                            badgeStatus: ver370.bioMenuAtBadge,
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: bioViewScreen(bio: bio)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: bioViewEnding(bio: bio)) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
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
                    unitLabelMachineTopTitle(machineName: "バイオハザード5")
                }
                // 設定推測グラフ
                NavigationLink(destination: bioView95Ci(bio: bio)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4754")
                
                // copyright
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver370.bioMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "バイオハザード5", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "bioViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: bioViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver250.bioMachineIconBadgeStatus != "none" {
//                ver250.bioMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(bioSubViewLoadMemory(
                        bio: bio,
                        bioMemory1: bioMemory1,
                        bioMemory2: bioMemory2,
                        bioMemory3: bioMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(bioSubViewSaveMemory(
                        bio: bio,
                        bioMemory1: bioMemory1,
                        bioMemory2: bioMemory2,
                        bioMemory3: bioMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bio.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct bioSubViewSaveMemory: View {
    @ObservedObject var bio: Bio
    @ObservedObject var bioMemory1: BioMemory1
    @ObservedObject var bioMemory2: BioMemory2
    @ObservedObject var bioMemory3: BioMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "バイオハザード5",
            selectedMemory: $bio.selectedMemory,
            memoMemory1: $bioMemory1.memo,
            dateDoubleMemory1: $bioMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $bioMemory2.memo,
            dateDoubleMemory2: $bioMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $bioMemory3.memo,
            dateDoubleMemory3: $bioMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        bioMemory1.gameArrayData = bio.gameArrayData
        bioMemory1.kindArrayData = bio.kindArrayData
        bioMemory1.atHitArrayData = bio.atHitArrayData
        bioMemory1.playGameSum = bio.playGameSum
        bioMemory1.atCount = bio.atCount
        bioMemory1.czCount = bio.czCount
        bioMemory1.screenCountDefault = bio.screenCountDefault
        bioMemory1.screenCountKisu = bio.screenCountKisu
        bioMemory1.screenCountGusu = bio.screenCountGusu
        bioMemory1.screenCountExcepted1 = bio.screenCountExcepted1
        bioMemory1.screenCountExcepted2 = bio.screenCountExcepted2
        bioMemory1.screenCountExcepted3 = bio.screenCountExcepted3
        bioMemory1.screenCountHighJaku = bio.screenCountHighJaku
        bioMemory1.screenCountHighKyo = bio.screenCountHighKyo
        bioMemory1.screenCountOver3 = bio.screenCountOver3
        bioMemory1.screenCountOver4 = bio.screenCountOver4
        bioMemory1.screenCountOver5 = bio.screenCountOver5
        bioMemory1.screenCountOver6 = bio.screenCountOver6
        bioMemory1.screenCountSum = bio.screenCountSum
        bioMemory1.endingCountDefault = bio.endingCountDefault
        bioMemory1.endingCountKisu = bio.endingCountKisu
        bioMemory1.endingCountGusu = bio.endingCountGusu
        bioMemory1.endingCountHighJaku = bio.endingCountHighJaku
        bioMemory1.endingCountHighKyo = bio.endingCountHighKyo
        bioMemory1.endingCountOver4 = bio.endingCountOver4
        bioMemory1.endingCountOver5 = bio.endingCountOver5
        bioMemory1.endingCountOver6 = bio.endingCountOver6
        bioMemory1.endingCountSum = bio.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bioMemory1.infectionCountMiss = bio.infectionCountMiss
        bioMemory1.infectionCountHit = bio.infectionCountHit
        bioMemory1.infectionCountSum = bio.infectionCountSum
    }
    func saveMemory2() {
        bioMemory2.gameArrayData = bio.gameArrayData
        bioMemory2.kindArrayData = bio.kindArrayData
        bioMemory2.atHitArrayData = bio.atHitArrayData
        bioMemory2.playGameSum = bio.playGameSum
        bioMemory2.atCount = bio.atCount
        bioMemory2.czCount = bio.czCount
        bioMemory2.screenCountDefault = bio.screenCountDefault
        bioMemory2.screenCountKisu = bio.screenCountKisu
        bioMemory2.screenCountGusu = bio.screenCountGusu
        bioMemory2.screenCountExcepted1 = bio.screenCountExcepted1
        bioMemory2.screenCountExcepted2 = bio.screenCountExcepted2
        bioMemory2.screenCountExcepted3 = bio.screenCountExcepted3
        bioMemory2.screenCountHighJaku = bio.screenCountHighJaku
        bioMemory2.screenCountHighKyo = bio.screenCountHighKyo
        bioMemory2.screenCountOver3 = bio.screenCountOver3
        bioMemory2.screenCountOver4 = bio.screenCountOver4
        bioMemory2.screenCountOver5 = bio.screenCountOver5
        bioMemory2.screenCountOver6 = bio.screenCountOver6
        bioMemory2.screenCountSum = bio.screenCountSum
        bioMemory2.endingCountDefault = bio.endingCountDefault
        bioMemory2.endingCountKisu = bio.endingCountKisu
        bioMemory2.endingCountGusu = bio.endingCountGusu
        bioMemory2.endingCountHighJaku = bio.endingCountHighJaku
        bioMemory2.endingCountHighKyo = bio.endingCountHighKyo
        bioMemory2.endingCountOver4 = bio.endingCountOver4
        bioMemory2.endingCountOver5 = bio.endingCountOver5
        bioMemory2.endingCountOver6 = bio.endingCountOver6
        bioMemory2.endingCountSum = bio.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bioMemory2.infectionCountMiss = bio.infectionCountMiss
        bioMemory2.infectionCountHit = bio.infectionCountHit
        bioMemory2.infectionCountSum = bio.infectionCountSum
    }
    func saveMemory3() {
        bioMemory3.gameArrayData = bio.gameArrayData
        bioMemory3.kindArrayData = bio.kindArrayData
        bioMemory3.atHitArrayData = bio.atHitArrayData
        bioMemory3.playGameSum = bio.playGameSum
        bioMemory3.atCount = bio.atCount
        bioMemory3.czCount = bio.czCount
        bioMemory3.screenCountDefault = bio.screenCountDefault
        bioMemory3.screenCountKisu = bio.screenCountKisu
        bioMemory3.screenCountGusu = bio.screenCountGusu
        bioMemory3.screenCountExcepted1 = bio.screenCountExcepted1
        bioMemory3.screenCountExcepted2 = bio.screenCountExcepted2
        bioMemory3.screenCountExcepted3 = bio.screenCountExcepted3
        bioMemory3.screenCountHighJaku = bio.screenCountHighJaku
        bioMemory3.screenCountHighKyo = bio.screenCountHighKyo
        bioMemory3.screenCountOver3 = bio.screenCountOver3
        bioMemory3.screenCountOver4 = bio.screenCountOver4
        bioMemory3.screenCountOver5 = bio.screenCountOver5
        bioMemory3.screenCountOver6 = bio.screenCountOver6
        bioMemory3.screenCountSum = bio.screenCountSum
        bioMemory3.endingCountDefault = bio.endingCountDefault
        bioMemory3.endingCountKisu = bio.endingCountKisu
        bioMemory3.endingCountGusu = bio.endingCountGusu
        bioMemory3.endingCountHighJaku = bio.endingCountHighJaku
        bioMemory3.endingCountHighKyo = bio.endingCountHighKyo
        bioMemory3.endingCountOver4 = bio.endingCountOver4
        bioMemory3.endingCountOver5 = bio.endingCountOver5
        bioMemory3.endingCountOver6 = bio.endingCountOver6
        bioMemory3.endingCountSum = bio.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bioMemory3.infectionCountMiss = bio.infectionCountMiss
        bioMemory3.infectionCountHit = bio.infectionCountHit
        bioMemory3.infectionCountSum = bio.infectionCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct bioSubViewLoadMemory: View {
    @ObservedObject var bio: Bio
    @ObservedObject var bioMemory1: BioMemory1
    @ObservedObject var bioMemory2: BioMemory2
    @ObservedObject var bioMemory3: BioMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "バイオハザード5",
            selectedMemory: $bio.selectedMemory,
            memoMemory1: bioMemory1.memo,
            dateDoubleMemory1: bioMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: bioMemory2.memo,
            dateDoubleMemory2: bioMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: bioMemory3.memo,
            dateDoubleMemory3: bioMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let memoryGameArrayData = decodeIntArray(from: bioMemory1.gameArrayData)
        saveArray(memoryGameArrayData, forKey: bio.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: bioMemory1.kindArrayData)
        saveArray(memoryKindArrayData, forKey: bio.kindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: bioMemory1.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: bio.atHitArrayKey)
//        bio.gameArrayData = bioMemory1.gameArrayData
//        bio.kindArrayData = bioMemory1.kindArrayData
//        bio.atHitArrayData = bioMemory1.atHitArrayData
        bio.playGameSum = bioMemory1.playGameSum
        bio.atCount = bioMemory1.atCount
        bio.czCount = bioMemory1.czCount
        bio.screenCountDefault = bioMemory1.screenCountDefault
        bio.screenCountKisu = bioMemory1.screenCountKisu
        bio.screenCountGusu = bioMemory1.screenCountGusu
        bio.screenCountExcepted1 = bioMemory1.screenCountExcepted1
        bio.screenCountExcepted2 = bioMemory1.screenCountExcepted2
        bio.screenCountExcepted3 = bioMemory1.screenCountExcepted3
        bio.screenCountHighJaku = bioMemory1.screenCountHighJaku
        bio.screenCountHighKyo = bioMemory1.screenCountHighKyo
        bio.screenCountOver3 = bioMemory1.screenCountOver3
        bio.screenCountOver4 = bioMemory1.screenCountOver4
        bio.screenCountOver5 = bioMemory1.screenCountOver5
        bio.screenCountOver6 = bioMemory1.screenCountOver6
        bio.screenCountSum = bioMemory1.screenCountSum
        bio.endingCountDefault = bioMemory1.endingCountDefault
        bio.endingCountKisu = bioMemory1.endingCountKisu
        bio.endingCountGusu = bioMemory1.endingCountGusu
        bio.endingCountHighJaku = bioMemory1.endingCountHighJaku
        bio.endingCountHighKyo = bioMemory1.endingCountHighKyo
        bio.endingCountOver4 = bioMemory1.endingCountOver4
        bio.endingCountOver5 = bioMemory1.endingCountOver5
        bio.endingCountOver6 = bioMemory1.endingCountOver6
        bio.endingCountSum = bioMemory1.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bio.infectionCountMiss = bioMemory1.infectionCountMiss
        bio.infectionCountHit = bioMemory1.infectionCountHit
        bio.infectionCountSum = bioMemory1.infectionCountSum
    }
    func loadMemory2() {
        let memoryGameArrayData = decodeIntArray(from: bioMemory2.gameArrayData)
        saveArray(memoryGameArrayData, forKey: bio.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: bioMemory2.kindArrayData)
        saveArray(memoryKindArrayData, forKey: bio.kindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: bioMemory2.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: bio.atHitArrayKey)
//        bio.gameArrayData = bioMemory2.gameArrayData
//        bio.kindArrayData = bioMemory2.kindArrayData
//        bio.atHitArrayData = bioMemory2.atHitArrayData
        bio.playGameSum = bioMemory2.playGameSum
        bio.atCount = bioMemory2.atCount
        bio.czCount = bioMemory2.czCount
        bio.screenCountDefault = bioMemory2.screenCountDefault
        bio.screenCountKisu = bioMemory2.screenCountKisu
        bio.screenCountGusu = bioMemory2.screenCountGusu
        bio.screenCountExcepted1 = bioMemory2.screenCountExcepted1
        bio.screenCountExcepted2 = bioMemory2.screenCountExcepted2
        bio.screenCountExcepted3 = bioMemory2.screenCountExcepted3
        bio.screenCountHighJaku = bioMemory2.screenCountHighJaku
        bio.screenCountHighKyo = bioMemory2.screenCountHighKyo
        bio.screenCountOver3 = bioMemory2.screenCountOver3
        bio.screenCountOver4 = bioMemory2.screenCountOver4
        bio.screenCountOver5 = bioMemory2.screenCountOver5
        bio.screenCountOver6 = bioMemory2.screenCountOver6
        bio.screenCountSum = bioMemory2.screenCountSum
        bio.endingCountDefault = bioMemory2.endingCountDefault
        bio.endingCountKisu = bioMemory2.endingCountKisu
        bio.endingCountGusu = bioMemory2.endingCountGusu
        bio.endingCountHighJaku = bioMemory2.endingCountHighJaku
        bio.endingCountHighKyo = bioMemory2.endingCountHighKyo
        bio.endingCountOver4 = bioMemory2.endingCountOver4
        bio.endingCountOver5 = bioMemory2.endingCountOver5
        bio.endingCountOver6 = bioMemory2.endingCountOver6
        bio.endingCountSum = bioMemory2.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bio.infectionCountMiss = bioMemory2.infectionCountMiss
        bio.infectionCountHit = bioMemory2.infectionCountHit
        bio.infectionCountSum = bioMemory2.infectionCountSum
    }
    func loadMemory3() {
        let memoryGameArrayData = decodeIntArray(from: bioMemory3.gameArrayData)
        saveArray(memoryGameArrayData, forKey: bio.gameArrayKey)
        let memoryKindArrayData = decodeStringArray(from: bioMemory3.kindArrayData)
        saveArray(memoryKindArrayData, forKey: bio.kindArrayKey)
        let memoryAtHitArrayData = decodeStringArray(from: bioMemory3.atHitArrayData)
        saveArray(memoryAtHitArrayData, forKey: bio.atHitArrayKey)
//        bio.gameArrayData = bioMemory3.gameArrayData
//        bio.kindArrayData = bioMemory3.kindArrayData
//        bio.atHitArrayData = bioMemory3.atHitArrayData
        bio.playGameSum = bioMemory3.playGameSum
        bio.atCount = bioMemory3.atCount
        bio.czCount = bioMemory3.czCount
        bio.screenCountDefault = bioMemory3.screenCountDefault
        bio.screenCountKisu = bioMemory3.screenCountKisu
        bio.screenCountGusu = bioMemory3.screenCountGusu
        bio.screenCountExcepted1 = bioMemory3.screenCountExcepted1
        bio.screenCountExcepted2 = bioMemory3.screenCountExcepted2
        bio.screenCountExcepted3 = bioMemory3.screenCountExcepted3
        bio.screenCountHighJaku = bioMemory3.screenCountHighJaku
        bio.screenCountHighKyo = bioMemory3.screenCountHighKyo
        bio.screenCountOver3 = bioMemory3.screenCountOver3
        bio.screenCountOver4 = bioMemory3.screenCountOver4
        bio.screenCountOver5 = bioMemory3.screenCountOver5
        bio.screenCountOver6 = bioMemory3.screenCountOver6
        bio.screenCountSum = bioMemory3.screenCountSum
        bio.endingCountDefault = bioMemory3.endingCountDefault
        bio.endingCountKisu = bioMemory3.endingCountKisu
        bio.endingCountGusu = bioMemory3.endingCountGusu
        bio.endingCountHighJaku = bioMemory3.endingCountHighJaku
        bio.endingCountHighKyo = bioMemory3.endingCountHighKyo
        bio.endingCountOver4 = bioMemory3.endingCountOver4
        bio.endingCountOver5 = bioMemory3.endingCountOver5
        bio.endingCountOver6 = bioMemory3.endingCountOver6
        bio.endingCountSum = bioMemory3.endingCountSum
        
        // ///////////////
        // ver3.7.0で追加
        // ///////////////
        bio.infectionCountMiss = bioMemory3.infectionCountMiss
        bio.infectionCountHit = bioMemory3.infectionCountHit
        bio.infectionCountSum = bioMemory3.infectionCountSum
    }
}

#Preview {
    bioViewTop(
//        ver370: Ver370(),
    )
}
