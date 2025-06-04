//
//  magiaViewKokakuStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/20.
//

import SwiftUI

struct magiaViewKokakuStart: View {
//    @ObservedObject var ver280 = Ver280()
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @State var selectedSegment: String = "ビッグ後"
    let segmentList: [String] = ["ビッグ後", "AT後"]
    
    var body: some View {
        List {
            Section {
                // //// セグメント選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                
                // //// カウントボタン
                // ビッグ後
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        // 通常スタート
                        unitCountButtonVerticalWithoutRatio(
                            title: "通常スタート",
                            count: $magia.kokakuStartAfterBonusCountNone,
                            color: .personalSummerLightBlue,
                            minusBool: $magia.minusCheck
                        )
                        // 高確スタート
                        unitCountButtonVerticalWithoutRatio(
                            title: "高確スタート",
                            count: $magia.kokakuStartAfterBonusCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $magia.minusCheck
                        )
                    }
                }
                // AT後
                else {
                    HStack {
                        // 通常スタート
                        unitCountButtonVerticalWithoutRatio(
                            title: "通常スタート",
                            count: $magia.kokakuStartAfterAtCountNone,
                            color: .blue,
                            minusBool: $magia.minusCheck
                        )
                        // 高確スタート
                        unitCountButtonVerticalWithoutRatio(
                            title: "高確スタート",
                            count: $magia.kokakuStartAfterAtCountHit,
                            color: .red,
                            minusBool: $magia.minusCheck
                        )
                    }
                }
                
                // //// 確率
                HStack {
                    // ビッグ後
                    unitResultRatioPercent2Line(
                        title: "ビッグ後",
                        count: $magia.kokakuStartAfterBonusCountHit,
                        bigNumber: $magia.kokakuStartAfterBonusCountSum,
                        numberofDicimal: 0
                    )
                    // AT後
                    unitResultRatioPercent2Line(
                        title: "AT後",
                        count: $magia.kokakuStartAfterAtCountHit,
                        bigNumber: $magia.kokakuStartAfterAtCountSum,
                        numberofDicimal: 0
                    )
                }
                
                // //// 参考情報）高確移行確率
                unitLinkButton(
                    title: "高確スタートについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "高確スタート",
                            textBody1: "・ビッグ終了後、AT終了後（含む 設定変更）に高確移行を抽選",
                            textBody2: "・高確当選時は10,20,30Gのいずれかに振り分けられる",
                            textBody3: "・高確を完全に見抜くことは難しいと思われるが、参考として予測しながらのカウントを推奨",
                            tableView: AnyView(magiaTableKokakuStart(magia: magia))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(magiaView95Ci(magia: magia, selection: 4)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver280.magiaKokakuStartBadgeStatus != "none" {
//                ver280.magiaKokakuStartBadgeStatus = "none"
//            }
//        }
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
        .navigationTitle("ビッグ,AT後の高確スタート")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetKokakuStart)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewKokakuStart(magia: Magia())
}
