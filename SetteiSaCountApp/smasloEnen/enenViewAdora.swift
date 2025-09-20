//
//  enenViewAdora.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/17.
//

import SwiftUI

struct enenViewAdora: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var enen: Enen
    @State var isShowAlert = false
    @State var selectedChara: String = "森羅日下部"
    let charaList: [String] = [
        "森羅日下部",
        "アーサー・ボイル",
        "武久火縄",
        "茉希尾瀬",
        "環古達",
        "秋樽桜備",
        "ジョーカー",
        "新門紅丸",
        "アイリス",
    ]
    let resultIntList: [Int] = [0,3,5,6,7,8]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 炎炎JAC開始画面
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedChara) {
                    ForEach(self.charaList, id: \.self) { chara in
                        Text(chara)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(chara: self.selectedChara),
                    count: bindingCount(chara: self.selectedChara),
                    bigNumber: $enen.adoraCountSum,
                    flushColor: flushColor(chara: self.selectedChara),
                    minusCheck: $enen.minusCheck) {
                        enen.adoraCountSumFunc()
                    }
            } header: {
                Text("炎炎JAC開始画面")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.resultIntList, id: \.self) { index in
                    unitResultCountListPercent(
                        title: sisaText(chara: self.charaList[index]),
                        count: bindingCount(chara: self.charaList[index]),
                        flashColor: flushColor(chara: self.charaList[index]),
                        bigNumber: $enen.adoraCountSum,
                        numberofDigit: 0,
                    )
                }
                // 参考情報）開始画面の振分け
                unitLinkButtonViewBuilder(sheetTitle: "開始画面の振分け") {
                    enenTableAdoraRatio(
                        enen: enen,
                    )
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        enenView95Ci(
                            enen: enen,
                            selection: 14,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    enenViewBayes(
                        ver391: ver391,
                        enen: enen,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("アドラバースト")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $enen.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: enen.resetAdora,
                    )
                }
            }
        }
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
    }
    private func sisaText(chara: String) -> String {
        switch chara {
        case self.charaList[0]: return "設定2・5 示唆"
        case self.charaList[1]: return "設定2・5 示唆"
        case self.charaList[2]: return "設定2・5 示唆"
        case self.charaList[3]: return "設定1・4・6 示唆"
        case self.charaList[4]: return "設定1・4・6 示唆"
        case self.charaList[5]: return "設定2 以上濃厚"
        case self.charaList[6]: return "設定1・4・6 濃厚"
        case self.charaList[7]: return "設定4 以上濃厚"
        case self.charaList[8]: return "設定5 以上濃厚"
        default: return "???"
        }
    }
    
    private func bindingCount(chara: String) -> Binding<Int> {
        switch chara {
        case self.charaList[0]: return enen.$adoraCount25Sisa
        case self.charaList[1]: return enen.$adoraCount25Sisa
        case self.charaList[2]: return enen.$adoraCount25Sisa
        case self.charaList[3]: return enen.$adoraCount146Sisa
        case self.charaList[4]: return enen.$adoraCount146Sisa
        case self.charaList[5]: return enen.$adoraCountOver2
        case self.charaList[6]: return enen.$adoraCount146Fix
        case self.charaList[7]: return enen.$adoraCountOver4
        case self.charaList[8]: return enen.$adoraCountOver5
        default: return .constant(0)
        }
    }
    
    private func flushColor(chara: String) -> Color {
        switch chara {
        case self.charaList[0]: return Color.blue
        case self.charaList[1]: return Color.blue
        case self.charaList[2]: return Color.blue
        case self.charaList[3]: return Color.yellow
        case self.charaList[4]: return Color.yellow
        case self.charaList[5]: return Color.cyan
        case self.charaList[6]: return Color.green
        case self.charaList[7]: return Color.red
        case self.charaList[8]: return Color.purple
        default: return Color.gray
        }
    }
}

#Preview {
    enenViewAdora(
        ver391: Ver391(),
        enen: Enen(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
