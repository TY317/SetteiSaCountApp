//
//  kabaneriUnatoViewOmikuji.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/01.
//

import SwiftUI

struct kabaneriUnatoViewOmikuji: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    @State var selectedItem: String = "ツラヌキ筒"
    let selectList: [String] = [
        "ツラヌキ筒",
        "無名の短銃",
        "自決袋",
        "来栖の刀",
        "菖蒲の弓",
        "ミヤマカラスアゲハ",
        "小吉",
        "中吉",
        "大吉",
    ]
    let sisaList: [String] = [
        "???",
        "???",
        "???",
        "???",
        "高設定示唆",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let resultTextList: [String] = [
        "???(ツラヌキ筒)",
        "???(無名の短銃)",
        "???(自決袋)",
        "???(来栖の刀)",
        "高設定示唆",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    var body: some View {
        List {
            // ---- おみくじ選択
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・設定示唆確認はアイテムくじを選択")
                    Text("・輪廻くじは規定ポイントを示唆")
                }
                // サークルピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingCount(item: self.selectedItem),
                    bigNumber: $kabaneriUnato.omikujiCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $kabaneriUnato.minusCheck) {
                        kabaneriUnato.omikujiSumFunc()
                    }
            } header: {
                Text("アイテムくじ選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.resultTextList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: item,
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $kabaneriUnato.omikujiCountSum,
                        numberofDigit: 0,
                    )
                }
                
                // 参考情報）小吉 出現タイミングの法則
                unitLinkButtonViewBuilder(sheetTitle: "小吉 出現タイミングの法則") {
                    kabaneriUnatoTableShokichi()
                }
                .popoverTip(tipVer3220KabaneriUnatoShokichi())
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuOmikujiBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("おみくじ")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetOmikuji)
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
        case self.selectList[7]: return self.sisaList[7]
        case self.selectList[8]: return self.sisaList[8]
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $kabaneriUnato.omikujiCount1
        case self.selectList[1]: return $kabaneriUnato.omikujiCount2
        case self.selectList[2]: return $kabaneriUnato.omikujiCount3
        case self.selectList[3]: return $kabaneriUnato.omikujiCount4
        case self.selectList[4]: return $kabaneriUnato.omikujiCount5
        case self.selectList[5]: return $kabaneriUnato.omikujiCount6
        case self.selectList[6]: return $kabaneriUnato.omikujiCountOver2
        case self.selectList[7]: return $kabaneriUnato.omikujiCountOver4
        case self.selectList[8]: return $kabaneriUnato.omikujiCountOver6
        case self.resultTextList[0]: return $kabaneriUnato.omikujiCount1
        case self.resultTextList[1]: return $kabaneriUnato.omikujiCount2
        case self.resultTextList[2]: return $kabaneriUnato.omikujiCount3
        case self.resultTextList[3]: return $kabaneriUnato.omikujiCount4
        case self.resultTextList[4]: return $kabaneriUnato.omikujiCount5
        case self.resultTextList[5]: return $kabaneriUnato.omikujiCount6
        case self.resultTextList[6]: return $kabaneriUnato.omikujiCountOver2
        case self.resultTextList[7]: return $kabaneriUnato.omikujiCountOver4
        case self.resultTextList[8]: return $kabaneriUnato.omikujiCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.gray
        case self.selectList[2]: return Color.purple
        case self.selectList[3]: return Color.purple
        case self.selectList[4]: return Color.red
        case self.selectList[5]: return Color.red
        case self.selectList[6]: return Color.brown
        case self.selectList[7]: return Color.gray
        case self.selectList[8]: return Color.orange
        case self.resultTextList[0]: return Color.gray
        case self.resultTextList[1]: return Color.gray
        case self.resultTextList[2]: return Color.purple
        case self.resultTextList[3]: return Color.purple
        case self.resultTextList[4]: return Color.red
        case self.resultTextList[5]: return Color.red
        case self.resultTextList[6]: return Color.brown
        case self.resultTextList[7]: return Color.gray
        case self.resultTextList[8]: return Color.orange
        default: return Color.gray
        }
    }
    
    
}

#Preview {
    kabaneriUnatoViewOmikuji(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
