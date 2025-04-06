//
//  kaijiViewMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct kaijiViewMode: View {
    @ObservedObject var ver270 = Ver270()
    var body: some View {
        List {
            Section {
                VStack {
                    Text("・4種類のモードで規定G数を管理")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・規定G数到達時にCZ濃厚のざわ高確に当選")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: ["モードA", "モードB", "モードC", "モードD"],
                        lineList: [1,1,1,2]
                    )
                    unitTableString(
                        columTitle: "規定G数",
                        stringList: ["650G","450G","250G","250G,450G,\n650G 全て"],
                        lineList: [1,1,1,2]
                    )
                }
                Text("高設定ほどモードB以上への移行率が優遇")
                    .fontWeight(.bold)
//                VStack {
//                    Text("[モード推測のポイント]")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("CZ濃厚前兆と推測できる要素を知ること")
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .fontWeight(.bold)
//                }
            } header: {
                Text("モードの基本情報")
            }
            
            Section {
                // //// 特殊ステチェン
                unitLinkButton(
                    title: "特殊ステチェン出現頻度",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "特殊ステチェン出現頻度",
                            tableView: AnyView(kaijiTableModeStageChange())
                        )
                    )
                )
                // //// 会話演出の応答
                unitLinkButton(
                    title: "会話演出の応答",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "会話演出の応答",
                            textBody1: "・出れば出るほど、一番近い規定G数ゾーンでのCZ濃厚前兆示唆",
                            textBody2: "・ループ状態抜け初回の会話演出応答有りのパターンでは青文字が出現しやすい\n　青文字が出現した場合はモードC以上が濃厚"
                        )
                    )
                )
                // //// サブ液晶のG数色表示
                unitLinkButton(
                    title: "サブ液晶のG数色表示",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "サブ液晶のG数色表示",
                            textBody1: "・250、450、650G到達時にG数表示が赤文字に変化でCZ濃厚前兆"
                        )
                    )
                )
            } header: {
                Text("推測要素１）通常時の演出")
            }
            
            // //// 推測要素2
            Section {
                // //// 滞在G数
                unitLinkButton(
                    title: "ざわ高確滞在G数が異様に長い",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ざわ高確滞在G数が異様に長い",
                            textBody1: "・契機役を引いて抽選に受かることで初めて閃き前兆に移行できるので、契機役を引けないと長く滞在することになる",
                            textBody2: "・やけに長く滞在した場合はCZ濃厚前兆をとっている可能性あり"
                        )
                    )
                )
                // //// リプレイのざわ変換
                unitLinkButton(
                    title: "リプレイが若干ざわに変換されやすい",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "リプレイのざわ変換",
                            textBody1: "・CZ濃厚前兆のざわ高確は約50％でリプレイがざわ揃いに変換される"
                        )
                    )
                )
            } header: {
                Text("推測要素２）ざわ高確中の挙動")
            }
        }
        .onAppear {
            if ver270.kaijiMenuModeBadgeStatus != "none" {
                ver270.kaijiMenuModeBadgeStatus = "none"
            }
        }
        .navigationTitle("モード推測")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kaijiViewMode()
}
