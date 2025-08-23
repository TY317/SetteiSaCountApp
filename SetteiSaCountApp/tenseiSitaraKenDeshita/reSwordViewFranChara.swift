//
//  reSwordViewFranChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordViewFranChara: View {
//    @ObservedObject var ver361: Ver361
    @ObservedObject var reSword: ReSword
    @State var isShowAlert = false
    @State var selectedChara: String = "青"
    let charaList: [String] = ["青", "ピンク", "緑", "赤", "紫", "金"]
    var body: some View {
        List {
//            Section {
//                VStack {
//                    Text("キャラ種類で設定を示唆")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("文字や背景の色に要注目")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
//                Text("詳細調査中")
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .font(.title2)
//                    .fontWeight(.bold)
//            } header: {
//                Text("キャラ紹介")
//            }
//            
//            unitAdBannerMediumRectangle()
            // キャラ背景色選択
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedChara) {
                    ForEach(self.charaList, id: \.self) { chara in
                        Text(chara)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
//                .popoverTip(tipVer361ReSwordChara())
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(chara: self.selectedChara),
                    count: bindingCount(chara: self.selectedChara),
                    bigNumber: $reSword.charaCountSum,
                    flushColor: flushColor(chara: self.selectedChara),
                    minusCheck: $reSword.minusCheck,
                    action: reSword.charaCountSumFunc
                )
            } header: {
                Text("キャラ背景色選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.charaList, id: \.self) { chara in
                    unitResultCountListPercent(
                        title: sisaText(chara: chara),
                        count: bindingCount(chara: chara),
                        flashColor: flushColor(chara: chara),
                        bigNumber: $reSword.charaCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver361.reSwordMenuFranCharaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("フランボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $reSword.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: reSword.resetCharaCount)
                }
            }
        }
    }
    
    private func sisaText(chara: String) -> String {
        switch chara {
        case self.charaList[0]: return "デフォルト"
        case self.charaList[1]: return "高設定示唆 弱"
        case self.charaList[2]: return "高設定示唆 強"
        case self.charaList[3]: return "設定2 以上濃厚"
        case self.charaList[4]: return "設定4 以上濃厚"
        case self.charaList[5]: return "設定6 濃厚"
        default: return "デフォルト"
        }
    }
    
    private func bindingCount(chara: String) -> Binding<Int> {
        switch chara {
        case self.charaList[0]: return reSword.$charaCountDefault
        case self.charaList[1]: return reSword.$charaCountHighJaku
        case self.charaList[2]: return reSword.$charaCountHighKyo
        case self.charaList[3]: return reSword.$charaCountOver2
        case self.charaList[4]: return reSword.$charaCountOver4
        case self.charaList[5]: return reSword.$charaCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(chara: String) -> Color {
        switch chara {
        case self.charaList[0]: return Color.blue
        case self.charaList[1]: return Color.pink
        case self.charaList[2]: return Color.green
        case self.charaList[3]: return Color.red
        case self.charaList[4]: return Color.purple
        case self.charaList[5]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    reSwordViewFranChara(
//        ver361: Ver361(),
        reSword: ReSword(),
    )
}
