//
//  toloveruViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI
import TipKit


// /////////////////////
// 変数
// /////////////////////
class Toloveru: ObservableObject {
    // ///////////////////////
    // ボーナス種類
    // ///////////////////////
    @AppStorage("toloveruBonusBainCount") var bonusBainCount = 0 {
        didSet {
            bonusCountSum = countSum(bonusBainCount, bonusPeroCount, bonusLovesplushCount)
        }
    }
        @AppStorage("toloveruBonusPeroCount") var bonusPeroCount = 0 {
            didSet {
                bonusCountSum = countSum(bonusBainCount, bonusPeroCount, bonusLovesplushCount)
            }
        }
            @AppStorage("toloveruBonusLovesplushCount") var bonusLovesplushCount = 0 {
                didSet {
                    bonusCountSum = countSum(bonusBainCount, bonusPeroCount, bonusLovesplushCount)
                }
            }
    @AppStorage("toloveruBonusCountSum") var bonusCountSum = 0
    
    func resetBonus() {
        bonusBainCount = 0
        bonusPeroCount = 0
        bonusLovesplushCount = 0
        minusCheck = false
    }
    
    // ///////////////////////
    // ハーレムモード
    // ///////////////////////
    @AppStorage("toloveruHarlemWhisperCount") var harlemWhisperCount = 0 {
        didSet {
            harlemCountSum = countSum(harlemWhisperCount, harlemAisplush)
        }
    }
        @AppStorage("toloveruHarlemAisplushCount") var harlemAisplush = 0 {
            didSet {
                harlemCountSum = countSum(harlemWhisperCount, harlemAisplush)
            }
        }
    @AppStorage("toloveruHarlemCountSum") var harlemCountSum = 0
    
