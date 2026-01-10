//
//  hokutoTenseiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/27.
//

import SwiftUI

struct hokutoTenseiViewNormal: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "点灯なし"
    let selectList: [String] = [
        "点灯なし",
        "白",
        "白点滅",
        "水色",
        "水色点滅",
        "黄緑",
        "黄緑点滅",
        "金",
    ]
    let sisaList: [String] = [
        "設定示唆なし",
        "設定2・4 示唆",
        "設定3・5 示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    var body: some View {
        List {
            // ---- レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    hokutoTenseiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // ---- 通常時のモード
            Section {
                // 参考情報）通常時のモード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    hokutoTenseiTableMode()
                }
                // 参考情報）あべし期待度テーブル
                unitLinkButtonViewBuilder(sheetTitle: "あべし期待度テーブル") {
                    hokutoTenseiTableAbeshi()
                }
            } header: {
                Text("通常時のモード")
            }
            
            // ---- 100Gごとの台枠ランプ
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "100Gごとの台枠ランプ示唆") {
                    hokutoTenseiSubViewMachineLamp()
                }
                // サークルピッカー
                VStack {
                    Text("[上部中央ランプ]")
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        Picker("[上部中央ランプ]", selection: self.$selectedItem) {
                            ForEach(self.selectList, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                    }
                }
                .popoverTip(tipVer3170hokutTenseiLampSisa())
                
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingCount(item: self.selectedItem),
                    bigNumber: $hokutoTensei.lampCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $hokutoTensei.minusCheck) {
                        hokutoTensei.lampSumFunc()
                    }
            } header: {
                Text("台枠ランプ カウント")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $hokutoTensei.lampCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("台枠ランプ カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hokutoTensei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hokutoTensei.resetNormal)
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
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $hokutoTensei.lampCountNone
        case self.selectList[1]: return $hokutoTensei.lampCount24Sisa
        case self.selectList[2]: return $hokutoTensei.lampCount35Sisa
        case self.selectList[3]: return $hokutoTensei.lampCountHighjaku
        case self.selectList[4]: return $hokutoTensei.lampCountHighKyo
        case self.selectList[5]: return $hokutoTensei.lampCountOver2
        case self.selectList[6]: return $hokutoTensei.lampCountOver4
        case self.selectList[7]: return $hokutoTensei.lampCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.gray
        case self.selectList[2]: return Color.gray
        case self.selectList[3]: return Color.cyan
        case self.selectList[4]: return Color.blue
        case self.selectList[5]: return Color.green
        case self.selectList[6]: return Color.green
        case self.selectList[7]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    hokutoTenseiViewNormal(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
