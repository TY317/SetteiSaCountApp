//
//  kabaneriUnatoViewKabaneriBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/01.
//

import SwiftUI

struct kabaneriUnatoViewKabaneriBonus: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
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
    
    @State var selectedItem: String = "男性(景之除く)"
    let selectList: [String] = [
        "男性(景之除く)",
        "女性(無名特殊除く)",
        "[景之] なぜ言わなかった、私をヒトだと!",
        "[景之] 私はヒトか、カバネか!?",
        "[景之] 今年は最後かな",
        "[無名] やっぱりこの台、普通じゃないね",
        "(ボイスなし)",
    ]
    let sisaList: [String] = [
        "設定3・5示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定5 以上濃厚",
    ]
    
    @State var selectedItemChara: String = "無名"
    let selectListChara: [String] = [
        "無名",
        "菖蒲",
        "鰍＆侑那",
        "生駒",
        "来栖",
        "景之",
        "美馬",
    ]
    let sisaListChara: [String] = [
        "設定3・5示唆",
        "偶数示唆",
        "設定4 以上濃厚",
    ]
    let indexList: [Int] = [3,0,6]
    var body: some View {
        List {
            // ---- 逆押しボイス
            Section {
                // 確率結果横並び
                HStack {
                    // 奇数示唆
                    unitResultRatioPercent2Line(
                        title: "奇数示唆",
                        count: $kabaneriUnato.voiceCount35Sisa,
                        bigNumber: $kabaneriUnato.voiceCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 偶数示唆
                    unitResultRatioPercent2Line(
                        title: "偶数示唆",
                        count: $kabaneriUnato.voiceCountGusu,
                        bigNumber: $kabaneriUnato.voiceCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 高設定示唆
                    unitResultRatioPercent2Line(
                        title: "高設定示唆",
                        count: $kabaneriUnato.voiceCountHighSum,
                        bigNumber: $kabaneriUnato.voiceCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("サブ液晶ランプが上下とも発光すれば景之or無名特殊")
                    }
                    // サークルピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.selectList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    // //// 示唆＆登録ボタン
                    unitCountSubmitWithResult(
                        title: sisaText(item: self.selectedItem),
                        count: bindingVoice(item: self.selectedItem),
                        bigNumber: $kabaneriUnato.voiceCountSum,
                        flushColor: flushColor(item: self.selectedItem),
                        minusCheck: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.voiceSumFunc()
                        }
                    
                    // 空白スペース
                    // スペース用の行
                    Text("")
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        .listRowSeparator(.hidden)
                    
                    // カウント結果
                    ForEach(self.selectList, id: \.self) { voice in
                        unitResultCountListPercent(
                            title: sisaText(item: voice),
                            count: bindingVoice(item: voice),
                            flashColor: flushColor(item: voice),
                            bigNumber: $kabaneriUnato.voiceCountSum
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                HStack {
                    Text("逆押し時のボイス")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "逆押し時のボイス",
                            textBody1: "・逆押し発生時、左リールにサンド目を狙うとボイスが発生",
                            textBody2: "・次ゲームのレバーON前であればサブ液晶タッチ or PUSHボタンで何度でも聴き直せる"
                        )
                    }
                }
            }
            
            // ---- キャラ紹介
            Section {
                // 確率結果横並び
                HStack {
                    // 奇数示唆
                    unitResultRatioPercent2Line(
                        title: "奇数示唆",
                        count: $kabaneriUnato.charaCount35Sisa,
                        bigNumber: $kabaneriUnato.charaCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 偶数示唆
                    unitResultRatioPercent2Line(
                        title: "偶数示唆",
                        count: $kabaneriUnato.charaCountGusu,
                        bigNumber: $kabaneriUnato.charaCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                DisclosureGroup {
                    // サークルピッカー
                    Picker("", selection: self.$selectedItemChara) {
                        ForEach(self.selectListChara, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    // //// 示唆＆登録ボタン
                    unitCountSubmitWithResult(
                        title: sisaTextChara(item: self.selectedItemChara),
                        count: bindingVoiceChara(item: self.selectedItemChara),
                        bigNumber: $kabaneriUnato.charaCountSum,
                        flushColor: flushColorChara(item: self.selectedItemChara),
                        minusCheck: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.charaSumFunc()
                        }
                    
                    // 空白スペース
                    // スペース用の行
                    Text("")
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        .listRowSeparator(.hidden)
                    
                    // カウント結果
                    ForEach(self.indexList, id: \.self) { index in
                        unitResultCountListPercent(
                            title: sisaTextChara(item: self.selectListChara[index]),
                            count: bindingVoiceChara(item: self.selectListChara[index]),
                            flashColor: flushColorChara(item: self.selectListChara[index]),
                            bigNumber: $kabaneriUnato.charaCountSum
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("キャラ紹介")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuKabaneriBonusBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("カバネリボーナス")
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
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetKabaneriBonus)
            }
        }
    }
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $kabaneriUnato.voiceCount35Sisa
        case self.selectList[1]: return $kabaneriUnato.voiceCountGusu
        case self.selectList[2]: return $kabaneriUnato.voiceCountHighJaku
        case self.selectList[3]: return $kabaneriUnato.voiceCountHighChu
        case self.selectList[4]: return $kabaneriUnato.voiceCountHighKyo
        case self.selectList[5]: return $kabaneriUnato.voiceCountOver2
        case self.selectList[6]: return $kabaneriUnato.voiceCountOver5
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .green
        case self.selectList[3]: return .purple
        case self.selectList[4]: return .red
        case self.selectList[5]: return .cyan
        case self.selectList[6]: return .orange
        default: return .gray
        }
    }
    
    private func sisaTextChara(item: String) -> String {
        switch item {
        case self.selectListChara[0]: return self.sisaList[1]
        case self.selectListChara[1]: return self.sisaList[1]
        case self.selectListChara[2]: return self.sisaList[1]
        case self.selectListChara[3]: return self.sisaList[0]
        case self.selectListChara[4]: return self.sisaList[0]
        case self.selectListChara[5]: return self.sisaList[0]
        case self.selectListChara[6]: return self.sisaList[2]
        default: return "???"
        }
    }
    
    private func bindingVoiceChara(item: String) -> Binding<Int> {
        switch item {
        case self.selectListChara[0]: return $kabaneriUnato.charaCountGusu
        case self.selectListChara[1]: return $kabaneriUnato.charaCountGusu
        case self.selectListChara[2]: return $kabaneriUnato.charaCountGusu
        case self.selectListChara[3]: return $kabaneriUnato.charaCount35Sisa
        case self.selectListChara[4]: return $kabaneriUnato.charaCount35Sisa
        case self.selectListChara[5]: return $kabaneriUnato.charaCount35Sisa
        case self.selectListChara[6]: return $kabaneriUnato.charaCountOver4
        default: return .constant(0)
        }
    }
    
    private func flushColorChara(item: String) -> Color {
        switch item {
        case self.selectListChara[0]: return .yellow
        case self.selectListChara[1]: return .yellow
        case self.selectListChara[2]: return .yellow
        case self.selectListChara[3]: return .blue
        case self.selectListChara[4]: return .blue
        case self.selectListChara[5]: return .blue
        case self.selectListChara[6]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    kabaneriUnatoViewKabaneriBonus(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
