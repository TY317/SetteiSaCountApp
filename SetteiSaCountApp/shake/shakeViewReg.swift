//
//  shakeViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewReg: View {
    @ObservedObject var shake: Shake
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "OK"
    let selectList: [String] = [
        "OK",
        "Feel so good",
        "Excellent",
        "Unbelievable",
        "Amazing",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定5 以上濃厚",
    ]
    
    var body: some View {
        List {
            // ---- ビタ押し成功時のボイス
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
                    bigNumber: $shake.voiceCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $shake.minusCheck) {
                        shake.voiceSumFunc()
                    }
            } header: {
                Text("ビタ押し成功時のボイス")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $shake.voiceCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $shake.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shake.resetReg)
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
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $shake.voiceCountDefault
        case self.selectList[1]: return $shake.voiceCountHighJaku
        case self.selectList[2]: return $shake.voiceCountHighChu
        case self.selectList[3]: return $shake.voiceCountHighKyo
        case self.selectList[4]: return $shake.voiceCountOver5
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.blue
        case self.selectList[2]: return Color.green
        case self.selectList[3]: return Color.red
        case self.selectList[4]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    shakeViewReg(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
