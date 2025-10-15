//
//  zeni5ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5ViewNormal: View {
    @ObservedObject var zeni5: Zeni5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    zeni5TableKoyakuPattern()
                }
                unitLinkButtonViewBuilder(sheetTitle: "通常時デカ目確率") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・通常時のデカ目確率に設定差あり")
                            Text("・ボーナス本前兆中は設定差ないため注意")
                        }
                        .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(
                                settingList: [2,3,4,5,6]
                            )
                            unitTableDenominate(
                                columTitle: "通常時デカ目",
                                denominateList: [21580.7,19209.1,10964.8,7249.1,5561.8]
                            )
                        }
                    }
                }
            } header: {
                Text("レア役")
            }
            
            // //// モード関連
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    zeni5TableMode()
                }
            } header: {
                Text("通常時モード")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: zeni5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    zeni5ViewNormal(
        zeni5: Zeni5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
