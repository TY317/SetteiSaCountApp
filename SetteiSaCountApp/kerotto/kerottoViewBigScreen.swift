//
//  kerottoViewBigScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoViewBigScreen: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kerotto: Kerotto
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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

    @State var selectedItem: String = "枠なし"
    let selectList: [String] = [
        "枠なし",
        "青枠(ケロット1匹＋他)",
        "青枠(コガエル2匹＋他)",
        "赤枠",
        "銀枠",
        "金枠 ケロ3匹",
        "金枠 山佐キャラ集合",
    ]
    let selectListRaki: [String] = [
        "枠なし",
        "青枠 人差し指",
        "青枠 ピース",
        "赤枠",
        "銀枠",
        "金枠 海賊",
        "金枠 魔法少女",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
    ]
    
    @State var selectedSegment: String = "虹河ラキモード以外"
    let segmentList: [String] = [
        "虹河ラキモード以外",
        "虹河ラキモード",
    ]

    var body: some View {
        List {
            // 画面選択
            Section {
                // コメント
                Text("SBB,BB終了画面でPUSHボタンを押すと、切り替わった画面で設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: self.selectedSegment) { oldValue, newValue in
                    self.selectedItem = newValue == self.segmentList.first ? self.selectList.first! : self.selectListRaki.first!
                }
                
                // サークルピッカー
                // 虹河ラキモード以外
                if self.selectedSegment == self.segmentList.first {
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.selectList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                }
                
                // 虹河ラキモード
                else {
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.selectListRaki, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                }
                
                

                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingScreen(item: self.selectedItem),
                    bigNumber: $kerotto.screenCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $kerotto.minusCheck) {
                        kerotto.screenSumFunc()
                    }
            } header: {
                Text("画面選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingScreen(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $kerotto.screenCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kerottoMenuBigScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BIG終了画面")
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
                unitButtonMinusCheck(minusCheck: $kerotto.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kerotto.resetScreen)
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
        case self.selectListRaki[0]: return self.sisaList[0]
        case self.selectListRaki[1]: return self.sisaList[1]
        case self.selectListRaki[2]: return self.sisaList[2]
        case self.selectListRaki[3]: return self.sisaList[3]
        case self.selectListRaki[4]: return self.sisaList[4]
        case self.selectListRaki[5]: return self.sisaList[5]
        case self.selectListRaki[6]: return self.sisaList[6]
        default: return "???"
        }
    }

    private func bindingScreen(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $kerotto.screenCount1
        case self.selectList[1]: return $kerotto.screenCount2
        case self.selectList[2]: return $kerotto.screenCount3
        case self.selectList[3]: return $kerotto.screenCount4
        case self.selectList[4]: return $kerotto.screenCount5
        case self.selectList[5]: return $kerotto.screenCount6
        case self.selectList[6]: return $kerotto.screenCount7
        case self.selectListRaki[0]: return $kerotto.screenCount1
        case self.selectListRaki[1]: return $kerotto.screenCount2
        case self.selectListRaki[2]: return $kerotto.screenCount3
        case self.selectListRaki[3]: return $kerotto.screenCount4
        case self.selectListRaki[4]: return $kerotto.screenCount5
        case self.selectListRaki[5]: return $kerotto.screenCount6
        case self.selectListRaki[6]: return $kerotto.screenCount7
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .blue
        case self.selectList[3]: return .red
        case self.selectList[4]: return .gray
        case self.selectList[5]: return .orange
        case self.selectList[6]: return .orange
        case self.selectListRaki[0]: return .gray
        case self.selectListRaki[1]: return .blue
        case self.selectListRaki[2]: return .blue
        case self.selectListRaki[3]: return .red
        case self.selectListRaki[4]: return .gray
        case self.selectListRaki[5]: return .orange
        case self.selectListRaki[6]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    kerottoViewBigScreen(
        kerotto: Kerotto(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
