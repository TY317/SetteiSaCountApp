//
//  creaViewRegCard.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaViewRegCard: View {
    @ObservedObject var crea: Crea
    @State var isShowAlert: Bool = false
    @State var selectedColor: String = "銅カード"
    let colorList: [String] = [
        "銅カード",
        "銀カード",
        "金カード",
        "赤カード",
        "オール銀・金",
        "赤カード2回",
    ]
    
    var body: some View {
        List {
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedColor) {
                    ForEach(self.colorList, id: \.self) { lampColor in
                        Text(lampColor)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(lamp: self.selectedColor),
                    count: bindingCount(lamp: self.selectedColor),
                    bigNumber: $crea.regCardCountSum,
                    flushColor: flushColor(lamp: self.selectedColor),
                    minusCheck: $crea.minusCheck) {
                        crea.regCardCountSumFunc()
                    }
            } header: {
                Text("カード色選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.colorList, id: \.self) { lamp in
                    if lamp != colorList[4] {
                        unitResultCountListPercent(
                            title: sisaText(lamp: lamp),
                            count: bindingCount(lamp: lamp),
                            flashColor: flushColor(lamp: lamp),
                            bigNumber: $crea.regCardCountSum,
                            numberofDigit: 0,
                        )
                    }
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
        .navigationTitle("REG中のカード")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $crea.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetRegCard)
            }
        }
    }
    private func sisaText(lamp: String) -> String {
        switch lamp {
        case self.colorList[0]: return "デフォルト"
        case self.colorList[1]: return "高設定示唆 弱"
        case self.colorList[2]: return "高設定示唆 強"
        case self.colorList[3]: return "設定4 以上濃厚"
        case self.colorList[4]: return "設定4 以上濃厚"
        case self.colorList[5]: return "設定6 濃厚"
        default: return "???"
        }
    }
    private func bindingCount(lamp: String) -> Binding<Int> {
        switch lamp {
        case self.colorList[0]: return $crea.regCardCountDefault
        case self.colorList[1]: return $crea.regCardCountHighJaku
        case self.colorList[2]: return $crea.regCardCountHighKyo
        case self.colorList[3]: return $crea.regCardCountOver4
        case self.colorList[4]: return $crea.regCardCountOver4
        case self.colorList[5]: return $crea.regCardCountOver6
        default: return .constant(0)
        }
    }
    private func flushColor(lamp: String) -> Color {
        switch lamp {
        case self.colorList[0]: return Color.brown
        case self.colorList[1]: return Color.gray
        case self.colorList[2]: return Color.orange
        case self.colorList[3]: return Color.red
        case self.colorList[4]: return Color.red
        case self.colorList[5]: return Color.red
        default: return Color.gray
        }
    }
}

#Preview {
    creaViewRegCard(
        crea: Crea(),
    )
}