    func resetHarlem() {
        harlemWhisperCount = 0
        harlemAisplush = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("toloveruMinusCheck") var minusCheck = false
    @AppStorage("toloveruSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetBonus()
        resetHarlem()
    }
}


// //// メモリー1
class ToloveruMemory1: ObservableObject {
    @AppStorage("toloveruBonusBainCountMemory1") var bonusBainCount = 0
    @AppStorage("toloveruBonusPeroCountMemory1") var bonusPeroCount = 0
    @AppStorage("toloveruBonusLovesplushCountMemory1") var bonusLovesplushCount = 0
    @AppStorage("toloveruBonusCountSumMemory1") var bonusCountSum = 0
    @AppStorage("toloveruHarlemWhisperCountMemory1") var harlemWhisperCount = 0
    @AppStorage("toloveruHarlemAisplushCountMemory1") var harlemAisplush = 0
    @AppStorage("toloveruHarlemCountSumMemory1") var harlemCountSum = 0
    @AppStorage("toloveruMemoMemory1") var memo = ""
    @AppStorage("toloveruDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class ToloveruMemory2: ObservableObject {
    @AppStorage("toloveruBonusBainCountMemory2") var bonusBainCount = 0
    @AppStorage("toloveruBonusPeroCountMemory2") var bonusPeroCount = 0
    @AppStorage("toloveruBonusLovesplushCountMemory2") var bonusLovesplushCount = 0
    @AppStorage("toloveruBonusCountSumMemory2") var bonusCountSum = 0
    @AppStorage("toloveruHarlemWhisperCountMemory2") var harlemWhisperCount = 0
    @AppStorage("toloveruHarlemAisplushCountMemory2") var harlemAisplush = 0
    @AppStorage("toloveruHarlemCountSumMemory2") var harlemCountSum = 0
    @AppStorage("toloveruMemoMemory2") var memo = ""
    @AppStorage("toloveruDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class ToloveruMemory3: ObservableObject {
    @AppStorage("toloveruBonusBainCountMemory3") var bonusBainCount = 0
    @AppStorage("toloveruBonusPeroCountMemory3") var bonusPeroCount = 0
    @AppStorage("toloveruBonusLovesplushCountMemory3") var bonusLovesplushCount = 0
    @AppStorage("toloveruBonusCountSumMemory3") var bonusCountSum = 0
    @AppStorage("toloveruHarlemWhisperCountMemory3") var harlemWhisperCount = 0
    @AppStorage("toloveruHarlemAisplushCountMemory3") var harlemAisplush = 0
    @AppStorage("toloveruHarlemCountSumMemory3") var harlemCountSum = 0
    @AppStorage("toloveruMemoMemory3") var memo = ""
    @AppStorage("toloveruDateMemory3") var dateDouble = 0.0
}


struct toloveruViewTop: View {
    @ObservedObject var toloveru = Toloveru()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 楽園計画初当たり
                    NavigationLink(destination: toloveruViewBonusHit()) {
                        unitLabelMenu(imageSystemName: "scope", textBody: "楽園計画 初当たり")
                    }
                    // 楽園計画中のボーナス
                    NavigationLink(destination: toloveruViewBonus()) {
                        unitLabelMenu(imageSystemName: "dog", textBody: "250G以降当選での初回ボーナス")
                    }
                    // 上位STハーレムモード
                    NavigationLink(destination: toloveruViewHarlem()) {
                        unitLabelMenu(imageSystemName: "beach.umbrella", textBody: "ハーレムモード")
                    }
                    // 終了画面
                    NavigationLink(destination: toloveruViewEndScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ST終了画面")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ToLOVEるダークネス")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(toloveruViewLoadMemory()))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(toloveruViewSaveMemory()))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetAll, message: "この機種の全データをリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct toloveruViewSaveMemory: View {
    @ObservedObject var toloveru = Toloveru()
    @ObservedObject var toloveruMemory1 = ToloveruMemory1()
    @ObservedObject var toloveruMemory2 = ToloveruMemory2()
    @ObservedObject var toloveruMemory3 = ToloveruMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ToLOVEるダークネス",
            selectedMemory: $toloveru.selectedMemory,
            memoMemory1: $toloveruMemory1.memo,
            dateDoubleMemory1: $toloveruMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $toloveruMemory2.memo,
            dateDoubleMemory2: $toloveruMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $toloveruMemory3.memo,
            dateDoubleMemory3: $toloveruMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        toloveruMemory1.bonusBainCount = toloveru.bonusBainCount
        toloveruMemory1.bonusPeroCount = toloveru.bonusPeroCount
        toloveruMemory1.bonusLovesplushCount = toloveru.bonusLovesplushCount
        toloveruMemory1.bonusCountSum = toloveru.bonusCountSum
        toloveruMemory1.harlemWhisperCount = toloveru.harlemWhisperCount
        toloveruMemory1.harlemAisplush = toloveru.harlemAisplush
        toloveruMemory1.harlemCountSum = toloveru.harlemCountSum
    }
    func saveMemory2() {
        toloveruMemory2.bonusBainCount = toloveru.bonusBainCount
        toloveruMemory2.bonusPeroCount = toloveru.bonusPeroCount
        toloveruMemory2.bonusLovesplushCount = toloveru.bonusLovesplushCount
        toloveruMemory2.bonusCountSum = toloveru.bonusCountSum
        toloveruMemory2.harlemWhisperCount = toloveru.harlemWhisperCount
        toloveruMemory2.harlemAisplush = toloveru.harlemAisplush
        toloveruMemory2.harlemCountSum = toloveru.harlemCountSum
    }
    func saveMemory3() {
        toloveruMemory3.bonusBainCount = toloveru.bonusBainCount
        toloveruMemory3.bonusPeroCount = toloveru.bonusPeroCount
        toloveruMemory3.bonusLovesplushCount = toloveru.bonusLovesplushCount
        toloveruMemory3.bonusCountSum = toloveru.bonusCountSum
        toloveruMemory3.harlemWhisperCount = toloveru.harlemWhisperCount
        toloveruMemory3.harlemAisplush = toloveru.harlemAisplush
        toloveruMemory3.harlemCountSum = toloveru.harlemCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct toloveruViewLoadMemory: View {
    @ObservedObject var toloveru = Toloveru()
    @ObservedObject var toloveruMemory1 = ToloveruMemory1()
    @ObservedObject var toloveruMemory2 = ToloveruMemory2()
    @ObservedObject var toloveruMemory3 = ToloveruMemory3()
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "ToLOVEるダークネス",
            selectedMemory: $toloveru.selectedMemory,
            memoMemory1: toloveruMemory1.memo,
            dateDoubleMemory1: toloveruMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: toloveruMemory2.memo,
            dateDoubleMemory2: toloveruMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: toloveruMemory3.memo,
            dateDoubleMemory3: toloveruMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        toloveru.bonusBainCount = toloveruMemory1.bonusBainCount
        toloveru.bonusPeroCount = toloveruMemory1.bonusPeroCount
        toloveru.bonusLovesplushCount = toloveruMemory1.bonusLovesplushCount
        toloveru.bonusCountSum = toloveruMemory1.bonusCountSum
        toloveru.harlemWhisperCount = toloveruMemory1.harlemWhisperCount
        toloveru.harlemAisplush = toloveruMemory1.harlemAisplush
        toloveru.harlemCountSum = toloveruMemory1.harlemCountSum
    }
    func loadMemory2() {
        toloveru.bonusBainCount = toloveruMemory2.bonusBainCount
        toloveru.bonusPeroCount = toloveruMemory2.bonusPeroCount
        toloveru.bonusLovesplushCount = toloveruMemory2.bonusLovesplushCount
        toloveru.bonusCountSum = toloveruMemory2.bonusCountSum
        toloveru.harlemWhisperCount = toloveruMemory2.harlemWhisperCount
        toloveru.harlemAisplush = toloveruMemory2.harlemAisplush
        toloveru.harlemCountSum = toloveruMemory2.harlemCountSum
    }
    func loadMemory3() {
        toloveru.bonusBainCount = toloveruMemory3.bonusBainCount
        toloveru.bonusPeroCount = toloveruMemory3.bonusPeroCount
        toloveru.bonusLovesplushCount = toloveruMemory3.bonusLovesplushCount
        toloveru.bonusCountSum = toloveruMemory3.bonusCountSum
        toloveru.harlemWhisperCount = toloveruMemory3.harlemWhisperCount
        toloveru.harlemAisplush = toloveruMemory3.harlemAisplush
        toloveru.harlemCountSum = toloveruMemory3.harlemCountSum
    }
}


#Preview {
    toloveruViewTop()
}
