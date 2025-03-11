//
//  sbjViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/06.
//

import SwiftUI
import TipKit

// /////////////////////
// Tip：高確カウント
// /////////////////////
struct sbjTipKokakuCount: Tip {
    var title: Text {
        Text("ボーナス高確初当り")
    }
    
    var message: Text? {
        Text("演出から高確っぽいと判断したらカウントを推奨。完全に見抜くことはできないと思われますので参考程度で使用下さい。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// /////////////////////
// Tip：通常チャンス目関連
// /////////////////////
struct sbjTipChanceCount: Tip {
    var title: Text {
        Text("通常 チャンス目関連")
    }
    
    var message: Text? {
        Text("通常モード中のチャンス目での\n・成立回数\n・ボーナス高確移行回数\n・ボーナス直撃回数\nをカウントを推奨")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}



struct sbjViewNormal: View {
    @ObservedObject var ver230 = Ver230()
    @ObservedObject var ver240 = Ver240()
    @ObservedObject var sbj = Sbj()
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @Environment(\.dismiss) private var dismiss
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 70.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 70.0
    
    var body: some View {
        List {
            // 高確、ステージについての情報
            Section {
                // 高確概要
                unitLinkButton(
                    title: "ボーナス高確について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボーナス高確",
                            textBody1: "・ボーナス当選のメインルート",
                            textBody2: "・主に3つの契機で移行抽選\n　　・規定ゲーム数\n　　・レア役\n　　・小役連続",
                            textBody3: "・規定ゲーム数は100と百の位が偶数のゾーンがチャンス。高設定ほど規定ゲーム数での移行が優遇されている",
                            textBody4: "・小役は3連以上でチャンス。小役連時はプッシュボタンのサイドランプを要チェック",
                            image1Title: "[規定ゲーム数での移行]",
                            image1: Image("sbjKiteiGame")
                        )
                    )
                )
                // //// 参考情報リンク
                // 示唆演出
                unitLinkButton(
                    title: "高確示唆演出",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "高確示唆演出",
                            image1: Image("sbjKokakuEnshutu")
                        )
                    )
                )
                // ハワイステージでの設定示唆
                unitLinkButton(
                    title: "ハワイステージでの設定示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ハワイステージでの設定示唆",
                            textBody1: "ハワイステージ滞在中に設定を示唆する演出が発生する場合あり",
                            image1: Image("sbjHawaiiSisa")
                        )
                    )
                )
            }
            .popoverTip(tipVer240SbjKokakuSisaUpdate())
            // //// 通常中チャンス目関連
            Section {
                HStack {
                    // チャンス目回数
                    unitCountButtonVerticalDenominate(
                        title: "ﾁｬﾝｽ目回数",
                        count: $sbj.normalChanceCount,
                        color: .personalSummerLightBlue,
                        bigNumber: $sbj.normalGame,
                        numberofDicimal: 0,
                        minusBool: $sbj.minusCheck
                    )
                    // ボナ高確移行
                    unitCountButtonVerticalPercent(
                        title: "ﾎﾞﾅ高確移行",
                        count: $sbj.normalChanceKokakuCount,
                        color: .personalSummerLightGreen,
                        bigNumber: $sbj.normalChanceCount,
                        numberofDicimal: 0,
                        minusBool: $sbj.minusCheck
                    )
                    // ボナ高確移行
                    unitCountButtonVerticalPercent(
                        title: "ﾎﾞﾅ直撃",
                        count: $sbj.normalChanceChokugekiCount,
                        color: .personalSummerLightPurple,
                        bigNumber: $sbj.normalChanceCount,
                        numberofDicimal: 0,
                        minusBool: $sbj.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "通常モード中のチャンス目について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常モード中チャンス目",
                            textBody1: "・通常モード中チャンス目からのボーナス高確移行とボーナス直撃に設定差あり",
                            textBody2: "・モードを完全に見抜くことはできないと思われるが、チャイナ以上は別抽選の可能性高いため、通常ステージ中のチャンス目のみを対象とするのが無難かも",
                            image1: Image("sbjNormalChance")
                        )
                    )
                )
            } header: {
                Text("通常モード中 チャンス目関連")
            }
            .popoverTip(sbjTipChanceCount())
            // //// 高確カウント
            Section {
                unitCountButtonVerticalWithoutRatio(
                    title: "ボーナス高確",
                    count: $sbj.kokakuCount,
                    color: .personalSummerLightRed,
                    minusBool: $sbj.minusCheck
                )
                .popoverTip(sbjTipKokakuCount())
//                // //// 参考情報リンク
//                // 示唆演出
//                unitLinkButton(
//                    title: "高確示唆演出",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "高確示唆演出",
//                            image1: Image("sbjKokakuEnshutu")
//                        )
//                    )
//                )
//                .popoverTip(tipVer230SbjKokakuSisaUpdate())
//                // 高確概要
//                unitLinkButton(
//                    title: "ボーナス高確について",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "ボーナス高確",
//                            textBody1: "・ボーナス当選のメインルート",
//                            textBody2: "・主に3つの契機で移行抽選\n　　・規定ゲーム数\n　　・レア役\n　　・小役連続",
//                            textBody3: "・規定ゲーム数は100と百の位が偶数のゾーンがチャンス。高設定ほど規定ゲーム数での移行が優遇されている",
//                            textBody4: "・小役は3連以上でチャンス。小役連時はプッシュボタンのサイドランプを要チェック",
//                            image1Title: "[規定ゲーム数での移行]",
//                            image1: Image("sbjKiteiGame")
//                        )
//                    )
//                )
            } header: {
                Text("ボーナス高確初当り")
            }
            
            // ボーナス初当り
            Section {
                Text("スロプラNEXTの数値を入力してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// 初当り合算
                HStack {
                    Text("初当り合算")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    // 合算回数
                    HStack {
                        TextField("初当り合算回数", value: $sbj.nextInputSumCount, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .focused($isFocused)
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            isFocused = false
                                        }, label: {
                                            Text("完了")
                                                .fontWeight(.bold)
                                        })
                                    }
                                }
                            }
                        Text("回")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                    }
                    // 合算確率
                    HStack {
                        Text("(1/")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                        TextField("初当り合算確率", value: $sbj.nextInputSumDenominate, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .focused($isFocused)
                        Text(")")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                    }
                }
                // //// 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("\(sbj.normalGame)")
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Ｇ")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                    }
                }
                // //// RB
                unitTextFieldNumberInputWithUnit(
                    title: "RB",
                    inputValue: $sbj.nextInputRbCount
                )
                .focused($isFocused)
                // //// 赤7BB
                unitTextFieldNumberInputWithUnit(
                    title: "赤7BB",
                    inputValue: $sbj.nextInputRedBbCount
                )
                .focused($isFocused)
                // //// 青7BB
                unitTextFieldNumberInputWithUnit(
                    title: "青7BB",
                    inputValue: $sbj.nextInputBlueBbCount
                )
                .focused($isFocused)
                // //// 初当り確率横並び
                VStack {
                    Text("[初当り確率]")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        // ボーナス高確
                        unitResultRatioDenomination2Line(
                            title: "高確",
                            count: $sbj.kokakuCount,
                            bigNumber: $sbj.normalGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // ボーナス合算
                        unitResultRatioDenomination2Line(
                            title: "ﾎﾞｰﾅｽ合算",
                            count: $sbj.bonusSum,
                            bigNumber: $sbj.normalGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // リオチャンス
                        unitResultRatioDenomination2Line(
                            title: "ﾘｵﾁｬﾝｽ高確",
                            count: $sbj.rioChanceCount,
                            bigNumber: $sbj.normalGame,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            image1: Image("sbjHitRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(sbjView95Ci(selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り確率")
            }
            // //// 小役カウント
            Section {
                Text("現在データはスロプラNEXTで確認できます")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// 参考情報リンク
                unitLinkButton(
                    title: "レア役確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役確率",
                            textBody1: "・設定1のみ数値が公表されている",
                            textBody2: "・発表の仕方的に設定差ある可能性高いと思われる",
                            image1: Image("sbjKoyakuRatio")
                        )
                    )
                )
                .popoverTip(tipVer240SbjKoyakuUpdate())
            } header: {
                Text("レア役確率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        .onAppear {
            if ver240.sbjMenuNormalBadgeStatus != "none" {
                ver240.sbjMenuNormalBadgeStatus = "none"
            }
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
                    unitButtonMinusCheck(minusCheck: $sbj.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sbj.resetNormal)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sbjViewNormal()
}
