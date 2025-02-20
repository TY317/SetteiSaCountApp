//
//  sevenSwordsViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/13.
//

import SwiftUI

struct sevenSwordsViewBonus: View {
    @ObservedObject var sevenSwords = SevenSwords()
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @Environment(\.dismiss) private var dismiss
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
            // //// 250Gでの当選カウント
            Section {
                HStack {
                    // 250Gハズレ
                    unitCountButtonVerticalPercent(
                        title: "250Gハズレ",
                        count: $sevenSwords.g250CountNoHit,
                        color: .personalSummerLightBlue,
                        bigNumber: $sevenSwords.g250CountSum,
                        numberofDicimal: 0,
                        minusBool: $sevenSwords.minusCheck
                    )
                    // 250G当選
                    unitCountButtonVerticalPercent(
                        title: "250G当選",
                        count: $sevenSwords.g250CountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $sevenSwords.g250CountSum,
                        numberofDicimal: 0,
                        minusBool: $sevenSwords.minusCheck
                    )
                }
                // 参考情報リンク
                unitLinkButton(
                    title: "規定ゲーム数での当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定ゲーム数での当選",
                            textBody1: "・規定ゲーム数到達時にボーナス当選の可能性あり",
                            textBody2: "・規定ゲーム数は100/250/450/650/1000",
                            textBody3: "・250Gでのボーナス当選に設定差があるらしい",
                            textBody4: "・独自集計で250〜290Gでの当選は25％。これを超えてくるのが高設定の目安かも。\n※あくまで独自集計値なので参考程度",
                            image1: Image("sevenSwords250HitRatio")
                        )
                    )
                )
            } header: {
                Text("規定G数 250での当選")
            }
            
            // //// 初当りデータ入力
            Section {
                Text("e-slot+の数値を入力してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // 通常ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "通常遊技ゲーム数",
                    inputValue: $sevenSwords.inputNormalGame,
                    unitText: "Ｇ"
                )
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
                // プロローグBONUS
                unitTextFieldNumberInputWithUnit(
                    title: "プロローグBONUS",
                    inputValue: $sevenSwords.inputBonusCountProloge
                )
                .focused($isFocused)
                // キンバリーBONUS
                unitTextFieldNumberInputWithUnit(
                    title: "キンバリーBONUS",
                    inputValue: $sevenSwords.inputBonusCountKimbary
                )
                .focused($isFocused)
                // ST発動回数
                unitTextFieldNumberInputWithUnit(
                    title: "Seven Spellblades Battle発動回数",
                    inputValue: $sevenSwords.inputStCount
                )
                .focused($isFocused)
                // 初当り確率
                HStack {
                    // ボーナス合算確率
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $sevenSwords.inputBonusCountSum,
                        bigNumber: $sevenSwords.inputNormalGame,
                        numberofDicimal: 0
                    )
                    // ST
                    unitResultRatioDenomination2Line(
                        title: "ST",
                        count: $sevenSwords.inputStCount,
                        bigNumber: $sevenSwords.inputNormalGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            textBody1: "・e-slot+ではST確率が総ゲーム数から算出されていますが、本アプリでは通常ゲーム数から算出しています。",
                            image1: Image("sevenSwordsHitRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(sevenSwordsView95Ci(selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り確率")
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
        .navigationTitle("ボーナス,ST 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sevenSwords.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sevenSwords.resetBonusSt)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sevenSwordsViewBonus()
}
