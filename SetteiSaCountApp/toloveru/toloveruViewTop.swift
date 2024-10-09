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
    
    func resetAll() {
        resetBonus()
        resetHarlem()
    }
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
//                        Image(systemName: "scope")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("楽園計画 初当たり")
                    }
                    // 楽園計画中のボーナス
                    NavigationLink(destination: toloveruViewBonus()) {
                        unitLabelMenu(imageSystemName: "dog", textBody: "250G以降当選での初回ボーナス")
//                        Image(systemName: "dog")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("250G以降当選での初回ボーナス")
                    }
                    // 上位STハーレムモード
                    NavigationLink(destination: toloveruViewHarlem()) {
                        unitLabelMenu(imageSystemName: "beach.umbrella", textBody: "ハーレムモード")
//                        Image(systemName: "beach.umbrella")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ハーレムモード")
                    }
                    // 終了画面
                    NavigationLink(destination: toloveruViewEndScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ST終了画面")
//                        Image(systemName: "photo.on.rectangle")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ST終了画面")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetAll, message: "この機種の全データをリセットします")
            }
        }
    }
}

#Preview {
    toloveruViewTop()
}
