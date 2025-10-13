//
//  toreveViewRevenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewRevenge: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var toreve: Toreve
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var selectedKind: String = "決戦前夜後"
    let kindList: [String] = [
        "決戦前夜後",
        "東卍チャンス後",
    ]
    @State var selectedZenyaThrough: String = "3,4周期目スルー時"
    let zenyaThroughList: [String] = [
        "3,4周期目スルー時",
        "5周期目スルー時",
    ]
    @State var selectedChanceThrough: String = "2スルー時"
    let chanceThroughList: [String] = [
        "2スルー時",
        "3スルー時",
    ]
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
    
    var body: some View {
        List {
            Section {
                // 種類選択のセグメントピッカー
                Picker("", selection: self.$selectedKind) {
                    ForEach(self.kindList, id: \.self) { kind in
                        Text(kind)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3110ToreveRevenge())
                
                // //// 決戦前夜
                if self.selectedKind == self.kindList[0] {
                    // //// 注意書き
                    Text("・ノイズ状態移行自体に設定差があります\n　スルー数ごとの状態移行の有無をカウントして下さい\n・1,2周期目スルー時は設定差ないためカウント不要です")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    
                    // スルー数選択のセグメントピッカー
                    Picker("", selection: self.$selectedZenyaThrough) {
                        ForEach(self.zenyaThroughList, id: \.self) { through in
                            Text(through)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // ３、４周期目スルー時
                    if self.selectedZenyaThrough == self.zenyaThroughList[0] {
                        // カウントボタン横並び
                        HStack {
                            // ノイズなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ノイズなし",
                                count: $toreve.revengeCountZenya34NoizeNone,
                                color: .personalSummerLightBlue,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                            // ノイズあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ノイズあり",
                                count: $toreve.revengeCountZenya34NoizeHit,
                                color: .blue,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                        }
                    }
                    // 5周期めスルー時
                    else {
                        // カウントボタン横並び
                        HStack {
                            // ノイズなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ノイズなし",
                                count: $toreve.revengeCountZenya5NoizeNone,
                                color: .personalSummerLightGreen,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                            // ノイズあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ノイズあり",
                                count: $toreve.revengeCountZenya5NoizeHit,
                                color: .green,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                        }
                    }
                }
                
                // //// 東卍チャンス後
                else {
                    // //// 注意書き
                    Text("・リベンジ発生に設定差(フェイク、ロンフリは設定差なし)\n　スルー数ごとのリベンジ有無をカウントして下さい\n・1,4スルー時は設定差ないためカウント不要です")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // スルー数選択のセグメントピッカー
                    Picker("", selection: self.$selectedChanceThrough) {
                        ForEach(self.chanceThroughList, id: \.self) { through in
                            Text(through)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // ２スルー時
                    if self.selectedChanceThrough == self.chanceThroughList[0] {
                        // カウントボタン横並び
                        HStack {
                            // リベンジなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リベンジなし",
                                count: $toreve.revengeCountChance2None,
                                color: .personalSpringLightYellow,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                            // リベンジあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リベンジあり",
                                count: $toreve.revengeCountChance2Hit,
                                color: .yellow,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                        }
                    }
                    // ３スルー時
                    else {
                        // カウントボタン横並び
                        HStack {
                            // リベンジなし
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リベンジなし",
                                count: $toreve.revengeCountChance3None,
                                color: .personalSummerLightRed,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                            // リベンジあり
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リベンジあり",
                                count: $toreve.revengeCountChance3Hit,
                                color: .red,
                                minusBool: $toreve.minusCheck) {
                                    toreve.revengeCountSumFunc()
                                }
                        }
                    }
                }
                
                // //// 確率の結果
                // 決戦前夜
                VStack(alignment: .center) {
                    Text("[決戦前夜後 ノイズ発生率]")
                    HStack {
                        // 3,4周期目スルー時
                        unitResultRatioPercent2Line(
                            title: self.zenyaThroughList[0],
                            count: $toreve.revengeCountZenya34NoizeHit,
                            bigNumber: $toreve.revengeCountZenya34Sum,
                            numberofDicimal: 0
                        )
                        // 5周期目スルー時
                        unitResultRatioPercent2Line(
                            title: self.zenyaThroughList[1],
                            count: $toreve.revengeCountZenya5NoizeHit,
                            bigNumber: $toreve.revengeCountZenya5Sum,
                            numberofDicimal: 0
                        )
                    }
                }
                // 東卍チャンス
                VStack(alignment: .center) {
                    Text("[東卍チャンス後 リベンジ発生率]")
                    HStack {
                        // 2スルー時
                        unitResultRatioPercent2Line(
                            title: self.chanceThroughList[0],
                            count: $toreve.revengeCountChance2Hit,
                            bigNumber: $toreve.revengeCountChance2Sum,
                            numberofDicimal: 0
                        )
                        // 3スルー時
                        unitResultRatioPercent2Line(
                            title: self.chanceThroughList[1],
                            count: $toreve.revengeCountChance3Hit,
                            bigNumber: $toreve.revengeCountChance3Sum,
                            numberofDicimal: 0
                        )
                    }
                }
                
                // //// 参考情報）決戦前夜後のリベンジ
                unitLinkButtonViewBuilder(sheetTitle: "決戦前夜後のリベンジ") {
                    toreveTableRevengeZenya(toreve: toreve)
                }
                // //// 参考情報）東卍チャンス後のリベンジ
                unitLinkButtonViewBuilder(sheetTitle: "東卍チャンス後のリベンジ") {
                    toreveTableRevengeChance(toreve: toreve)
                }
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    toreveViewBayes(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
//                VStack(alignment: .leading) {
//                    Text("・前兆やAT終了後などの引き戻し")
//                    Text("・高設定ほど発生確率が高い")
//                    Text("・決戦前夜、東卍チャンス終了後のリベンジは発生すれば高設定への期待度アップ")
//                    Text("・東卍ラッシュ後のリベンジは設定差あるが、低設定でも普通に発生する確率のようなので過信は禁物")
//                }
//                HStack(spacing: 0) {
//                    unitTableString(
//                        columTitle: "",
//                        stringList: [
//                            "決戦前夜終了後",
//                            "東卍チャンス終了後",
//                            "東卍ラッシュ終了後",
//                            "リベンジチャンス終了後",
//                            "天上天下唯我独尊終了後",
//                        ],
//                        maxWidth: 200,
//                    )
//                    unitTableString(
//                        columTitle: "復帰先",
//                        stringList: [
//                            "東卍ラッシュへ",
//                            "東卍ラッシュ\nバーストへ",
//                        ],
//                        lineList: [3,2],
//                    )
//                }
//                .frame(maxWidth: .infinity, alignment: .center)
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.toreveMenuRevengeBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
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
        .navigationTitle("リベンジ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetRevenge)
            }
        }
    }
}

#Preview {
    toreveViewRevenge(
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
