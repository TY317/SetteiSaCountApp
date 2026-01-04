//
//  hokutoTenseiViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct hokutoTenseiViewFirstHit: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // 注意書き
            Text("・ゲーム数はマイスロを参考に入力して下さい\n・天破の初当り回数は自力カウント推奨")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $hokutoTensei.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)
            // カウントボタン横並び
            HStack {
                // 天破
                unitCountButtonVerticalDenominate(
                    title: "天破の刻",
                    count: $hokutoTensei.firstHitCountTenha,
                    color: .personalSummerLightGreen,
                    bigNumber: $hokutoTensei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $hokutoTensei.minusCheck
                )
                // AT
                unitCountButtonVerticalDenominate(
                    title: "闘神演舞",
                    count: $hokutoTensei.firstHitCountAt,
                    color: .personalSummerLightRed,
                    bigNumber: $hokutoTensei.normalGame,
                    numberofDicimal: 0,
                    minusBool: $hokutoTensei.minusCheck
                )
            }
            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(
                        columTitle: "天破の刻",
                        denominateList: hokutoTensei.ratioAtFirstHitTenha
                    )
                    unitTableDenominate(
                        columTitle: "闘神演舞",
                        denominateList: hokutoTensei.ratioAtFirstHitAt
                    )
                }
            }
            
            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    hokutoTenseiView95Ci(
                        hokutoTensei: hokutoTensei,
                        selection: 1,
                    )
                )
            )
            
            // //// 設定期待値へのリンク
            unitNaviLinkBayes {
                hokutoTenseiViewBayes(
                    hokutoTensei: hokutoTensei,
                    bayes: bayes,
                    viewModel: viewModel,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hokutoTensei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hokutoTensei.resetFirstHit)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    hokutoTenseiViewFirstHit(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
