//
//  thunderViewPlay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/11.
//

import SwiftUI
import Vision
import UIKit
import PhotosUI
import TipKit

// //////////////////
// Tip：画像からの自動入力
// //////////////////
struct tipThunderOcr: Tip {
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



struct thunderViewPlay: View {
    @ObservedObject var thunder: Thunder
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
    @State var ocrResultTextList: [String] = []
    @State var ocrResultColorList: [Color] = []
    @State var ocrNeedCheckList: [Bool] = []
    let ocrMenuList: [String] = [
        "総プレイ数",
        "ベルA",
        "ベルB",
        "スイカ",
        "チェリーB",
        
        "総BB回数",
        "RB回数",
        
        "特殊赤7BB回数",
        
        "BB中ベルB回数",
        "BB中ベルC回数",
    ]
    let searchAreaUpper: [CGFloat] = [
        0.3,
        1.3,
        1.3,
        1.3,
        1.3,
        
        1.3,
        1.3,
        
        0.3,
        
        1.3,
        1.3,
    ]
    let searchAreaLower: [CGFloat] = [
        0.3,
        -0.1,
        -0.1,
        -0.1,
        -0.1,
        
        -0.1,
        -0.1,
        
        0.3,
        
        -0.1,
        -0.1,
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
                            thunder.gameSumFunc()
                            thunder.bonusSumFunc()
                            thunder.bellSumFunc()
                            thunder.bbGameCalFunc()
//                            thunder.rb1MaiGameCal()
//                            thunder.rbGameCal()
//                            thunder.bbGameCal()
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
                    .popoverTip(tipThunderOcr())
                    
                    Spacer()
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        thunderView95Ci(
                            thunder: thunder,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    thunderViewBayes(
                        thunder: thunder,
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
//                            textBody3: "・風鈴A,風鈴Bは「通常中小役」または「BB中小役」のオレンジ帯の文字が写っていないと読み取りエラーとなります",
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
                    gameNumber: thunder.startGame,
                    titleFont: .subheadline,
                )
                // 総プレイ数
                unitTextFieldNumberInputWithUnit(
                    title: "総プレイ数",
                    inputValue: $thunder.playGame,
                    titleFont: .subheadline,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                .onChange(of: thunder.playGame) { oldValue, newValue in
                    thunder.gameSumFunc()
                }
            } header: {
                Text("ゲーム数")
            }
            
            // ---- 小役
            Section {
                // 確率結果
                HStack {
                    // ベル合算
                    unitResultRatioDenomination2Line(
                        title: "🔔合算",
                        count: $thunder.normalKoyakuCountBellSum,
                        bigNumber: $thunder.playGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // スイカ
                    unitResultRatioDenomination2Line(
                        title: "🍉",
                        count: $thunder.normalKoyakuCountSuika,
                        bigNumber: $thunder.playGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 🍒
                    unitResultRatioDenomination2Line(
                        title: "🍒B",
                        count: $thunder.normalKoyakuCountCherryB,
                        bigNumber: $thunder.playGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    thunderTableKoyakuRatio(thunder: thunder)
                }
                
                DisclosureGroup("データ詳細") {
                    // 総プレイ数
                    unitTextGameNumberWithoutInput(
                        titleText: "総プレイ数",
                        gameNumber: thunder.playGame,
                        titleFont: .subheadline,
                    )
                    
                    // 風鈴A
                    unitTextFieldNumberInputWithUnit(
                        title: "🔔A",
                        inputValue: $thunder.normalKoyakuCountBellA,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.normalKoyakuCountBellA) { oldValue, newValue in
                        thunder.bellSumFunc()
                    }
                    
                    // 風鈴B
                    unitTextFieldNumberInputWithUnit(
                        title: "🔔B",
                        inputValue: $thunder.normalKoyakuCountBellB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.normalKoyakuCountBellB) { oldValue, newValue in
                        thunder.bellSumFunc()
                    }
                    
                    // スイカ
                    unitTextFieldNumberInputWithUnit(
                        title: "🍉",
                        inputValue: $thunder.normalKoyakuCountSuika,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // チェリーB
                    unitTextFieldNumberInputWithUnit(
                        title: "🍒B",
                        inputValue: $thunder.normalKoyakuCountCherryB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                }
            } header: {
                Text("小役")
            }
            
            // 初当り
            Section {
                // 確率結果
                HStack {
                    // BIG
                    unitResultRatioDenomination2Line(
                        title: "BIG",
                        count: $thunder.totalBig,
                        bigNumber: $thunder.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // REG
                    unitResultRatioDenomination2Line(
                        title: "REG",
                        count: $thunder.totalReg,
                        bigNumber: $thunder.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,5,6])
                        unitTableDenominate(
                            columTitle: "BIG",
                            denominateList: thunder.ratioBig
                        )
                        unitTableDenominate(
                            columTitle: "REG",
                            denominateList: thunder.ratioReg
                        )
                    }
                }
                
                // データ詳細
                DisclosureGroup("データ詳細") {
                    // 累計ゲーム数
                    unitTextGameNumberWithoutInput(
                        titleText: "累計ゲーム数",
                        gameNumber: thunder.totalGame,
                        titleFont: .subheadline,
                    )
                    // 打ち始めBIG
                    unitTextGameNumberWithoutInput(
                        titleText: "打ち始めBIG",
                        gameNumber: thunder.startBig,
                        titleFont: .subheadline,
                        unitText: "回",
                    )
                    // 打ち始めBIG
                    unitTextGameNumberWithoutInput(
                        titleText: "打ち始めREG",
                        gameNumber: thunder.startReg,
                        titleFont: .subheadline,
                        unitText: "回",
                    )
                    
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "総BB",
                        inputValue: $thunder.playBig,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.playBig) { oldValue, newValue in
                        thunder.bonusSumFunc()
                        thunder.bbGameCalFunc()
                    }
                    
                    // REG
                    unitTextFieldNumberInputWithUnit(
                        title: "総RB",
                        inputValue: $thunder.playReg,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.playReg) { oldValue, newValue in
                        thunder.bonusSumFunc()
                    }
                }
            } header: {
                Text("初当り")
            }
            
            // BTループ率
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "BTループ率",
                    count: $thunder.btRedSeven,
                    bigNumber: $thunder.playBig,
                    numberofDicimal: 0
                )
                
                // 参考情報）BTループ率
                unitLinkButtonViewBuilder(sheetTitle: "BTループ率 ※独自算出値") {
                    VStack {
                        HStack(spacing: 0) {
                            unitTableSettingIndex(settingList: [1,2,5,6])
                            unitTablePercent(
                                columTitle: "BTループ率",
                                percentList: thunder.ratioBtLoop
                            )
                        }
                        Text("※ 独自算出値")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                }
                
                // 詳細データ
                DisclosureGroup("詳細データ") {
                    // BIG
                    unitTextFieldNumberInputWithUnit(
                        title: "総BB",
                        inputValue: $thunder.playBig,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.playBig) { oldValue, newValue in
                        thunder.bonusSumFunc()
                        thunder.bbGameCalFunc()
                    }
                    
                    // 特殊赤7BB
                    unitTextFieldNumberInputWithUnit(
                        title: "特殊赤7BB",
                        inputValue: $thunder.btRedSeven,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    .onChange(of: thunder.btRedSeven) { oldValue, newValue in
                        thunder.bonusSumFunc()
                        thunder.bbGameCalFunc()
                    }
                }
            } header: {
                HStack {
                    Text("BTループ率")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "BTループ率",
                            textBody1: "・独自算出値です。ご理解の上ご参考ください。"
                        )
                    }
                }
            }
            
            // BB中小役
            Section {
                // 確率結果
                HStack {
                    // 🔔B
                    unitResultRatioDenomination2Line(
                        title: "🔔B",
                        count: $thunder.bbCountBellB,
                        bigNumber: $thunder.bbGame,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // 🔔C
                    unitResultRatioDenomination2Line(
                        title: "🔔C",
                        count: $thunder.bbCountBellC,
                        bigNumber: $thunder.bbGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // リーチ目
                    unitResultRatioDenomination2Line(
                        title: "リーチ目",
                        count: $thunder.bbCountReach,
                        bigNumber: $thunder.bbGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）BB中小役確率
                unitLinkButtonViewBuilder(sheetTitle: "BB中小役確率") {
                    thunderTableBbKoyaku(thunder: thunder)
                }
                
                unitLabelCautionText {
                    Text("リーチ目は自動入力未対応です")
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
                                    textBody1: "・初当りセクションのBIG回数＆特殊赤7回数から自動算出しています",
                                    textBody2: "・目押しミスなど発生した場合は手動入力で調整してください"
                                )
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        TextField(
                            "BB中ゲーム数",
                            value: self.$thunder.bbGame,
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
                    
                    // BB中ベルB
                    unitTextFieldNumberInputWithUnit(
                        title: "BB中ベルB",
                        inputValue: $thunder.bbCountBellB,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // BB中ベルC
                    unitTextFieldNumberInputWithUnit(
                        title: "BB中ベルC",
                        inputValue: $thunder.bbCountBellC,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                    
                    // BB中リーチ目
                    unitTextFieldNumberInputWithUnit(
                        title: "BB中リーチ目",
                        inputValue: $thunder.bbCountReach,
                        titleFont: .subheadline,
                    )
                    .focused(self.$isFocused)
                }
            } header: {
                Text("BB中小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMenuPlayBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
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
                unitButtonMinusCheck(minusCheck: $thunder.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: thunder.resetPlay)
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
                        if item.text.contains(self.ocrMenuList[i]) {
//                        if item.text.contains(searchText(index: i, item: menu)) {
                            print("  対応文字列発見！")
                            // 風鈴だけ近くのタイトルを見にいく
//                            var isTitleSection: Bool = false
//                            if menu.contains("風鈴") {
//                                isTitleSection = allResults.contains { otherItem in
//                                    otherItem.text.contains(titleText(index: i)) &&   // タイトルが合致
//                                    otherItem.minY < (item.minY + ((item.maxY - item.minY) * self.titleSearchArea))
//                                }
//                                if isTitleSection {
//                                    print("   タイトル検出成功！")
//                                } else {
//                                    print("   タイトル検出失敗・・")
//                                }
//                            } else {
//                                isTitleSection = true
//                            }
                            
                            // 対応する数字を抽出
                            let targetText = allResults.filter { otherItem in
//                                isTitleSection &&  // 近くに規定の文字あり
                                otherItem.text != item.text &&  // 自分自身を除外
                                otherItem.minY < (item.minY + ((item.maxY - item.minY) * self.searchAreaUpper[i])) &&// 捜索範囲 上限
                                otherItem.minY > (item.minY - ((item.maxY - item.minY) * self.searchAreaLower[i])) &&// 捜索範囲 下限
                                otherItem.minX > self.halfRightRatio  // 幅方向半分より右
                            }
                                .min(by: { abs($0.minY - item.minY) < abs($1.minY - item.minY) }) // 最も近いものを抽出
//                            let targetText = allResults.filter { otherItem -> Bool in // 明示的に -> Bool を追加
//                                // 条件を一つずつ変数に切り出す
//                                let isNotSelf = otherItem.text != item.text
//                                let isRightSide = otherItem.minX > self.halfRightRatio
//                                
//                                // 座標計算を整理
//                                let height = item.maxY - item.minY
//                                let upperLimit = item.minY + (height * self.searchAreaUpper[i])
//                                let lowerLimit = item.minY - (height * self.searchAreaLower[i])
//                                
//                                let isWithinYRange = otherItem.minY < upperLimit && otherItem.minY > lowerLimit
//                                
//                                // 全てを満たすか返す
//                                return isNotSelf && isRightSide && isWithinYRange
//                            }
//                            .min(by: { a, b in
//                                return abs(a.minY - item.minY) < abs(b.minY - item.minY)
//                            })
                            
                            // 数字が抽出できた場合の処理
                            if let target = targetText {
                                print("   対応する数字抽出成功！")
                                // 数字の抽出　分数の場合
                                if target.text.contains("/") {
                                    print("    分数発見！")
//                                    if let probValue = self.extractProbability(from: target.text) {
//                                        thunder.rbCount1MaiDeno = probValue
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
    
    private func finalResultUpdate() {
        // needCheckがtrueのままのやつを読み取りエラーにして赤色にする
        for (i, need) in self.ocrNeedCheckList.enumerated() {
            if need {
                self.ocrResultTextList[i] = "読み取りエラー"
                self.ocrResultColorList[i] = .red
            }
        }
    }
    
    private func updateVar(index: Int, newValue: Int) {
        switch index {
        case 0: thunder.playGame = newValue
        case 1: thunder.normalKoyakuCountBellA = newValue
        case 2: thunder.normalKoyakuCountBellB = newValue
        case 3: thunder.normalKoyakuCountSuika = newValue
        case 4: thunder.normalKoyakuCountCherryB = newValue
        case 5: thunder.playBig = newValue
        case 6: thunder.playReg = newValue
        case 7: thunder.btRedSeven = newValue
        case 8: thunder.bbCountBellB = newValue
        case 9: thunder.bbCountBellC = newValue
        default: break
        }
    }
}

#Preview {
    thunderViewPlay(
        thunder: Thunder(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
