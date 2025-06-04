//
//  izaBanchoViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewFirstHit: View {
    @ObservedObject var izaBancho: IzaBancho
    var body: some View {
        List {
            Section {
                Text("現在値はダイトモで確認して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(
                                izaBanchoTableFirstHit(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
                // 番長ボーナス直撃
                unitLinkButton(
                    title: "番長ボーナス直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "番長ボーナス直撃",
                            textBody1: "・通常時の番長ボーナス直撃に設定差あり",
                            textBody2: "・CZで虹まで昇格させて出てくるボーナスは対象外",
                            tableView: AnyView(
                                izaBanchoTableBBChokugeki(
                                    izaBancho: izaBancho
                                )
                            )
                        )
                    )
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    izaBanchoViewFirstHit(
        izaBancho: IzaBancho()
    )
}
