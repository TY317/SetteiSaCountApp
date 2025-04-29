//
//  shamanKingViewHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/27.
//

import SwiftUI

struct shamanKingViewHit: View {
//    @ObservedObject var shamanKing = ShamanKing()
    @ObservedObject var shamanKing: ShamanKing
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 150.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 150.0
    
    var body: some View {
        List {
            Section {
                Text("ユニメモの数値を入力してください")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // 通常ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "通常遊技数",
                    inputValue: $shamanKing.inputGame,
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
                // シャーマンボーナス回数
                unitTextFieldNumberInputWithUnit(
                    title: "ｼｬｰﾏﾝﾎﾞｰﾅｽ回数",
                    inputValue: $shamanKing.inputShamanBonusCount
                )
                .focused($isFocused)
                // エピソードボーナス回数
                unitTextFieldNumberInputWithUnit(
                    title: "ｴﾋﾟｿｰﾄﾞﾎﾞｰﾅｽ回数",
                    inputValue: $shamanKing.inputEpisodeBonusCount
                )
                .focused($isFocused)
                // シャーマンファイト回数
                unitTextFieldNumberInputWithUnit(
                    title: "ｼｬｰﾏﾝﾌｧｲﾄ回数",
                    inputValue: $shamanKing.inputShamanFightCount
                )
                .focused($isFocused)
                // 確率横並び
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $shamanKing.bonusCountSum,
                        bigNumber: $shamanKing.inputGame,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $shamanKing.inputShamanFightCount,
                        bigNumber: $shamanKing.inputGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(shamanKingTableFirstHit())
//                            image1: Image("shamanKingHit")
                        )
                    )
                )
                unitLinkButton(
                    title: "エピソードボーナス振り分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "エピソードボーナス振り分け",
                            textBody1: "・ボーナス当選時のエピソードへの振り分けに設定差あり",
                            textBody2: "・高設定ほどエピソード割合が優遇",
                            textBody3: "・確定役やボーナス準備中の昇格には設定差ないため、それ以外でのエピソード初当りが対象",
                            textBody4: "・複数回確認できれば高設定に期待",
                            tableView: AnyView(shamanKingTableEpisode())
//                            image1: Image("shamanKingEpisodeRatio")
                        )
                    )
                )
                unitLinkButton(
                    title: "リプレイ契機のAT直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "リプレイ契機のAT直撃",
                            textBody1: "・通常時のAT直撃に設定差あり",
                            textBody2: "・内部OS図柄揃い成立時の一部がAT直撃となる",
                            textBody3: "・通常時はOS揃いせずにリプレイ揃いとなるため、リプレイからの謎当り直撃となる",
                            tableView: AnyView(shamanKingDirectAt())
//                            image1: Image("shamanKingAtDirectHit")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(shamanKingView95Ci(shamanKing: shamanKing, selection: 5)))
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
        .navigationTitle("ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
//                    unitButtonMinusCheck(minusCheck: $sbj.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    shamanKingViewHit(shamanKing: ShamanKing())
}
