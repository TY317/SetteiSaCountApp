//
//  guiltyCrown2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import SwiftUI

struct guiltyCrown2ViewTop: View {
//    @ObservedObject var ver340: Ver340
//    @ObservedObject var ver350: Ver350
    @StateObject var guiltyCrown2 = GuiltyCrown2()
    @State var isShowAlert: Bool = false
    @StateObject var guiltyCrown2Memory1 = GuiltyCrown2Memory1()
    @StateObject var guiltyCrown2Memory2 = GuiltyCrown2Memory2()
    @StateObject var guiltyCrown2Memory3 = GuiltyCrown2Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "ギルティクラウン2")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: guiltyCrown2ViewNormal(
//                        ver350: ver350,
                        guiltyCrown2: guiltyCrown2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
//                            badgeStatus: ver350.guiltyCrown2MenuNormalBadgeStaus,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: guiltyCrown2ViewFirstHit(
//                        ver350: ver350,
                        guiltyCrown2: guiltyCrown2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
//                            badgeStatus: ver350.guiltyCrown2MenuFirstHitBadgeStaus,
                        )
                    }
                    
                    // BIG終了画面
                    NavigationLink(destination: guiltyCrown2ViewBonusScreen(
                        guiltyCrown2: guiltyCrown2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了後のサブ液晶画面"
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: guiltyCrown2ViewAtScreen(
                        guiltyCrown2: guiltyCrown2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: guiltyCrown2View95Ci(
                    guiltyCrown2: guiltyCrown2,
                    selection: 1
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4790")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver350.guiltyCrown2MachineIconBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(guiltyCrown2SubViewLoadMemory(
                        guiltyCrown2: guiltyCrown2,
                        guiltyCrown2Memory1: guiltyCrown2Memory1,
                        guiltyCrown2Memory2: guiltyCrown2Memory2,
                        guiltyCrown2Memory3: guiltyCrown2Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(guiltyCrown2SubViewSaveMemory(
                        guiltyCrown2: guiltyCrown2,
                        guiltyCrown2Memory1: guiltyCrown2Memory1,
                        guiltyCrown2Memory2: guiltyCrown2Memory2,
                        guiltyCrown2Memory3: guiltyCrown2Memory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: guiltyCrown2.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct guiltyCrown2SubViewSaveMemory: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @ObservedObject var guiltyCrown2Memory1: GuiltyCrown2Memory1
    @ObservedObject var guiltyCrown2Memory2: GuiltyCrown2Memory2
    @ObservedObject var guiltyCrown2Memory3: GuiltyCrown2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: guiltyCrown2.machineName,
            selectedMemory: $guiltyCrown2.selectedMemory,
            memoMemory1: $guiltyCrown2Memory1.memo,
            dateDoubleMemory1: $guiltyCrown2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $guiltyCrown2Memory2.memo,
            dateDoubleMemory2: $guiltyCrown2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $guiltyCrown2Memory3.memo,
            dateDoubleMemory3: $guiltyCrown2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        guiltyCrown2Memory1.bonusScreenCountBlack = guiltyCrown2.bonusScreenCountBlack
        guiltyCrown2Memory1.bonusScreenCountWhite = guiltyCrown2.bonusScreenCountWhite
        guiltyCrown2Memory1.bonusScreenCountSum = guiltyCrown2.bonusScreenCountSum
        guiltyCrown2Memory1.atScreenCountDefault = guiltyCrown2.atScreenCountDefault
        guiltyCrown2Memory1.atScreenCountOver2 = guiltyCrown2.atScreenCountOver2
        guiltyCrown2Memory1.atScreenCountOver4 = guiltyCrown2.atScreenCountOver4
        guiltyCrown2Memory1.atScreenCountOver6 = guiltyCrown2.atScreenCountOver6
        guiltyCrown2Memory1.atScreenCountSum = guiltyCrown2.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2Memory1.suikaBonusCountJaku = guiltyCrown2.suikaBonusCountJaku
        guiltyCrown2Memory1.suikaBonusCountJakuBonus = guiltyCrown2.suikaBonusCountJakuBonus
        guiltyCrown2Memory1.suikaBonusCountKyo = guiltyCrown2.suikaBonusCountKyo
        guiltyCrown2Memory1.suikaBonusCountKyoBonus = guiltyCrown2.suikaBonusCountKyoBonus
        guiltyCrown2Memory1.bonusDetailCountJakuRedIshoku = guiltyCrown2.bonusDetailCountJakuRedIshoku
        guiltyCrown2Memory1.bonusDetailCountKyoRed = guiltyCrown2.bonusDetailCountKyoRed
        guiltyCrown2Memory1.bonusDetailCountKyoWhite = guiltyCrown2.bonusDetailCountKyoWhite
        guiltyCrown2Memory1.bonusDetailCountKyoWhiteIshoku = guiltyCrown2.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2Memory1.bonusDetailCountSum = guiltyCrown2.bonusDetailCountSum
        guiltyCrown2Memory1.normalGame = guiltyCrown2.normalGame
    }
    func saveMemory2() {
        guiltyCrown2Memory2.bonusScreenCountBlack = guiltyCrown2.bonusScreenCountBlack
        guiltyCrown2Memory2.bonusScreenCountWhite = guiltyCrown2.bonusScreenCountWhite
        guiltyCrown2Memory2.bonusScreenCountSum = guiltyCrown2.bonusScreenCountSum
        guiltyCrown2Memory2.atScreenCountDefault = guiltyCrown2.atScreenCountDefault
        guiltyCrown2Memory2.atScreenCountOver2 = guiltyCrown2.atScreenCountOver2
        guiltyCrown2Memory2.atScreenCountOver4 = guiltyCrown2.atScreenCountOver4
        guiltyCrown2Memory2.atScreenCountOver6 = guiltyCrown2.atScreenCountOver6
        guiltyCrown2Memory2.atScreenCountSum = guiltyCrown2.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2Memory2.suikaBonusCountJaku = guiltyCrown2.suikaBonusCountJaku
        guiltyCrown2Memory2.suikaBonusCountJakuBonus = guiltyCrown2.suikaBonusCountJakuBonus
        guiltyCrown2Memory2.suikaBonusCountKyo = guiltyCrown2.suikaBonusCountKyo
        guiltyCrown2Memory2.suikaBonusCountKyoBonus = guiltyCrown2.suikaBonusCountKyoBonus
        guiltyCrown2Memory2.bonusDetailCountJakuRedIshoku = guiltyCrown2.bonusDetailCountJakuRedIshoku
        guiltyCrown2Memory2.bonusDetailCountKyoRed = guiltyCrown2.bonusDetailCountKyoRed
        guiltyCrown2Memory2.bonusDetailCountKyoWhite = guiltyCrown2.bonusDetailCountKyoWhite
        guiltyCrown2Memory2.bonusDetailCountKyoWhiteIshoku = guiltyCrown2.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2Memory2.bonusDetailCountSum = guiltyCrown2.bonusDetailCountSum
        guiltyCrown2Memory2.normalGame = guiltyCrown2.normalGame
    }
    func saveMemory3() {
        guiltyCrown2Memory3.bonusScreenCountBlack = guiltyCrown2.bonusScreenCountBlack
        guiltyCrown2Memory3.bonusScreenCountWhite = guiltyCrown2.bonusScreenCountWhite
        guiltyCrown2Memory3.bonusScreenCountSum = guiltyCrown2.bonusScreenCountSum
        guiltyCrown2Memory3.atScreenCountDefault = guiltyCrown2.atScreenCountDefault
        guiltyCrown2Memory3.atScreenCountOver2 = guiltyCrown2.atScreenCountOver2
        guiltyCrown2Memory3.atScreenCountOver4 = guiltyCrown2.atScreenCountOver4
        guiltyCrown2Memory3.atScreenCountOver6 = guiltyCrown2.atScreenCountOver6
        guiltyCrown2Memory3.atScreenCountSum = guiltyCrown2.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2Memory3.suikaBonusCountJaku = guiltyCrown2.suikaBonusCountJaku
        guiltyCrown2Memory3.suikaBonusCountJakuBonus = guiltyCrown2.suikaBonusCountJakuBonus
        guiltyCrown2Memory3.suikaBonusCountKyo = guiltyCrown2.suikaBonusCountKyo
        guiltyCrown2Memory3.suikaBonusCountKyoBonus = guiltyCrown2.suikaBonusCountKyoBonus
        guiltyCrown2Memory3.bonusDetailCountJakuRedIshoku = guiltyCrown2.bonusDetailCountJakuRedIshoku
        guiltyCrown2Memory3.bonusDetailCountKyoRed = guiltyCrown2.bonusDetailCountKyoRed
        guiltyCrown2Memory3.bonusDetailCountKyoWhite = guiltyCrown2.bonusDetailCountKyoWhite
        guiltyCrown2Memory3.bonusDetailCountKyoWhiteIshoku = guiltyCrown2.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2Memory3.bonusDetailCountSum = guiltyCrown2.bonusDetailCountSum
        guiltyCrown2Memory3.normalGame = guiltyCrown2.normalGame
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct guiltyCrown2SubViewLoadMemory: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @ObservedObject var guiltyCrown2Memory1: GuiltyCrown2Memory1
    @ObservedObject var guiltyCrown2Memory2: GuiltyCrown2Memory2
    @ObservedObject var guiltyCrown2Memory3: GuiltyCrown2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: guiltyCrown2.machineName,
            selectedMemory: $guiltyCrown2.selectedMemory,
            memoMemory1: guiltyCrown2Memory1.memo,
            dateDoubleMemory1: guiltyCrown2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: guiltyCrown2Memory2.memo,
            dateDoubleMemory2: guiltyCrown2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: guiltyCrown2Memory3.memo,
            dateDoubleMemory3: guiltyCrown2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        guiltyCrown2.bonusScreenCountBlack = guiltyCrown2Memory1.bonusScreenCountBlack
        guiltyCrown2.bonusScreenCountWhite = guiltyCrown2Memory1.bonusScreenCountWhite
        guiltyCrown2.bonusScreenCountSum = guiltyCrown2Memory1.bonusScreenCountSum
        guiltyCrown2.atScreenCountDefault = guiltyCrown2Memory1.atScreenCountDefault
        guiltyCrown2.atScreenCountOver2 = guiltyCrown2Memory1.atScreenCountOver2
        guiltyCrown2.atScreenCountOver4 = guiltyCrown2Memory1.atScreenCountOver4
        guiltyCrown2.atScreenCountOver6 = guiltyCrown2Memory1.atScreenCountOver6
        guiltyCrown2.atScreenCountSum = guiltyCrown2Memory1.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2.suikaBonusCountJaku = guiltyCrown2Memory1.suikaBonusCountJaku
        guiltyCrown2.suikaBonusCountJakuBonus = guiltyCrown2Memory1.suikaBonusCountJakuBonus
        guiltyCrown2.suikaBonusCountKyo = guiltyCrown2Memory1.suikaBonusCountKyo
        guiltyCrown2.suikaBonusCountKyoBonus = guiltyCrown2Memory1.suikaBonusCountKyoBonus
        guiltyCrown2.bonusDetailCountJakuRedIshoku = guiltyCrown2Memory1.bonusDetailCountJakuRedIshoku
        guiltyCrown2.bonusDetailCountKyoRed = guiltyCrown2Memory1.bonusDetailCountKyoRed
        guiltyCrown2.bonusDetailCountKyoWhite = guiltyCrown2Memory1.bonusDetailCountKyoWhite
        guiltyCrown2.bonusDetailCountKyoWhiteIshoku = guiltyCrown2Memory1.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2.bonusDetailCountSum = guiltyCrown2Memory1.bonusDetailCountSum
        guiltyCrown2.normalGame = guiltyCrown2Memory1.normalGame
    }
    func loadMemory2() {
        guiltyCrown2.bonusScreenCountBlack = guiltyCrown2Memory2.bonusScreenCountBlack
        guiltyCrown2.bonusScreenCountWhite = guiltyCrown2Memory2.bonusScreenCountWhite
        guiltyCrown2.bonusScreenCountSum = guiltyCrown2Memory2.bonusScreenCountSum
        guiltyCrown2.atScreenCountDefault = guiltyCrown2Memory2.atScreenCountDefault
        guiltyCrown2.atScreenCountOver2 = guiltyCrown2Memory2.atScreenCountOver2
        guiltyCrown2.atScreenCountOver4 = guiltyCrown2Memory2.atScreenCountOver4
        guiltyCrown2.atScreenCountOver6 = guiltyCrown2Memory2.atScreenCountOver6
        guiltyCrown2.atScreenCountSum = guiltyCrown2Memory2.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2.suikaBonusCountJaku = guiltyCrown2Memory2.suikaBonusCountJaku
        guiltyCrown2.suikaBonusCountJakuBonus = guiltyCrown2Memory2.suikaBonusCountJakuBonus
        guiltyCrown2.suikaBonusCountKyo = guiltyCrown2Memory2.suikaBonusCountKyo
        guiltyCrown2.suikaBonusCountKyoBonus = guiltyCrown2Memory2.suikaBonusCountKyoBonus
        guiltyCrown2.bonusDetailCountJakuRedIshoku = guiltyCrown2Memory2.bonusDetailCountJakuRedIshoku
        guiltyCrown2.bonusDetailCountKyoRed = guiltyCrown2Memory2.bonusDetailCountKyoRed
        guiltyCrown2.bonusDetailCountKyoWhite = guiltyCrown2Memory2.bonusDetailCountKyoWhite
        guiltyCrown2.bonusDetailCountKyoWhiteIshoku = guiltyCrown2Memory2.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2.bonusDetailCountSum = guiltyCrown2Memory2.bonusDetailCountSum
        guiltyCrown2.normalGame = guiltyCrown2Memory2.normalGame
    }
    func loadMemory3() {
        guiltyCrown2.bonusScreenCountBlack = guiltyCrown2Memory3.bonusScreenCountBlack
        guiltyCrown2.bonusScreenCountWhite = guiltyCrown2Memory3.bonusScreenCountWhite
        guiltyCrown2.bonusScreenCountSum = guiltyCrown2Memory3.bonusScreenCountSum
        guiltyCrown2.atScreenCountDefault = guiltyCrown2Memory3.atScreenCountDefault
        guiltyCrown2.atScreenCountOver2 = guiltyCrown2Memory3.atScreenCountOver2
        guiltyCrown2.atScreenCountOver4 = guiltyCrown2Memory3.atScreenCountOver4
        guiltyCrown2.atScreenCountOver6 = guiltyCrown2Memory3.atScreenCountOver6
        guiltyCrown2.atScreenCountSum = guiltyCrown2Memory3.atScreenCountSum
        
        // ////////////////////
        // ver3.5.0で追加
        // ////////////////////
        guiltyCrown2.suikaBonusCountJaku = guiltyCrown2Memory3.suikaBonusCountJaku
        guiltyCrown2.suikaBonusCountJakuBonus = guiltyCrown2Memory3.suikaBonusCountJakuBonus
        guiltyCrown2.suikaBonusCountKyo = guiltyCrown2Memory3.suikaBonusCountKyo
        guiltyCrown2.suikaBonusCountKyoBonus = guiltyCrown2Memory3.suikaBonusCountKyoBonus
        guiltyCrown2.bonusDetailCountJakuRedIshoku = guiltyCrown2Memory3.bonusDetailCountJakuRedIshoku
        guiltyCrown2.bonusDetailCountKyoRed = guiltyCrown2Memory3.bonusDetailCountKyoRed
        guiltyCrown2.bonusDetailCountKyoWhite = guiltyCrown2Memory3.bonusDetailCountKyoWhite
        guiltyCrown2.bonusDetailCountKyoWhiteIshoku = guiltyCrown2Memory3.bonusDetailCountKyoWhiteIshoku
        guiltyCrown2.bonusDetailCountSum = guiltyCrown2Memory3.bonusDetailCountSum
        guiltyCrown2.normalGame = guiltyCrown2Memory3.normalGame
    }
}

#Preview {
    guiltyCrown2ViewTop(
//        ver340: Ver340(),
//        ver350: Ver350(),
    )
}
