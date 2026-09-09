//
//  shinYoshiViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct shinYoshiViewScreen: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "新月"
    let selectList: [String] = [
        "新月",
        "三日月",
        "満月",
        "大岡越前",
        "柳生",
        "大奥",
        "吉宗",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    var body: some View {
        List {
//            // 参考情報）終了画面示唆
//            shinYoshiTableScreen()
//                .frame(maxWidth: .infinity, alignment: .center)

            // 終了画面選択
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)

                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingScreen(item: self.selectedItem),
                    bigNumber: $shinYoshi.screenCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $shinYoshi.minusCheck) {
                        shinYoshi.screenSumFunc()
                    }
                    .popoverTip(tipVer460ShinYoshiScreen())
            } header: {
                Text("終了画面選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingScreen(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $shinYoshi.screenCountSum
                    )
                }
                // 参考情報）終了画面の出現率
                unitLinkButtonViewBuilder(sheetTitle: "終了画面の出現率") {
                    shinYoshiTableScreenRatio(shinYoshi: shinYoshi)
                }
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    shinYoshiViewBayes(
                        shinYoshi: shinYoshi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $shinYoshi.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shinYoshi.resetScreen)
            }
        }
    }

    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        default: return "???"
        }
    }

    private func bindingScreen(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $shinYoshi.screenCount1
        case self.selectList[1]: return $shinYoshi.screenCount2
        case self.selectList[2]: return $shinYoshi.screenCount3
        case self.selectList[3]: return $shinYoshi.screenCount4
        case self.selectList[4]: return $shinYoshi.screenCount5
        case self.selectList[5]: return $shinYoshi.screenCount6
        case self.selectList[6]: return $shinYoshi.screenCount7
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .green
        case self.selectList[2]: return .red
        case self.selectList[3]: return .brown
        case self.selectList[4]: return .orange
        case self.selectList[5]: return .pink
        case self.selectList[6]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    shinYoshiViewScreen(
        shinYoshi: ShinYoshi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
