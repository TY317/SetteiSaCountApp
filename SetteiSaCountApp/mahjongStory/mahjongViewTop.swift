//
//  mahjongViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/15.
//

import SwiftUI

struct mahjongViewTop: View {
//    @ObservedObject var ver280 = Ver280()
    @ObservedObject var mahjong = Mahjong()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "麻雀物語")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: mahjongViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: mahjongViewFirstHit()) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: mahjongViewBonusScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: mahjongViewAtScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    // ボイス
                    NavigationLink(destination: mahjongViewVoice()) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "ボーナス,AT 終了後ボイス")
                    }
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: mahjongView95Ci()) {
//                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4777")
                    .popoverTip(tipVer220AddLink())
            }
        }
//        .onAppear {
//            if ver280.mahjongMachineIconBadgeStatus != "none" {
//                ver280.mahjongMachineIconBadgeStatus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(mahjongSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(mahjongSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mahjong.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct mahjongSubViewSaveMemory: View {
    @ObservedObject var mahjong = Mahjong()
    @ObservedObject var mahjongMemory1 = MahjongMemory1()
    @ObservedObject var mahjongMemory2 = MahjongMemory2()
    @ObservedObject var mahjongMemory3 = MahjongMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "麻雀物語",
            selectedMemory: $mahjong.selectedMemory,
            memoMemory1: $mahjongMemory1.memo,
            dateDoubleMemory1: $mahjongMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mahjongMemory2.memo,
            dateDoubleMemory2: $mahjongMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mahjongMemory3.memo,
            dateDoubleMemory3: $mahjongMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mahjongMemory1.bonusScreenCountDefault = mahjong.bonusScreenCountDefault
        mahjongMemory1.bonusScreenCountGusu = mahjong.bonusScreenCountGusu
        mahjongMemory1.bonusScreenCountKisu = mahjong.bonusScreenCountKisu
        mahjongMemory1.bonusScreenCount2Over = mahjong.bonusScreenCount2Over
        mahjongMemory1.bonusScreenCount5Over = mahjong.bonusScreenCount5Over
        mahjongMemory1.bonusScreenCount6Over = mahjong.bonusScreenCount6Over
        mahjongMemory1.bonusScreenCountSum = mahjong.bonusScreenCountSum
        mahjongMemory1.atScreenCountDefault = mahjong.atScreenCountDefault
        mahjongMemory1.atScreenCountHighJaku = mahjong.atScreenCountHighJaku
        mahjongMemory1.atScreenCountHighKyo = mahjong.atScreenCountHighKyo
        mahjongMemory1.atScreenCount2Over = mahjong.atScreenCount2Over
        mahjongMemory1.atScreenCount4Over = mahjong.atScreenCount4Over
        mahjongMemory1.atScreenCount6Over = mahjong.atScreenCount6Over
        mahjongMemory1.atScreenCountSum = mahjong.atScreenCountSum
    }
    func saveMemory2() {
        mahjongMemory2.bonusScreenCountDefault = mahjong.bonusScreenCountDefault
        mahjongMemory2.bonusScreenCountGusu = mahjong.bonusScreenCountGusu
        mahjongMemory2.bonusScreenCountKisu = mahjong.bonusScreenCountKisu
        mahjongMemory2.bonusScreenCount2Over = mahjong.bonusScreenCount2Over
        mahjongMemory2.bonusScreenCount5Over = mahjong.bonusScreenCount5Over
        mahjongMemory2.bonusScreenCount6Over = mahjong.bonusScreenCount6Over
        mahjongMemory2.bonusScreenCountSum = mahjong.bonusScreenCountSum
        mahjongMemory2.atScreenCountDefault = mahjong.atScreenCountDefault
        mahjongMemory2.atScreenCountHighJaku = mahjong.atScreenCountHighJaku
        mahjongMemory2.atScreenCountHighKyo = mahjong.atScreenCountHighKyo
        mahjongMemory2.atScreenCount2Over = mahjong.atScreenCount2Over
        mahjongMemory2.atScreenCount4Over = mahjong.atScreenCount4Over
        mahjongMemory2.atScreenCount6Over = mahjong.atScreenCount6Over
        mahjongMemory2.atScreenCountSum = mahjong.atScreenCountSum
    }
    func saveMemory3() {
        mahjongMemory3.bonusScreenCountDefault = mahjong.bonusScreenCountDefault
        mahjongMemory3.bonusScreenCountGusu = mahjong.bonusScreenCountGusu
        mahjongMemory3.bonusScreenCountKisu = mahjong.bonusScreenCountKisu
        mahjongMemory3.bonusScreenCount2Over = mahjong.bonusScreenCount2Over
        mahjongMemory3.bonusScreenCount5Over = mahjong.bonusScreenCount5Over
        mahjongMemory3.bonusScreenCount6Over = mahjong.bonusScreenCount6Over
        mahjongMemory3.bonusScreenCountSum = mahjong.bonusScreenCountSum
        mahjongMemory3.atScreenCountDefault = mahjong.atScreenCountDefault
        mahjongMemory3.atScreenCountHighJaku = mahjong.atScreenCountHighJaku
        mahjongMemory3.atScreenCountHighKyo = mahjong.atScreenCountHighKyo
        mahjongMemory3.atScreenCount2Over = mahjong.atScreenCount2Over
        mahjongMemory3.atScreenCount4Over = mahjong.atScreenCount4Over
        mahjongMemory3.atScreenCount6Over = mahjong.atScreenCount6Over
        mahjongMemory3.atScreenCountSum = mahjong.atScreenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct mahjongSubViewLoadMemory: View {
    @ObservedObject var mahjong = Mahjong()
    @ObservedObject var mahjongMemory1 = MahjongMemory1()
    @ObservedObject var mahjongMemory2 = MahjongMemory2()
    @ObservedObject var mahjongMemory3 = MahjongMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "麻雀物語",
            selectedMemory: $mahjong.selectedMemory,
            memoMemory1: mahjongMemory1.memo,
            dateDoubleMemory1: mahjongMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mahjongMemory2.memo,
            dateDoubleMemory2: mahjongMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mahjongMemory3.memo,
            dateDoubleMemory3: mahjongMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        mahjong.bonusScreenCountDefault = mahjongMemory1.bonusScreenCountDefault
        mahjong.bonusScreenCountGusu = mahjongMemory1.bonusScreenCountGusu
        mahjong.bonusScreenCountKisu = mahjongMemory1.bonusScreenCountKisu
        mahjong.bonusScreenCount2Over = mahjongMemory1.bonusScreenCount2Over
        mahjong.bonusScreenCount5Over = mahjongMemory1.bonusScreenCount5Over
        mahjong.bonusScreenCount6Over = mahjongMemory1.bonusScreenCount6Over
        mahjong.bonusScreenCountSum = mahjongMemory1.bonusScreenCountSum
        mahjong.atScreenCountDefault = mahjongMemory1.atScreenCountDefault
        mahjong.atScreenCountHighJaku = mahjongMemory1.atScreenCountHighJaku
        mahjong.atScreenCountHighKyo = mahjongMemory1.atScreenCountHighKyo
        mahjong.atScreenCount2Over = mahjongMemory1.atScreenCount2Over
        mahjong.atScreenCount4Over = mahjongMemory1.atScreenCount4Over
        mahjong.atScreenCount6Over = mahjongMemory1.atScreenCount6Over
        mahjong.atScreenCountSum = mahjongMemory1.atScreenCountSum
    }
    func loadMemory2() {
        mahjong.bonusScreenCountDefault = mahjongMemory2.bonusScreenCountDefault
        mahjong.bonusScreenCountGusu = mahjongMemory2.bonusScreenCountGusu
        mahjong.bonusScreenCountKisu = mahjongMemory2.bonusScreenCountKisu
        mahjong.bonusScreenCount2Over = mahjongMemory2.bonusScreenCount2Over
        mahjong.bonusScreenCount5Over = mahjongMemory2.bonusScreenCount5Over
        mahjong.bonusScreenCount6Over = mahjongMemory2.bonusScreenCount6Over
        mahjong.bonusScreenCountSum = mahjongMemory2.bonusScreenCountSum
        mahjong.atScreenCountDefault = mahjongMemory2.atScreenCountDefault
        mahjong.atScreenCountHighJaku = mahjongMemory2.atScreenCountHighJaku
        mahjong.atScreenCountHighKyo = mahjongMemory2.atScreenCountHighKyo
        mahjong.atScreenCount2Over = mahjongMemory2.atScreenCount2Over
        mahjong.atScreenCount4Over = mahjongMemory2.atScreenCount4Over
        mahjong.atScreenCount6Over = mahjongMemory2.atScreenCount6Over
        mahjong.atScreenCountSum = mahjongMemory2.atScreenCountSum
    }
    func loadMemory3() {
        mahjong.bonusScreenCountDefault = mahjongMemory3.bonusScreenCountDefault
        mahjong.bonusScreenCountGusu = mahjongMemory3.bonusScreenCountGusu
        mahjong.bonusScreenCountKisu = mahjongMemory3.bonusScreenCountKisu
        mahjong.bonusScreenCount2Over = mahjongMemory3.bonusScreenCount2Over
        mahjong.bonusScreenCount5Over = mahjongMemory3.bonusScreenCount5Over
        mahjong.bonusScreenCount6Over = mahjongMemory3.bonusScreenCount6Over
        mahjong.bonusScreenCountSum = mahjongMemory3.bonusScreenCountSum
        mahjong.atScreenCountDefault = mahjongMemory3.atScreenCountDefault
        mahjong.atScreenCountHighJaku = mahjongMemory3.atScreenCountHighJaku
        mahjong.atScreenCountHighKyo = mahjongMemory3.atScreenCountHighKyo
        mahjong.atScreenCount2Over = mahjongMemory3.atScreenCount2Over
        mahjong.atScreenCount4Over = mahjongMemory3.atScreenCount4Over
        mahjong.atScreenCount6Over = mahjongMemory3.atScreenCount6Over
        mahjong.atScreenCountSum = mahjongMemory3.atScreenCountSum
    }
}

#Preview {
    mahjongViewTop()
}
