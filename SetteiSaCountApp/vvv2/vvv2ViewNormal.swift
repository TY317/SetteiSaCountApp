//
//  vvv2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2ViewNormal: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            // //// レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    vvv2TableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // //// マギウスマークでの示唆
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "マギウスマークの数") {
                    VStack {
                        Text("・周期のマップに表示されるマギウスマークの数が4個以上あれば設定示唆！？")
                    }
                }
                unitLinkButtonViewBuilder(sheetTitle: "サブ液晶の機体") {
                    VStack(alignment: .leading) {
                        Text("・サブ液晶の機体がヴァルヴレイヴ以外であれば設定示唆")
                        Text("・バッフェの期待度は無人＜有人の順となる")
                    }
                }
            } header: {
                Text("設定示唆演出")
            }
            
            // //// モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    vvv2TableMode()
                }
            } header: {
                Text("モード")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    vvv2ViewNormal(
        vvv2: Vvv2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
