//
//  VVV_CZ.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/06.
//

import SwiftUI

// ////////////////////
// 変数
// ////////////////////
class czVar: ObservableObject {
    @Published var selectedZone = "200G台"     // 液晶ゲーム数ゾーンの選択結果
    @Published var selectedCharacter = "サキ"     // CZキャラの選択結果
    @Published var selectedResult = "革命"     // CZ結果の選択結果
    
    // //// 液晶ゲーム数ゾーン配列の設定
    let zoneArrayKey = "zoneArrayCzVVV"     // 配列を保存するためのキー
    @AppStorage("zoneArrayCzVVV") var zoneArrayCzVVVData: Data?     // JSONデータを保存するためのAppstrage変数
    var zoneArray: [String] {
        if let data = zoneArrayCzVVVData,
           let decodedArray = try? JSONDecoder().decode([String].self, from: data) {
            return decodedArray
        }
        return []
    }
    
    // //// キャラ配列の設定
    let characterArrayKey = "characterArrayCzVVV"     // 配列を保存するためのキー
    @AppStorage("characterArrayCzVVV") var characterArrayCzVVVData: Data?     // JSONデータを保存するためのAppstrage変数
    var characterArray: [String] {
        if let data = characterArrayCzVVVData,
           let decodedArray = try? JSONDecoder().decode([String].self, from: data) {
            return decodedArray
        }
        return []
    }
    
    // //// 結果配列の設定
    let resultArrayKey = "resultArrayCzVVV"     // 配列を保存するためのキー
    @AppStorage("resultArrayCzVVV") var resultArrayCzVVVData: Data?     // JSONデータを保存するためのAppstrage変数
    var resultArray: [String] {
        if let data = resultArrayCzVVVData,
           let decodedArray = try? JSONDecoder().decode([String].self, from: data) {
            return decodedArray
        }
        return []
    }
    
    // //// ボーナス回数関係
    // 革命回数
    var kakumeiCount: Int {
        return resultArray.filter { $0 == "革命" }.count
    }
    // 決戦回数
    var kessenCount: Int {
        return resultArray.filter { $0 == "決戦" }.count
    }
    // 革命比率(%)
    var kakumeiRatio: Double {
        let ratio = Double(kakumeiCount) / Double(kakumeiCount + kessenCount) * 100
        return (kakumeiCount + kessenCount) > 0 ? ratio : 0.0
    }
    
    @AppStorage("vvvCzMinusCheck") var MinusCheck = false
    @Published var isShowDataInputView = false
    
