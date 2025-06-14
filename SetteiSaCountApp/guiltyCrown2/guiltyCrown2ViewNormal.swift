//
//  guiltyCrown2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import SwiftUI

struct guiltyCrown2ViewNormal: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    let selectListStage: [String] = [
        "学校",
        "葬儀社",
        "王国"
    ]
    @State var selectedStage: String = "学校"
    let voiceList: [String] = [
        "そこにおわすは集じゃないか！",
        "探し物は水族館にあり？",
        "ミッションだってのに浮かれやがって",
        "人の手は借りないって決めてるの",
        "ねぇ、集、なんか変わった？",
        "うちの子たちよろしく",
        "こんな状態はもうすぐ終わるわ。心配無用よ",
        "いいニュースだ",
        "集・・ずっと側にいても、いい？",
        "取りなさい集。今度こそ・・",
        "痛いなぁ！怪我したらどうすんのさ！気をつけてよね",
        "告白はきちんとするべきです",
        "もし邪魔したら、パパに言いつけるからね",
        "こらえ性のない男ね",
        "これぞホントの癒し系となっ！",
        "まいていきましょう",
        "協力、感謝する、だがここからは別料金だ",
        "記憶の鎖が解け、新しい王のモードに入ったか"
    ]
    @State var selectedVoice: String = "そこにおわすは集じゃないか！"
    @State var selectedVoiceIndex: Int = 0
    let voiceSisaListGakko: [String] = [
        "デフォルト",
        "デフォルト",
        "モードC 以上濃厚",
        "モードC 以上濃厚",
        "モードB 以上に期待",
        "モードC 以上濃厚",
        "モードB 以上濃厚",
        "モードC 以上濃厚",
        "モードC 以上濃厚",
        "モードD 濃厚",
        "モードB 否定",
        "モードC 以上濃厚",
        "モードB or D 濃厚",
        "モードC 以上濃厚",
        "モードC 以上濃厚",
        "当該ゲームでのモードアップ期待度 約25%",
        "当該ゲームでのモードアップ期待度 約50%",
        "当該ゲームでのモードアップ濃厚",
    ]
    let voiceSisaListSogisha: [String] = [
        "モードC 以上濃厚",
        "モードC 以上濃厚",
        "デフォルト",
        "デフォルト",
        "モードC 以上濃厚",
        "モードB 以上に期待",
        "モードC 以上濃厚",
        "モードB 以上濃厚",
        "モードC 以上濃厚",
        "モードD 濃厚",
        "モードC 以上濃厚",
        "モードB 否定",
        "モードC 以上濃厚",
        "モードB or D 濃厚",
        "モードC 以上濃厚",
        "当該ゲームでのモードアップ期待度 約25%",
        "当該ゲームでのモードアップ期待度 約50%",
        "当該ゲームでのモードアップ濃厚",
    ]
    let voiceSisaListOhkoku: [String] = [
        "デフォルト",
        "デフォルト",
        "デフォルト",
        "デフォルト",
        "モードB 以上に期待",
        "モードB 以上に期待",
        "モードB 以上濃厚",
        "モードB 以上濃厚",
        "モードC 以上濃厚",
        "モードD 濃厚",
        "モードB 否定",
        "モードB 否定",
        "モードC 以上濃厚",
        "モードC 以上濃厚",
        "モードB or D 濃厚",
        "当該ゲームでのモードアップ期待度 約25%",
        "当該ゲームでのモードアップ期待度 約50%",
        "当該ゲームでのモードアップ濃厚",
    ]
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // リプレイフラグ
                unitLinkButton(
                    title: "リプレイ停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "リプレイ停止形",
                            tableView: AnyView(guiltyCrown2TableReplayPattern())
                        )
                    )
                )
                // ベルフラグ
                unitLinkButton(
                    title: "ベル停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ベル停止形",
                            tableView: AnyView(guiltyCrown2TableBellPattern())
                        )
                    )
                )
                // レア役
                unitLinkButton(
                    title: "レア役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役停止形",
                            textBody1: "・弱停止形でもエフェクト発生すれば強フラグの可能性あり",
                            tableView: AnyView(guiltyCrown2TableRarePattern())
                        )
                    )
                )
            } header: {
                Text("小役")
            }
            
            // //// モード
            Section {
                // 参考情報）状態について
                unitLinkButton(
                    title: "通常時の状態について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時の状態",
                            textBody1: "・通常、高確、超高確の3種類の状態がある",
                            textBody2: "・レア役成立時やボーナス成立時のAT当選率に影響する"
                        )
                    )
                )
                // 参考情報）VCモード
                unitLinkButton(
                    title: "VCモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "VCモード",
                            textBody1: "・ベル契機、VCポイント契機のCZ当選率に影響するモード",
                            textBody2: "・A,B,C,Dの4種類がある",
                            textBody3: "・チャンス目成立時やレゾナンスナビのCHANCE選択時に昇格抽選",
                            textBody4: "・CZ当選までモードの転落はなし"
                        )
                    )
                )
            } header: {
                Text("モード")
            }
            
            // //// ボイス示唆
            Section {
                Text("・レゾナンスナビで「NEXT」→「CHANCE」時、ボタンPUSHで発生するボイスでVCモードを示唆\n・滞在ステージで示唆が変化するためステージも合わせて選択して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // ステージの選択
                Picker("", selection: self.$selectedStage) {
                    ForEach(self.selectListStage, id: \.self) { stage in
                        Text(stage)
                    }
                }
                .pickerStyle(.segmented)
                
                // ボイスの選択
                Picker(selection: self.$selectedVoiceIndex) {
                    ForEach(0..<self.voiceList.count, id: \.self) { index in
                        Text(self.voiceList[index])
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // 選択されているボイスの示唆
//                if self.selectedStage == self.selectListStage[0] {
//                    if self.voiceSisaListGakko.indices.contains(self.selectedVoiceIndex) {
//                        HStack {
//                            Text("示唆：")
//                            Text(self.voiceSisaListGakko[self.selectedVoiceIndex])
//                                .frame(maxWidth: .infinity, alignment: .center)
//                        }
//                        .foregroundStyle(Color.secondary)
//                    } else {
//                        Text("-")
//                    }
//                }
                if selectedSisaList(
                    stage: self.selectedStage
                ).indices.contains(self.selectedVoiceIndex) {
                    HStack {
                        Text("示唆：")
                        Text(
                            self.selectedSisaList(
                                stage: self.selectedStage
                            )[self.selectedVoiceIndex])
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .foregroundStyle(Color.secondary)
                }
            } header: {
                Text("ボイスでのVCモード示唆")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func selectedSisaList(stage: String) -> [String] {
        switch stage {
        case self.selectListStage[0]: return self.voiceSisaListGakko
        case self.selectListStage[1]: return self.voiceSisaListSogisha
        case self.selectListStage[2]: return self.voiceSisaListOhkoku
        default: return self.voiceSisaListGakko
        }
    }
}

#Preview {
    guiltyCrown2ViewNormal(
        guiltyCrown2: GuiltyCrown2()
    )
}
