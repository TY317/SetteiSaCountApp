//
//  hokutoTenseiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import SwiftUI

struct hokutoTenseiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hokutoTensei = HokutoTensei()
    @State var isShowAlert: Bool = false
    @StateObject var hokutoTenseiMemory1 = HokutoTenseiMemory1()
    @StateObject var hokutoTenseiMemory2 = HokutoTenseiMemory2()
    @StateObject var hokutoTenseiMemory3 = HokutoTenseiMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hokutoTensei.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hokutoTenseiViewNormal(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.hokutoTenseiMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: hokutoTenseiViewFirstHit(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.hokutoTenseiMenuFirstHitBadge,
                        )
                    }
                    
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hokutoTenseiView95Ci(
                    hokutoTensei: hokutoTensei,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hokutoTenseiViewBayes(
                    hokutoTensei: hokutoTensei,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hokutoTenseiMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4909")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎武論尊・原哲夫／コアミックス 1983")
                    Text("©︎COAMIX 2007 版権許諾証YJN-815")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(hokutoTenseiSubViewLoadMemory(
                    hokutoTensei: hokutoTensei,
                    hokutoTenseiMemory1: hokutoTenseiMemory1,
                    hokutoTenseiMemory2: hokutoTenseiMemory2,
                    hokutoTenseiMemory3: hokutoTenseiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(hokutoTenseiSubViewSaveMemory(
                    hokutoTensei: hokutoTensei,
                    hokutoTenseiMemory1: hokutoTenseiMemory1,
                    hokutoTenseiMemory2: hokutoTenseiMemory2,
                    hokutoTenseiMemory3: hokutoTenseiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hokutoTensei.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct hokutoTenseiSubViewSaveMemory: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var hokutoTenseiMemory1: HokutoTenseiMemory1
    @ObservedObject var hokutoTenseiMemory2: HokutoTenseiMemory2
    @ObservedObject var hokutoTenseiMemory3: HokutoTenseiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: hokutoTensei.machineName,
            selectedMemory: $hokutoTensei.selectedMemory,
            memoMemory1: $hokutoTenseiMemory1.memo,
            dateDoubleMemory1: $hokutoTenseiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hokutoTenseiMemory2.memo,
            dateDoubleMemory2: $hokutoTenseiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hokutoTenseiMemory3.memo,
            dateDoubleMemory3: $hokutoTenseiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hokutoTenseiMemory1.normalGame = hokutoTensei.normalGame
        hokutoTenseiMemory1.firstHitCountAt = hokutoTensei.firstHitCountAt
        hokutoTenseiMemory1.firstHitCountTenha = hokutoTensei.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTenseiMemory1.lampCountNone = hokutoTensei.lampCountNone
        hokutoTenseiMemory1.lampCount24Sisa = hokutoTensei.lampCount24Sisa
        hokutoTenseiMemory1.lampCount35Sisa = hokutoTensei.lampCount35Sisa
        hokutoTenseiMemory1.lampCountHighjaku = hokutoTensei.lampCountHighjaku
        hokutoTenseiMemory1.lampCountHighKyo = hokutoTensei.lampCountHighKyo
        hokutoTenseiMemory1.lampCountOver2 = hokutoTensei.lampCountOver2
        hokutoTenseiMemory1.lampCountOver4 = hokutoTensei.lampCountOver4
        hokutoTenseiMemory1.lampCountOver6 = hokutoTensei.lampCountOver6
        hokutoTenseiMemory1.lampCountSum = hokutoTensei.lampCountSum
        hokutoTenseiMemory1.inputGame = hokutoTensei.inputGame
        hokutoTenseiMemory1.gameArrayData = hokutoTensei.gameArrayData
    }
    func saveMemory2() {
        hokutoTenseiMemory2.normalGame = hokutoTensei.normalGame
        hokutoTenseiMemory2.firstHitCountAt = hokutoTensei.firstHitCountAt
        hokutoTenseiMemory2.firstHitCountTenha = hokutoTensei.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTenseiMemory2.lampCountNone = hokutoTensei.lampCountNone
        hokutoTenseiMemory2.lampCount24Sisa = hokutoTensei.lampCount24Sisa
        hokutoTenseiMemory2.lampCount35Sisa = hokutoTensei.lampCount35Sisa
        hokutoTenseiMemory2.lampCountHighjaku = hokutoTensei.lampCountHighjaku
        hokutoTenseiMemory2.lampCountHighKyo = hokutoTensei.lampCountHighKyo
        hokutoTenseiMemory2.lampCountOver2 = hokutoTensei.lampCountOver2
        hokutoTenseiMemory2.lampCountOver4 = hokutoTensei.lampCountOver4
        hokutoTenseiMemory2.lampCountOver6 = hokutoTensei.lampCountOver6
        hokutoTenseiMemory2.lampCountSum = hokutoTensei.lampCountSum
        hokutoTenseiMemory2.inputGame = hokutoTensei.inputGame
        hokutoTenseiMemory2.gameArrayData = hokutoTensei.gameArrayData
    }
    func saveMemory3() {
        hokutoTenseiMemory3.normalGame = hokutoTensei.normalGame
        hokutoTenseiMemory3.firstHitCountAt = hokutoTensei.firstHitCountAt
        hokutoTenseiMemory3.firstHitCountTenha = hokutoTensei.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTenseiMemory3.lampCountNone = hokutoTensei.lampCountNone
        hokutoTenseiMemory3.lampCount24Sisa = hokutoTensei.lampCount24Sisa
        hokutoTenseiMemory3.lampCount35Sisa = hokutoTensei.lampCount35Sisa
        hokutoTenseiMemory3.lampCountHighjaku = hokutoTensei.lampCountHighjaku
        hokutoTenseiMemory3.lampCountHighKyo = hokutoTensei.lampCountHighKyo
        hokutoTenseiMemory3.lampCountOver2 = hokutoTensei.lampCountOver2
        hokutoTenseiMemory3.lampCountOver4 = hokutoTensei.lampCountOver4
        hokutoTenseiMemory3.lampCountOver6 = hokutoTensei.lampCountOver6
        hokutoTenseiMemory3.lampCountSum = hokutoTensei.lampCountSum
        hokutoTenseiMemory3.inputGame = hokutoTensei.inputGame
        hokutoTenseiMemory3.gameArrayData = hokutoTensei.gameArrayData
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct hokutoTenseiSubViewLoadMemory: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var hokutoTenseiMemory1: HokutoTenseiMemory1
    @ObservedObject var hokutoTenseiMemory2: HokutoTenseiMemory2
    @ObservedObject var hokutoTenseiMemory3: HokutoTenseiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: hokutoTensei.machineName,
            selectedMemory: $hokutoTensei.selectedMemory,
            memoMemory1: hokutoTenseiMemory1.memo,
            dateDoubleMemory1: hokutoTenseiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hokutoTenseiMemory2.memo,
            dateDoubleMemory2: hokutoTenseiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hokutoTenseiMemory3.memo,
            dateDoubleMemory3: hokutoTenseiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        hokutoTensei.normalGame = hokutoTenseiMemory1.normalGame
        hokutoTensei.firstHitCountAt = hokutoTenseiMemory1.firstHitCountAt
        hokutoTensei.firstHitCountTenha = hokutoTenseiMemory1.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTensei.lampCountNone = hokutoTenseiMemory1.lampCountNone
        hokutoTensei.lampCount24Sisa = hokutoTenseiMemory1.lampCount24Sisa
        hokutoTensei.lampCount35Sisa = hokutoTenseiMemory1.lampCount35Sisa
        hokutoTensei.lampCountHighjaku = hokutoTenseiMemory1.lampCountHighjaku
        hokutoTensei.lampCountHighKyo = hokutoTenseiMemory1.lampCountHighKyo
        hokutoTensei.lampCountOver2 = hokutoTenseiMemory1.lampCountOver2
        hokutoTensei.lampCountOver4 = hokutoTenseiMemory1.lampCountOver4
        hokutoTensei.lampCountOver6 = hokutoTenseiMemory1.lampCountOver6
        hokutoTensei.lampCountSum = hokutoTenseiMemory1.lampCountSum
        hokutoTensei.inputGame = hokutoTenseiMemory1.inputGame
        let array = decodeIntArray(from: hokutoTenseiMemory1.gameArrayData)
        saveArray(array, forKey: hokutoTensei.gameArrayKey)
    }
    func loadMemory2() {
        hokutoTensei.normalGame = hokutoTenseiMemory2.normalGame
        hokutoTensei.firstHitCountAt = hokutoTenseiMemory2.firstHitCountAt
        hokutoTensei.firstHitCountTenha = hokutoTenseiMemory2.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTensei.lampCountNone = hokutoTenseiMemory2.lampCountNone
        hokutoTensei.lampCount24Sisa = hokutoTenseiMemory2.lampCount24Sisa
        hokutoTensei.lampCount35Sisa = hokutoTenseiMemory2.lampCount35Sisa
        hokutoTensei.lampCountHighjaku = hokutoTenseiMemory2.lampCountHighjaku
        hokutoTensei.lampCountHighKyo = hokutoTenseiMemory2.lampCountHighKyo
        hokutoTensei.lampCountOver2 = hokutoTenseiMemory2.lampCountOver2
        hokutoTensei.lampCountOver4 = hokutoTenseiMemory2.lampCountOver4
        hokutoTensei.lampCountOver6 = hokutoTenseiMemory2.lampCountOver6
        hokutoTensei.lampCountSum = hokutoTenseiMemory2.lampCountSum
        hokutoTensei.inputGame = hokutoTenseiMemory2.inputGame
        let array = decodeIntArray(from: hokutoTenseiMemory2.gameArrayData)
        saveArray(array, forKey: hokutoTensei.gameArrayKey)
    }
    func loadMemory3() {
        hokutoTensei.normalGame = hokutoTenseiMemory3.normalGame
        hokutoTensei.firstHitCountAt = hokutoTenseiMemory3.firstHitCountAt
        hokutoTensei.firstHitCountTenha = hokutoTenseiMemory3.firstHitCountTenha
        
        // -----------
        // ver3.17.0で追加
        // -----------
        hokutoTensei.lampCountNone = hokutoTenseiMemory3.lampCountNone
        hokutoTensei.lampCount24Sisa = hokutoTenseiMemory3.lampCount24Sisa
        hokutoTensei.lampCount35Sisa = hokutoTenseiMemory3.lampCount35Sisa
        hokutoTensei.lampCountHighjaku = hokutoTenseiMemory3.lampCountHighjaku
        hokutoTensei.lampCountHighKyo = hokutoTenseiMemory3.lampCountHighKyo
        hokutoTensei.lampCountOver2 = hokutoTenseiMemory3.lampCountOver2
        hokutoTensei.lampCountOver4 = hokutoTenseiMemory3.lampCountOver4
        hokutoTensei.lampCountOver6 = hokutoTenseiMemory3.lampCountOver6
        hokutoTensei.lampCountSum = hokutoTenseiMemory3.lampCountSum
        hokutoTensei.inputGame = hokutoTenseiMemory3.inputGame
        let array = decodeIntArray(from: hokutoTenseiMemory3.gameArrayData)
        saveArray(array, forKey: hokutoTensei.gameArrayKey)
    }
}

#Preview {
    hokutoTenseiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
