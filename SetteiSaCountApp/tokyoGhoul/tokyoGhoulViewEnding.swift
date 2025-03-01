//
//  tokyoGhoulViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/01.
//

import SwiftUI

struct tokyoGhoulViewEnding: View {
    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @State var isShowAlert = false
    let selectListColor: [String] = ["白カード", "青カード", "赤カード"]
    @State var selectedColor: String = "白カード"
    let selectListWhiteChara: [String] = [
        "金木研",
        "霧嶋菫香",
        "笛口雛実",
        "永近英良",
        "西尾錦",
        "月山習",
        "芳村",
        "四方蓮示",
        "ウタ",
        "イトリ",
        "古間円児",
        "入見カヤ"
    ]
    @State var selectedWhiteChara: String = "金木研"
    let selectListBlueChara: [String] = [
        "金木研",
        "霧嶋董香",
        "笛口雛実",
        "ナキ",
        "西尾錦",
        "月山習",
        "亜門鋼太朗",
        "篠原幸紀",
        "滝澤政道",
        "真戸暁",
        "真戸呉緒",
        "丸手斎"
    ]
    @State var selectedBlueChara: String = "金木研"
    let selectListRedChara: [String] = [
        "金木研",
        "霧嶋菫香",
        "ヤモリ",
        "霧嶋絢都",
        "鯱",
        "亜門鋼太朗",
        "篠原幸紀",
        "鈴屋什造"
    ]
    @State var selectedRedChara: String = "金木研"
    
