//
//  karakuriViewMakuai.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/29.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：幕間カウントボタンの機能説明
// //////////////////
struct karakuriTipMakuaiCountButton: Tip {
    var title: Text {
        Text("通常幕間のカウントと記録")
    }
    var message: Text? {
        Text("タップでカウント＆現在スイカ回数を履歴に登録し、スイカ回数をリセット\nマイナスチェック時は減算＆履歴を1行削除")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：ゲーム数についての説明
// //////////////////
struct karakuriMakuaiGame: Tip {
    var title: Text {
        Text("通常幕間のカウントと記録")
    }
    var message: Text? {
        Text("タップでカウント＆現在スイカ回数を履歴に登録し、スイカ回数をリセット\nマイナスチェック時は減算＆履歴を1行削除")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct karakuriViewMakuai: View {
//    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuri: Karakuri
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var spaceHeight = 250.0
    var body: some View {
        List {
            // //// カウント部分
            Section {
                HStack {
                    // スイカカウント
                    unitCountButtonVerticalWithoutRatio(title: "幕間チャンス間\nスイカ", count: $karakuri.suikaCount, color: .personalSummerLightGreen, minusBool: $karakuri.minusCheck)
                    // 幕間チャンス
                    ZStack {
                        // 背景フラッシュ部分
                        Rectangle()
                            .backgroundFlashModifier(trigger: karakuri.makuaiCount, color: .personalSummerLightRed)
                        // //// ボタンと表示部分
                        VStack(spacing: 5) {
                            // タイトル
                            Text("\n幕間チャンス")
                                .multilineTextAlignment(.center)
                            // 回数
                            if karakuri.makuaiCount < 1000{
                                Text("\(karakuri.makuaiCount)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                            }
                            else {
                                Text("\(karakuri.makuaiCount)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .padding(.vertical, 8.0)
                            }
                            // カウントボタン
                            Button(action: {
                                karakuri.makuaiCount = countUpDown(minusCheck: karakuri.minusCheck, count: karakuri.makuaiCount)
                                if karakuri.minusCheck == false {
                                    karakuri.addDataHistoryMakuai()
                                    karakuri.suikaCount = 0
                                } else {
                                    let suikaArray = decodeIntArray(from: karakuri.suikaCountArrayData)
                                    if suikaArray.count > 0 {
                                        karakuri.removeLastHistoryMakuai()
                                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                                    } else {
                                        
                                    }
                                }
                            }, label: {
                                Text("")
                            })
                            .buttonStyle(CountButtonStyle(color: .personalSummerLightRed, MinusBool: karakuri.minusCheck))
                            .popoverTip(karakuriTipMakuaiCountButton())
                        }
                    }
                }

            } header: {
                Text("スイカと幕間チャンスのカウント")
            }
            
            // //// 履歴部分
            Section {
                // //// 配列のデータが0以上なら履歴表示
                let suikaArray = decodeIntArray(from: karakuri.suikaCountArrayData)
                if suikaArray.count > 0 {
                    ForEach(suikaArray.indices, id: \.self) { index in
                        let viewIndex = suikaArray.count - index - 1
                        HStack {
                            // 回数
                            Text("\(viewIndex+1)")
                                .frame(width: 40.0)
                            // 規定スイカ回数
                            if suikaArray.indices.contains(viewIndex) {
                                Text("\(suikaArray[viewIndex])")
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("-")
                                    .frame(maxWidth: .infinity)
                            }
                        }
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
//                    .padding(.top)
                }
            } header: {
                VStack {
                    Text("通常幕間の履歴")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    unitHeaderHistoryColumns(column2: "規定スイカ回数")
                }
            }
            
            // //// ゲーム数入力と確率算出
            Section {
                // ゲーム数入力部分
                unitTextFieldGamesInput(title: "消化ゲーム数", inputValue: $karakuri.makuaiPlayGame)
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
                // 確率の算出
                unitResultRatioDenomination2Line(title: "通常幕間出現率", color: .grayBack, count: $karakuri.makuaiCount, bigNumber: $karakuri.makuaiPlayGame, numberofDicimal: 0)
                // 参考情報リンク
                unitLinkButton(title: "通常時の幕間チャンスについて", exview: AnyView(unitExView5body2image(title: "通常時の幕間チャンス", textBody1: "・通常時からくりレア役（スイカ）契機の幕間チャンス出現率に設定差あり", textBody2: "・高設定ほどスイカの規定回数が少ない回数が選ばれやすいと思われる", textBody3: "・スイカの出現確率が約1/100なので設定6では規定回数の平均が10回程度になる計算", image1: Image("karakuriMakuai"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(karakuriView95Ci(karakuri: karakuri, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("現在ゲーム数と幕間出現率")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "からくりサーカス",
                screenClass: screenClass
            )
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
                self.spaceHeight = 0
            } else {
                self.spaceHeight = 250.0
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
                    self.spaceHeight = 0
                } else {
                    self.spaceHeight = 250.0
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("スイカと通常幕間")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetMakuai)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    karakuriViewMakuai(karakuri: Karakuri())
}
