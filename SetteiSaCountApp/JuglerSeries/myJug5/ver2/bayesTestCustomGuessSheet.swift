//
//  bayesTestCustomGuessSheet.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import SwiftUI

struct bayesTestCustomGuessSheet: View {
    var settingList: [Int]
    @Binding var guessCustom1: [Int]
    @Binding var guessCustom2: [Int]
    @Binding var guessCustom3: [Int]
    @Environment(\.dismiss) private var dismiss
    @AppStorage("bayesTestGuessCustom1Key") var guessCustom1JSON: String = "[1,1,1,1,1,1]"
    @AppStorage("bayesTestGuessCustom2Key") var guessCustom2JSON: String = "[1,2,3,4,5,6]"
    @AppStorage("bayesTestGuessCustom3Key") var guessCustom3JSON: String = "[6,5,4,3,2,1]"
    @State var selectedCustom: String = "カスタム1"
    let customList: [String] = ["カスタム1", "カスタム2", "カスタム3"]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("", selection: self.$selectedCustom) {
                        ForEach(self.customList, id: \.self) { custom in
                            Text(custom)
                        }
                    }
                    .pickerStyle(.segmented)
                    ForEach(self.selectGuess().indices, id: \.self) { index in
                        HStack {
                            Text("設定\(self.settingList[index]): ")
                            Stepper(value: self.bindingGuess()[index], in: 0...999) {
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
                            }
                        }
                    }
                }
            }
            .navigationTitle("カスタム設定配分")
            .onChange(of: selectGuess()) {
                if let data = try? JSONEncoder().encode(self.selectGuess()),
                   let str = String(data: data, encoding: .utf8) {
                    if self.selectedCustom == self.customList[0] {
                        self.guessCustom1JSON = str
                    } else if self.selectedCustom == self.customList[1] {
                        self.guessCustom2JSON = str
                    } else {
                        self.guessCustom3JSON = str
                    }
                }
            }
            // //// ツールバー閉じるボタン
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
    private func selectGuess() -> [Int] {
        switch self.selectedCustom {
        case self.customList[0]: return self.guessCustom1
        case self.customList[1]: return self.guessCustom2
        case self.customList[2]: return self.guessCustom3
        default : return self.guessCustom1
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
}

#Preview {
    @Previewable @State var guess: [Int] = [1,1,1,1,1,1]
    @Previewable @State var guess2: [Int] = [1,2,3,4,5,6]
    @Previewable @State var guess3: [Int] = [6,5,4,3,2,1]
    bayesTestCustomGuessSheet(
        settingList: [1,2,3,4,5,6],
        guessCustom1: $guess,
        guessCustom2: $guess2,
        guessCustom3: $guess3,
    )
}
