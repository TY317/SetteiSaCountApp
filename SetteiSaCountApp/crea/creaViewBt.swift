//
//  creaViewBt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct creaViewBt: View {
    @ObservedObject var crea: Crea
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading){
                    Text("・BT中の白BAR成立までのハズレ出現率に設定差あり")
                    Text("・白BAR成立後はハズレ出現しないためカウントから除外")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                
                // カウントボタン横並び
                HStack {
                    // BTゲーム数
                    unitCountButtonVerticalWithoutRatio(
                        title: "BTゲーム数",
                        count: $crea.btGame,
                        color: .gray,
                        minusBool: $crea.minusCheck
                    )
                    // ハズレ
                    unitCountButtonVerticalWithoutRatio(
                        title: "ハズレ",
                        count: $crea.btHazure,
                        color: .personalSummerLightRed,
                        minusBool: $crea.minusCheck
                    )
                }
                
                // 確率結果
                unitResultRatioDenomination2Line(
                    title: "ハズレ出現率",
                    count: $crea.btHazure,
                    bigNumber: $crea.btGame,
                    numberofDicimal: 0
                )
                
                // 参考情報）ハズレ確率
                unitLinkButtonViewBuilder(sheetTitle: "BT中のハズレ確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ハズレ",
                            denominateList: [crea.ratioBtHazure[0],crea.ratioBtHazure[3],],
                            lineList: [3,3],
                        )
                    }
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    creaViewBayes(
                        crea: crea,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("BT中のハズレ")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.creaMenuBtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BT中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $crea.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetBt)
            }
        }
    }
}

#Preview {
    creaViewBt(
        crea: Crea(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
