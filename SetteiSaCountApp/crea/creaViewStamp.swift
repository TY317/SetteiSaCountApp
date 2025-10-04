//
//  creaViewStamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaViewStamp: View {
    @ObservedObject var crea: Crea
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "なし"
    let selectList: [String] = [
        "なし",
        "レオン",
        "子供クレア",
        "シャロン",
    ]
    
    var body: some View {
        List {
            Section {
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
                    bigNumber: $crea.stampCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $crea.minusCheck) {
                        crea.stampCountSumFunc()
                    }
            } header: {
                Text("カード色選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $crea.stampCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BIG終了時のスタンプ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $crea.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetStamp)
            }
        }
    }
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return "デフォルト"
        case self.selectList[1]: return "偶数設定示唆"
        case self.selectList[2]: return "高設定示唆 弱"
        case self.selectList[3]: return "高設定示唆 強"
        default: return "???"
        }
    }
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $crea.stampCountDefault
        case self.selectList[1]: return $crea.stampCountGusu
        case self.selectList[2]: return $crea.stampCountHighJaku
        case self.selectList[3]: return $crea.stampCountHighKyo
        default: return .constant(0)
        }
    }
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.yellow
        case self.selectList[2]: return Color.green
        case self.selectList[3]: return Color.red
        default: return Color.gray
        }
    }
}

#Preview {
    creaViewStamp(
        crea: Crea(),
    )
}
