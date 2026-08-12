//
//  bioRe3ViewPoint.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct bioRe3ViewPoint: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var bioRe3: BioRe3
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

    @State var selectedMode: String = "通常時"
    let modeList: [String] = [
        "通常時",
        "AT中",
        "上位AT中",
    ]
    @State var selectedItem: String = "50pt"
    let selectList: [String] = [
        "50pt",
        "100pt",
        "150pt",
        "200pt",
        "250pt",
        "300pt",
        "350pt",
        "400pt",
        "450pt",
        "500pt",
    ]
    let sisaList: [String] = [
        "50pt",
        "100pt",
        "150pt",
        "200pt",
        "250pt",
        "300pt",
        "350pt",
        "400pt",
        "450pt",
        "500pt",
    ]

    var body: some View {
        List {
            // 規定ポイント選択
            Section {
                // セグメントピッカー（滞在状態）
                Picker("", selection: self.$selectedMode) {
                    ForEach(self.modeList, id: \.self) { mode in
                        Text(mode)
                    }
                }
                .pickerStyle(.segmented)

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
                    count: bindingPoint(mode: self.selectedMode, item: self.selectedItem),
                    bigNumber: bindingSum(mode: self.selectedMode),
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $bioRe3.minusCheck) {
                        sumFunc(mode: self.selectedMode)
                    }
            } header: {
                Text("規定ポイント選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingPoint(mode: self.selectedMode, item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: bindingSum(mode: self.selectedMode)
                    )
                    // モードごとに行のidentityを分ける
                    // （分けないとセグメント切替でcountの値が変わり、フラッシュが誤発火する）
                    .id("\(self.selectedMode)-\(item)")
                }
            } header: {
                Text("カウント結果（\(self.selectedMode)）")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bioRe3MenuPointBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bioRe3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("規定ネメシスポイント")
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
                unitButtonMinusCheck(minusCheck: $bioRe3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bioRe3.resetPoint)
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
        case self.selectList[9]: return self.sisaList[9]
        default: return "???"
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .red
        case self.selectList[1]: return .green
        case self.selectList[2]: return .red
        case self.selectList[3]: return .yellow
        case self.selectList[4]: return .red
        case self.selectList[5]: return .gray
        case self.selectList[6]: return .red
        case self.selectList[7]: return .gray
        case self.selectList[8]: return .gray
        case self.selectList[9]: return .gray
        default: return .gray
        }
    }

    private func bindingPoint(mode: String, item: String) -> Binding<Int> {
        switch mode {
        // 通常時
        case self.modeList[0]:
            switch item {
            case self.selectList[0]: return $bioRe3.pointNormalCount1
            case self.selectList[1]: return $bioRe3.pointNormalCount2
            case self.selectList[2]: return $bioRe3.pointNormalCount3
            case self.selectList[3]: return $bioRe3.pointNormalCount4
            case self.selectList[4]: return $bioRe3.pointNormalCount5
            case self.selectList[5]: return $bioRe3.pointNormalCount6
            case self.selectList[6]: return $bioRe3.pointNormalCount7
            case self.selectList[7]: return $bioRe3.pointNormalCount8
            case self.selectList[8]: return $bioRe3.pointNormalCount9
            case self.selectList[9]: return $bioRe3.pointNormalCount10
            default: return .constant(0)
            }
        // AT中
        case self.modeList[1]:
            switch item {
            case self.selectList[0]: return $bioRe3.pointAtCount1
            case self.selectList[1]: return $bioRe3.pointAtCount2
            case self.selectList[2]: return $bioRe3.pointAtCount3
            case self.selectList[3]: return $bioRe3.pointAtCount4
            case self.selectList[4]: return $bioRe3.pointAtCount5
            case self.selectList[5]: return $bioRe3.pointAtCount6
            case self.selectList[6]: return $bioRe3.pointAtCount7
            case self.selectList[7]: return $bioRe3.pointAtCount8
            case self.selectList[8]: return $bioRe3.pointAtCount9
            case self.selectList[9]: return $bioRe3.pointAtCount10
            default: return .constant(0)
            }
        // 上位AT中
        case self.modeList[2]:
            switch item {
            case self.selectList[0]: return $bioRe3.pointHighAtCount1
            case self.selectList[1]: return $bioRe3.pointHighAtCount2
            case self.selectList[2]: return $bioRe3.pointHighAtCount3
            case self.selectList[3]: return $bioRe3.pointHighAtCount4
            case self.selectList[4]: return $bioRe3.pointHighAtCount5
            case self.selectList[5]: return $bioRe3.pointHighAtCount6
            case self.selectList[6]: return $bioRe3.pointHighAtCount7
            case self.selectList[7]: return $bioRe3.pointHighAtCount8
            case self.selectList[8]: return $bioRe3.pointHighAtCount9
            case self.selectList[9]: return $bioRe3.pointHighAtCount10
            default: return .constant(0)
            }
        default: return .constant(0)
        }
    }

    private func bindingSum(mode: String) -> Binding<Int> {
        switch mode {
        case self.modeList[0]: return $bioRe3.pointNormalCountSum
        case self.modeList[1]: return $bioRe3.pointAtCountSum
        case self.modeList[2]: return $bioRe3.pointHighAtCountSum
        default: return .constant(0)
        }
    }

    private func sumFunc(mode: String) {
        switch mode {
        case self.modeList[0]: bioRe3.pointNormalSumFunc()
        case self.modeList[1]: bioRe3.pointAtSumFunc()
        case self.modeList[2]: bioRe3.pointHighAtSumFunc()
        default: break
        }
    }
}

#Preview {
    bioRe3ViewPoint(
        bioRe3: BioRe3(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
