//
//  kaijiViewHirameki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiViewHirameki: View {
//    @ObservedObject var ver260 = Ver260()
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var isShowAlert = false
    @State var selectedColor: String = "青"
    let colorList: [String] = [
        "青",
        "黄",
        "緑",
        "赤"
    ]
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
            Section {
                Text("ジャッジ発展時の色ごとに失敗・成功回数をカウント")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 色選択
                Picker("", selection: self.$selectedColor) {
                    ForEach(self.colorList, id: \.self) { effectColor in
                        Text(effectColor)
                    }
                }
                .pickerStyle(.segmented)
                // //// 色ごとのカウントボタン
                // 青
                if self.selectedColor == self.colorList[0] {
                    HStack {
                        unitCountButtonVerticalWithoutRatio(
                            title: "失敗",
                            count: $kaiji.hiramekiCountBlueMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $kaiji.minusCheck
                        )
                        unitCountButtonVerticalWithoutRatio(
                            title: "成功",
                            count: $kaiji.hiramekiCountBlueSuccess,
                            color: .blue,
                            minusBool: $kaiji.minusCheck
                        )
                    }
                }
                // 黄色
                else if self.selectedColor == self.colorList[1] {
                    HStack {
                        unitCountButtonVerticalWithoutRatio(
                            title: "失敗",
                            count: $kaiji.hiramekiCountYellowMiss,
                            color: .personalSpringLightYellow,
                            minusBool: $kaiji.minusCheck
                        )
                        unitCountButtonVerticalWithoutRatio(
                            title: "成功",
                            count: $kaiji.hiramekiCountYellowSuccess,
                            color: .yellow,
                            minusBool: $kaiji.minusCheck
                        )
                    }
                }
                // 緑
                else if self.selectedColor == self.colorList[2] {
                    HStack {
                        unitCountButtonVerticalWithoutRatio(
                            title: "失敗",
                            count: $kaiji.hiramekiCountGreenMiss,
                            color: .personalSummerLightGreen,
                            minusBool: $kaiji.minusCheck
                        )
                        unitCountButtonVerticalWithoutRatio(
                            title: "成功",
                            count: $kaiji.hiramekiCountGreenSuccess,
                            color: .green,
                            minusBool: $kaiji.minusCheck
                        )
                    }
                }
                // 赤
                else {
                    HStack {
                        unitCountButtonVerticalWithoutRatio(
                            title: "失敗",
                            count: $kaiji.hiramekiCountRedMiss,
                            color: .personalSummerLightRed,
                            minusBool: $kaiji.minusCheck
                        )
                        unitCountButtonVerticalWithoutRatio(
                            title: "成功",
                            count: $kaiji.hiramekiCountRedSuccess,
                            color: .red,
                            minusBool: $kaiji.minusCheck
                        )
                    }
                }
                // //// 成功率横並び
                HStack(spacing:3) {
                    // 青
                    unitResultRatioPercent2Line(
                        title: "青",
                        count: $kaiji.hiramekiCountBlueSuccess,
                        bigNumber: $kaiji.hiramekiCountBlueSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 黄色
                    unitResultRatioPercent2Line(
                        title: "黄",
                        count: $kaiji.hiramekiCountYellowSuccess,
                        bigNumber: $kaiji.hiramekiCountYellowSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 緑
                    unitResultRatioPercent2Line(
                        title: "緑",
                        count: $kaiji.hiramekiCountGreenSuccess,
                        bigNumber: $kaiji.hiramekiCountGreenSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 赤
                    unitResultRatioPercent2Line(
                        title: "赤",
                        count: $kaiji.hiramekiCountRedSuccess,
                        bigNumber: $kaiji.hiramekiCountRedSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報）色ごとの成功率について
                unitLinkButton(
                    title: "色ごとの成功率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "色ごとの成功率",
                            textBody1: "・閃き前兆開始時にCZ突入抽選をしており、高設定ほど優遇",
                            textBody2: "・自力でのCZ当選もあるため、実際は下記数値よりも高い成功率となるはず",
                            tableView: AnyView(kaijiTableHirameki(kaiji: kaiji))
                        )
                    )
                )
                // //// 参考情報）トネガワラッシュ直撃について
                unitLinkButton(
                    title: "トネガワラッシュ直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "トネガワラッシュ直撃",
                            textBody1: "・閃き前兆移行時にトネガワラッシュ直撃抽選が行われる",
                            textBody2: "・当選率は高設定ほど優遇",
                            tableView: AnyView(kaijiTableHiramekiTonegawa())
                        )
                    )
                )
//                .popoverTip(tipVer260KaijiHiramekiTonegawa())
            } header: {
                Text("色ごとの成功率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
//        .onAppear {
//            if ver260.kaijiMenuHiramekiBadgeStatus != "none" {
//                ver260.kaijiMenuHiramekiBadgeStatus = "none"
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
        .navigationTitle("閃き前兆")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetHirameki)
                }
            }
        }
    }
}

#Preview {
    kaijiViewHirameki(kaiji: Kaiji())
}
