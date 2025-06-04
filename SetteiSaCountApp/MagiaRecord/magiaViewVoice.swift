//
//  magiaViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI
import TipKit

struct magiaViewVoice: View {
//    @ObservedObject var ver310: Ver310
    @ObservedObject var magia: Magia
    @State var selectedSegment: String = "AT非当選時"
    let segmentList: [String] = ["AT非当選時", "AT当選時"]
    let maxWidth: CGFloat = 400
    let lineList: [Int] = [2,2,2,2,2]
    let voiceList: [String] = [
        "①運命を変えたいなら神浜市に来て",
        "②この町で魔法少女は救われる",
        "③お姉ちゃんはまだ誰かを助けることができるんだよ",
        "④お姉ちゃんが幸せを見つけるたびに私はお姉ちゃんと会えるから",
        "⑤奇跡ってあるんだねお姉ちゃん"
    ]
    var body: some View {
//        TipView(tipVer310MagiaVoice())
        List {
            // /// 調査中表示
//            Section {
//                Text("詳細調査中")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
            
            // //// ALL設定バトル動画の情報
//            Section {
//                VStack {
//                    Text("・終了後にサブ液晶タッチでボイス発生")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・「運命を変えたいなら〜」がデフォルトと思われる")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・設定5,6のデフォルト比率は合算で6/10で60%だった")
//                }
//                .foregroundStyle(Color.secondary)
//            } header: {
//                Text("試打動画からの考察")
//            }
            
            // //// ver3.1.0で更新
//            TipView(tipVer310MagiaVoice())
            // //// 注意書き
            Section {
                // //// セグメント選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                
                // AT非当選時
                if self.selectedSegment == self.segmentList[0] {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: self.voiceList,
                            maxWidth: self.maxWidth,
                            lineList: self.lineList,
                            contentFont: .body
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "デフォルト",
                                "300pt以内期待度UP",
                                "深いptが選択されにくい",
                                "③より深いptが選択されにくい",
                                "300pt以内期待度UP"
                            ],
                            maxWidth: self.maxWidth,
                            lineList: self.lineList,
                            contentFont: .body
                        )
                    }
                }
                // AT当選時
                else {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: self.voiceList,
                            maxWidth: self.maxWidth,
                            lineList: self.lineList,
                            contentFont: .body
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "デフォルト",
                                "浅いG数期待度UP",
                                "100G以内期待度UP",
                                "100G以内期待度UP\n(150G以内濃厚)",
                                "50G以内濃厚"
                            ],
                            maxWidth: self.maxWidth,
                            lineList: self.lineList,
                            contentFont: .body
                        )
                    }
                }
            } header: {
                Text("ボイス")
            }
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver310.magiaMenuVoiceBadgeStatus != "none" {
//                ver310.magiaMenuVoiceBadgeStatus = "none"
//            }
//        }
        .navigationTitle("BIG終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    magiaViewVoice(
//        ver310: Ver310(),
        magia: Magia()
    )
}
