//
//  shamanKingViewCzFuriwake.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct shamanKingViewCzFuriwake: View {
//    @ObservedObject var ver270 = Ver270()
//    @ObservedObject var shamanKing = ShamanKing()
    @ObservedObject var shamanKing: ShamanKing
    @State var isShowAlert = false
    let selectListPt: [String] = [
        "0〜595Pt",
        "600〜1000Pt"
    ]
    @State var selectedPt: String = "0〜595Pt"
    var body: some View {
        List {
            // //// CZ振分けカウント
            Section {
                // //// 憑依ポイント
                Picker("", selection: self.$selectedPt) {
                    ForEach(self.selectListPt, id: \.self) { pt in
                        Text(pt)
                    }
                }
                .pickerStyle(.segmented)
                VStack {
                    Text("道蓮,潤,竜之介は憑依合体バトルのキャラ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("たまお は上位CZのコックリさん占いをカウント")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // //// カウントボタン横並び
                // 0-565Pt
                if self.selectedPt == self.selectListPt[0] {
                    HStack {
                        // 道蓮
                        unitCountButtonVerticalPercent(
                            title: "道蓮",
                            count: $shamanKing.czCountUnder600Ren,
                            color: .personalSummerLightBlue,
                            bigNumber: $shamanKing.czCountUnder600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 道潤
                        unitCountButtonVerticalPercent(
                            title: "道潤",
                            count: $shamanKing.czCountUnder600Jun,
                            color: .personalSpringLightYellow,
                            bigNumber: $shamanKing.czCountUnder600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 竜之介
                        unitCountButtonVerticalPercent(
                            title: "竜之介",
                            count: $shamanKing.czCountUnder600Ryunosuke,
                            color: .personalSummerLightGreen,
                            bigNumber: $shamanKing.czCountUnder600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // コックリ
                        unitCountButtonVerticalPercent(
                            title: "たまお",
                            count: $shamanKing.czCountUnder600Kokkuri,
                            color: .personalSummerLightRed,
                            bigNumber: $shamanKing.czCountUnder600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // //// 600-1000Pt
                else {
                    HStack {
                        // 道蓮
                        unitCountButtonVerticalPercent(
                            title: "道蓮",
                            count: $shamanKing.czCountOver600Ren,
                            color: .blue,
                            bigNumber: $shamanKing.czCountOver600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 道潤
                        unitCountButtonVerticalPercent(
                            title: "道潤",
                            count: $shamanKing.czCountOver600Jun,
                            color: .yellow,
                            bigNumber: $shamanKing.czCountOver600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // 竜之介
                        unitCountButtonVerticalPercent(
                            title: "竜之介",
                            count: $shamanKing.czCountOver600Ryunosuke,
                            color: .green,
                            bigNumber: $shamanKing.czCountOver600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                        // コックリ
                        unitCountButtonVerticalPercent(
                            title: "たまお",
                            count: $shamanKing.czCountOver600Kokkuri,
                            color: .red,
                            bigNumber: $shamanKing.czCountOver600Sum,
                            numberofDicimal: 0,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // //// 参考情報）振分け
                unitLinkButton(
                    title: "CZ当選時の種別振り分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "CZ当選時の種別振り分け",
                            textBody1: "・前兆移行してCZ当選した場合は憑依ポイントに応じて振り分け抽選",
                            textBody2: "・高設定ほど期待度の高い種別の振り分けが優遇",
                            textBody3: "・道蓮,潤,竜之介は憑依合体バトルのキャラ。たまお は上位CZのコックリさん占いを指す",
                            tableView: AnyView(shamanKingTableCzFuriwake(shamanKing: shamanKing))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(shamanKingView95Ci(shamanKing: shamanKing, selection: 9)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("前兆移行時の憑依ポイント別カウント")
            }
        }
//        .onAppear {
//            if ver270.shamanKingMenuCzFuriwakeBadgeStatus != "none" {
//                ver270.shamanKingMenuCzFuriwakeBadgeStatus = "none"
//            }
//        }
        .navigationTitle("CZ当選時の振分け")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $shamanKing.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetCzFuriwake)
                }
            }
        }
    }
}

#Preview {
    shamanKingViewCzFuriwake(shamanKing: ShamanKing())
}