    // Tips
    var addButtonTip = VVVTipCzAddButton()
}


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct VVV_CZ: View {
    @ObservedObject var cz = czVar()
    @State var isShowAlert = false
    @State var isShowexViewCzModeTop = false
    @State var isShowexViewKakumeiRatio = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// 履歴表示部分
                    ScrollView {
                        if cz.zoneArray.count > 0 {
                            ForEach(cz.zoneArray.indices, id: \.self) {index in
                                let ViewIndex = cz.zoneArray.count - index - 1
                                HStack {
                                    Text("\(ViewIndex+1)")
                                        .frame(width: 40)
                                    // ゾーン
                                    Text(cz.zoneArray[ViewIndex])
                                        .frame(maxWidth: .infinity)
                                    Text(cz.characterArray[ViewIndex])
                                        .frame(maxWidth: .infinity)
                                    Text(cz.resultArray[ViewIndex])
                                        .frame(maxWidth: .infinity)
                                }
                                if cz.zoneArray.count > 0 {
                                    Divider()
                                }
                            }
                        }
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
                    .frame(height: 300)
                }
                
                // //// カラム名の表示
                header: {
                    HStack {
                        Text("回数")
                            .frame(width: 40)
                        Text("当選ゾーン")
                            .frame(maxWidth: .infinity)
                        Text("CZキャラ")
                            .frame(maxWidth: .infinity)
                        Text("CZ結果")
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Section {
                    
                    // //// 登録・削除ボタン
                    HStack {
                        Spacer()
                        PlusDeleatButtonView(cz: cz)
                        Spacer()
                    }
                    
                    // //// 参考情報リンク：CZ,モードに関する噂
                    Button(action: {
                        isShowexViewCzModeTop.toggle()
                    }, label: {
                        Text(">> CZ,モードについて")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .sheet(isPresented: $isShowexViewCzModeTop, content: {
                        exViewCzModeTopVVV()
                            .presentationDetents([.medium])
                    })
                    
                    // //// ボーナス回数、比率の部分
                    bonusTimesView()
                    
                    // //// 参考情報リンク：革命比率
                    Button(action: {
                        isShowexViewKakumeiRatio.toggle()
                    }, label: {
                        Text(">> 革命ボーナス比率について")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .sheet(isPresented: $isShowexViewKakumeiRatio, content: {
                        exViewKakumeiRatioVVV()
                            .presentationDetents([.medium])
                    })
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 250)
                } else {
                    
                }
//                Section {
//                    Text("")
//                }
//                .listRowBackground(Color.clear)
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
            .navigationTitle("CZ,ボーナス当選履歴")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // マイナスボタン
                        Button(action: {
                            cz.MinusCheck = !cz.MinusCheck
                        }, label: {
                            if cz.MinusCheck == true{
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(Color.red)
                            } else {
                                Image(systemName: "minus.circle")
                            }
                        })
                        // データリセットボタン
                        Button("リセット", systemImage: "arrow.clockwise.square") {
                            isShowAlert = true
                        }
                        .alert("データリセット", isPresented: $isShowAlert) {
                            Button("キャンセル", role: .cancel) {
                                
                            }
                            Button("リセット", role: .destructive) {
                                VVVfuncResetCz(cz: cz)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("ページ内のデータは完全に消去されます")
                        }
                    }
                }
            }
//        }
//        .navigationTitle("CZ,ボーナス当選履歴")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    Button(action: {
//                        cz.MinusCheck = !cz.MinusCheck
//                    }, label: {
//                        if cz.MinusCheck == true{
//                            Image(systemName: "minus.circle.fill")
//                                .foregroundColor(Color.red)
//                        } else {
//                            Image(systemName: "minus.circle")
//                        }
//                    })
//                    // データリセットボタン
//                    Button("リセット", systemImage: "arrow.clockwise.square") {
//                        isShowAlert = true
//                    }
//                    .alert("データリセット", isPresented: $isShowAlert) {
//                        Button("キャンセル", role: .cancel) {
//                            
//                        }
//                        Button("リセット", role: .destructive) {
//                            VVVfuncResetCz(cz: cz)
//                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
//                        }
//                    } message: {
//                        Text("ページ内のデータは完全に消去されます")
//                    }
//                }
//            }
//        }
    }
}


// /////////////////////////
// ビュー：データの追加、削除ボタン
// /////////////////////////
struct PlusDeleatButtonView: View {
    @ObservedObject var cz = czVar()
    
    var body: some View {
        // データの追加・削除ボタン
        Button(action: {
            if cz.MinusCheck == false {
                cz.isShowDataInputView.toggle()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
            else {
                // ゾーン配列の1行削除
                var toSaveZoneArray = cz.zoneArray
                if toSaveZoneArray.count != 0 {
                    toSaveZoneArray.removeLast()
                    saveArray(toSaveZoneArray, forKey: cz.zoneArrayKey)
                }
                // キャラクター配列の1行削除
                var toSaveCharacterArray = cz.characterArray
                if toSaveCharacterArray.count != 0 {
                    toSaveCharacterArray.removeLast()
                    saveArray(toSaveCharacterArray, forKey: cz.characterArrayKey)
                }
                // CZ結果配列の1行削除
                var toSaveResultArray = cz.resultArray
                if toSaveResultArray.count != 0 {
                    toSaveResultArray.removeLast()
                    saveArray(toSaveResultArray, forKey: cz.resultArrayKey)
                }
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }, label: {
            if cz.MinusCheck == false {
                Image(systemName: "plus")
            }
            else {
                Image(systemName: "minus")
            }
        })
        .buttonStyle(PlusDeleatButtonStyle(MinusBool: cz.MinusCheck))
        .popoverTip(cz.addButtonTip)
        .sheet(isPresented: $cz.isShowDataInputView) {
            DataInputView(cz: cz)
                .presentationDetents([.medium])
        }
    }
}


// /////////////////////////
// ビュー：初当たりデータ入力画面(モーダル遷移)
// /////////////////////////
struct DataInputView: View {
    @ObservedObject var cz = czVar()
    let zones = ["100未満", "100G台", "200G台", "300G台", "400G台", "500G台", "600G台", "700G台", "800G台", "900G台"]
    let characters = ["キューマ", "ライゾウ", "サキ", "アキラ", "マリエ", "3人共闘"]
    let results = ["ハズレ", "革命", "決戦"]
    @Environment(\.dismiss) private var dismiss
    
    // キーボードを非表示にするための変数
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // //// 詳細情報 入力・選択
                Section {
                    HStack(spacing: -10) {
                        // //// ゾーン選択
                        VStack {
                            Text("ゾーン")
                            Picker("ゾーン", selection: $cz.selectedZone) {
                                ForEach(zones, id: \.self) { zone in
//                                    Text($0)
                                    Text(zone)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        
                        // //// キャラクター選択
                        VStack {
                            Text("キャラ")
                            Picker("", selection: $cz.selectedCharacter) {
                                ForEach(characters, id: \.self) { chara in
//                                    Text($0)
                                    Text(chara)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        
                        // 結果選択
                        VStack {
                            Text("CZ結果")
                            Picker("", selection: $cz.selectedResult) {
                                ForEach(results, id: \.self) { result in
//                                    Text($0)
                                    Text(result)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    Button(action: {
                        // ゾーンarrayへのデータ追加
                        var toSaveZoneArray = cz.zoneArray
                        toSaveZoneArray.append(cz.selectedZone)
                        saveArray(toSaveZoneArray, forKey: cz.zoneArrayKey)
                        
                        // キャラクターarrayへのデータ追加
                        var toSaveCharacterArray = cz.characterArray
                        toSaveCharacterArray.append(cz.selectedCharacter)
                        saveArray(toSaveCharacterArray, forKey: cz.characterArrayKey)
                        
                        // 結果arrayへのデータ追加
                        var toSaveResultArray = cz.resultArray
                        toSaveResultArray.append(cz.selectedResult)
                        saveArray(toSaveResultArray, forKey: cz.resultArrayKey)
                        
                        // バイブ
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        
                        // 画面を閉じる
                        dismiss()
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("登録")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    })
                }
            }
            // //// タイトル
            .navigationTitle("履歴登録")
            .toolbarTitleDisplayMode(.inline)
            
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
        // キーボード出てない場合に設定するとうまく動作しなくなる。設定する場所もここではない方がいいかも
//        .onTapGesture {
//            isFocused = false
//        }
    }
}


// ////////////////////////////
// ビュー：革命、決戦回数と比率の表示
// ////////////////////////////
struct bonusTimesView: View {
    @ObservedObject var cz = czVar()
    
    var body: some View {
        HStack {
            HStack {
                // //// 革命ボーナス回数
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("grayBack"))
                        .cornerRadius(15)
                    VStack {
                        Text("革命")
                            .font(.title3)
                            .padding(.top, 3.0)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("\(cz.kakumeiCount)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                }
                
                // //// 決戦ボーナス回数
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("grayBack"))
                        .cornerRadius(15)
                    VStack {
                        Text("決戦")
                            .font(.title3)
                            .padding(.top, 3.0)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("\(cz.kessenCount)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            // 革命比率の表示
            ZStack {
                Rectangle()
                    .foregroundColor(Color("personalSummerLightRed"))
                    .cornerRadius(15)
                VStack {
                    Text("革命比率")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 3.0)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("\(String(format: "%.0f", cz.kakumeiRatio))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 100)
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func VVVfuncResetCz(cz: czVar) {
    
    cz.selectedZone = "200G台"
    cz.selectedCharacter = "サキ"
    cz.selectedResult = "革命"
    // ゾーン配列のリセット
    var toSaveZoneArray = cz.zoneArray
    toSaveZoneArray.removeAll()
    saveArray(toSaveZoneArray, forKey: cz.zoneArrayKey)
    // キャラクター配列のリセット
    var toSaveCharacterArray = cz.characterArray
    toSaveCharacterArray.removeAll()
    saveArray(toSaveCharacterArray, forKey: cz.characterArrayKey)
    // 結果配列のリセット
    var toSaveResultArray = cz.resultArray
    toSaveResultArray.removeAll()
    saveArray(toSaveResultArray, forKey: cz.resultArrayKey)
    cz.MinusCheck = false
}

#Preview {
    VVV_CZ()
}
