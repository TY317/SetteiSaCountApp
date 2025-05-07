//
//  arifureViewPremiumAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/17.
//

import SwiftUI

struct arifureViewPremiumAt: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
//    @ObservedObject var ver250 = Ver250()
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
            // //// 上位AT初当り
            Section {
                unitLinkButton(
                    title: "上位AT初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "上位AT初当り",
                            tableView: AnyView(arifureSubViewTablePremiumAtHit(arifure: arifure))
                        )
                    )
                )
            } header: {
                Text("上位AT初当り")
            }
            
            // //// 覚醒チャレンジ成功率
            Section {
                unitLinkButton(
                    title: "覚醒チャレンジ成功期待度",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "覚醒チャレンジ成功期待度",
                            textBody1: "・チャレンジ成功率に設定差あり",
                            textBody2: "・最終ゲーム小役成立時は成功濃厚なので注意。ハズレでの成功に着目",
                            tableView: AnyView(arifureSubViewTableKakuseiSuccess(arifure: arifure))
                        )
                    )
                )
            } header: {
                Text("覚醒チャレンジ")
            }
            
            // //// ビッグトリガーアタック
            Section {
                Text("1G目以外でのレア役成立時は継続確定となるため、継続ゲーム数から除外を推奨")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// カウントボタン横並び
                HStack {
                    // 2G
                    unitCountButtonVerticalPercent(
                        title: "2G",
                        count: $arifure.btaGameCount2G,
                        color: .personalSummerLightBlue,
                        bigNumber: $arifure.btaGameCountSum,
                        numberofDicimal: 0,
                        minusBool: $arifure.minusCheck
                    )
                    // 3G
                    unitCountButtonVerticalPercent(
                        title: "3G",
                        count: $arifure.btaGameCount3G,
                        color: .personalSummerLightGreen,
                        bigNumber: $arifure.btaGameCountSum,
                        numberofDicimal: 0,
                        minusBool: $arifure.minusCheck
                    )
                    // 4G以上
                    unitCountButtonVerticalPercent(
                        title: "4G以上",
                        count: $arifure.btaGameCount4GOver,
                        color: .personalSummerLightRed,
                        bigNumber: $arifure.btaGameCountSum,
                        numberofDicimal: 0,
                        minusBool: $arifure.minusCheck
                    )
                }
                // //// 参考情報）継続G数について
                unitLinkButton(
                    title: "継続G数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "継続G数について",
                            textBody1: "・保証G数は2G",
                            textBody2: "・2G以降は継続抽選で決定\n　2G以降のレア役成立時はその時点で継続濃厚",
                            textBody3: "・継続率は3段階あり、高設定ほど高継続率が選ばれやすい",
                            textBody4: "・継続率は見抜けないため、実質の継続G数カウントを推奨\n　100万回シミュレートでの実質継続G数は下記を参照",
                            tableView: AnyView(arifureSubViewTableBta(arifure: arifure))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 10)))
                    .popoverTip(tipUnitButtonLink95Ci())
                unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
            } header: {
                Text("ビッグトリガーアタック継続G数")
            }
        }
//        .onAppear {
//            if ver250.arifureMenuPremiumBadgeStatus != "none" {
//                ver250.arifureMenuPremiumBadgeStatus = "none"
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
        .navigationTitle("上位AT関連")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetPremium)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewPremiumAt(arifure: Arifure())
}
