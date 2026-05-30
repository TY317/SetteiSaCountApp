//
//  kokakukidotaiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/13.
//

import SwiftUI

struct kokakukidotaiViewNormal: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    let itemList: [String] = ["青", "緑",]
    @State var selectedItem: String = "青"
    
    var body: some View {
        List {
            // タチコマの家出
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・AT終了時200or400Gでの当否がカウント対象")
                        Text("・リセット時、CZ終了時の200or400Gは対象外")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // カウントボタン横並び
                HStack {
                    // ハズレ
                    unitCountButtonPercentWithFunc(
                        title: "ハズレ",
                        count: $kokakukidotai.iedeCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $kokakukidotai.iedeCountSum,
                        numberofDicimal: 0,
                        minusBool: $kokakukidotai.minusCheck) {
                            kokakukidotai.iedeSumFunc()
                        }
                    // 当選
                    unitCountButtonPercentWithFunc(
                        title: "当選",
                        count: $kokakukidotai.iedeCountSuccess,
                        color: .personalSummerLightRed,
                        bigNumber: $kokakukidotai.iedeCountSum,
                        numberofDicimal: 0,
                        minusBool: $kokakukidotai.minusCheck) {
                            kokakukidotai.iedeSumFunc()
                        }
                }
                
                // 参考情報）200or400GでのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "200or400GでのCZ期待度") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・AT終了時の200or400G時にタチコマの家出を抽選")
                            Text("・CZ合算の期待度に設定")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "合算期待度",
                                percentList: kokakukidotai.ratioIede
                            )
                        }
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kokakukidotaiView95Ci(
                            kokakukidotai: kokakukidotai,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kokakukidotaiViewBayes(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("AT終了時200or400GでのCZ当選")
            }
            
            // ---- 発展色ごとの成功率
            Section {
                // 確率結果
                HStack {
                    // 青
                    unitResultRatioPercent2Line(
                        title: "青",
                        count: $kokakukidotai.czColorCountBlueHit,
                        bigNumber: $kokakukidotai.czColorCountBlueSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    
                    // 緑
                    unitResultRatioPercent2Line(
                        title: "緑",
                        count: $kokakukidotai.czColorCountGreenHit,
                        bigNumber: $kokakukidotai.czColorCountGreenSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）発展色ごとの
                unitLinkButtonViewBuilder(sheetTitle: "発展色ごとのCZ以上当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "青",
                            percentList: kokakukidotai.ratioCzColorBlue,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "緑",
                            percentList: kokakukidotai.ratioCzColorGreen,
//                            numberofDicimal: 1,
                        )
                    }
                }
                .popoverTip(tipVer3270KokakukidotaiCz())
                
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.itemList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // 青
                        if self.selectedItem == self.itemList[0] {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kokakukidotai.czColorCountBlueMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                            // CZ以上当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ以上当選",
                                count: $kokakukidotai.czColorCountBlueHit,
                                color: .blue,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                        }
                        // 緑
                        else {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kokakukidotai.czColorCountGreenMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                            // CZ以上当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ以上当選",
                                count: $kokakukidotai.czColorCountGreenHit,
                                color: .green,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kokakukidotaiView95Ci(
                                kokakukidotai: kokakukidotai,
                                selection: 6,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kokakukidotaiViewBayes(
                            kokakukidotai: kokakukidotai,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("殲滅ゾーン 発展色ごとの成功率")
            }
            
            
            // レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    kokakukidotaiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            // モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "モードについて") {
                    kokakukidotaiTableMode()
                }
                unitLinkButtonViewBuilder(sheetTitle: "リプレイフラッシュでの示唆") {
                    kokakukidotaiTableReplayFlush()
                }
//                .popoverTip(tipVer3190KokakukidotaiModeSisa())
                unitLinkButtonViewBuilder(sheetTitle: "アイキャッチでの示唆") {
                    kokakukidotaiTableEyechatch()
                }
            } header: {
                Text("通常時のモード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kokakukidotaiViewNormal(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
