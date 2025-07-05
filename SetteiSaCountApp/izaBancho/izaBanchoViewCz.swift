//
//  izaBanchoViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/04.
//

import SwiftUI

struct izaBanchoViewCz: View {
    @ObservedObject var ver350: Ver350
    @ObservedObject var izaBancho: IzaBancho
    let selectListSegment: [String] = ["青","黄"]
    @State var selectedSegment: String = "青"
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 2
    let lazyVGridCountLandscape: Int = 4
    @State var lazyVGridCount: Int = 2
    
    var body: some View {
        List {
            // //// エフェクト色ごとの当選
            Section {
                // 色の選択セグメント
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.selectListSegment, id: \.self) { effectColor in
                        Text(effectColor)
                    }
                }
                .pickerStyle(.segmented)
                // //// カウントボタン
                // 青
                if self.selectedSegment == self.selectListSegment[0] {
                    HStack {
                        // 非当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $izaBancho.czResultCountBlueMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $izaBancho.minusCheck,
                            action: izaBancho.czResultCountSumFunc
                        )
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "成功",
                            count: $izaBancho.czResultCountBlueHit,
                            color: .blue,
                            minusBool: $izaBancho.minusCheck,
                            action: izaBancho.czResultCountSumFunc
                        )
                    }
                }
                // 黄
                else {
                    HStack {
                        // 非当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "失敗",
                            count: $izaBancho.czResultCountYellowMiss,
                            color: .personalSpringLightYellow,
                            minusBool: $izaBancho.minusCheck,
                            action: izaBancho.czResultCountSumFunc
                        )
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "成功",
                            count: $izaBancho.czResultCountYellowHit,
                            color: .yellow,
                            minusBool: $izaBancho.minusCheck,
                            action: izaBancho.czResultCountSumFunc
                        )
                    }
                }
                
                // //// 確率結果
                HStack {
                    // 青
                    unitResultRatioPercent2Line(
                        title: "青",
                        count: $izaBancho.czResultCountBlueHit,
                        bigNumber: $izaBancho.czResultCountBlueSum,
                        numberofDicimal: 1
                    )
                    // 黄
                    unitResultRatioPercent2Line(
                        title: "黄",
                        count: $izaBancho.czResultCountYellowHit,
                        bigNumber: $izaBancho.czResultCountYellowSum,
                        numberofDicimal: 1
                    )
                }
                
                // //// 参考情報）エフェクト色ごとの当選率
                unitLinkButton(
                    title: "エフェクト色ごとの当選率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "エフェクト色ごとの当選率",
                            textBody1: "・最終エフェクト色が青・黄の場合に設定差あり",
                            tableView: AnyView(izaBanchoTableCzEffect(izaBancho: izaBancho))
                        )
                    )
                )
                
                // //// 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        izaBanchoView95Ci(
                            izaBancho: izaBancho,
                            selection: 2,
                        )
                    )
                )
            } header: {
                Text("エフェクト色ごとの当選率")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.izaBanchoMenuCzBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
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
        .navigationTitle("刺客ゾーン")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $izaBancho.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: izaBancho.resetCz)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    izaBanchoViewCz(
        ver350: Ver350(),
        izaBancho: IzaBancho()
    )
}
