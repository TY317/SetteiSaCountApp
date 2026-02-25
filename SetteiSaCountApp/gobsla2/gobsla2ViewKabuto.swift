//
//  gobsla2ViewKabuto.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/24.
//

import SwiftUI

struct gobsla2ViewKabuto: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
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
    
    @State var selectedItem: String = "10pt"
    let selectList: [String] = [
        "10pt",
        "20pt",
        "30pt",
        "40pt",
        "50pt",
        "60pt",
        "70pt",
        "80pt",
        "90pt",
        "100pt",
    ]
    var body: some View {
        List {
            // 規定兜ポイント
            Section {
                // サークルピッカー
                unitPickerMenuString(
                    title: "規定pt",
                    selected: self.$selectedItem,
                    selectlist: self.selectList
                )
                
                // 登録ボタン
                unitCountSubmitButton(
                    count: bindingInt(pt: self.selectedItem),
                    minusCheck: $gobsla2.minusCheck) {
                        gobsla2.ptSumFunc()
                    } flushAction: {
                        vibeSelect()
                    }
                
            } header: {
                Text("規定兜pt")
            }
            
            // カウント結果
            Section {
                // 20pt以下、40pt以上の確率
                HStack {
                    // 20pt以下
                    unitResultRatioPercent2Line(
                        title: "20pt以下",
                        count: $gobsla2.ptCountU20,
                        bigNumber: $gobsla2.ptCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 40pt以下
                    unitResultRatioPercent2Line(
                        title: "40pt以下",
                        count: $gobsla2.ptCountO40,
                        bigNumber: $gobsla2.ptCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: item,
                        count: bindingInt(pt: item),
                        flashColor: flushColorResult(item: item),
                        bigNumber: $gobsla2.ptCountSum,
                        numberofDigit: 0,
                    )
                }
                
                // 参考情報）規定兜pt振分け
                unitLinkButtonViewBuilder(sheetTitle: "規定兜pt振分け") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・高設定ほど20pt以下の振り分けが優遇")
                            Text("・30ptはほぼ設定差なし")
                        }
                            .padding(.bottom)
                        Text("[20pt以下、40pt以上の割合]")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "20pt以下",
                                percentList: gobsla2.ratioPtU20,
                                numberofDicimal: 0,
                            )
                            unitTablePercent(
                                columTitle: "40pt以上",
                                percentList: gobsla2.ratioPtO40,
                                numberofDicimal: 0,
                            )
                        }
                        .padding(.bottom)
                        Text("[振分け詳細]")
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "10pt",
                                percentList: gobsla2.ratioPt10,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "20pt",
                                percentList: gobsla2.ratioPt20,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "30pt",
                                percentList: gobsla2.ratioPt30,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "40pt",
                                percentList: gobsla2.ratioPt40,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "50pt",
                                percentList: gobsla2.ratioPt50,
                                numberofDicimal: 1,
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "60pt",
                                percentList: gobsla2.ratioPt60,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "70pt",
                                percentList: gobsla2.ratioPt70,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "80pt",
                                percentList: gobsla2.ratioPt80,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "90pt",
                                percentList: gobsla2.ratioPt90,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "100pt",
                                percentList: gobsla2.ratioPt100,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        gobsla2View95Ci(
                            gobsla2: gobsla2,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    gobsla2ViewBayes(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("兜ptカウント結果")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MenuKabutoBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("兜pt")
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
                unitButtonMinusCheck(minusCheck: $gobsla2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: gobsla2.resetKabuto)
            }
        }
    }
    
    private func bindingInt(pt: String) -> Binding<Int> {
        switch pt {
        case self.selectList[1]: return $gobsla2.ptCount20
        case self.selectList[2]: return $gobsla2.ptCount30
        case self.selectList[3]: return $gobsla2.ptCount40
        case self.selectList[4]: return $gobsla2.ptCount50
        case self.selectList[5]: return $gobsla2.ptCount60
        case self.selectList[6]: return $gobsla2.ptCount70
        case self.selectList[7]: return $gobsla2.ptCount80
        case self.selectList[8]: return $gobsla2.ptCount90
        case self.selectList[9]: return $gobsla2.ptCount100
        default: return $gobsla2.ptCount10
        }
    }
    
    private func notBindingInt(pt: String) -> Int {
        switch pt {
        case self.selectList[1]: return gobsla2.ptCount20
        case self.selectList[2]: return gobsla2.ptCount30
        case self.selectList[3]: return gobsla2.ptCount40
        case self.selectList[4]: return gobsla2.ptCount50
        case self.selectList[5]: return gobsla2.ptCount60
        case self.selectList[6]: return gobsla2.ptCount70
        case self.selectList[7]: return gobsla2.ptCount80
        case self.selectList[8]: return gobsla2.ptCount90
        case self.selectList[9]: return gobsla2.ptCount100
        default: return gobsla2.ptCount10
        }
    }
    
    private func vibeSelect() {
        if notBindingInt(pt: self.selectedItem) > 0 {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
    
    private func flushColorResult(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.red
        case self.selectList[1]: return Color.purple
        case self.selectList[2]: return Color.gray
        case self.selectList[3]: return Color.blue
        case self.selectList[4]: return Color.yellow
        case self.selectList[5]: return Color.green
        case self.selectList[6]: return Color.cyan
        case self.selectList[7]: return Color.orange
        case self.selectList[8]: return Color.brown
        default: return Color.gray
        }
    }
}

#Preview {
    gobsla2ViewKabuto(
        gobsla2: Gobsla2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
