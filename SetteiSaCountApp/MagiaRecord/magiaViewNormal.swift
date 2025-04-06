//
//  magiaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewNormal: View {
    @ObservedObject var magia = Magia()
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            // //// 小役確率
            Section {
                Text("現在値はユニメモで確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 参考情報）小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("magiaKoyaku")
                        )
                    )
                )
                // //// 参考情報）弱チェリー確率
                unitLinkButton(
                    title: "弱🍒確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱🍒確率",
                            tableView: AnyView(magiaTableJakuCherry())
                        )
                    )
                )
            } header: {
                Text("小役確率")
            }
            
            // //// スイカからのCZ当選
            Section {
                // //// カウントボタン横並び
                HStack {
                    // スイカ
                    unitCountButtonVerticalWithoutRatio(
                        title: "スイカ",
                        count: $magia.suikaCzCountSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $magia.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ",
                        count: $magia.suikaCzCountCz,
                        color: .personalSummerLightRed,
                        minusBool: $magia.minusCheck
                    )
                    // 当選率
                    unitResultRatioPercent2Line(
                        title: "当選率",
                        count: $magia.suikaCzCountCz,
                        bigNumber: $magia.suikaCzCountSuika,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
                // //// 参考情報）スイカからのCZ
                unitLinkButton(
                    title: "スイカからのCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "スイカからのCZ",
                            textBody1: "・通常時スイカからのCZ マギアチャレンジ当選に設定差あり",
                            tableView: AnyView(magiaTableSuikaCz())
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(magiaView95Ci(selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("スイカからのCZ当選")
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
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetNormal)
                }
            }
        }
    }
}

#Preview {
    magiaViewNormal()
}
