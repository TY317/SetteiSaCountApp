//
//  vvvViewCzHistoryVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/06.
//

import SwiftUI

class vvvCzHistory: ObservableObject {
    // 選択肢の設定
    let zones = ["100未満", "100G台", "200G台", "300G台", "400G台", "500G台", "600G台", "700G台", "800G台", "900G台"]
    let characters = ["キューマ", "ライゾウ", "サキ", "アキラ", "マリエ", "3人共闘"]
    let results = ["ハズレ", "革命", "決戦"]
    // 選択結果の設定
    @Published var selectedZone = "200G台"     // 液晶ゲーム数ゾーンの選択結果
    @Published var selectedCharacter = "サキ"     // CZキャラの選択結果
    @Published var selectedResult = "革命"     // CZ結果の選択結果
    // //// 配列の設定
    // ゾーン配列
    let zoneArrayKey = "zoneArrayCzVVV"
    @AppStorage("zoneArrayCzVVV") var zoneArrayCzVVVData: Data?
    // キャラクター配列
    let characterArrayKey = "characterArrayCzVVV"
    @AppStorage("characterArrayCzVVV") var characterArrayCzVVVData: Data?
    // 結果配列
    let resultArrayKey = "resultArrayCzVVV"
    @AppStorage("resultArrayCzVVV") var resultArrayCzVVVData: Data?
    // //// 集計結果の変数設定
    @AppStorage("vvvKakumeiCount") var kakumeiCount = 0 {
        didSet {
            bonusCountSum = countSum(kakumeiCount, kessenCount)
        }
    }
        @AppStorage("vvvKessenCount") var kessenCount = 0 {
            didSet {
                bonusCountSum = countSum(kakumeiCount, kessenCount)
            }
        }
    @AppStorage("vvvBonusCountSum") var bonusCountSum = 0
    
    @AppStorage("vvvCzMinusCheck") var MinusCheck = false
    
    // 1行削除
    func removeLastHistory() {
        arrayStringRemoveLast(arrayData: zoneArrayCzVVVData, key: zoneArrayKey)
        arrayStringRemoveLast(arrayData: characterArrayCzVVVData, key: characterArrayKey)
        arrayStringRemoveLast(arrayData: resultArrayCzVVVData, key: resultArrayKey)
        kakumeiCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "革命")
        kessenCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "決戦")
        selectedZone = "200G台"
        selectedCharacter = "サキ"
        selectedResult = "革命"
    }
    
    // データ追加
    func addDataHistory() {
        arrayStringAddData(arrayData: zoneArrayCzVVVData, addData: selectedZone, key: zoneArrayKey)
        arrayStringAddData(arrayData: characterArrayCzVVVData, addData: selectedCharacter, key: characterArrayKey)
        arrayStringAddData(arrayData: resultArrayCzVVVData, addData: selectedResult, key: resultArrayKey)
        kakumeiCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "革命")
        kessenCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "決戦")
        selectedZone = "200G台"
        selectedCharacter = "サキ"
        selectedResult = "革命"
    }
    
    func resetHistory() {
        arrayStringRemoveAll(arrayData: zoneArrayCzVVVData, key: zoneArrayKey)
        arrayStringRemoveAll(arrayData: characterArrayCzVVVData, key: characterArrayKey)
        arrayStringRemoveAll(arrayData: resultArrayCzVVVData, key: resultArrayKey)
        kakumeiCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "革命")
        kessenCount = arrayStringDataCount(arrayData: resultArrayCzVVVData, countString: "決戦")
        selectedZone = "200G台"
        selectedCharacter = "サキ"
        selectedResult = "革命"
        MinusCheck = false
    }
}

struct vvvViewCzHistoryVer2: View {
    @ObservedObject var vvv = vvvCzHistory()
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            // //// 履歴表示、登録
            Section {
                ScrollView {
                    // 配列のデータが0以上なら履歴表示
                    let zoneArray = decodeStringArray(from: vvv.zoneArrayCzVVVData)
                    if zoneArray.count > 0 {
                        ForEach(zoneArray.indices, id: \.self) { index in
                            let viewIndex = zoneArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // ゾーン
                                if zoneArray.indices.contains(viewIndex) {
                                    Text(zoneArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // キャラクター
                                let characterArray = decodeStringArray(from: vvv.characterArrayCzVVVData)
                                if characterArray.indices.contains(viewIndex) {
                                    Text(characterArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                }
                                // CZ結果
                                let resultArray = decodeStringArray(from: vvv.resultArrayCzVVVData)
                                if resultArray.indices.contains(viewIndex) {
                                    Text(resultArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
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
                .frame(height: self.scrollViewHeight)
                
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if vvv.MinusCheck {
                            let zoneArray = decodeStringArray(from: vvv.zoneArrayCzVVVData)
                            if zoneArray.count > 0 {
                                vvv.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if vvv.MinusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: vvv.MinusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        vvvSubViewDataInput(vvv: vvv)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                unitLinkButton(title: "CZ,モードについて", exview: AnyView(exViewCzModeTopVVV()))
            } header: {
                unitHeaderHistoryColumns(column2: "当選ゾーン", column3: "CZキャラ", column4: "CZ結果")
            }
            
            // //// 革命比率
            Section {
                HStack {
                    HStack {
                        unitResultCount2Line(title: "革命", color: .grayBack, count: $vvv.kakumeiCount)
                        unitResultCount2Line(title: "決戦", color: .grayBack, count: $vvv.kessenCount)
                    }
                    .frame(maxWidth: .infinity)
                    unitResultRatioPercent2Line(title: "革命比率", color: .grayBack, count: $vvv.kakumeiCount, bigNumber: $vvv.bonusCountSum, numberofDicimal: 0)
                }
                // //// 参考情報リンク
                unitLinkButton(title: "革命ボーナス比率について", exview: AnyView(exViewKakumeiRatioVVV()))
            } header: {
                Text("革命比率")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
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
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
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
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .navigationTitle("CZ,ボーナス当選履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $vvv.MinusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: vvv.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////////////
// ビュー：データインプットビュー
// ///////////////////////////////
struct vvvSubViewDataInput: View {
    @ObservedObject var vvv: vvvCzHistory
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // //// サークルピッカー横並び
                HStack {
                    // ゾーン
                    unitPickerCircleString(title: "ゾーン", selected: $vvv.selectedZone, selectList: vvv.zones)
                    // キャラクター
                    unitPickerCircleString(title: "キャラ", selected: $vvv.selectedCharacter, selectList: vvv.characters)
                    // 結果
                    unitPickerCircleString(title: "CZ結果", selected: $vvv.selectedResult, selectList: vvv.results)
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        vvv.addDataHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        dismiss()
                    } label: {
                        Text("登録")
                            .fontWeight(.bold)
                    }
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

#Preview {
    vvvViewCzHistoryVer2()
}
