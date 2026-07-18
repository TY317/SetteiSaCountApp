//
//  godKisekiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewNormal: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
    
//    let items: [String] = ["リプ 3連", "黄7 3連"]
    let items: [String] = ["リプ 3連", "リプ 4連"]
    @State var selectedItem: String = "リプ 3連"
    var body: some View {
        List {
            // ベル
            Section {
                // 確率結果
                HStack {
                    // 下段
                    unitResultRatioDenomination2Line(
                        title: "下段🔔",
                        count: $godKiseki.bellCountGedan,
                        bigNumber: $godKiseki.bellGame,
                        numberofDicimal: 1
                    )
                    // 押し順
                    unitResultRatioDenomination2Line(
                        title: "押し順🔔",
                        count: $godKiseki.bellCountOshijun,
                        bigNumber: $godKiseki.bellGame,
                        numberofDicimal: 0
                    )
                }
                .popoverTip(tipVer412GodKisekiBell())
                
                // カウント
                DisclosureGroup {
                    // ゲーム数入力
                    unitTextFieldNumberInputWithUnit(
                        title: "ゲーム数",
                        inputValue: $godKiseki.bellGame,
                        unitText: "Ｇ",
                    )
                    .focused(self.$isFocused)
                    
                    // カウントボタン横並び
                    HStack {
                        // 下段
                        unitCountButtonWithoutRatioWithFunc(
                            title: "下段🔔",
                            count: $godKiseki.bellCountGedan,
                            color: .personalSpringLightYellow,
                            minusBool: $godKiseki.minusCheck) {
                                
                            }
                        // 押し順
                        unitCountButtonWithoutRatioWithFunc(
                            title: "押し順🔔",
                            count: $godKiseki.bellCountOshijun,
                            color: .yellow,
                            minusBool: $godKiseki.minusCheck) {
                                
                            }
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            }
            
            // 小役3連
            Section {
                // 確率結果
                HStack {
                    // リプ3連
                    unitResultRatioPercent2Line(
                        title: "リプ 3連",
                        count: $godKiseki.ren3CountBlueHit,
                        bigNumber: $godKiseki.ren3CountBlue,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // リプ4連
                    unitResultRatioPercent2Line(
                        title: "リプ 4連",
                        count: $godKiseki.ren4CountBlueHit,
                        bigNumber: $godKiseki.ren4CountBlue,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）小役連での当選率
                unitLinkButtonViewBuilder(
                    sheetTitle: "小役連での当選率") {
                        godKisekiTableKoyakuRen(godKiseki: godKiseki)
                    }
                
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // リプ3連
                        if self.selectedItem == self.items[0] {
                            // リプ3連
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リプ 3連",
                                count: $godKiseki.ren3CountBlue,
                                color: .personalSummerLightBlue,
                                minusBool: $godKiseki.minusCheck) {
                                    
                                }
                            // 当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選",
                                count: $godKiseki.ren3CountBlueHit,
                                color: .blue,
                                minusBool: $godKiseki.minusCheck) {
                                    
                                }
                        }
                        // リプ 4連
                        else {
                            // リプ 4連
                            unitCountButtonWithoutRatioWithFunc(
                                title: "リプ 4連",
                                count: $godKiseki.ren4CountBlue,
                                color: .personalSummerLightPurple,
                                minusBool: $godKiseki.minusCheck) {
                                    
                                }
                            // 当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "当選",
                                count: $godKiseki.ren4CountBlueHit,
                                color: .purple,
                                minusBool: $godKiseki.minusCheck) {
                                    
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            godKisekiView95Ci(
                                godKiseki: godKiseki,
                                selection: 2,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
//                        unitNaviLinkBayes {
//                            godKisekiViewBayes(
//                                godKiseki: godKiseki,
//                                bayes: bayes,
//                                viewModel: viewModel,
//                            )
//                        }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("小役連")
            }
            // 小役関連
            Section {
                // 小役停止形
                unitLinkButtonViewBuilder(sheetTitle: "小役停止形") {
                    godKisekiKoyakuPattern()
                }
                // 参考情報）小役からのGG当選率
                unitLinkButtonViewBuilder(sheetTitle: "小役からのGG当選率") {
                    godKisekiTableKoyakuHit()
                }
//                .popoverTip(tipVer3270GodKisekiKoyakuHit())
            } header: {
                Text("小役")
            }
            
            // モード
            Section {
                // モード概要
                unitLinkButtonViewBuilder(sheetTitle: "モード概要") {
                    godKisekiTableModeGaiyo()
                }
                
                // モード示唆
                HStack {
                    Spacer()
                    Button {
                        self.isShowDestination.toggle()
                    } label: {
                        Text(">> モード示唆")
                    }
                    .sheet(
                        isPresented: self.$isShowDestination
                    ) {
                        godKisekiNaviModeSisa(isPresented: self.$isShowDestination)
                            .presentationDetents([.large])
                    }
                }
            } header: {
                Text("モード")
            }
            
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $godKiseki.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: godKiseki.resetNormal)
            }
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
    }
}

#Preview {
    godKisekiViewNormal(
        godKiseki: GodKiseki(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
