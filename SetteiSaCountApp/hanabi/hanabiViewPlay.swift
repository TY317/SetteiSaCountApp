//
//  hanabiViewPlay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/07.
//

import SwiftUI
import Vision
import UIKit
import PhotosUI
import TipKit

// //////////////////
// Tip：画像からの自動入力
// //////////////////
struct tipHanabiOcr: Tip {
    var title: Text {
        Text("スクショから自動入力")
    }
    var message: Text? {
        Text("ユニメモのスクショ画像から設定判別に必要な要素を自動入力できます")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


struct hanabiViewPlay: View {
    @ObservedObject var hanabi: Hanabi
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
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
    
    @State private var selectedItem: PhotosPickerItem?
    @State var isShowResult: Bool = false
    @State var itemList: [String] = []
    @State var resultList: [String] = []
    @State var statusTitle: String = "読み取り中・・"
    @State var colorList: [Color] = []
    let sameHeightRatio: CGFloat = 0.01
    let nearHeightRatio: CGFloat = 0.03
    let nearTitleHeightRatio: CGFloat = 0.2
    
    @State private var selectedItems: [PhotosPickerItem] = []
    let ocrMenuList: [String] = [
        "総プレイ数",
        "花火チャレンジプレイ数",
        "花火GAMEプレイ数",
        "総BB回数",
        "総RB回数",
        "風鈴A",
        "風鈴B",
        "氷A",
        "氷B",
        "チェリーA1",
        "チェリーA2",
        "チェリーB",
        "花火チャレンジはずれ",
        "花火GAMEはずれ",
        "BB中 風鈴A",
        "BB中 風鈴B",
        "1枚役回数",
//        "1枚役確率",
    ]
    @State var ocrResultTextList: [String] = []
    @State var ocrResultColorList: [Color] = []
    @State var ocrNeedCheckList: [Bool] = []
    let searchAreaUpper: [CGFloat] = [
        0.3,
        0.3,
        0.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
        1.3,
//        -0.1,
    ]
    let searchAreaLower: [CGFloat] = [
        0.3,
        0.3,
        0.3,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
//        1.3,
    ]
    let searchArea: CGFloat = 0.7
    let halfRightRatio: CGFloat = 0.5
    let titleSearchArea: CGFloat = 10
    
    var body: some View {
        List {
            // ---- ユニメモ画像読み込み
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("・ユニメモのスクリーンショット画像をご用意ください")
                    Text("・風鈴A,Bは通常中小役またはBB中小役のオレンジ帯の文字が写っていないと読み取りエラーとなります")
                    Text("・読み取り後は必ずご自身で数値をご確認下さい")
                }
                
                // フォトピッカー複数選択
                HStack {
                    Spacer()
                    PhotosPicker(
                        "画像選択して自動入力",
                        selection: self.$selectedItems,
                        maxSelectionCount: 10,
                        selectionBehavior: .ordered,
                        matching: .images,
                    )
                    .buttonStyle(BorderedProminentButtonStyle())
                    .onChange(of: self.selectedItems) { oldValue, newValue in
                        // 選択されたアイテムが空なら何もしない
                        guard !newValue.isEmpty else { return }
                        
                        // 初期化処理
                        self.ocrResultTextList = Array(repeating: "読み取り中・・", count: ocrMenuList.count)  // 結果テキスト
                        self.ocrResultColorList = Array(repeating: .yellow, count: ocrMenuList.count) // 結果テキスト色
                        self.ocrNeedCheckList = Array(repeating: true, count: ocrMenuList.count)   // 読み取り結果
                        self.statusTitle = "読み取り中・・"  // 結果表示のタイトルを読み取り中にリセット
                        self.isShowResult.toggle()   // 結果表示を発火
                        
                        // 複数画像の処理
                        Task {
                            for item in newValue {
                                // 画像データをロード
                                if let data = try? await item.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    
                                    // 1枚ずつ解析関数を呼ぶ
                                    ocrImg(uiImage: uiImage)
                                }
                            }
                            
                            // 終了後の処理
                            finalResultUpdate()  // 読み取り終わったら結果を整理しタイトルを更新
                            hanabi.gameSumFunc()
                            hanabi.bonusSumFunc()
                            hanabi.bellSumFunc()
                            hanabi.kohriSumFunc()
//                            hanabi.rb1MaiGameCal()
                            hanabi.rbGameCal()
                            hanabi.bbGameCal()
                            self.statusTitle = "読み取り完了"   // 結果表示画面のタイトルを完了に更新
                            self.selectedItems = []   // 次の解析に備えて選択を解除しておく
                        }
                    }
                    .sheet(isPresented: self.$isShowResult, content: {
                        NavigationView {
                            ScrollView {
                                // タイトル表示
                                Text(self.statusTitle)
                                    .font(.title)
                                    .padding(.bottom)
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        ForEach(self.ocrMenuList.indices, id: \.self) { index in
                                            if self.ocrMenuList.indices.contains(index) &&
                                                self.ocrResultTextList.indices.contains(index) &&
                                                self.ocrResultColorList.indices.contains(index) {
                                                Text(self.ocrMenuList[index])
                                                    .foregroundStyle(self.ocrResultColorList[index])
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.7)
                                            }
                                        }
                                    }
                                    VStack {
                                        ForEach(self.ocrMenuList.indices, id: \.self) { index in
                                            if self.ocrMenuList.indices.contains(index) &&
                                                self.ocrResultTextList.indices.contains(index) &&
                                                self.ocrResultColorList.indices.contains(index) {
                                                Text(" : ")
                                                    .foregroundStyle(self.ocrResultColorList[index])
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.7)
                                            }
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        ForEach(self.ocrMenuList.indices, id: \.self) { index in
                                            if self.ocrMenuList.indices.contains(index) &&
                                                self.ocrResultTextList.indices.contains(index) &&
                                                self.ocrResultColorList.indices.contains(index) {
                                                Text(self.ocrResultTextList[index])
                                                    .foregroundStyle(self.ocrResultColorList[index])
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.7)
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            // //// ツールバー閉じるボタン
                            .toolbar {
                                ToolbarItem(placement: .automatic) {
                                    Button(action: {
                                        self.isShowResult = false
                                    }, label: {
                                        Text("閉じる")
                                            .fontWeight(.bold)
                                    })
                                }
                            }
                        }
                        .presentationDetents([.large])
                    })
                    .popoverTip(tipHanabiOcr())
                    
                    Spacer()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hanabiView95Ci(
                            hanabi: hanabi,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hanabiViewBayes(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                HStack {
                    Text("ユニメモ画像から自動入力")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "自動入力",
                            textBody1: "・ユニメモの画像からプレイデータを読み取り自動入力します",
                            textBody2: "・ユニメモの画像保存機能で保存した画像もご利用可能ですが、画質が低いため読み取り精度が下がる場合があります",
                            textBody3: "・風鈴A,風鈴Bは「通常中小役」または「BB中小役」のオレンジ帯の文字が写っていないと読み取りエラーとなります",
                            textBody4: "・誤った数値を読み取る可能性もありますので、必ず自動入力後の数値をご自身でご確認の上ご利用ください"
                        )
                    }
                }
            }
            
            // ---- ゲーム数
            Section {
                // ゲーム数入力
                unitTextGameNumberWithoutInput(
                    titleText: "打ち始め総ゲーム数",
                    gameNumber: hanabi.startGame,
                    titleFont: .subheadline,
                )
                // 総プレイ数
                unitTextFieldNumberInputWithUnit(
                    title: "総プレイ数",
                    inputValue: $hanabi.playGame,
                    titleFont: .subheadline,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                .onChange(of: hanabi.playGame) { oldValue, newValue in
                    hanabi.gameSumFunc()
                }
                // チャレンジプレイ数
                unitTextFieldNumberInputWithUnit(
                    title: "花火チャレンジプレイ数",
                    inputValue: $hanabi.challengeGame,
                    titleFont: .footnote,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // 花火ゲームプレイ数
                unitTextFieldNumberInputWithUnit(
                    title: "花火GAMEプレイ数",
                    inputValue: $hanabi.hanabiGame,
                    titleFont: .subheadline,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
            } header: {
                Text("ゲーム数")
            }
            
            // ---- 初当り
            Section {
                // 確率結果
                HStack {
                    // BIG
                    unitResultRatioDenomination2Line(
                        title: "BIG",
                        count: $hanabi.totalBig,
                        bigNumber: $hanabi.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // REG
                    unitResultRatioDenomination2Line(
                        title: "REG",
                        count: $hanabi.totalReg,
                        bigNumber: $hanabi.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: hanabi.ratioBig
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: hanabi.ratioReg
                        )
                    }
                }
                
                // データ詳細
                DisclosureGroup("データ詳細") {
                    // 累計ゲーム数
                    unitTextGameNumberWithoutInput(
                        titleText: "累計ゲーム数",
                        gameNumber: hanabi.totalGame,
                        titleFont: .subheadline,
                    )
                    // 打ち始めBIG
                    unitTextGameNumberWithoutInput(
                        titleText: "打ち始めBIG",
                        gameNumber: hanabi.startBig,
                        titleFont: .subheadline,
                        unitText: "回",
                    )
                    // 打ち始めBIG
                    unitTextGameNumberWithoutInput(
                        titleText: "打ち始めREG",
                        gameNumber: hanabi.startReg,
                        titleFont: .subheadline,
                        unitText: "回",
                    )
                    
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "総BB",
                        inputValue: $hanabi.playBig,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.playBig) { oldValue, newValue in
                        hanabi.bonusSumFunc()
                        hanabi.bbGameCal()
                    }
                    
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "総RB",
                        inputValue: $hanabi.playReg,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.playReg) { oldValue, newValue in
                        hanabi.bonusSumFunc()
                        hanabi.rbGameCal()
                    }
                }
            } header: {
                Text("初当り")
            }
            
            // ---- 通常時小役
            Section {
                // 確率結果
                HStack {
                    // 風鈴合算
                    unitResultRatioDenomination2Line(
                        title: "風鈴合算",
                        count: $hanabi.normalKoyakuCountBellSum,
                        bigNumber: $hanabi.playGame,
                        numberofDicimal: 2,
                        spacerBool: false,
                    )
                    // 氷合算
                    unitResultRatioDenomination2Line(
                        title: "氷A",
                        count: $hanabi.normalKoyakuCountKohriA,
                        bigNumber: $hanabi.playGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // チェリーA2
                    unitResultRatioDenomination2Line(
                        title: "チェリーA2",
                        count: $hanabi.normalKoyakuCountCherryA2,
                        bigNumber: $hanabi.playGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,5,6])
                            unitTableDenominate(
                                columTitle: "風鈴合算",
                                denominateList: hanabi.ratioBellSum,
                                numberofDicimal: 2,
                            )
                            unitTableDenominate(
                                columTitle: "氷A",
                                denominateList: hanabi.ratioKohriA,
                                numberofDicimal: 1,
                            )
                            unitTableDenominate(
                                columTitle: "チェリーA2",
                                denominateList: hanabi.ratioCherryA2,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                
                DisclosureGroup("データ詳細") {
                    // 総プレイ数
                    unitTextGameNumberWithoutInput(
                        titleText: "総プレイ数",
                        gameNumber: hanabi.playGame,
                        titleFont: .subheadline,
                    )
                    // 風鈴A
                    unitTextFieldNumberInputWithUnit(
                        title: "風鈴A",
                        inputValue: $hanabi.normalKoyakuCountBellA,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.normalKoyakuCountBellA) { oldValue, newValue in
                        hanabi.normalKoyakuCountBellSum = hanabi.normalKoyakuCountBellA + hanabi.normalKoyakuCountBellB
                    }
                    
                    // 風鈴B
                    unitTextFieldNumberInputWithUnit(
                        title: "風鈴B",
                        inputValue: $hanabi.normalKoyakuCountBellB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.normalKoyakuCountBellB) { oldValue, newValue in
                        hanabi.normalKoyakuCountBellSum = hanabi.normalKoyakuCountBellA + hanabi.normalKoyakuCountBellB
                    }
                    
                    // 氷A
                    unitTextFieldNumberInputWithUnit(
                        title: "氷A",
                        inputValue: $hanabi.normalKoyakuCountKohriA,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.normalKoyakuCountKohriA) { oldValue, newValue in
                        hanabi.kohriSumFunc()
                    }
                    
                    // 氷B
                    unitTextFieldNumberInputWithUnit(
                        title: "氷B",
                        inputValue: $hanabi.normalKoyakuCountKohriB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.normalKoyakuCountKohriB) { oldValue, newValue in
                        hanabi.kohriSumFunc()
                    }
                    
                    // チェリーA1
                    unitTextFieldNumberInputWithUnit(
                        title: "チェリーA1",
                        inputValue: $hanabi.normalKoyakuCountCherryA1,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // チェリーA2
                    unitTextFieldNumberInputWithUnit(
                        title: "チェリーA2",
                        inputValue: $hanabi.normalKoyakuCountCherryA2,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // チェリーB
                    unitTextFieldNumberInputWithUnit(
                        title: "チェリーB",
                        inputValue: $hanabi.normalKoyakuCountCherryB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // 参考情報）小役確率詳細
                    unitLinkButtonViewBuilder(sheetTitle: "小役確率詳細") {
                        VStack {
                            // ベル
                            HStack(spacing: 0) {
                                unitTableSettingIndex(settingList: [1,2,5,6])
                                unitTableDenominate(
                                    columTitle: "風鈴A",
                                    denominateList: hanabi.ratioBellA,
                                    numberofDicimal: 1,
                                )
                                unitTableDenominate(
                                    columTitle: "風鈴B",
                                    denominateList: hanabi.ratioBellB,
                                    numberofDicimal: 1,
                                )
                            }
                            
                            // 氷
                            HStack(spacing: 0) {
                                unitTableSettingIndex(settingList: [1,2,5,6])
                                unitTableDenominate(
                                    columTitle: "氷A",
                                    denominateList: hanabi.ratioKohriA,
                                    numberofDicimal: 1,
                                )
                                unitTableDenominate(
                                    columTitle: "氷B",
                                    denominateList: [1560.4],
                                    numberofDicimal: 0,
                                    lineList: [4],
                                    colorList: [.white],
                                )
                            }
                            
                            // チェリー
                            HStack(spacing: 0) {
                                unitTableSettingIndex(settingList: [1,2,5,6])
                                unitTableDenominate(
                                    columTitle: "🍒A1",
                                    denominateList: hanabi.ratioCherryA1,
                                    numberofDicimal: 1,
                                )
                                unitTableDenominate(
                                    columTitle: "🍒A2",
                                    denominateList: hanabi.ratioCherryA2,
                                    numberofDicimal: 1,
                                )
                                unitTableDenominate(
                                    columTitle: "🍒B",
                                    denominateList: hanabi.ratioCherryB,
                                    numberofDicimal: 0,
                                )
                            }
                        }
                    }
                }
            } header: {
                Text("通常中小役")
            }
            
            // ---- RT中ハズレ
            Section {
                // 確率結果
                HStack {
                    // チャレンジ
                    unitResultRatioDenomination2Line(
                        title: "花火チャレンジ中",
                        count: $hanabi.hazureCountChallenge,
                        bigNumber: $hanabi.challengeGame,
                        numberofDicimal: 1
                    )
                    // GAME
                    unitResultRatioDenomination2Line(
                        title: "花火GAME中",
                        count: $hanabi.hazureCountGame,
                        bigNumber: $hanabi.hanabiGame,
                        numberofDicimal: 1
                    )
                }
                
                // 参考情報）RT中ハズレ確率
                unitLinkButtonViewBuilder(sheetTitle: "RT中ハズレ確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "花火チャレンジ中",
                            denominateList: hanabi.ratioHazureChallenge,
                            numberofDicimal: 1,
                        )
                        unitTableDenominate(
                            columTitle: "花火GAME中",
                            denominateList: hanabi.ratioHazureGame,
                            numberofDicimal: 1,
                        )
                    }
                }
                
                // 詳細データ
                DisclosureGroup("データ詳細") {
                    // 花火チャレンジプレイ数
                    unitTextGameNumberWithoutInput(
                        titleText: "花火チャレンジプレイ数",
                        gameNumber: hanabi.challengeGame,
                        titleFont: .footnote,
                    )
                    
                    // 花火GAMEプレイ数
                    unitTextGameNumberWithoutInput(
                        titleText: "花火GAMEプレイ数",
                        gameNumber: hanabi.hanabiGame,
                        titleFont: .subheadline,
                    )
                    
                    // 花火チャレンジハズレ回数
                    unitTextFieldNumberInputWithUnit(
                        title: "花火チャレンジはずれ",
                        inputValue: $hanabi.hazureCountChallenge,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // 花火GAMEハズレ回数
                    unitTextFieldNumberInputWithUnit(
                        title: "花火GAMEはずれ",
                        inputValue: $hanabi.hazureCountGame,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                }
            } header: {
                Text("RT中ハズレ")
            }
            
            // ---- BB中小役
            Section {
                // 確率結果
                HStack {
                    // 風鈴A
                    unitResultRatioDenomination2Line(
                        title: "風鈴A",
                        count: $hanabi.bbCountBellA,
                        bigNumber: $hanabi.bbCountGame,
                        numberofDicimal: 2,
                        spacerBool: false,
                    )
                    // 風鈴B
                    unitResultRatioDenomination2Line(
                        title: "風鈴B",
                        count: $hanabi.bbCountBellB,
                        bigNumber: $hanabi.bbCountGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // バラケ目
                    unitResultRatioDenomination2Line(
                        title: "バラケ目",
                        count: $hanabi.bbCountBarake,
                        bigNumber: $hanabi.bbCountGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）BB中小役確率
                unitLinkButtonViewBuilder(sheetTitle: "BB中小役確率") {
                    VStack {
                        Text("・バラケ目成立時は第3停止後に激しいフラッシュあり")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,5,6])
                            unitTableDenominate(
                                columTitle: "風鈴A",
                                denominateList: hanabi.ratioBbBellA,
                                numberofDicimal: 2,
                            )
                            unitTableDenominate(
                                columTitle: "風鈴B",
                                denominateList: hanabi.ratioBbBellB,
                                numberofDicimal: 1,
                            )
                            unitTableDenominate(
                                columTitle: "バラケ目",
                                denominateList: hanabi.ratioBbBarake,
                                numberofDicimal: 0,
                            )
                        }
                    }
                }
                unitLabelCautionText {
                    Text("バラケ目は自動入力未対応です")
                    Text("成立時はデータ詳細から手動入力してください")
                }
                
                // 詳細データ
                DisclosureGroup("データ詳細") {
                    // BB中ゲーム数
                    HStack {
                        HStack {
                            Text("BB中ゲーム数")
                                .font(.subheadline)
                            unitToolbarButtonQuestion {
                                unitExView5body2image(
                                    title: "BB中ゲーム数",
                                    textBody1: "・初当りセクションのBIG回数から自動算出しています",
                                    textBody2: "・バラケ目やビタ押しミスなど発生した場合は手動入力で調整してください"
                                )
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        TextField(
                            "BB中ゲーム数",
                            value: self.$hanabi.bbCountGame,
                            format: .number,
                        )
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .focused(self.$isFocused)
                        .offset(x: 5)
                        Text("Ｇ")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                    }
                    
                    // 風鈴A
                    unitTextFieldNumberInputWithUnit(
                        title: "風鈴A回数",
                        inputValue: $hanabi.bbCountBellA,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // 風鈴B
                    unitTextFieldNumberInputWithUnit(
                        title: "風鈴B回数",
                        inputValue: $hanabi.bbCountBellB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // バラケ目
                    unitTextFieldNumberInputWithUnit(
                        title: "バラケ目回数",
                        inputValue: $hanabi.bbCountBarake,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                }
            } header: {
                Text("BB中小役")
            }
            
            // ---- RB中小役
            Section {
                // 確率結果
                HStack {
                    // 1枚やく
                    unitResultRatioDenomination2Line(
                        title: "1枚役",
                        count: $hanabi.rbCount1Mai,
                        bigNumber: $hanabi.rbCountGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // バラケ目
                    unitResultRatioDenomination2Line(
                        title: "バラケ目",
                        count: $hanabi.rbCountBarake,
                        bigNumber: $hanabi.rbCountGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // 参考情報）RB中小役確率
                unitLinkButtonViewBuilder(sheetTitle: "RB中小役確率") {
                    VStack {
                        Text("・バラケ目成立時は第3停止後に激しいフラッシュあり")
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,5,6])
                            unitTableDenominate(
                                columTitle: "1枚役",
                                denominateList: hanabi.ratioRb1Mai,
                                numberofDicimal: 1,
                            )
                            unitTableDenominate(
                                columTitle: "バラケ目",
                                denominateList: hanabi.ratioRbBarake,
                                numberofDicimal: 0,
                            )
                        }
                    }
                }
                unitLabelCautionText {
                    Text("バラケ目は自動入力未対応です")
                    Text("成立時はデータ詳細から手動入力してください")
                }
                
                // 詳細データ
                DisclosureGroup("データ詳細") {
                    // RB中ゲーム数
                    HStack {
                        HStack {
                            Text("RB中ゲーム数")
                                .font(.subheadline)
                            unitToolbarButtonQuestion {
                                unitExView5body2image(
                                    title: "RB中ゲーム数",
                                    textBody1: "・REG回数と1枚役回数から自動算出しています",
                                    textBody2: "・バラケ目やパンクなど発生した場合は手動入力で調整してください"
                                )
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        TextField(
                            "RB中ゲーム数",
                            value: self.$hanabi.rbCountGame,
                            format: .number,
                        )
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .focused(self.$isFocused)
                        .offset(x: 5)
//                        Text("\(hanabi.rbCountGame)")
//                            .foregroundStyle(Color.secondary)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .offset(x: 5)
                        Text("Ｇ")
                            .foregroundStyle(Color.secondary)
                            .font(.footnote)
                    }
                    
                    // 1枚役
                    unitTextFieldNumberInputWithUnit(
                        title: "1枚役回数",
                        inputValue: $hanabi.rbCount1Mai,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: hanabi.rbCount1Mai) { oldValue, newValue in
//                        hanabi.rb1MaiGameCal()
                        hanabi.rbGameCal()
                    }
                    
                    // 1枚役確立
//                    HStack {
//                        Text("1枚役確率")
//                            .font(.subheadline)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        HStack {
//                            Text("1/")
//                                .foregroundStyle(Color.secondary)
//                            TextField(
//                                "1枚役確率",
//                                value: $hanabi.rbCount1MaiDeno,
//                                format: .number,
//                            )
//                            .keyboardType(.decimalPad)
//                            .multilineTextAlignment(.center)
//                            .focused(self.$isFocused)
//                            .onChange(of: hanabi.rbCount1MaiDeno, { oldValue, newValue in
//                                hanabi.rb1MaiGameCal()
//                            })
//                        }
//                    }
                    
                    // バラケ目
                    unitTextFieldNumberInputWithUnit(
                        title: "バラケ目回数",
                        inputValue: $hanabi.rbCountBarake,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                }
            } header: {
                Text("RB中小役")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMenuPlayBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("プレイデータ")
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
                unitButtonMinusCheck(minusCheck: $hanabi.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hanabi.resetPlay)
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
    
    private func ocrImg(uiImage: UIImage) {
        print("  画像サイズ \(uiImage.size)") // ← 呼ばれたか確認
        // CGImage生成
        guard let cgImage = uiImage.cgImage else {
            print("  エラー: CGImageの生成に失敗")
            return
        }
        
        // VisionでTextObservation取得
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("  Visionエラー: \(error.localizedDescription)")
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("  結果が空でした")
                return
            }
            print("  TextObservation取得")
            
            // 1. 全てのデータを解析結果として保持（テキスト + 座標）
            let allResults = observations.compactMap { observation -> (
                text: String,
                minX: CGFloat,
                minY: CGFloat,
                maxX: CGFloat,
                maxY: CGFloat
            )? in
                guard let candidate = observation.topCandidates(1).first else { return nil }
                // 座標を取得（0.0〜1.0の範囲）
                return (
                    text: candidate.string,
                    minX: observation.boundingBox.minX,
                    minY: observation.boundingBox.minY,
                    maxX: observation.boundingBox.maxX,
                    maxY: observation.boundingBox.maxY,
                )
            }
            
            // -- デバッグ用 全てのアイテムの結果をコンソールに表示
//            let imgHeight = uiImage.size.height // 画像のピクセル高さ
//            let imgWidth = uiImage.size.width   // 画像のピクセル幅
//            for (index, item) in allResults.enumerated() {
//                let minPixX = Int(imgWidth * item.minX)
//                let minPixY = Int(imgHeight * item.minY)
//                let maxPixX = Int(imgWidth * item.maxX)
//                let maxPixY = Int(imgHeight * item.maxY)
//                print("index\(index): \(item.text), minX: \(minPixX), minY: \(minPixY), maxX: \(maxPixX), maxY: \(maxPixY)")
//            }
            // ------------
            
            // --- 2. 解析結果から欲しい数値を抽出
            // 読み取り項目ごとに繰り返す処理
            for (i, menu) in self.ocrMenuList.enumerated() {
                if self.ocrNeedCheckList[i] {   // チェック必要ならチェックを回す
                    print("\(menu)の読み取り")
                    
                    // 対応する文字列さがして数字を拾う
                    for item in allResults {
                        // 項目の文字列あったら対応する数字を拾って変数に入れる
//                        if item.text.contains(self.ocrMenuList[i]) {
                        if item.text.contains(searchText(index: i, item: menu)) {
                            print("  対応文字列発見！")
                            // 風鈴だけ近くのタイトルを見にいく
                            var isTitleSection: Bool = false
                            if menu.contains("風鈴") {
                                isTitleSection = allResults.contains { otherItem in
                                    otherItem.text.contains(titleText(index: i)) &&   // タイトルが合致
                                    otherItem.minY < (item.minY + ((item.maxY - item.minY) * self.titleSearchArea))
                                }
                                if isTitleSection {
                                    print("   タイトル検出成功！")
                                } else {
                                    print("   タイトル検出失敗・・")
                                }
                            } else {
                                isTitleSection = true
                            }
                            
                            // 対応する数字を抽出
                            let targetText = allResults.filter { otherItem in
                                isTitleSection &&  // 近くに規定の文字あり
                                otherItem.text != item.text &&  // 自分自身を除外
                                otherItem.minY < (item.minY + ((item.maxY - item.minY) * self.searchAreaUpper[i])) &&// 捜索範囲 上限
                                otherItem.minY > (item.minY - ((item.maxY - item.minY) * self.searchAreaLower[i])) &&// 捜索範囲 下限
                                otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                            }
                                .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                            
                            // 数字が抽出できた場合の処理
                            if let target = targetText {
                                print("   対応する数字抽出成功！")
                                // 数字の抽出　分数の場合
                                if target.text.contains("/") {
                                    print("    分数発見！")
//                                    if let probValue = self.extractProbability(from: target.text) {
//                                        hanabi.rbCount1MaiDeno = probValue
//                                        self.ocrResultTextList[i] = target.text  // 結果表示用テキストの更新
//                                        self.ocrResultColorList[i] = .green  // 結果表示用テキスト色の更新
//                                        self.ocrNeedCheckList[i] = false  // これから先はチェック不要に更新
//                                        print("    結果抽出完了！")
//                                    } else {
//                                        print("    確率分母抽出失敗・・")
//                                    }
                                }
                                // 数字の抽出整数値の場合
                                else {
                                    print("    整数発見！")
                                    let filtered = target.text.filter { "0123456789".contains($0) }
                                    if !filtered.isEmpty {
                                        let result = Int(filtered) ?? 0
                                        updateVar(index: i, newValue: result)  // 変数の値を更新
                                        self.ocrResultTextList[i] = target.text  // 結果表示用テキストの更新
                                        self.ocrResultColorList[i] = .green  // 結果表示用テキスト色の更新
                                        self.ocrNeedCheckList[i] = false  // これから先はチェック不要に更新
                                        print("    結果抽出完了！")
                                    } else {
                                        print("    整数抽出失敗・・")
                                    }
                                }
                            } else {
                                print("   対応する数字抽出できず・・")
                            }
                        }
                    }
                }
            }
        }
        
        // ハンドラの作成
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ja-JP"]
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])
    }
    
    private func readImg(uiImage: UIImage) {
        print("  画像サイズ \(uiImage.size)") // ← 呼ばれたか確認
        // CGImage生成
        guard let cgImage = uiImage.cgImage else {
            print("  エラー: CGImageの生成に失敗")
            return
        }
        
        // VisionでTextObservation取得
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("  Visionエラー: \(error.localizedDescription)")
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("  結果が空でした")
                return
            }
            print("  TextObservation取得")
            
            // 1. 全てのデータを解析結果として保持（テキスト + 座標）
            let allResults = observations.compactMap { observation -> (
                text: String,
                minX: CGFloat,
                minY: CGFloat,
                maxX: CGFloat,
                maxY: CGFloat
            )? in
                guard let candidate = observation.topCandidates(1).first else { return nil }
                // 座標を取得（0.0〜1.0の範囲）
                return (
                    text: candidate.string,
                    minX: observation.boundingBox.minX,
                    minY: observation.boundingBox.minY,
                    maxX: observation.boundingBox.maxX,
                    maxY: observation.boundingBox.maxY,
                )
            }
            
            // 2. 解析結果から欲しい数値を抽出
            // -- デバッグ用
            let imgHeight = uiImage.size.height // 画像のピクセル高さ
            let imgWidth = uiImage.size.width   // 画像のピクセル幅
            for (index, item) in allResults.enumerated() {
                let minPixX = Int(imgWidth * item.minX)
                let minPixY = Int(imgHeight * item.minY)
                let maxPixX = Int(imgWidth * item.maxX)
                let maxPixY = Int(imgHeight * item.maxY)
                print("index\(index): \(item.text), minX: \(minPixX), minY: \(minPixY), maxX: \(maxPixX), maxY: \(maxPixY)")
            }
            // ------------
            
            // --- 総プレイ数の抽出 ---
            var searchFlag: Bool = false
            for item in allResults {
                if item.text.contains("総プレイ数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
//                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.sameHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.playGame = Int(filtered) ?? hanabi.playGame
                        searchFlag = true
                    }
                }
            }
            itemList.append("総プレイ数")
            if searchFlag {
                resultList.append("\(hanabi.playGame) Ｇ")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 花火チャンレンジプレイ数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("花火チャレンジプレイ数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
//                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.sameHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.challengeGame = Int(filtered) ?? hanabi.challengeGame
                        searchFlag = true
                    }
                }
            }
            itemList.append("花火チャレンジプレイ数")
            if searchFlag {
                resultList.append("\(hanabi.challengeGame) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 花火GAMEプレイ数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("花火GAMEプレイ数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
//                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.sameHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.hanabiGame = Int(filtered) ?? hanabi.hanabiGame
                        searchFlag = true
                    }
                }
            }
            itemList.append("花火GAMEプレイ数")
            if searchFlag {
                resultList.append("\(hanabi.hanabiGame) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 総BB回数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("総BB回数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.playBig = Int(filtered) ?? hanabi.playBig
                        searchFlag = true
                    }
                }
            }
            itemList.append("総BB回数")
            if searchFlag {
                resultList.append("\(hanabi.playBig) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 総RB回数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("総RB回数") &&
                    item.text.contains("中") == false {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.playReg = Int(filtered) ?? hanabi.playReg
                        searchFlag = true
                    }
                }
            }
            itemList.append("総RB回数")
            if searchFlag {
                resultList.append("\(hanabi.playReg) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 風鈴Aの抽出 ---
            searchFlag = false
            for item in allResults {
//                if item.text.contains("風鈴A") {
                if item.text.contains("風") &&
                    item.text.contains("A") {
                    let isTitleSection = allResults.contains { otherItem in
                        otherItem.text.contains("通常中小役") &&
                        otherItem.minY - item.minY < self.nearTitleHeightRatio // 自分の位置から規定の範囲より上
                    }
                    let sameRowText = allResults.filter { otherItem in
                        isTitleSection &&  // 近くに規定の文字あり
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountBellA = Int(filtered) ?? hanabi.normalKoyakuCountBellA
                        searchFlag = true
                    }
                }
            }
            itemList.append("風鈴A")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountBellA) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
                
            // --- 風鈴Bの抽出 ---
            searchFlag = false
            for item in allResults {
//                if item.text.contains("風鈴B") {
                if item.text.contains("風") &&
                    item.text.contains("B") {
                    let isTitleSection = allResults.contains { otherItem in
                        otherItem.text.contains("通常中小役") &&
                        otherItem.minY - item.minY < self.nearTitleHeightRatio // 自分の位置から規定の範囲より上
                    }
                    let sameRowText = allResults.filter { otherItem in
                        isTitleSection &&  // 近くに規定の文字あり
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountBellB = Int(filtered) ?? hanabi.normalKoyakuCountBellB
                        searchFlag = true
                    }
                }
            }
            itemList.append("風鈴B")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountBellB) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 氷Aの抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("氷A") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountKohriA = Int(filtered) ?? hanabi.normalKoyakuCountKohriA
                        searchFlag = true
                    }
                }
            }
            itemList.append("氷A")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountKohriA) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 氷Bの抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("氷B") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountKohriB = Int(filtered) ?? hanabi.normalKoyakuCountKohriB
                        searchFlag = true
                    }
                }
            }
            itemList.append("氷B")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountKohriB) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- チェリーA1の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("チェリーA1") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountCherryA1 = Int(filtered) ?? hanabi.normalKoyakuCountCherryA1
                        searchFlag = true
                    }
                }
            }
            itemList.append("チェリーA1")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountCherryA1) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- チェリーA2の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("チェリーA2") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountCherryA2 = Int(filtered) ?? hanabi.normalKoyakuCountCherryA2
                        searchFlag = true
                    }
                }
            }
            itemList.append("チェリーA2")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountCherryA2) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- チェリーBの抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("チェリーB") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.normalKoyakuCountCherryB = Int(filtered) ?? hanabi.normalKoyakuCountCherryB
                        searchFlag = true
                    }
                }
            }
            itemList.append("チェリーB")
            if searchFlag {
                resultList.append("\(hanabi.normalKoyakuCountCherryB) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 花火チャレンジはずれ回数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("花火チャレンジはずれ回数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.hazureCountChallenge = Int(filtered) ?? hanabi.hazureCountChallenge
                        searchFlag = true
                    }
                }
            }
            itemList.append("花火チャレンジはずれ回数")
            if searchFlag {
                resultList.append("\(hanabi.hazureCountChallenge) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 花火GAMEはずれ回数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("花火GAMEはずれ回数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.hazureCountGame = Int(filtered) ?? hanabi.hazureCountGame
                        searchFlag = true
                    }
                }
            }
            itemList.append("花火GAMEはずれ回数")
            if searchFlag {
                resultList.append("\(hanabi.hazureCountGame) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- BB中風鈴Aの抽出 ---
            searchFlag = false
            for item in allResults {
                let isTitleSection = allResults.contains { otherItem in
                    otherItem.text.contains("BB中小役") &&
                    otherItem.minY - item.minY < self.nearTitleHeightRatio // 自分の位置から規定の範囲より上
                }
//                if item.text.contains("風鈴A回数") {
                if item.text.contains("風") &&
                    item.text.contains("A") {
                    let sameRowText = allResults.filter { otherItem in
                        isTitleSection &&  // 近くに規定の文字あり
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.bbCountBellA = Int(filtered) ?? hanabi.bbCountBellA
                        searchFlag = true
                    }
                }
            }
            itemList.append("BB中 風鈴A")
            if searchFlag {
                resultList.append("\(hanabi.bbCountBellA) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- BB中風鈴Bの抽出 ---
            searchFlag = false
            for item in allResults {
                let isTitleSection = allResults.contains { otherItem in
                    otherItem.text.contains("BB中小役") &&
                    otherItem.minY - item.minY < self.nearTitleHeightRatio // 自分の位置から規定の範囲より上
                }
//                if item.text.contains("風鈴B回数") {
                if item.text.contains("風") &&
                    item.text.contains("B") {
                    let sameRowText = allResults.filter { otherItem in
                        isTitleSection &&  // 近くに規定の文字あり
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.bbCountBellB = Int(filtered) ?? hanabi.bbCountBellB
                        searchFlag = true
                    }
                }
            }
            itemList.append("BB中 風鈴B")
            if searchFlag {
                resultList.append("\(hanabi.bbCountBellB) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 1枚役回数の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("1枚役回数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY > item.minY &&  // itemより上に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        hanabi.rbCount1Mai = Int(filtered) ?? hanabi.rbCount1Mai
                        searchFlag = true
                    }
                }
            }
            itemList.append("1枚役回数")
            if searchFlag {
                resultList.append("\(hanabi.rbCount1Mai) 回")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
            
            // --- 1枚役確率の抽出 ---
            searchFlag = false
            for item in allResults {
                if item.text.contains("1枚役回数") {
                    let sameRowText = allResults.filter { otherItem in
                        otherItem.text != item.text &&  // 自分自身を除外
                        otherItem.minY < item.minY &&  // itemより下に位置する
                        abs(otherItem.minY - item.minY) < self.nearHeightRatio &&  // ただし離れすぎていない（5%以内など）
                        otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                    }
                        .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
                    
                    // テキストから整数に変換
                    if let target = sameRowText {
                        if let probValue = self.extractProbability(from: target.text) {
                            hanabi.rbCount1MaiDeno = probValue
                            searchFlag = true
                        }
                    }
                }
            }
            itemList.append("1枚役確率")
            if searchFlag {
                resultList.append("1/ \(hanabi.rbCount1MaiDeno)")
                colorList.append(.green)
            } else {
                resultList.append("読み取りエラー")
                colorList.append(.red)
            }
        }
        
        // ハンドラの作成
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ja-JP"]
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])
        
        self.statusTitle = "読み取り完了"  // 読み取り状況を完了に更新
        self.selectedItem = nil  // 画像選択解除しておく
    }
    
    private func extractProbability(from text: String) -> Double? {
        // 正規表現の解説:
        // 1/ の後にある、数字とドット（小数点）の組み合わせを探す
        // ([0-9.]+) -> 数字またはドットが1回以上続く部分をキャプチャ
        let pattern = #"1/([0-9.]+)"#
        
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) {
            
            // キャプチャしたグループ（([0-9.]+)の部分）を取り出す
            if let range = Range(match.range(at: 1), in: text) {
                let numberString = String(text[range])
                return Double(numberString)
            }
        }
        return nil
    }
    
    private func searchText(index: Int, item: String) -> String {
        switch index {
        case 14: return "風鈴A"
        case 15: return "風鈴B"
//        case 17: return "1枚役回数"
        default: return item
        }
    }
    
    private func updateVar(index: Int, newValue: Int) {
        switch index {
        case 0: hanabi.playGame = newValue
        case 1: hanabi.challengeGame = newValue
        case 2: hanabi.hanabiGame = newValue
        case 3: hanabi.playBig = newValue
        case 4: hanabi.playReg = newValue
        case 5: hanabi.normalKoyakuCountBellA = newValue
        case 6: hanabi.normalKoyakuCountBellB = newValue
        case 7: hanabi.normalKoyakuCountKohriA = newValue
        case 8: hanabi.normalKoyakuCountKohriB = newValue
        case 9: hanabi.normalKoyakuCountCherryA1 = newValue
        case 10: hanabi.normalKoyakuCountCherryA2 = newValue
        case 11: hanabi.normalKoyakuCountCherryB = newValue
        case 12: hanabi.hazureCountChallenge = newValue
        case 13: hanabi.hazureCountGame = newValue
        case 14: hanabi.bbCountBellA = newValue
        case 15: hanabi.bbCountBellB = newValue
        case 16: hanabi.rbCount1Mai = newValue
        default: break
        }
    }
    
    private func titleText(index: Int) -> String {
        switch index {
        case 14: return "BB中小役"
        case 15: return "BB中小役"
        default: return "通常中小役"
        }
    }

    private func finalResultUpdate() {
        // needCheckがtrueのままのやつを読み取りエラーにして赤色にする
        for (i, need) in self.ocrNeedCheckList.enumerated() {
            if need {
                self.ocrResultTextList[i] = "読み取りエラー"
                self.ocrResultColorList[i] = .red
            }
        }
    }
}

#Preview {
    hanabiViewPlay(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