    var body: some View {
        List {
            Section {
                // //// カードの色選択
                Picker("", selection: self.$selectedColor) {
                    ForEach(self.selectListColor, id: \.self) { card in
                        Text(card)
                    }
                }
                .pickerStyle(.segmented)
                // //// キャラの選択
                // 白カード
                if self.selectedColor == self.selectListColor[0] {
                    // 白カードキャラ選択 サークルピッカー
                    Picker(selection: self.$selectedWhiteChara) {
                        ForEach(self.selectListWhiteChara, id: \.self) { whiteChara in
                            Text(whiteChara)
                        }
                    } label: {
                        
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120.0)
                    // 選択されているキャラのカウント表示
                    // 奇数示唆　弱
                    if self.selectedWhiteChara == self.selectListWhiteChara[0] ||
                        self.selectedWhiteChara == self.selectListWhiteChara[1] ||
                        self.selectedWhiteChara == self.selectListWhiteChara[2] ||
                        self.selectedWhiteChara == self.selectListWhiteChara[3] ||
                        self.selectedWhiteChara == self.selectListWhiteChara[4] ||
                        self.selectedWhiteChara == self.selectListWhiteChara[5] {
                        unitResultCountListPercent(
                            title: "奇数示唆 弱",
                            count: $tokyoGhoul.endingCountKisuJaku,
                            flashColor: .gray,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // 奇数示唆 強
                    else {
                        unitResultCountListPercent(
                            title: "奇数示唆 強",
                            count: $tokyoGhoul.endingCountKisuKyo,
                            flashColor: .gray,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // 奇数示唆　弱
                        if self.selectedWhiteChara == self.selectListWhiteChara[0] ||
                            self.selectedWhiteChara == self.selectListWhiteChara[1] ||
                            self.selectedWhiteChara == self.selectListWhiteChara[2] ||
                            self.selectedWhiteChara == self.selectListWhiteChara[3] ||
                            self.selectedWhiteChara == self.selectListWhiteChara[4] ||
                            self.selectedWhiteChara == self.selectListWhiteChara[5] {
                            tokyoGhoul.endingCountKisuJaku = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountKisuJaku)
                        }
                        // 奇数示唆 強
                        else {
                            tokyoGhoul.endingCountKisuKyo = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountKisuKyo)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if tokyoGhoul.minusCheck == false {
                                Text("登録")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            } else {
                                Text("マイナス")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.red)
                            }
                            Spacer()
                        }
                    }
                }
                // 青カード
                else if self.selectedColor == "青カード" {
                    // 青カードキャラ選択 サークルピッカー
                    Picker(selection: self.$selectedBlueChara) {
                        ForEach(self.selectListBlueChara, id: \.self) { blueChara in
                            Text(blueChara)
                        }
                    } label: {
                        
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120.0)
                    // 選択されているキャラのカウント表示
                    // 偶数示唆　弱
                    if self.selectedBlueChara == self.selectListBlueChara[0] ||
                        self.selectedBlueChara == self.selectListBlueChara[1] ||
                        self.selectedBlueChara == self.selectListBlueChara[2] ||
                        self.selectedBlueChara == self.selectListBlueChara[3] ||
                        self.selectedBlueChara == self.selectListBlueChara[4] ||
                        self.selectedBlueChara == self.selectListBlueChara[5] {
                        unitResultCountListPercent(
                            title: "偶数示唆 弱",
                            count: $tokyoGhoul.endingCountGusuJaku,
                            flashColor: .personalSummerLightBlue,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // 偶数示唆 強
                    else {
                        unitResultCountListPercent(
                            title: "偶数示唆 強",
                            count: $tokyoGhoul.endingCountGusuKyo,
                            flashColor: .blue,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // 偶数示唆　弱
                        if self.selectedBlueChara == self.selectListBlueChara[0] ||
                            self.selectedBlueChara == self.selectListBlueChara[1] ||
                            self.selectedBlueChara == self.selectListBlueChara[2] ||
                            self.selectedBlueChara == self.selectListBlueChara[3] ||
                            self.selectedBlueChara == self.selectListBlueChara[4] ||
                            self.selectedBlueChara == self.selectListBlueChara[5] {
                            tokyoGhoul.endingCountGusuJaku = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountGusuJaku)
                        }
                        // 偶数示唆 強
                        else {
                            tokyoGhoul.endingCountGusuKyo = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountGusuKyo)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if tokyoGhoul.minusCheck == false {
                                Text("登録")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            } else {
                                Text("マイナス")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.red)
                            }
                            Spacer()
                        }
                    }
                }
                
                // //// 赤カード
                else {
                    // 赤カードキャラ選択 サークルピッカー
                    Picker(selection: self.$selectedRedChara) {
                        ForEach(self.selectListRedChara, id: \.self) { redChara in
                            Text(redChara)
                        }
                    } label: {
                        
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120.0)
                    // 選択されているキャラのカウント表示
                    // 高設定示唆　弱
                    if self.selectedRedChara == self.selectListRedChara[0] ||
                        self.selectedRedChara == self.selectListRedChara[1] ||
                        self.selectedRedChara == self.selectListRedChara[2] ||
                        self.selectedRedChara == self.selectListRedChara[3] {
                        unitResultCountListPercent(
                            title: "高設定示唆 弱",
                            count: $tokyoGhoul.endingCountHighJaku,
                            flashColor: .personalSummerLightRed,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // 高設定示唆 強
                    else {
                        unitResultCountListPercent(
                            title: "高設定示唆 強",
                            count: $tokyoGhoul.endingCountHighKyo,
                            flashColor: .red,
                            bigNumber: $tokyoGhoul.endingCountSum
                        )
                    }
                    // //// 登録ボタン
                    Button {
                        // 高設定示唆　弱
                        if self.selectedRedChara == self.selectListRedChara[0] ||
                            self.selectedRedChara == self.selectListRedChara[1] ||
                            self.selectedRedChara == self.selectListRedChara[2] ||
                            self.selectedRedChara == self.selectListRedChara[3] {
                            tokyoGhoul.endingCountHighJaku = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountHighJaku)
                        }
                        // 高設定示唆 強
                        else {
                            tokyoGhoul.endingCountHighKyo = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.endingCountHighKyo)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if tokyoGhoul.minusCheck == false {
                                Text("登録")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            } else {
                                Text("マイナス")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.red)
                            }
                            Spacer()
                        }
                    }
                }
            } header: {
                Text("キャラカード選択")
            }
            
            // カウント結果
            Section {
                // 奇数示唆　弱
                unitResultCountListPercent(
                    title: "奇数示唆 弱",
                    count: $tokyoGhoul.endingCountKisuJaku,
                    flashColor: .gray,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
                // 奇数示唆 強
                unitResultCountListPercent(
                    title: "奇数示唆 強",
                    count: $tokyoGhoul.endingCountKisuKyo,
                    flashColor: .gray,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
                // 偶数示唆　弱
                unitResultCountListPercent(
                    title: "偶数示唆 弱",
                    count: $tokyoGhoul.endingCountGusuJaku,
                    flashColor: .personalSummerLightBlue,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
                // 偶数示唆 強
                unitResultCountListPercent(
                    title: "偶数示唆 強",
                    count: $tokyoGhoul.endingCountGusuKyo,
                    flashColor: .blue,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
                // 高設定示唆　弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $tokyoGhoul.endingCountHighJaku,
                    flashColor: .personalSummerLightRed,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $tokyoGhoul.endingCountHighKyo,
                    flashColor: .red,
                    bigNumber: $tokyoGhoul.endingCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $tokyoGhoul.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetEnding)
                }
            }
        }
    }
}

#Preview {
    tokyoGhoulViewEnding()
}
