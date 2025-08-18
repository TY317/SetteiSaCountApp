//
//  unitToolbarButtonCustomSheet.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import SwiftUI

struct unitToolbarButtonCustomSheet: View {
    var settingList: [Int] = [1,2,3,4,5,6]
    @ObservedObject var bayes: Bayes
    @Binding var guessCustom1: [Int]
    @Binding var guessCustom2: [Int]
    @Binding var guessCustom3: [Int]
    @Binding var selectedBeforeGuessPattern: String
    
    @State var isShowcustomSheet: Bool = false
    @State var selectedCustom: String = ""
    let customList: [String] = ["カスタム1", "カスタム2", "カスタム3"]
    
    var body: some View {
        Button {
            self.isShowcustomSheet.toggle()
        } label: {
            Image(systemName: "gearshape")
        }
        .sheet(isPresented: self.$isShowcustomSheet) {
            // //// カスタム配分設定シートのビュー
            NavigationView {
                List {
                    Section {
                        // カスタム１−３の選択セグメント
                        Picker("", selection: self.$selectedCustom) {
                            ForEach(self.customList, id: \.self) { custom in
                                Text(custom)
                            }
                        }
                        .pickerStyle(.segmented)
                        // 設定ごとのステッパー
                        ForEach(self.settingList.indices, id: \.self) { index in
                            HStack {
                                Text("設定\(self.settingList[index]): ")
//                                Stepper(value: self.bindingGuess()[index], in: 0...999) {
                                if bindingGuess().indices.contains(index) {
                                    Stepper {
                                        HStack {
                                            let total: Int = self.selectGuess().reduce(0, +)
                                            let guess: Double = Double(self.selectGuess()[index]) / Double(total) * 100
                                            Text("\(self.selectGuess()[index])")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .offset(x: 20)
                                            Text("(\(guess, specifier: "%.1f")%)")
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                    } onIncrement: {
//                                        self.selectGuess()[index] += 1
                                        if self.selectedCustom == self.customList[0] {
                                            self.guessCustom1[index] += 1
                                        } else if self.selectedCustom == self.customList[1] {
                                            self.guessCustom2[index] += 1
                                        } else {
                                            self.guessCustom3[index] += 1
                                        }
                                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                                    } onDecrement: {
                                        if self.selectGuess()[index] > 0 {
//                                            self.selectGuess()[index] -= 1
                                            if self.selectedCustom == self.customList[0] {
                                                self.guessCustom1[index] -= 1
                                            } else if self.selectedCustom == self.customList[1] {
                                                self.guessCustom2[index] -= 1
                                            } else {
                                                self.guessCustom3[index] -= 1
                                            }
                                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                                        }
                                    }

//                                    Stepper(
//                                        value: bindingGuess()[index],
//                                        in: 0...999,
//                                    ) {
//                                        HStack {
//                                            let total: Int = self.selectGuess().reduce(0, +)
//                                            let guess: Double = Double(self.selectGuess()[index]) / Double(total) * 100
//                                            Text("\(self.selectGuess()[index])")
//                                                .font(.title2)
//                                                .fontWeight(.bold)
//                                                .frame(maxWidth: .infinity, alignment: .center)
//                                                .offset(x: 20)
//                                            Text("(\(guess, specifier: "%.1f")%)")
//                                                .frame(maxWidth: .infinity, alignment: .center)
//                                        }
//                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("カスタム設定配分")
                // //// 値が変更されるたびにAppstorageの値を更新して保存
                .onChange(of: selectGuess()) {
                    if let data = try? JSONEncoder().encode(self.selectGuess()),
                       let str = String(data: data, encoding: .utf8) {
                        // 5段階設定の場合
                        if self.settingList.count == 5 {
                            if self.selectedCustom == self.customList[0] {
                                bayes.guess5Custom1JSON = str
                            } else if self.selectedCustom == self.customList[1] {
                                bayes.guess5Custom2JSON = str
                            } else {
                                bayes.guess5Custom3JSON = str
                            }
                        }
                        // 6段階設定の場合
//                        if self.settingList == [1,2,3,4,5,6] {
                        else {
                            if self.selectedCustom == self.customList[0] {
                                bayes.guess6Custom1JSON = str
                            } else if self.selectedCustom == self.customList[1] {
                                bayes.guess6Custom2JSON = str
                            } else {
                                bayes.guess6Custom3JSON = str
                            }
                        }
                    }
                    // バイブレーションさせる
//                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
                // //// ツールバー閉じるボタン
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            self.isShowcustomSheet = false
                        }, label: {
                            Text("閉じる")
                                .fontWeight(.bold)
                        })
                    }
                }
                // //// 選択されているパターンが最初に表示されるようにしておく
                // //// カスタム以外が選択されていたらカスタム１
                .onAppear {
                    // カスタム配分を配列にしとく
//                    self.guessCustom1 = decodeIntArrayFromString(stringData: bayes.guess6Custom1JSON)
//                    self.guessCustom2 = decodeIntArrayFromString(stringData: bayes.guess6Custom2JSON)
//                    self.guessCustom3 = decodeIntArrayFromString(stringData: bayes.guess6Custom3JSON)
                    
                    // パターンの選択状態に合わせて表示の初期値を変更
//                    if bayes.selectedBeforeGuessPattern == self.customList[1] {
                    if self.selectedBeforeGuessPattern == self.customList[1] {
                        self.selectedCustom = self.customList[1]
//                    } else if bayes.selectedBeforeGuessPattern == self.customList[2] {
                    } else if self.selectedBeforeGuessPattern == self.customList[2] {
                        self.selectedCustom = self.customList[2]
                    } else {
                        self.selectedCustom = self.customList[0]
                    }
                }
            }
            
            
        }
    }
    private func bindingGuess() -> Binding<[Int]> {
        switch self.selectedCustom {
        case self.customList[0]: return self.$guessCustom1
        case self.customList[1]: return self.$guessCustom2
        case self.customList[2]: return self.$guessCustom3
        default: return self.$guessCustom1
        }
    }
    private func selectGuess() -> [Int] {
        switch self.selectedCustom {
        case self.customList[0]: return self.guessCustom1
        case self.customList[1]: return self.guessCustom2
        case self.customList[2]: return self.guessCustom3
        default : return self.guessCustom1
        }
    }
}

#Preview {
    @Previewable @State var guess: [Int] = [1,1,1,1,1,1]
    @Previewable @State var guess2: [Int] = [1,2,3,4,5,6]
    @Previewable @State var guess3: [Int] = [6,5,4,3,2,1]
    @Previewable @State var guessPattern: String = "デフォルト"
    unitToolbarButtonCustomSheet(
        bayes: Bayes(),
        guessCustom1: $guess,
        guessCustom2: $guess2,
        guessCustom3: $guess3,
        selectedBeforeGuessPattern: $guessPattern,
    )
}
