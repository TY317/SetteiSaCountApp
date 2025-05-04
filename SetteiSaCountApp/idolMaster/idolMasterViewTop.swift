//
//  idolMasterViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterViewTop: View {
    @ObservedObject var ver300: Ver300
    @StateObject var idolMaster = IdolMaster()
    @State var isShowAlert: Bool = false
    @StateObject var idolMasterMemory1 = IdolMasterMemory1()
    @StateObject var idolMasterMemory2 = IdolMasterMemory2()
    @StateObject var idolMasterMemory3 = IdolMasterMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "アイドルマスター ミリオンライブ!", titleFont: .title3)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: idolMasterViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // CZ,ボーナス初当り
                    NavigationLink(destination: idolMasterViewFirstHit(idolMaster: idolMaster)) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "CZ,ボーナス 初当り"
                        )
                    }
                    // 終了画面
                    NavigationLink(destination: idolMasterViewScreen(idolMaster: idolMaster)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    // ボイス
                    NavigationLink(destination: idolMasterViewVoice()) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "MSC終了後ボイス"
                        )
                    }
                    // ケロッとトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー")
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: idolMasterView95Ci()) {
//                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
//                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4753")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver300.idolMasterMachineIconBadgeStatus != "none" {
                ver300.idolMasterMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(idolMasterSubViewLoadMemory(
                        idolMaster: idolMaster,
                        idolMasterMemory1: idolMasterMemory1,
                        idolMasterMemory2: idolMasterMemory2,
                        idolMasterMemory3: idolMasterMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(idolMasterSubViewSaveMemory(
                        idolMaster: idolMaster,
                        idolMasterMemory1: idolMasterMemory1,
                        idolMasterMemory2: idolMasterMemory2,
                        idolMasterMemory3: idolMasterMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: idolMaster.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct idolMasterSubViewSaveMemory: View {
    @ObservedObject var idolMaster: IdolMaster
    @ObservedObject var idolMasterMemory1: IdolMasterMemory1
    @ObservedObject var idolMasterMemory2: IdolMasterMemory2
    @ObservedObject var idolMasterMemory3: IdolMasterMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "アイドルマスター ミリオンライブ！",
            selectedMemory: $idolMaster.selectedMemory,
            memoMemory1: $idolMasterMemory1.memo,
            dateDoubleMemory1: $idolMasterMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $idolMasterMemory2.memo,
            dateDoubleMemory2: $idolMasterMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $idolMasterMemory3.memo,
            dateDoubleMemory3: $idolMasterMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        idolMasterMemory1.screenCountDefault = idolMaster.screenCountDefault
        idolMasterMemory1.screenCountKisuJaku = idolMaster.screenCountKisuJaku
        idolMasterMemory1.screenCountKisuKyo = idolMaster.screenCountKisuKyo
        idolMasterMemory1.screenCountGusuJaku = idolMaster.screenCountGusuJaku
        idolMasterMemory1.screenCountGusuKyo = idolMaster.screenCountGusuKyo
        idolMasterMemory1.screenCountHighJaku = idolMaster.screenCountHighJaku
        idolMasterMemory1.screenCountHighChu = idolMaster.screenCountHighChu
        idolMasterMemory1.screenCountHighKyo = idolMaster.screenCountHighKyo
        idolMasterMemory1.screenCountGold = idolMaster.screenCountGold
        idolMasterMemory1.screenCountRainbow = idolMaster.screenCountRainbow
        idolMasterMemory1.screenCountSum = idolMaster.screenCountSum
    }
    func saveMemory2() {
        idolMasterMemory2.screenCountDefault = idolMaster.screenCountDefault
        idolMasterMemory2.screenCountKisuJaku = idolMaster.screenCountKisuJaku
        idolMasterMemory2.screenCountKisuKyo = idolMaster.screenCountKisuKyo
        idolMasterMemory2.screenCountGusuJaku = idolMaster.screenCountGusuJaku
        idolMasterMemory2.screenCountGusuKyo = idolMaster.screenCountGusuKyo
        idolMasterMemory2.screenCountHighJaku = idolMaster.screenCountHighJaku
        idolMasterMemory2.screenCountHighChu = idolMaster.screenCountHighChu
        idolMasterMemory2.screenCountHighKyo = idolMaster.screenCountHighKyo
        idolMasterMemory2.screenCountGold = idolMaster.screenCountGold
        idolMasterMemory2.screenCountRainbow = idolMaster.screenCountRainbow
        idolMasterMemory2.screenCountSum = idolMaster.screenCountSum
    }
    func saveMemory3() {
        idolMasterMemory3.screenCountDefault = idolMaster.screenCountDefault
        idolMasterMemory3.screenCountKisuJaku = idolMaster.screenCountKisuJaku
        idolMasterMemory3.screenCountKisuKyo = idolMaster.screenCountKisuKyo
        idolMasterMemory3.screenCountGusuJaku = idolMaster.screenCountGusuJaku
        idolMasterMemory3.screenCountGusuKyo = idolMaster.screenCountGusuKyo
        idolMasterMemory3.screenCountHighJaku = idolMaster.screenCountHighJaku
        idolMasterMemory3.screenCountHighChu = idolMaster.screenCountHighChu
        idolMasterMemory3.screenCountHighKyo = idolMaster.screenCountHighKyo
        idolMasterMemory3.screenCountGold = idolMaster.screenCountGold
        idolMasterMemory3.screenCountRainbow = idolMaster.screenCountRainbow
        idolMasterMemory3.screenCountSum = idolMaster.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct idolMasterSubViewLoadMemory: View {
    @ObservedObject var idolMaster: IdolMaster
    @ObservedObject var idolMasterMemory1: IdolMasterMemory1
    @ObservedObject var idolMasterMemory2: IdolMasterMemory2
    @ObservedObject var idolMasterMemory3: IdolMasterMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "アイドルマスター ミリオンライブ！",
            selectedMemory: $idolMaster.selectedMemory,
            memoMemory1: idolMasterMemory1.memo,
            dateDoubleMemory1: idolMasterMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: idolMasterMemory2.memo,
            dateDoubleMemory2: idolMasterMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: idolMasterMemory3.memo,
            dateDoubleMemory3: idolMasterMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        idolMaster.screenCountDefault = idolMasterMemory1.screenCountDefault
        idolMaster.screenCountKisuJaku = idolMasterMemory1.screenCountKisuJaku
        idolMaster.screenCountKisuKyo = idolMasterMemory1.screenCountKisuKyo
        idolMaster.screenCountGusuJaku = idolMasterMemory1.screenCountGusuJaku
        idolMaster.screenCountGusuKyo = idolMasterMemory1.screenCountGusuKyo
        idolMaster.screenCountHighJaku = idolMasterMemory1.screenCountHighJaku
        idolMaster.screenCountHighChu = idolMasterMemory1.screenCountHighChu
        idolMaster.screenCountHighKyo = idolMasterMemory1.screenCountHighKyo
        idolMaster.screenCountGold = idolMasterMemory1.screenCountGold
        idolMaster.screenCountRainbow = idolMasterMemory1.screenCountRainbow
        idolMaster.screenCountSum = idolMasterMemory1.screenCountSum
    }
    func loadMemory2() {
        idolMaster.screenCountDefault = idolMasterMemory2.screenCountDefault
        idolMaster.screenCountKisuJaku = idolMasterMemory2.screenCountKisuJaku
        idolMaster.screenCountKisuKyo = idolMasterMemory2.screenCountKisuKyo
        idolMaster.screenCountGusuJaku = idolMasterMemory2.screenCountGusuJaku
        idolMaster.screenCountGusuKyo = idolMasterMemory2.screenCountGusuKyo
        idolMaster.screenCountHighJaku = idolMasterMemory2.screenCountHighJaku
        idolMaster.screenCountHighChu = idolMasterMemory2.screenCountHighChu
        idolMaster.screenCountHighKyo = idolMasterMemory2.screenCountHighKyo
        idolMaster.screenCountGold = idolMasterMemory2.screenCountGold
        idolMaster.screenCountRainbow = idolMasterMemory2.screenCountRainbow
        idolMaster.screenCountSum = idolMasterMemory2.screenCountSum
    }
    func loadMemory3() {
        idolMaster.screenCountDefault = idolMasterMemory3.screenCountDefault
        idolMaster.screenCountKisuJaku = idolMasterMemory3.screenCountKisuJaku
        idolMaster.screenCountKisuKyo = idolMasterMemory3.screenCountKisuKyo
        idolMaster.screenCountGusuJaku = idolMasterMemory3.screenCountGusuJaku
        idolMaster.screenCountGusuKyo = idolMasterMemory3.screenCountGusuKyo
        idolMaster.screenCountHighJaku = idolMasterMemory3.screenCountHighJaku
        idolMaster.screenCountHighChu = idolMasterMemory3.screenCountHighChu
        idolMaster.screenCountHighKyo = idolMasterMemory3.screenCountHighKyo
        idolMaster.screenCountGold = idolMasterMemory3.screenCountGold
        idolMaster.screenCountRainbow = idolMasterMemory3.screenCountRainbow
        idolMaster.screenCountSum = idolMasterMemory3.screenCountSum
    }
}


#Preview {
    idolMasterViewTop(ver300: Ver300())
}
