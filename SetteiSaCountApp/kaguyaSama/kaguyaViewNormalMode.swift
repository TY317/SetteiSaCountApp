//
//  kaguyaViewNormalMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/12.
//

import SwiftUI

struct kaguyaViewNormalMode: View {
    var body: some View {
        List {
            // 通常時のモード
            Section {
                unitLinkButton(title: "モードの種類", exview: AnyView(unitExView5body2image(title: "通常時のモード種類", textBody1: "・通常時は4つのモードでチャンス目の規定回数を管理", image1: Image("kaguyaMode"))))
                unitLinkButton(title: "規定回数振り分け", exview: AnyView(unitExView5body2image(title: "規定回数振り分け", image1: Image("kaguyaChanceTimes"))))
                unitLinkButton(title: "モード移行", exview: AnyView(unitExView5body2image(title: "モード移行", textBody1: "・モードは設定変更時、CZ後、ボーナス後に移行", textBody2: "・ビッグボーナス当選までモードダウンはない。ただし通常Dのみ通常Cへの移行がある。",image1: Image("kaguyaModeChange"))))
            } header: {
                Text("通常時のモード")
            }
            // ミニ藤原の示唆
            Section {
                unitLinkButton(title: "衣装チェンジによる示唆", exview: AnyView(unitExView5body2image(title: "衣装チェンジによる示唆", textBody1: "・「変身！」セリフ経由の衣装チェンジが対象。CZ後などでの衣装チェンジは対象外", image1: Image("kaguyaClothChange"))), detent: .large)
                unitLinkButton(title: "セリフによる示唆", exview: AnyView(unitExView5body2image(title: "セリフによる示唆", image1: Image("kaguyaFujiwaraComent"))), detent: .large)
            } header: {
                Text("ミニ藤原の示唆")
            }
            // 規定ゲーム数での抽選
            Section {
                unitLinkButton(title: "規定ゲーム数でのCZ抽選", exview: AnyView(unitExView5body2image(title: "規定ゲーム数", textBody1: "・130, 300, 600ゲーム消化でCZを抽選", textBody2: "・130よりは300,600の方が期待度が高い")))
            } header: {
                Text("規定ゲーム数での抽選")
            }
        }
    }
}

#Preview {
    kaguyaViewNormalMode()
}