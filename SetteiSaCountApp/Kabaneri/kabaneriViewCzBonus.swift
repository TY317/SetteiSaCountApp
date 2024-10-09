//
//  kabaneriViewCzBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/30.
//

import SwiftUI
import TipKit

struct kabaneriViewCzBonus: View {
    @ObservedObject var kabaneri = Kabaneri()
    @State var isShowAlert = false
    @State var bonusGameSelected = "100G"
    @State var bonusGameSelectList = ["100G", "250G", "450G", "650G"]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowDataInputView = false
    
    var body: some View {
//        NavigationView {
            List {
                // 履歴
                Section {
                    // //// 履歴
                    // //// 縦画面
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        ScrollView {
                            // //// 配列のデータが0以上なら履歴表示
                            let gameArray = decodeIntArray(from: kabaneri.gameArrayData)
                            if gameArray.count > 0 {
                                ForEach(gameArray.indices, id: \.self) { index in
                                    let viewIndex = gameArray.count - index - 1
                                    HStack {
                                        // ゲーム数
                                        if gameArray.indices.contains(viewIndex) {
                                            Text("\(gameArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 種類
                                        let bonusArray = decodeStringArray(from: kabaneri.bonusArrayData)
                                        if bonusArray.indices.contains(viewIndex) {
                                            Text("\(bonusArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 当選契機
                                        let triggerArray = decodeStringArray(from: kabaneri.triggerArrayData)
                                        if triggerArray.indices.contains(viewIndex) {
                                            Text("\(triggerArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 備考
                                        let remarksArray = decodeStringArray(from: kabaneri.remarksArrayData)
                                        if remarksArray.indices.contains(viewIndex) {
                                            Text("\(remarksArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                    }
                                    Divider()
                                }
                            }
                            // //// 配列のデータ数が0なら履歴なしを表示
                            else {
                                HStack {
                                    Spacer()
                                    Text("履歴なし")
                                        .font(.title)
                                    Spacer()
                                }
                                .padding(.top)
                            }
                        }
                        .frame(height: 250)
                    }
                    // //// 横画面
                    else {
                        ScrollView {
                            // //// 配列のデータが0以上なら履歴表示
                            let gameArray = decodeIntArray(from: kabaneri.gameArrayData)
                            if gameArray.count > 0 {
                                ForEach(gameArray.indices, id: \.self) { index in
                                    let viewIndex = gameArray.count - index - 1
                                    HStack {
                                        // ゲーム数
                                        if gameArray.indices.contains(viewIndex) {
                                            Text("\(gameArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 種類
                                        let bonusArray = decodeStringArray(from: kabaneri.bonusArrayData)
                                        if bonusArray.indices.contains(viewIndex) {
                                            Text("\(bonusArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 当選契機
                                        let triggerArray = decodeStringArray(from: kabaneri.triggerArrayData)
                                        if triggerArray.indices.contains(viewIndex) {
                                            Text("\(triggerArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                        // 備考
                                        let remarksArray = decodeStringArray(from: kabaneri.remarksArrayData)
                                        if remarksArray.indices.contains(viewIndex) {
                                            Text("\(remarksArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("-")
                                                .frame(maxWidth: .infinity)
                                        }
                                    }
                                    Divider()
                                }
                            }
                            // //// 配列のデータ数が0なら履歴なしを表示
                            else {
                                HStack {
                                    Spacer()
                                    Text("履歴なし")
                                        .font(.title)
                                    Spacer()
                                }
                                .padding(.top)
                            }
                        }
                        .frame(height: 150)
                    }
                    // //// 登録、1行削除ボタン
                    HStack {
                        Spacer()
                        Button(action: {
                            if kabaneri.minusCheck {
                                let gameArray = decodeIntArray(from: kabaneri.gameArrayData)
                                if gameArray.count > 0 {
                                    kabaneri.removeLastHistory()
                                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                }
                            } else {
                                isShowDataInputView.toggle()
                            }
                        }, label: {
                            if kabaneri.minusCheck {
                                Image(systemName: "minus")
                            } else {
                                Image(systemName: "plus")
                            }
                        })
                        .buttonStyle(PlusDeleatButtonStyle(MinusBool: kabaneri.minusCheck))
                        .sheet(isPresented: $isShowDataInputView, content: {
                            kabaneriSubViewDataInput(kabaneri: kabaneri)
                                .presentationDetents([.medium])
                        })
                        Spacer()
                    }
                } header: {
                    unitHeaderHistoryColumnsWithoutTimes(column2: "ゲーム数", column3: "種類", column4: "当選契機", column5: "備考")
                }
                // //// CZ出現率
                Section {
                    HStack {
                        unitResultCount2Line(title: "CZ回数", color: .grayBack, count: $kabaneri.czHitCount)
                        unitResultRatioDenomination2Line(title: "CZ確率", color: .grayBack, count: $kabaneri.czHitCount, bigNumber: $kabaneri.historyPlayGame, numberofDicimal: 0)
                    }
//                    Text("CZ回数、ゲーム数はマイスロで確認")
                    unitLinkButton(title: "CZ出現率", exview: AnyView(unitExView5body2image(title: "CZ出現率", textBody1: "・3種類のCZの合算確率で確認", textBody2: "・詳細データはマイスロで確認", image1: Image("kabaneriCzRatio"))))
                } header: {
                    Text("CZ出現率")
                }
                // //// ボーナスランク
                Section {
                    unitLinkButton(title: "ボーナスランクについて", exview: AnyView(unitExView5body2image(title: "ボーナスランクについて", textBody1: "・1〜6の6段階がある", textBody2: "・高設定は低いランクからスタートしやすい。特に設定6は最初のボーナスは駿城になりやすい", textBody3: "・駿城失敗後、CZ失敗後にランクアップを抽選。高設定ほどランクアップしやすい", image1: Image("kabaneriBonusRankStart"), image2: Image("kabaneriBonusRankUp"))))
                    unitLinkButton(title: "駿城後、キリ番のキャラでの示唆", exview: AnyView(unitExView5body2image(title: "キャラごとのランク示唆", textBody1: "・駿城ボーナス失敗後と100Gなどのキリ番（サブ液晶）のキャラでボーナスランクを示唆", textBody2: "・キャラ毎の示唆内容は共通", image1: Image("kabaneriBonusRankChara"))))
                } header: {
                    Text("ボーナスランク")
                }
                // //// 規定ゲーム数でのボーナス当選
                Section {
                    Picker("", selection: $bonusGameSelected) {
                        ForEach(bonusGameSelectList, id: \.self) { select in
//                            Text($0)
                            Text(select)
                        }
                    }
                    .pickerStyle(.segmented)
                    // //// カウントボタン部分
                    // 100G
                    if bonusGameSelected == "100G" {
                        HStack {
                            // 非当選
                            unitCountButtonVerticalWithoutRatio(title: "100非当選", count: $kabaneri.bonus100LoseCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 当選
                            unitCountButtonVerticalWithoutRatio(title: "100当選", count: $kabaneri.bonus100WinCount, color: .blue, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // 250G
                    else if bonusGameSelected == "250G" {
                        HStack {
                            // 非当選
                            unitCountButtonVerticalWithoutRatio(title: "250非当選", count: $kabaneri.bonus250LoseCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck)
                            // 当選
                            unitCountButtonVerticalWithoutRatio(title: "250当選", count: $kabaneri.bonus250WinCount, color: .yellow, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // 450G
                    else if bonusGameSelected == "450G" {
                        HStack {
                            // 非当選
                            unitCountButtonVerticalWithoutRatio(title: "450非当選", count: $kabaneri.bonus450LoseCount, color: .personalSummerLightGreen, minusBool: $kabaneri.minusCheck)
                            // 当選
                            unitCountButtonVerticalWithoutRatio(title: "450当選", count: $kabaneri.bonus450WinCount, color: .green, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // 650G
                    else {
                        HStack {
                            // 非当選
                            unitCountButtonVerticalWithoutRatio(title: "650非当選", count: $kabaneri.bonus650LoseCount, color: .personalSummerLightPurple, minusBool: $kabaneri.minusCheck)
                            // 当選
                            unitCountButtonVerticalWithoutRatio(title: "650当選", count: $kabaneri.bonus650WinCount, color: .purple, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // //// 結果表示
                    // 縦画面
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        // 100,250
                        HStack {
                            unitResultRatioPercent2Line(title: "100G当選率", color: .grayBack, count: $kabaneri.bonus100WinCount, bigNumber: $kabaneri.bonus100CountSum, numberofDicimal: 0)
                            unitResultRatioPercent2Line(title: "250G当選率", color: .grayBack, count: $kabaneri.bonus250WinCount, bigNumber: $kabaneri.bonus250CountSum, numberofDicimal: 0)
                        }
                        // 450,650
                        HStack {
                            unitResultRatioPercent2Line(title: "450G当選率", color: .grayBack, count: $kabaneri.bonus450WinCount, bigNumber: $kabaneri.bonus450CountSum, numberofDicimal: 0)
                            unitResultRatioPercent2Line(title: "650G当選率", color: .grayBack, count: $kabaneri.bonus650WinCount, bigNumber: $kabaneri.bonus650CountSum, numberofDicimal: 0)
                        }
                    }
                    // 横画面
                    else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        // 100,250,450,650
                        HStack {
                            unitResultRatioPercent2Line(title: "100G当選率", color: .grayBack, count: $kabaneri.bonus100WinCount, bigNumber: $kabaneri.bonus100CountSum, numberofDicimal: 0)
                            unitResultRatioPercent2Line(title: "250G当選率", color: .grayBack, count: $kabaneri.bonus250WinCount, bigNumber: $kabaneri.bonus250CountSum, numberofDicimal: 0)
                            unitResultRatioPercent2Line(title: "450G当選率", color: .grayBack, count: $kabaneri.bonus450WinCount, bigNumber: $kabaneri.bonus450CountSum, numberofDicimal: 0)
                            unitResultRatioPercent2Line(title: "650G当選率", color: .grayBack, count: $kabaneri.bonus650WinCount, bigNumber: $kabaneri.bonus650CountSum, numberofDicimal: 0)
                        }
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "規定ゲーム数での当選率", exview: AnyView(unitExView5body2image(title: "規定ゲーム数での当選率", image1: Image("kabaneriBonusGHitAll"))))
                } header: {
                    Text("規定ゲーム数でのボーナス当選")
                }
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 250)
                } else {
                    
                }
            }
            // //// 画面の向き情報の取得部分
            .onAppear {
                // ビューが表示されるときにデバイスの向きを取得
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                // デバイスの向きの変更を監視する
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    self.orientation = UIDevice.current.orientation
                    // 向きがフラットでなければlastOrientationの値を更新
                    if self.orientation.isFlat {
                        
                    }
                    else {
                        self.lastOrientation = self.orientation
                    }
                }
            }
            .onDisappear {
                // ビューが非表示になるときに監視を解除
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .navigationTitle("CZ,ボーナス初当たり")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetBonus)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("CZ,ボーナス初当たり")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetBonus)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

// /////////////////////////
// ビュー：データインプット画面
// /////////////////////////
struct kabaneriSubViewDataInput: View {
    @ObservedObject var kabaneri: Kabaneri
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "ゲーム数", inputValue: $kabaneri.inputGame)
                    .popoverTip(tipKabaneriInputGame())
                    .focused($isFocused)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    isFocused = false
                                }, label: {
                                    Text("完了")
                                        .fontWeight(.bold)
                                })
                            }
                        }
                    }
                // サークルピッカー横並び
                HStack {
                    unitPickerCircleString(title: "種類", selected: $kabaneri.selectedBonus, selectList: kabaneri.selectListBonus)
                    // //// CZ時の表示
                    if kabaneri.selectedBonus == "CZ" {
                        unitPickerCircleString(title: "当選契機", selected: $kabaneri.selectedCzTrigger, selectList: kabaneri.selectListCzTrigger)
                        unitPickerCircleString(title: "CZ種類", selected: $kabaneri.selectedCzType, selectList: kabaneri.selectListCzType)
                    }
                    // //// 駿城時の表示
                    else if kabaneri.selectedBonus == "駿城" {
                        unitPickerCircleString(title: "当選契機", selected: $kabaneri.selectedBonusTrigger, selectList: kabaneri.selectListBonusTrigger)
                        unitPickerCircleString(title: "ST当落", selected: $kabaneri.selectedHayajiroStHit, selectList: kabaneri.selectListHayajiroStHit)
                    }
                    // //// エピボ時の表示
                    else if kabaneri.selectedBonus == "エピボ" {
                        unitPickerCircleString(title: "当選契機", selected: $kabaneri.selectedBonusTrigger, selectList: kabaneri.selectListBonusTrigger)
                        unitPickerCircleString(title: "ST当落", selected: $kabaneri.selectedEpiboStHit, selectList: kabaneri.selectListEpiboStHit)
                    }
                    // //// 現在時の表示
                    else {
                        unitPickerCircleString(title: "当選契機", selected: $kabaneri.selectedCurrentTrigger, selectList: kabaneri.selectListCurrentTrigger)
                        unitPickerCircleString(title: "備考", selected: $kabaneri.selectedCurrentRemarks, selectList: kabaneri.selectListCurrentRemarks)
                    }
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button(action: {
                        if kabaneri.selectedBonus == "CZ" {
                            kabaneri.addDataHistoryCz()
                        } else if kabaneri.selectedBonus == "駿城" {
                            kabaneri.addDataHistoryHayajiro()
                        } else if kabaneri.selectedBonus == "エピボ" {
                            kabaneri.addDataHistoryEpibo()
                        } else {
                            kabaneri.addDataHistoryCurrent()
                        }
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        dismiss()
                    }, label: {
                        Text("登録")
                            .fontWeight(.bold)
                    })
                    Spacer()
                }
            }
            .navigationTitle("履歴登録")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

struct tipKabaneriInputGame: Tip {
    var title: Text {
        Text("サブ液晶ゲーム数")
    }
    var message: Text? {
        Text("現在のサブ液晶ゲーム数を入力して下さい")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

#Preview {
    kabaneriViewCzBonus()
}
