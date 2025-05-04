//
//  arifureViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/02.
//

import SwiftUI

struct arifureViewNormal: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    @State var isShowAlert = false
    let selectListKoyakuKind: [String] = [
        "弱🍒",
        "弱チャンス目",
        "高確中スイカ"
    ]
    @State var selectedKoyakuKind: String = "弱🍒"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    
    var body: some View {
        List {
            // //// モードの説明
            Section {
                // 高確
                unitLinkButton(
                    title: "高確について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "高確",
                            textBody1: "・スイカでの引鉄高確移行と強レア役での初当り当選率がUPする状態",
                            textBody2: "・滞在中は主に魔力駆動四輪ブリーゼステージに移行する",
                            textBody3: "・主な移行契機はスイカ",
                            textBody4: "・ミュウボーナス、AT後に移行する場合もある"
                        )
                    )
                )
                // 引鉄高確
                unitLinkButton(
                    title: "引鉄高確について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "引鉄高確",
                            textBody1: "・引鉄を狙え が約1/4で発生する状態",
                            textBody2: "・滞在中は主に神山ステージに移行する",
                            textBody3: "・主な移行契機は弱レア役、高確中スイカ"
                        )
                    )
                )
            }
            
            // //// 引鉄高確移行
            Section {
                // //// 小役種類の選択
                Picker("", selection: self.$selectedKoyakuKind) {
                    ForEach(self.selectListKoyakuKind, id: \.self) { koyaku in
                        Text(koyaku)
                    }
                }
                .pickerStyle(.segmented)
                // //// カウントボタン
                // 弱チェリー
                if self.selectedKoyakuKind == self.selectListKoyakuKind[0] {
                    HStack {
                        // 弱チェカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱🍒回数",
                            count: $arifure.jakuCherryCount,
                            color: .personalSummerLightRed,
                            minusBool: $arifure.minusCheck
                        )
                        // 高確移行カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "引鉄高確移行",
                            count: $arifure.jakuCherryKokakuCount,
                            color: .red,
                            minusBool: $arifure.minusCheck
                        )
                    }
                }
                // 弱チャンス目
                else if self.selectedKoyakuKind == self.selectListKoyakuKind[1] {
                    HStack {
                        // 弱チャンス目カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱チャンス目回数",
                            count: $arifure.jakuChanceCount,
                            color: .personalSummerLightBlue,
                            minusBool: $arifure.minusCheck
                        )
                        // 高確移行カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "引鉄高確移行",
                            count: $arifure.jakuChanceKokakuCount,
                            color: .blue,
                            minusBool: $arifure.minusCheck
                        )
                    }
                }
                // 高確スイカ
                else {
                    HStack {
                        // 高確スイカカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "高確スイカ回数",
                            count: $arifure.kokakuSuikaCount,
                            color: .personalSummerLightGreen,
                            minusBool: $arifure.minusCheck
                        )
                        // 高確移行カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "引鉄高確移行",
                            count: $arifure.kokakuSuikaKokakuCount,
                            color: .green,
                            minusBool: $arifure.minusCheck
                        )
                    }
                }
                // //// 移行率
                HStack {
                    // 弱チェリー
                    unitResultRatioPercent2Line(
                        title: "弱🍒",
                        count: $arifure.jakuCherryKokakuCount,
                        bigNumber: $arifure.jakuCherryCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 弱チャンス目
                    unitResultRatioPercent2Line(
                        title: "弱チャンス目",
                        count: $arifure.jakuChanceKokakuCount,
                        bigNumber: $arifure.jakuChanceCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 高確スイカ
                    unitResultRatioPercent2Line(
                        title: "高確スイカ",
                        count: $arifure.kokakuSuikaKokakuCount,
                        bigNumber: $arifure.kokakuSuikaCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("arifureKoyakuPattern")
                        )
                    )
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "弱レア役での引鉄高確移行について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱レア役での引鉄高確移行",
                            textBody1: "・弱レア役契機での引鉄高確（神山ステージ）移行に設定差あり",
                            textBody2: "・弱🍒と弱チャンス目は全状態不問",
                            textBody3: "・スイカは高確中（魔力駆動四輪ブリーゼステージ）のみ抽選",
                            tableView: AnyView(arifureTableJakuRareMove())
//                            image1: Image("arifureJakuRareKokaku")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("弱レア役での引鉄高確移行率")
            }
            
            // //// 規定ゲーム100GでのCZ当選率
            Section {
                // //// カウントボタン
                HStack {
                    // CZ非当選
                    unitCountButtonVerticalPercent(
                        title: "CZ非当選",
                        count: $arifure.cz100GCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $arifure.cz100GCountSum,
                        numberofDicimal: 0,
                        minusBool: $arifure.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalPercent(
                        title: "CZ当選",
                        count: $arifure.cz100GCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $arifure.cz100GCountSum,
                        numberofDicimal: 0,
                        minusBool: $arifure.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "CZモードと規定G数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZモードと規定G数",
                            textBody1: "・規定ゲーム数消化時のCZ当選を管理する3種類のモード",
                            textBody2: "・規定ゲーム数は100/300/500/700/900\n　900は天井で必ず当選ではないため注意",
                            textBody3: "・高設定ほど規定ゲーム数での当選が優遇",
                            textBody4: "・滞在モードを見抜くことはできないと思われるが、100Gは全モードで当選期待度が同じの可能性あるため、カウントを推奨",
                            textBody5: "・リセット後は内部的にゲーム数がランダム加算されているため、カウントから除外が無難かも",
                            tableView: AnyView(arifureTableCzMode())
//                            image1Title: "[CZモードごとの期待度テーブル]",
//                            image1: Image("arifureCzModeTable"),
//                            image2Title: "[期待度記号ごとのCZ当選率]",
//                            image2: Image("arifureCzMarkRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 8)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("規定ゲーム数100GでのCZ当選率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetNormal)
                }
            }
        }
    }
}

#Preview {
    arifureViewNormal(arifure: Arifure())
}
