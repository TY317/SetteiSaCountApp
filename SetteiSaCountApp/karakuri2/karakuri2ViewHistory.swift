//
//  karakuri2ViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct karakuri2ViewHistory: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var karakuri2: Karakuri2
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
    let imageNameList: [String] = [
        "karakuri2CzScreen0",
        "karakuri2CzScreen1",
        "karakuri2CzScreen2",
        "karakuri2CzScreen3",
        "karakuri2CzScreen4",
        "karakuri2CzScreen5",
        "karakuri2CzScreen6",
        "karakuri2CzScreen7",
    ]
    let upperBeltTextList: [String] = [
        "AT当選",
        "鳴海",
        "勝",
        "しろがね",
        "ギイ＆オリンピア",
        "舌出し",
        "オートマータ",
        "ピエロ",
    ]
    let lowerBeltTextList: [String] = [
        "-",
        "???",
        "???",
        "???",
        "???",
        "???",
        "???",
        "???",
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7]

    var body: some View {
        List {
            // ---- 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "液晶ゲーム数",
                    inputValue: $karakuri2.inputGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                // 前兆種類
                unitPickerMenuString(
                    title: "CZ種類",
                    selected: $karakuri2.selectedKind,
                    selectlist: karakuri2.kindList
                )
                // カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                Button {
                                    if karakuri2.selectedImageName == self.imageNameList[index] {
                                        karakuri2.selectedImageName = ""
                                    }
                                    else {
                                        karakuri2.selectedImageName = self.imageNameList[index]
                                    }
                                } label: {
                                    unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        lowerBeltText: self.lowerBeltTextList[index],
                                    )
                                    .overlay {
                                        if karakuri2.selectedImageName == self.imageNameList[index] {
                                            Rectangle()
                                                .foregroundStyle(Color.white)
                                                .opacity(0.6)
                                                .border(Color.green, width: 10)
                                                .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if karakuri2.minusCheck {
                        karakuri2.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        karakuri2.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        karakuri2.selectedImageName = ""
                    }
                } label: {
                    unitButtonSubmitLabel(minusCheck: karakuri2.minusCheck)
                }
            } header: {
                HStack {
                    Text("CZ結果登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "CZ結果登録",
                            textBody1: "CZ、失敗画面の結果メモとしてご利用下さい",
                        )
                    }
                }
            }
            
            // ---- 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: karakuri2.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 液晶G数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: 80)
                                }
                                // 前兆種類
                                let kindArray = decodeStringArray(from: karakuri2.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    Text(kindText(kind: kindArray[viewIndex]))
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // 終了画面
                                let screenArray = decodeStringArray(from: karakuri2.screenArrayData)
                                if screenArray.indices.contains(viewIndex) {
                                    if let screenIndex = self.imageNameList.firstIndex(where: { $0 == screenArray[viewIndex] }) {
                                        unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[screenIndex]),
                                            upperBeltText: self.upperBeltTextList[screenIndex],
                                            upperBeltFont: .subheadline,
                                            upperBeltBool: false,
                                            lowerBeltText: self.lowerBeltTextList[screenIndex],
                                            lowerBeltFont: .subheadline,
                                        )
                                        .frame(height: 80)
                                        .frame(maxWidth: .infinity)
                                    } else {
                                        Rectangle()
                                            .foregroundStyle(Color.clear)
                                            .frame(height: 80)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                            Divider()
                        }
                    }
                    // //// 配列のデータ数が0なら履歴なしを表示
                    else {
                        unitLabelHistoryZero()
                    }
                }
                .frame(height: self.scrollViewHeight)
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "液晶G数",
                    column3: "CZ種類",
                    column4: "終了画面",
                    column2MaxWidth: 80,
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.karakuri2MenuHistoryBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ履歴")
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
                unitButtonMinusCheck(minusCheck: $karakuri2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: karakuri2.resetHistory)
            }
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
    }
    
    private func kindText(kind: String) -> String {
        switch kind {
        case karakuri2.kindList[1]: return "幕間(AT後)"
        case karakuri2.kindList[2]: return "幕間(通常時)"
        case karakuri2.kindList[3]: return "劇場"
        default: return "女神"
        }
    }
}

#Preview {
    karakuri2ViewHistory(
        karakuri2: Karakuri2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
