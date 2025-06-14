//
//  izaBanchoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewNormal: View {
    @ObservedObject var ver340: Ver340
    @ObservedObject var izaBancho: IzaBancho
    var body: some View {
        List {
            // //// 小役関連
            Section {
                Text("現在値はダイトモで確認して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(izaBanchoTableKoyakuStyle())
                        )
                    )
                )
                // 共通ベルA確率について
                unitLinkButton(
//                    title: "共通ベルA確率について",
                    // //// ver3.4.0で更新
                    title: "設定差のある小役について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "設定差のある小役",
                            textBody1: "・共通ベルAと弱🍒に設定差あり",
                            textBody2: "・共通ベルAはナビなし時に上段に揃うベル",
                            textBody3: "・ナビあり時などは上段揃いではないため、自力でのカウントは難しいが、ダイトモで現在値確認できる",
                            tableView: AnyView(
                                izaBanchoTableCommonBellA(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
                .popoverTip(tipVer340IzaBanchoKorakuRatio())
            } header: {
                Text("小役確率")
            }
            
            // //// モード関連
            Section {
                // 基本情報
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・4つのモードで規定ゲーム数を管理",
                            textBody2: "・高設定ほどモード移行が優遇されると思われる",
                            textBody3: "・設定変更後、上位AT後は通常モードは選択されない",
                            tableView: AnyView(izaBanchoTableMode())
                        )
                    )
                )
                // 修行からのモード推測
                unitLinkButton(
                    title: "モード推測について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "モード推測",
                            textBody1: "・ゲーム数契機からの修行の有無やハズレからモード推測できる場合あり",
                            textBody2: "・強対決の結果からモード推測できる場合あり",
                            tableView: AnyView(izaBanchoTableModeSuisoku())
                        )
                    )
                )
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver340.izaBanchoMenuNormalBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    izaBanchoViewNormal(
        ver340: Ver340(),
        izaBancho: IzaBancho(),
    )
}
