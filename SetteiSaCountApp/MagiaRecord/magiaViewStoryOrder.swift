//
//  magiaViewStoryOrder.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/25.
//

import SwiftUI

struct magiaViewStoryOrder: View {
//    @ObservedObject var ver352: Ver352
    @ObservedObject var magia: Magia
    let firstChoice: [Int] = [1,2,3,4,5]
    @State var firstSelected: Int = 1
    @State var storyOrder: [Int] = [1,2,3,4,5]
    let sisaList: [String] = [
        "奇数示唆 弱",
        "奇数示唆",
        "奇数かつ高設定示唆",
        "偶数示唆 弱",
        "偶数示唆",
        "偶数かつ高設定示唆",
        "1否定",
        "2否定",
        "3否定",
        "1否定＆高設定示唆",
        "5以上濃厚",
    ]
    @State var flushBool: Bool = false
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // //// ストーリー順番選択
            Section {
                // //// 注意書き
                Text("・ストーリーの順番で設定を示唆\n・SPストーリーを挟んでも示唆は有効")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                VStack {
                    // 選択肢のタイトル
                    Text("[話数選択（左から順に）]")
                    
                    // //// 選択肢横並び
                    HStack(spacing: 0) {
                        // 1話目
                        Picker("", selection: self.$storyOrder[0]) {
                            ForEach(self.firstChoice, id: \.self) { first in
                                Text("\(first)")
                                    .font(.title3)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        .onChange(of: self.storyOrder[0]) { oldValue, newValue in
                            if newValue == 2 {
                                self.storyOrder = [2,1,3,4,5]
                            } else if newValue == 3 {
                                self.storyOrder = [3,1,2,4,5]
                            } else if newValue == 4 {
                                self.storyOrder = [4,1,2,3,5]
                            } else if newValue == 5 {
                                self.storyOrder = [5,1,2,3,4]
                            } else {
                                self.storyOrder = [1,2,3,4,5]
                            }
                        }
                        
                        // //// 1スタート
                        if self.storyOrder[0] == 1 {
                            // 2話目
                            Picker("", selection: self.$storyOrder[1]) {
                                ForEach([2,3], id: \.self) { second in
                                    Text("\(second)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[1]) { oldValue, newValue in
                                if newValue == 2 {
                                    self.storyOrder[2] = 3
                                } else {
                                    self.storyOrder[2] = 2
                                }
                            }
                            // 3話目
                            Text("\(self.storyOrder[2])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 4話目
                            Picker("", selection: self.$storyOrder[3]) {
                                ForEach([4,5], id: \.self) { fourth in
                                    Text("\(fourth)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                if newValue == 4 {
                                    self.storyOrder[4] = 5
                                } else {
                                    self.storyOrder[4] = 4
                                }
                            }
                        }
                        
                        // 2スタート
                        else if self.storyOrder[0] == 2 {
                            // 2話目
                            Picker("", selection: self.$storyOrder[1]) {
                                ForEach([1,4], id: \.self) { second in
                                    Text("\(second)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[1]) { oldValue, newValue in
                                if newValue == 1 {
                                    self.storyOrder[2] = 3
                                    self.storyOrder[3] = 4
                                    self.storyOrder[4] = 5
//                                    if self.storyOrder[3] != 4 && self.storyOrder[3] != 5 {
//                                        self.storyOrder[3] = 4
//                                    }
                                } else {
                                    self.storyOrder[2] = 1
                                    self.storyOrder[3] = 3
                                    self.storyOrder[4] = 5
//                                    if self.storyOrder[3] != 3 && self.storyOrder[3] != 5 {
//                                        self.storyOrder[3] = 3
//                                    }
                                }
                            }
                            
                            // 3話目
                            Text("\(self.storyOrder[2])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 4話目
                            if self.storyOrder[1] == 1 {
                                Picker("", selection: self.$storyOrder[3]) {
                                    ForEach([4,5], id: \.self) { fourth in
                                        Text("\(fourth)")
                                            .font(.title3)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(maxWidth: .infinity)
                                .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                    if newValue == 4 {
                                        self.storyOrder[4] = 5
                                    } else {
                                        self.storyOrder[4] = 4
                                    }
                                }
                            } else {
                                Picker("", selection: self.$storyOrder[3]) {
                                    ForEach([3,5], id: \.self) { fourth in
                                        Text("\(fourth)")
                                            .font(.title3)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(maxWidth: .infinity)
                                .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                    if newValue == 3 {
                                        self.storyOrder[4] = 5
                                    } else {
                                        self.storyOrder[4] = 3
                                    }
                                }
                            }
                        }
                        // 3スタート
                        else if self.storyOrder[0] == 3 {
                            // 2話目
                            Text("\(self.storyOrder[1])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 3話目
                            Text("\(self.storyOrder[2])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 4話目
                            Picker("", selection: self.$storyOrder[3]) {
                                ForEach([4,5], id: \.self) { fourth in
                                    Text("\(fourth)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                if newValue == 4 {
                                    self.storyOrder[4] = 5
                                } else {
                                    self.storyOrder[4] = 4
                                }
                            }
                        }
                        // 4スタート
                        else if self.storyOrder[0] == 4 {
                            // 2話目
                            Text("\(self.storyOrder[1])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 3話目
                            Text("\(self.storyOrder[2])")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.secondary)
                                .font(.title3)
                            
                            // 4話目
                            Picker("", selection: self.$storyOrder[3]) {
                                ForEach([3,5], id: \.self) { fourth in
                                    Text("\(fourth)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                if newValue == 3 {
                                    self.storyOrder[4] = 5
                                } else {
                                    self.storyOrder[4] = 3
                                }
                            }
                        }
                        // 5スタート
                        else {
                            // 2話目
                            Picker("", selection: self.$storyOrder[1]) {
                                ForEach([1,2,3,4], id: \.self) { second in
                                    Text("\(second)")
                                        .font(.title3)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                            .onChange(of: self.storyOrder[1]) { oldValue, newValue in
                                if newValue == 1 {
                                    self.storyOrder[2] = 2
                                    self.storyOrder[3] = 3
                                    self.storyOrder[4] = 4
                                } else if newValue == 2 {
                                    self.storyOrder[2] = 1
                                    self.storyOrder[3] = 3
                                    self.storyOrder[4] = 4
                                } else if newValue == 3 {
                                    self.storyOrder[2] = 1
                                    self.storyOrder[3] = 2
                                    self.storyOrder[4] = 4
                                } else {
                                    self.storyOrder[2] = 2
                                    self.storyOrder[3] = 1
                                    self.storyOrder[4] = 3
                                }
                            }
                            
                            // 3話目
                            if self.storyOrder[1] == 4 {
                                Picker("", selection: self.$storyOrder[2]) {
                                    ForEach([2,3], id: \.self) { third in
                                        Text("\(third)")
                                            .font(.title3)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(maxWidth: .infinity)
                                .onChange(of: self.storyOrder[2]) { oldValue, newValue in
                                    if newValue == 2 {
                                        self.storyOrder[3] = 1
                                        self.storyOrder[4] = 3
                                    } else {
                                        self.storyOrder[3] = 1
                                        self.storyOrder[4] = 2
                                    }
                                }
                            } else {
                                Text("\(self.storyOrder[2])")
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(Color.secondary)
                                    .font(.title3)
                            }
                            
                            // 4話目
                            if self.storyOrder[2] == 3 {
                                Picker("", selection: self.$storyOrder[3]) {
                                    ForEach([1,2], id: \.self) { fourth in
                                        Text("\(fourth)")
                                            .font(.title3)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(maxWidth: .infinity)
                                .onChange(of: self.storyOrder[3]) { oldValue, newValue in
                                    if newValue == 1 {
                                        self.storyOrder[4] = 2
                                    } else {
                                        self.storyOrder[4] = 1
                                    }
                                }
                            } else {
                                Text("\(self.storyOrder[3])")
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(Color.secondary)
                                    .font(.title3)
                            }
                        }
                        
                        // 5話目
                        Text("\(self.storyOrder[4])")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.secondary)
                            .font(.title3)
                    }
                    .frame(height: 150)
                }
                
                // //// 示唆表示
                unitCountSubmitWithResult(
                    title: sisaText(order: self.storyOrder),
                    count: bindingForCount(sisa: sisaText(order: self.storyOrder)),
                    bigNumber: magia.$storyOrderCountSum,
                    flushColor: flushColor(sisa: sisaText(order: self.storyOrder)),
                    minusCheck: magia.$minusCheck) {
                        magia.storyOrderSumFunc()
                    }
                
            } header: {
                Text("順番選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.sisaList, id: \.self) { sisa in
                    unitResultCountListPercent(
                        title: sisa,
                        count: bindingForCount(sisa: sisa),
                        flashColor: flushColor(sisa: sisa),
                        bigNumber: $magia.storyOrderCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver352.magiaMenuStoryOrderBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
        .onAppear {
            let array = decodeIntArray(from: magia.orderArrayData)
            if array.count < 5 {
                self.storyOrder = [1,2,3,4,5]
            } else {
                self.storyOrder = array
            }
        }
        .onDisappear {
            saveArray(self.storyOrder, forKey: magia.orderArrayKey)
        }
        .navigationTitle("ストーリーの順番")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetStoryOrder)
                }
            }
        }
    }
    
    private func sisaText(order: [Int]) -> String {
        switch order {
        case[1,2,3,4,5]: return self.sisaList[0]
        case[1,2,3,5,4]: return self.sisaList[2]
        case[1,3,2,4,5]: return self.sisaList[1]
        case[1,3,2,5,4]: return self.sisaList[2]
        case[2,1,3,4,5]: return self.sisaList[3]
        case[2,1,3,5,4]: return self.sisaList[5]
        case[2,4,1,3,5]: return self.sisaList[4]
        case[2,4,1,5,3]: return self.sisaList[5]
        case[3,1,2,4,5]: return self.sisaList[1]
        case[3,1,2,5,4]: return self.sisaList[2]
        case[4,1,2,3,5]: return self.sisaList[4]
        case[4,1,2,5,3]: return self.sisaList[5]
        case[5,1,2,3,4]: return self.sisaList[6]
        case[5,2,1,3,4]: return self.sisaList[7]
        case[5,3,1,2,4]: return self.sisaList[8]
        case[5,4,2,1,3]: return self.sisaList[7]
        case[5,4,3,1,2]: return self.sisaList[9]
        case[5,4,3,2,1]: return self.sisaList[10]
        default: return "???"
        }
    }
    
    private func bindingForCount(sisa: String) -> Binding<Int> {
        switch sisa {
        case self.sisaList[0]: return magia.$storyOrderCountKisuJaku
        case self.sisaList[1]: return magia.$storyOrderCountKisu
        case self.sisaList[2]: return magia.$storyOrderCountKisuHigh
        case self.sisaList[3]: return magia.$storyOrderCountGusuJaku
        case self.sisaList[4]: return magia.$storyOrderCountGusu
        case self.sisaList[5]: return magia.$storyOrderCountGusuHigh
        case self.sisaList[6]: return magia.$storyOrderCountNegate1
        case self.sisaList[7]: return magia.$storyOrderCountNegate2
        case self.sisaList[8]: return magia.$storyOrderCountNegate3
        case self.sisaList[9]: return magia.$storyOrderCountNegate1High
        case self.sisaList[10]: return magia.$storyOrderCountOver5
        default: return .constant(0)
        }
    }
    
    private func flushColor(sisa: String) -> Color {
        switch sisa {
        case self.sisaList[0]: return .personalSummerLightBlue
        case self.sisaList[1]: return .blue
        case self.sisaList[2]: return .green
        case self.sisaList[3]: return .personalSpringLightYellow
        case self.sisaList[4]: return .yellow
        case self.sisaList[5]: return .red
        case self.sisaList[6]: return .brown
        case self.sisaList[7]: return .mint
        case self.sisaList[8]: return .gray
        case self.sisaList[9]: return .purple
        case self.sisaList[10]: return .orange
        default: return .clear
        }
    }
    
    private func countProcess(sisa: String) {
        switch sisa {
        case self.sisaList[0]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountKisuJaku)
        case self.sisaList[1]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountKisu)
        case self.sisaList[2]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountKisuHigh)
        case self.sisaList[3]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountGusuJaku)
        case self.sisaList[4]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountGusu)
        case self.sisaList[5]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountGusuHigh)
        case self.sisaList[6]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountNegate1)
        case self.sisaList[7]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountNegate2)
        case self.sisaList[8]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountNegate3)
        case self.sisaList[9]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountNegate1High)
        case self.sisaList[10]: return countUpDownInout(minusCheck: magia.minusCheck, count: &magia.storyOrderCountOver5)
        default: break
        }
    }
}

#Preview {
    magiaViewStoryOrder(
//        ver352: Ver352(),
        magia: Magia(),
    )
}
