//
//  hokutoViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/07.
//

import SwiftUI
import TipKit

struct hokutoViewVoice: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var hokuto: Hokuto
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー
                Picker(selection: $hokuto.selectedVoice) {
                    ForEach(hokuto.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // //// 選択されているボイスのカウント表示
                // リン
                if hokuto.selectedVoice == hokuto.selectListVoice[0] {
                    unitResultCountListPercent(title: "デフォルト", count: $hokuto.voiceDefaultCount, flashColor: .gray, bigNumber: $hokuto.voiceCountSum)
                }
                // シン
                else if hokuto.selectedVoice == hokuto.selectListVoice[2] {
                    unitResultCountListPercent(title: "高設定示唆(最弱)", count: $hokuto.voiceShinCount, flashColor: .blue, bigNumber: $hokuto.voiceCountSum)
                }
                // サウザー
                else if hokuto.selectedVoice == hokuto.selectListVoice[3] {
                    unitResultCountListPercent(title: "高設定示唆(弱)", count: $hokuto.voiceSauzaCount, flashColor: .yellow, bigNumber: $hokuto.voiceCountSum)
                }
                // ジャギ
                else if hokuto.selectedVoice == hokuto.selectListVoice[4] {
                    unitResultCountListPercent(title: "高設定示唆(中)", count: $hokuto.voiceJagiCount, flashColor: .green, bigNumber: $hokuto.voiceCountSum)
                }
                // アミバ
                else if hokuto.selectedVoice == hokuto.selectListVoice[5] {
                    unitResultCountListPercent(title: "高設定示唆(強)", count: $hokuto.voiceAmibaCount, flashColor: .red, bigNumber: $hokuto.voiceCountSum)
                }
                // ケンシロウ
                else if hokuto.selectedVoice == hokuto.selectListVoice[6] {
                    unitResultCountListPercent(title: "設定4以上濃厚", count: $hokuto.voiceKenCount, flashColor: .purple, bigNumber: $hokuto.voiceCountSum)
                }
                // ユリア
                else if hokuto.selectedVoice == hokuto.selectListVoice[7] {
                    unitResultCountListPercent(title: "設定5以上濃厚", count: $hokuto.voiceYuriaCount, flashColor: .purple, bigNumber: $hokuto.voiceCountSum)
                }
                // バット
                else {
                    unitResultCountListPercent(title: "デフォルト", count: $hokuto.voiceDefaultCount, flashColor: .gray, bigNumber: $hokuto.voiceCountSum)
                }
                
                // //// 登録ボタン
                Button(action: {
                    // リン
                    if hokuto.selectedVoice == hokuto.selectListVoice[0] {
                        hokuto.voiceDefaultCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceDefaultCount)
                    }
                    // シン
                    else if hokuto.selectedVoice == hokuto.selectListVoice[2] {
                        hokuto.voiceShinCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceShinCount)
                    }
                    // サウザー
                    else if hokuto.selectedVoice == hokuto.selectListVoice[3] {
                        hokuto.voiceSauzaCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceSauzaCount)
                    }
                    // ジャギ
                    else if hokuto.selectedVoice == hokuto.selectListVoice[4] {
                        hokuto.voiceJagiCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceJagiCount)
                    }
                    // アミバ
                    else if hokuto.selectedVoice == hokuto.selectListVoice[5] {
                        hokuto.voiceAmibaCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceAmibaCount)
                    }
                    // ケンシロウ
                    else if hokuto.selectedVoice == hokuto.selectListVoice[6] {
                        hokuto.voiceKenCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceKenCount)
                    }
                    // ユリア
                    else if hokuto.selectedVoice == hokuto.selectListVoice[7] {
                        hokuto.voiceYuriaCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceYuriaCount)
                    }
                    // バット
                    else {
                        hokuto.voiceDefaultCount = countUpDown(minusCheck: hokuto.minusCheck, count: hokuto.voiceDefaultCount)
                    }
                }, label: {
                    HStack {
                        Spacer()
                        if hokuto.minusCheck == false {
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
                })
            } header: {
                Text("ボイス選択")
            }
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(title: "デフォルト", count: $hokuto.voiceDefaultCount, flashColor: .gray, bigNumber: $hokuto.voiceCountSum)
                // シン
                unitResultCountListPercent(title: "高設定示唆(最弱)", count: $hokuto.voiceShinCount, flashColor: .blue, bigNumber: $hokuto.voiceCountSum)
                // サウザー
                unitResultCountListPercent(title: "高設定示唆(弱)", count: $hokuto.voiceSauzaCount, flashColor: .yellow, bigNumber: $hokuto.voiceCountSum)
                // ジャギ
                unitResultCountListPercent(title: "高設定示唆(中)", count: $hokuto.voiceJagiCount, flashColor: .green, bigNumber: $hokuto.voiceCountSum)
                // アミバ
                unitResultCountListPercent(title: "高設定示唆(強)", count: $hokuto.voiceAmibaCount, flashColor: .red, bigNumber: $hokuto.voiceCountSum)
                // ケンシロウ
                unitResultCountListPercent(title: "設定4以上濃厚", count: $hokuto.voiceKenCount, flashColor: .purple, bigNumber: $hokuto.voiceCountSum)
                // ユリア
                unitResultCountListPercent(title: "設定5以上濃厚", count: $hokuto.voiceYuriaCount, flashColor: .purple, bigNumber: $hokuto.voiceCountSum)
                // 参考情報
                unitLinkButton(title: "BB後のボイスについて", exview: AnyView(unitExView5body2image(title: "BB後のボイスについて", textBody1: "・AT終了後にサブ液晶をタッチ", textBody2: "・1G連時は確率が違うため除外", textBody3: "・アミバは強いと言われている", image1: Image("hokutoVoice"), image2: Image("hokutoVoice2"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(hokutoView95Ci(hokuto: hokuto, selection: 4)))
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hokutoViewBayes(
//                        ver380: ver380,
                        hokuto: hokuto,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
            
            // //// 画面下の余白
            if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                unitClearScrollSection(spaceHeight: 200)
            } else {
                
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スマスロ北斗の拳",
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
        .navigationTitle("BB後のボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $hokuto.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetVoice)
                }
            }
        }
    }
}

#Preview {
    hokutoViewVoice(
//        ver380: Ver380(),
        hokuto: Hokuto(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
