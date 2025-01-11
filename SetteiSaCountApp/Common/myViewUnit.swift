//
//  myViewUnit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI
import TipKit
import Charts

struct myViewUnit: View {
    @State var count = 10
    var body: some View {
//        unitVerticalCountDenominate(count: self.$count)
        Text("aaa")
    }
}


// ////////////////////////////
// ビュー：機種選択ページの機種リスト
// ////////////////////////////
struct unitMachinListLink: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            HStack {
                self.iconImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(self.machineName)
                    Text("\(self.makerName) , \(String(self.releaseYear))年 \(self.releaseMonth)月")
                        .font(.caption)
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

// //////////////////////////
// ビュー：機種選択ページ　アイコン表示用のリンク
// //////////////////////////
struct unitMachineIconLink: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            VStack {
                self.iconImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(13.0)
                    .padding(.horizontal, 4.0)
                Text(self.machineName)
                    .font(.caption)
                    .lineLimit(1)
//                    .foregroundColor(Color.primary)
                    .foregroundStyle(Color.primary)
            }
        }
    }
}

// //////////////////////////
// ビュー：参考情報リンクボタン
// //////////////////////////
struct unitLinkButton: View {
    @State var title: String
    @State var exview: AnyView
    @State var isShowExView = false
    var detent: PresentationDetent = .medium
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.isShowExView.toggle()
            }, label: {
    //            Text(">> \(self.title)")
    //                .foregroundColor(Color.blue)
    //                .frame(maxWidth: .infinity, alignment: .trailing)
                Text(">> \(self.title)")
//                    .foregroundColor(Color.blue)
                    .foregroundStyle(Color.blue)
            })
            .sheet(isPresented: $isShowExView, content: {
                self.exview
                    .presentationDetents([detent])
            })
        }
    }
}


// //////////////////////
// ビュー：縦型カウントボタン、確率表示なし
// //////////////////////
struct unitCountButtonVerticalWithoutRatio: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
//    @Binding var bigNumber: Int
//    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
//    var denominator: Double {
//        let deno = Double(bigNumber) / Double(count)
//        return count > 0 ? deno : 0.0
//    }
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            if let flushBool = self.flushBool {
                if flushBool {
                    // 背景フラッシュ部分
                    if let flushColor = self.flushColor {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: flushColor)
                    } else {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: self.color)
                    }
                }
                else {
                    Rectangle()
//                        .foregroundColor(Color.clear)
                        .foregroundStyle(Color.clear)
                }
            }
            else {
                // 背景フラッシュ部分
                if let flushColor = self.flushColor {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: flushColor)
                } else {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: self.color)
                }
            }
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text(self.title)
                    .multilineTextAlignment(.center)
                // 回数
                if self.count < 1000{
                    Text("\(self.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                else {
                    Text("\(self.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: minusBool))
            }
        }
    }
}


// //////////////////////
// ビュー：縦型カウントボタン、確率分母タイプ
// //////////////////////
struct unitCountButtonVerticalDenominate: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var denominator: Double {
        let deno = Double(bigNumber) / Double(count)
        return count > 0 ? deno : 0.0
    }
    @State var minusColor: Color = .red
    
    var body: some View {
        ZStack {
            if let flushBool = self.flushBool {
                if flushBool {
                    // 背景フラッシュ部分
                    if let flushColor = self.flushColor {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: flushColor)
                    } else {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: self.color)
                    }
                }
                else {
                    Rectangle()
//                        .foregroundColor(Color.clear)
                        .foregroundStyle(Color.clear)
                }
            }
            else {
                // 背景フラッシュ部分
                if let flushColor = self.flushColor {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: flushColor)
                } else {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: self.color)
                }
            }
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text(self.title)
                // 確率
                HStack(spacing: 0) {
                    Text("\(self.count > 0 ? 1 : 0)/")
                        .font(.footnote)
                        .lineLimit(1)
                    Text("\(String(format:"%.\(self.numberofDicimal)f",self.denominator))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                // 回数
                if self.count < 1000{
                    Text("\(self.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                else {
                    Text("\(self.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: self.color, minusColor: self.minusColor, MinusBool: minusBool))
            }
        }
    }
}


// //////////////////////
// ビュー：縦型カウントボタン、%タイプ
// //////////////////////
struct unitCountButtonVerticalPercent: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var ratio: Double {
        let rat = Double(count) / Double(bigNumber) * 100
        return bigNumber > 0 ? rat : 0.0
    }
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            if let flushBool = self.flushBool {
                if flushBool {
                    // 背景フラッシュ部分
                    if let flushColor = self.flushColor {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: flushColor)
                    } else {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: self.color)
                    }
                }
                else {
                    Rectangle()
//                        .foregroundColor(Color.clear)
                        .foregroundStyle(Color.clear)
                }
            }
            else {
                // 背景フラッシュ部分
                if let flushColor = self.flushColor {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: flushColor)
                } else {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: self.color)
                }
            }
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text(self.title)
                    .multilineTextAlignment(.center)
                // 確率
                HStack(spacing: 0) {
                    Text("\(String(format:"%.\(self.numberofDicimal)f",self.ratio))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("%")
                        .font(.footnote)
                        .lineLimit(1)
                }
                // 回数
                if self.count < 1000{
                    Text("\(self.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                else {
                    Text("\(self.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: minusBool))
            }
        }
    }
}


// /////////////////////
// ビュー：ボタンの背景フラッシュ用ユニット
// /////////////////////
struct unitFlashRectangle: View {
    @Binding var trigger: Int
    @State var color: Color
    
    var body: some View {
        Rectangle()
            .backgroundFlashModifier(trigger: self.trigger, color: self.color)
    }
}


// /////////////////////
// ビュー：水平型、カウント回数表示
// /////////////////////
struct unitResultCount2Line: View {
    @State var title: String
    @State var color: Color = .grayBack
    @Binding var count: Int
    @State var spacerBool: Bool = true
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                if self.spacerBool {
                    Spacer()
                }
                Rectangle()
//                    .foregroundColor(self.color)
                    .foregroundStyle(self.color)
                    .cornerRadius(15)
                if self.spacerBool {
                    Spacer()
                }
            }
            VStack {
                Text(self.title)
                Text("\(self.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }
}


// /////////////////////
// ビュー：水平型、確率表示、確率分母タイプ
// /////////////////////
struct unitResultRatioDenomination2Line: View {
    @State var title: String
    @State var color: Color = .grayBack
    @Binding var count: Int
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @State var spacerBool: Bool = true
    var denomination: Double {
        let deno = Double(bigNumber) / Double(count)
        return count > 0 ? deno : 0.0
    }
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                if self.spacerBool {
                    Spacer()
                }
                Rectangle()
//                    .foregroundColor(self.color)
                    .foregroundStyle(self.color)
                    .cornerRadius(15)
                if self.spacerBool {
                    Spacer()
                }
            }
            VStack {
                Text(self.title)
                HStack(spacing: 0) {
                    Text("\(self.count > 0 ? 1 : 0)/")
//                        .font(.title3)
//                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("\(String(format: "%.\(numberofDicimal)f", self.denomination))")
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(1)
                }
            }
        }
    }
}


// /////////////////////
// ビュー：水平型、確率表示、％タイプ
// /////////////////////
struct unitResultRatioPercent2Line: View {
    @State var title: String
    @State var color: Color = .grayBack
    @Binding var count: Int
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @State var spacerBool: Bool = true
    var ratio: Double {
        let ra = Double(count) / Double(bigNumber) * 100
        return bigNumber > 0 ? ra : 0.0
    }
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                if self.spacerBool {
                    Spacer()
                }
                Rectangle()
//                    .foregroundColor(self.color)
                    .foregroundStyle(self.color)
                    .cornerRadius(15)
                if self.spacerBool {
                    Spacer()
                }
            }
            VStack {
                Text(self.title)
                    .multilineTextAlignment(.center)
                HStack(spacing: 0) {
                    Text("\(String(format: "%.\(numberofDicimal)f", self.ratio))")
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("%")
//                        .font(.title3)
//                        .fontWeight(.bold)
                        .lineLimit(1)
                }
            }
        }
    }
    
}


// /////////////////////
// ビュー：水平型、確率表示、比率タイプ（右が１になるように計算）
// /////////////////////
struct unitResultRatioRatioRightOneLine: View {
    @State var title: String
    @State var color: Color
    @Binding var count1: Int
    @Binding var count2: Int
    @State var numberofDicimal: Int
    var leftNumber: Double {
        let ln = Double(count1) / Double(count2)
        return count2 > 0 ? ln : Double(count1)
    }
    var rightNumber: Int {
        return count2 > 0 ? 1 : 0
    }
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
//                    .foregroundColor(self.color)
                    .foregroundStyle(self.color)
                    .cornerRadius(15)
                Spacer()
            }
            // 表示部分
            VStack {
                // タイトル
                Text(self.title)
                    .multilineTextAlignment(.center)
                // 計算結果
//                HStack(spacing: 0) {
                    Text("\(String(format: "%.\(numberofDicimal)f", self.leftNumber)) : \(rightNumber)")
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
//                    Text("%")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .lineLimit(1)
//                }
            }
        }
    }
}



// //////////////////////////////////////////
// ビュー：テキストフィールド、ゲーム数入力、確率なし
// //////////////////////////////////////////
struct unitTextFieldGamesInput: View {
    @State var title: String
    @Binding var inputValue: Int
    
    var body: some View {
        HStack {
            Text(self.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(self.title, value: self.$inputValue, format: .number)
                .keyboardType(.numberPad)
//                .focused($isFocused)
                .multilineTextAlignment(.center)
        }
    }
}


// /////////////////////////////
// ビュー：マイナスチェックボタン
// /////////////////////////////
struct unitButtonMinusCheck: View {
    @Binding var minusCheck: Bool
    
    var body: some View {
        Button(action: {
            self.minusCheck.toggle()
        }, label: {
            if self.minusCheck {
                Image(systemName: "minus.circle.fill")
//                    .foregroundColor(Color.red)
                    .foregroundStyle(Color.red)
            } else {
                Image(systemName: "minus.circle")
            }
        })
    }
}


// ////////////////////////////
// ビュー：データリセットボタン
// ////////////////////////////
struct unitButtonReset: View {
    @Binding var isShowAlert: Bool
    let action: () -> Void
    @State var message: String = "このページのデータをリセットします"
    
    var body: some View {
        Button("リセット", systemImage: "arrow.clockwise.square") {
            self.isShowAlert = true
        }
        .alert("データリセット", isPresented: $isShowAlert) {
            Button("キャンセル", role: .cancel) {
                
            }
            Button("リセット", role: .destructive) {
                action()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        } message: {
            Text(self.message)
        }
    }
}


// ///////////////////////////////////
// ビュー：参考情報ページ、5行・２イメージ仕様
// ///////////////////////////////////
struct unitExView5body2image: View {
    @Environment(\.dismiss) private var dismiss
    @State var title: String
    @State var textBody1: String?
    @State var textBody2: String?
    @State var textBody3: String?
    @State var textBody4: String?
    @State var textBody5: String?
    @State var image1Title: String?
    @State var image1: Image?
    @State var image2Title: String?
    @State var image2: Image?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let textBody1 = textBody1 {
                        Text(textBody1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let textBody2 = textBody2 {
                        Text(textBody2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let textBody3 = textBody3 {
                        Text(textBody3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let textBody4 = textBody4 {
                        Text(textBody4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let textBody5 = textBody5 {
                        Text(textBody5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let image1Title = image1Title {
                        Text(image1Title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top)
                    }
                    if let image1 = image1 {
                        image1
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .bottom, .trailing])
                    }
                    if let image2Title = image2Title {
                        Text(image2Title)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    if let image2 = image2 {
                        image2
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .bottom, .trailing])
                    }
                    Spacer()
                }
                .padding(.leading)
            }
            // //// タイトル
            .navigationTitle(self.title)
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
    }
}


// ////////////////////////////////
// ビュー：機種トップページの機種タイトル
// ////////////////////////////////
struct unitLabelMachineTopTitle: View {
    @State var machineName: String
    @State var titleFont: Font = .title
    
    var body: some View {
        HStack {
            Spacer()
            Text(self.machineName)
                .font(self.titleFont)
                .fontWeight(.bold)
//                .foregroundColor(.primary)
                .foregroundStyle(Color.primary)
            Spacer()
        }
    }
}


// ////////////////////////////////
// ビュー：履歴カラムをセクションのヘッダーで表示
// ////////////////////////////////
struct unitHeaderHistoryColumns: View {
    var column1: String = "回数"
    var column1Width:Double = 40.0
    var column1Bool: Bool = true
    var column2: String?
    var column3: String?
    var column4: String?
    var column5: String?
    
    
    var body: some View {
        HStack {
            if self.column1Bool {
                Text(column1)
                    .frame(width: column1Width)
            }
            if let column2 = column2 {
                Text(column2)
                    .frame(maxWidth: .infinity)
            }
            if let column3 = column3 {
                Text(column3)
                    .frame(maxWidth: .infinity)
            }
            if let column4 = column4 {
                Text(column4)
                    .frame(maxWidth: .infinity)
            }
            if let column5 = column5 {
                Text(column5)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}


// ////////////////////////////////
// ビュー：履歴カラムをセクションのヘッダーで表示、回数なし
// ////////////////////////////////
struct unitHeaderHistoryColumnsWithoutTimes: View {
//    var column1: String = "回数"
//    var column1Width:Double = 40.0
    var column2: String?
    var column3: String?
    var column4: String?
    var column5: String?
    
    
    var body: some View {
        HStack {
//            Text(column1)
//                .frame(width: column1Width)
            if let column2 = column2 {
                Text(column2)
                    .frame(maxWidth: .infinity)
            }
            if let column3 = column3 {
                Text(column3)
                    .frame(maxWidth: .infinity)
            }
            if let column4 = column4 {
                Text(column4)
                    .frame(maxWidth: .infinity)
            }
            if let column5 = column5 {
                Text(column5)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}



// ////////////////////////////////
// ビュー：情報登録用のサークルピッカー
// ////////////////////////////////
struct unitPickerCircleString: View {
    var title: String
    @Binding var selected: String
    var selectList: [String]
    var pickerHeight: Double = 150
    
    var body: some View {
        VStack {
            Text(self.title)
            Picker(self.title, selection: $selected) {
                ForEach(selectList, id: \.self) { select in
//                    Text($0)
                    Text(select)
                }
            }
            .pickerStyle(.wheel)
        }
        .frame(height: self.pickerHeight)
        .frame(maxWidth: .infinity)
    }
}


// ///////////////////////////
// ビュー：情報登録用の登録ボタン
// ///////////////////////////
struct unitButtonSubmitwithDismis: View {
    let action: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                action()
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                dismiss()
            }, label: {
                Text("登録")
                    .fontWeight(.bold)
            })
            Spacer()
        }
    }
}


// ///////////////////////////
// ビュー：閉じるボタン
// ///////////////////////////
struct unitButtonColose: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            Button(action: {
                dismiss()
            }, label: {
                Text("閉じる")
                    .fontWeight(.bold)
            })
    }
}


// //////////////////////////////
// ビュー：画面選択してカウントするボタン
// //////////////////////////////
struct unitButtonScreenChoice: View {
    @State var image: Image
    @State var keyword: String
    @Binding var currentKeyword: String
    @Binding var count: Int
    @Binding var minusCheck: Bool
//    var firstTip = tipUnitButtonScreenChoiceFirstTap()
//    var secondTip = tipUnitButtonScreenChoiceSecondTap()
    
    var body: some View {
        Button {
            // //// 選択中の処理
            if currentKeyword == keyword {
                count = countUpDown(minusCheck: minusCheck, count: count)
                currentKeyword = ""
            }
            
            // //// 非選択中の処理
            else {
                currentKeyword = keyword
            }
            
        } label: {
            ZStack {
                // //// 選択中の表示
                if currentKeyword == keyword {
                    // 選択中＆マイナスチェックON時の表示
                    if minusCheck {
                        ZStack {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.5)
                                .border(Color.red, width: 10)
                                .cornerRadius(10)
                            Image(systemName: "minus.circle")
//                                .foregroundColor(Color.red)
                                .foregroundStyle(Color.red)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                    }
                    // 選択中＆マイナスチェックOFF時の表示
                    else {
                        ZStack {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.5)
                                .border(Color.green, width: 10)
                                .cornerRadius(10)
//                                .popoverTip(secondTip)
                            Image(systemName: "plus.circle")
//                                .foregroundColor(Color.green)
                                .foregroundStyle(Color.green)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                    }
                }
                
                // //// 非選択中の表示
                else {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
//                        .popoverTip(firstTip)
                }
            }
        }
    }
}


// //////////////////////////////
// ビュー：画面選択してカウントするボタン
// //////////////////////////////
struct unitButtonScreenChoiceForDataInput: View {
    @State var image: Image
    @State var keyword: String
    @Binding var currentKeyword: String
    
    var body: some View {
        Button {
            currentKeyword = keyword
        } label: {
            ZStack {
                // //// 選択中の表示
                if currentKeyword == keyword {
                    ZStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.5)
                            .border(Color.green, width: 10)
                            .cornerRadius(10)
                        Image(systemName: "")//plus.circle")
//                            .foregroundColor(Color.green)
                            .foregroundStyle(Color.green)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                }
                
                // //// 非選択中の表示
                else {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
            }
        }
    }
}


// /////////////////////////////
// ビュー：カウント結果のリスト表示
// /////////////////////////////
struct unitResultCountListPercent: View {
    @State var title: String
    @Binding var count: Int
    @State var flashColor: Color
    @Binding var bigNumber: Int
    @State var numberofDigit: Int = 1
    var ratio: Double {
        let Ratio = Double(count) / Double(bigNumber) * 100
        return bigNumber > 0 ? Ratio : 0.0
    }
    var body: some View {
        ZStack {
            Rectangle()
                .backgroundFlashModifier(trigger: count, color: flashColor)
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("\(count)")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("(\(String(format: "%.\(numberofDigit)f", ratio))%)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}


// //////////////////////////////
// ビュー：画面選択の解除 ツールバーボタン
// //////////////////////////////
struct unitButtonToolbarScreenSelectReset: View {
    @Binding var currentKeyword: String
//    var tips = tipUnitButtonScreenChoiceClear()
    
    var body: some View {
        Button(action: {
            currentKeyword = ""
        }, label: {
            if currentKeyword == "" {
                Image(systemName: "rectangle.on.rectangle.slash")
//                    .foregroundColor(.gray)
                    .foregroundStyle(Color.gray)
            } else {
                Image(systemName: "rectangle.on.rectangle.slash")
//                    .foregroundColor(.blue)
                    .foregroundStyle(Color.blue)
//                    .popoverTip(tips)
            }
        })
    }
}


// //////////////////////////////
// ビュー：スクロールのための空スペース
// //////////////////////////////
struct unitClearScrollSection: View {
    @State var spaceHeight: Double
    
    var body: some View {
        Section {
            Rectangle()
//                .foregroundColor(.clear)
                .foregroundStyle(Color.clear)
                .frame(height: self.spaceHeight)
        }
        .listRowBackground(Color.clear)
    }
}


// //////////////////////////////
// ビュー：スクロールのための空スペース
// //////////////////////////////
struct unitClearScrollSectionBinding: View {
    @Binding var spaceHeight: Double
    
    var body: some View {
        Section {
            Rectangle()
//                .foregroundColor(.clear)
                .foregroundStyle(Color.clear)
                .frame(height: self.spaceHeight)
        }
        .listRowBackground(Color.clear)
    }
}


// /////////////////////////////
// ビュー：メニュー画面の画像と目次
// /////////////////////////////
struct unitLabelMenu: View {
    @State var imageSystemName: String
    @State var textBody: String
    @State var imageWidthSize: Double = 25.0
    @State var statisticsBool: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: self.imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .foregroundColor(Color.gray)
                .foregroundStyle(Color.gray)
                .frame(width: self.imageWidthSize)
            Text(self.textBody)
            if self.statisticsBool {
                Spacer()
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.gray)
                    .frame(width: self.imageWidthSize)
            }
        }
    }
}

// //////////////////////////
// ビュー：メモリー上書き保存のツールバーボタン
// //////////////////////////
struct unitButtonSaveMemory: View {
    @State var isShowSaveView: Bool = false
    @State var saveView: AnyView
    
    var body: some View {
        Button {
            self.isShowSaveView.toggle()
        } label: {
            Image(systemName: "externaldrive.badge.plus")
        }
        .sheet(isPresented: self.$isShowSaveView) {
            self.saveView
                .presentationDetents([.large])
        }
    }
}


// //////////////////////////
// ビュー：メモリー上書き保存の画面
// //////////////////////////
struct unitViewSaveMemory: View {
    @Environment(\.dismiss) private var dismiss
    
    let memorySelectList: [String] = ["メモリー1", "メモリー2", "メモリー3"]
    let machineName: String
    @Binding var selectedMemory: String
    // メモリー1
    @Binding var memoMemory1: String
    @Binding var dateDoubleMemory1: Double
    @State var dateMemory1: Date = Date()
    @State var memoInput1: String = ""
    let actionMemory1: () -> Void
    // メモリー2
    @Binding var memoMemory2: String
    @Binding var dateDoubleMemory2: Double
    @State var dateMemory2: Date = Date()
    @State var memoInput2: String = ""
    let actionMemory2: () -> Void
    // メモリー3
    @Binding var memoMemory3: String
    @Binding var dateDoubleMemory3: Double
    @State var dateMemory3: Date = Date()
    @State var memoInput3: String = ""
    let actionMemory3: () -> Void
    
    @Binding var isShowSaveAlert: Bool
    @FocusState var isFocused: Bool
    
    @ObservedObject var common = commonVar()
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // //// 機種名
                    HStack {
                        Text("機種")
                        Spacer()
                        Text(self.machineName)
//                            .foregroundColor(.secondary)
                            .foregroundStyle(Color.secondary)
                    }
                    // //// メモリー選択
                    Picker("", selection: self.$selectedMemory) {
                        ForEach(self.memorySelectList, id: \.self) { memory in
                            Text(memory)
                        }
                    }
                    .pickerStyle(.palette)
                    // メモ
                    HStack {
                        Text("メモ")
                        if self.selectedMemory == "メモリー1" {
                            TextField("未入力", text: $memoInput1)
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
                        } else if self.selectedMemory == "メモリー2" {
                            TextField("未入力", text: $memoInput2)
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
                        } else {
                            TextField("未入力", text: $memoInput3)
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
                        }
                    }
                    // 日付
                    if self.selectedMemory == "メモリー1" {
                        DatePicker(selection: self.$dateMemory1, displayedComponents: .date) {
                            Text("日付")
                        }
                    } else if self.selectedMemory == "メモリー2" {
                        DatePicker(selection: self.$dateMemory2, displayedComponents: .date) {
                            Text("日付")
                        }
                    } else {
                        DatePicker(selection: self.$dateMemory3, displayedComponents: .date) {
                            Text("日付")
                        }
                    }
                }
                // 上書き保存ボタン
                Section {
                    Button {
                        self.isShowSaveAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("上書き保存")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .alert("上書き保存", isPresented: self.$isShowSaveAlert) {
                        Button("キャンセル", role: .cancel) {
                            
                        }
                        Button("OK", role: .destructive) {
                            // メモリー1
                            if self.selectedMemory == "メモリー1" {
                                self.memoMemory1 = self.memoInput1
                                self.dateDoubleMemory1 = self.dateMemory1.timeIntervalSince1970
                                actionMemory1()
                            }
                            // メモリー2
                            else if self.selectedMemory == "メモリー2" {
                                self.memoMemory2 = self.memoInput2
                                self.dateDoubleMemory2 = self.dateMemory2.timeIntervalSince1970
                                actionMemory2()
                            }
                            // メモリー3
                            else {
                                self.memoMemory3 = self.memoInput3
                                self.dateDoubleMemory3 = self.dateMemory3.timeIntervalSince1970
                                actionMemory3()
                            }
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            // //// レビューリクエストの実行
                            // アプリ起動回数が10回以上ならレビューリクエストを実行
                            if common.appLaunchCount > 10 {
                                // 現在の時刻を日本時間に合わせて取得
                                let currentDate = Date()
                                let calendar = Calendar.current
                                let timeZone = TimeZone(identifier: "Asia/Tokyo")!
                                let currentComponents = calendar.dateComponents(in: timeZone, from: currentDate)
                                // 時間のコンポーネントを取得
                                guard let hour = currentComponents.hour else { return }
                                // 21時から翌日の8時までの間
                                // 250102修正 15時から翌日の9時までの間、全然レビュー来ないので緩和
                                if hour >= 15 || hour < 9 {
                                    requestReview()
                                    print("レビューリクエストの実行")
                                    common.appLaunchCount = 0
                                } else {
                                    print("レビューリクエストの見送り")
                                }
                            } else {
                                print("起動回数不足:\(common.appLaunchCount)回")
                            }
                        }
                    } message: {
                        Text("現在のカウントデータを選択中のメモリーに上書き保存します")
                    }
                }
            }
            .navigationTitle("データ保存")
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
        .onAppear {
            self.memoInput1 = self.memoMemory1
            if self.dateDoubleMemory1 > 10000.0 {
                self.dateMemory1 = Date(timeIntervalSince1970: $dateDoubleMemory1.wrappedValue)
            } else {
                
            }
            self.memoInput2 = self.memoMemory2
            if self.dateDoubleMemory2 > 10000.0 {
                self.dateMemory2 = Date(timeIntervalSince1970: $dateDoubleMemory2.wrappedValue)
            } else {
                
            }
            self.memoInput3 = self.memoMemory3
            if self.dateDoubleMemory3 > 10000.0 {
                self.dateMemory3 = Date(timeIntervalSince1970: $dateDoubleMemory3.wrappedValue)
            } else {
                
            }
        }
    }
}


// //////////////////////////
// ビュー：メモリー読み出しのツールバーボタン
// //////////////////////////
struct unitButtonLoadMemory: View {
    @State var isShowLoadView: Bool = false
    @State var loadView: AnyView
    
    var body: some View {
        Button {
            self.isShowLoadView.toggle()
        } label: {
            Image(systemName: "folder")
        }
        .sheet(isPresented: self.$isShowLoadView) {
            self.loadView
                .presentationDetents([.large])
        }
    }
}


// //////////////////////////
// ビュー：メモリー読み出し画面
// //////////////////////////
struct unitViewLoadMemory: View {
    @Environment(\.dismiss) private var dismiss
    let memorySelectList: [String] = ["メモリー1", "メモリー2", "メモリー3"]
    let machineName: String
    @Binding var selectedMemory: String
    // メモリー1
    @State var memoMemory1: String
    @State var dateDoubleMemory1: Double
    let actionMemory1: () -> Void
    // メモリー2
    @State var memoMemory2: String
    @State var dateDoubleMemory2: Double
    let actionMemory2: () -> Void
    // メモリー3
    @State var memoMemory3: String
    @State var dateDoubleMemory3: Double
    let actionMemory3: () -> Void
    
    @Binding var isShowLoadAlert: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // //// 機種名
                    HStack {
                        Text("機種")
                        Spacer()
                        Text(self.machineName)
//                            .foregroundColor(.secondary)
                            .foregroundStyle(Color.secondary)
                    }
                    // //// メモリー選択
                    Picker("", selection: self.$selectedMemory) {
                        ForEach(self.memorySelectList, id: \.self) { memory in
                            Text(memory)
                        }
                    }
                    .pickerStyle(.palette)
                    // //// メモ
                    HStack {
                        Text("メモ")
                        Spacer()
                        if self.selectedMemory == "メモリー1" {
                            if self.memoMemory1 != "" {
                                Text(self.memoMemory1)
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        } else if self.selectedMemory == "メモリー2" {
                            if self.memoMemory2 != "" {
                                Text(self.memoMemory2)
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        } else {
                            if self.memoMemory3 != "" {
                                Text(self.memoMemory3)
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        }
                    }
                    // 日付
                    HStack {
                        Text("日付")
                        Spacer()
                        if self.selectedMemory == "メモリー1" {
                            if self.dateDoubleMemory1 > 10000.0 {
                                let date = Date(timeIntervalSince1970: self.dateDoubleMemory1)
                                Text(date, format: Date.FormatStyle(date: .long, time: .none))
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        } else if self.selectedMemory == "メモリー2" {
                            if self.dateDoubleMemory2 > 10000.0 {
                                let date = Date(timeIntervalSince1970: self.dateDoubleMemory2)
                                Text(date, format: Date.FormatStyle(date: .long, time: .none))
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        } else {
                            if self.dateDoubleMemory3 > 10000.0 {
                                let date = Date(timeIntervalSince1970: self.dateDoubleMemory3)
                                Text(date, format: Date.FormatStyle(date: .long, time: .none))
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            } else {
                                Text("なし")
//                                    .foregroundColor(.secondary)
                                    .foregroundStyle(Color.secondary)
                            }
                        }
                    }
                }
                // データ読み出しボタン
                Section {
                    Button {
                        self.isShowLoadAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("読み出し")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                }
                .alert("データ読み出し", isPresented: self.$isShowLoadAlert) {
                    Button("キャンセル", role: .cancel) {
                        
                    }
                    Button("OK", role: .destructive) {
                        // メモリー1
                        if self.selectedMemory == "メモリー1" {
                            actionMemory1()
                        }
                        // メモリー2
                        else if self.selectedMemory == "メモリー2" {
                            actionMemory2()
                        }
                        // メモリー3
                        else {
                            actionMemory3()
                        }
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } message: {
                    Text("現在のカウントデータをリセットし、選択中のメモリーデータを読み出します")
                }
            }
            .navigationTitle("データ読み出し")
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
}


// ////////////////////////////
// ビュー：95%信頼区間のグラフ表示（確率分母バージョン）
// ////////////////////////////
struct unitChart95CiDenominate: View {
    @Binding var currentCount: Int
    @Binding var bigNumber: Int
    @State var setting1Enable: Bool = true
    @State var setting1Denominate: Double
    @State var setting2Enable: Bool = true
    @State var setting2Denominate: Double
    @State var setting3Enable: Bool = true
    @State var setting3Denominate: Double
    @State var setting4Enable: Bool = true
    @State var setting4Denominate: Double
    @State var setting5Enable: Bool = true
    @State var setting5Denominate: Double
    @State var setting6Enable: Bool = true
    @State var setting6Denominate: Double
    let xAxisTitle: String = "設定"
    let barOpacity: Double = 0.5
    let chartHeight: CGFloat = 250
    let ruleMarkColor: Color = .red
//    let yScaleLower: Double = 0.8
//    let yScaleUpper: Double = 1.2
    @State var yScaleKeisu: Double = 0.2
    
    var body: some View {
        Chart {
            // 設定1
            if self.setting1Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定1"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting1Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting1Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.gray)
                .opacity(self.barOpacity)
            }
            
            // 設定2
            if self.setting2Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定2"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting2Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting2Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.blue)
                .opacity(self.barOpacity)
            }
            
            // 設定3
            if self.setting3Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定3"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting3Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting3Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.yellow)
                .opacity(self.barOpacity)
            }
            
            // 設定4
            if self.setting4Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定4"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting4Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting4Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.green)
                .opacity(self.barOpacity)
            }
            
            // 設定5
            if self.setting5Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定5"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting5Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting5Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.purple)
                .opacity(self.barOpacity)
            }
            
            // 設定6
            if self.setting6Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定6"),
                    yStart: .value("下限", statistical95Lower(denominate: self.setting6Denominate, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95Upper(denominate: self.setting6Denominate, times: self.bigNumber))
                )
                .foregroundStyle(Color.red)
                .opacity(self.barOpacity)
            }
            
            // 現在値の赤ライン
            RuleMark(
                y: .value("現状", self.currentCount)
            )
            .foregroundStyle(self.ruleMarkColor)
        }
//        .chartYScale(domain: (statistical95Lower(denominate: minDenominate(), times: self.bigNumber)-(statistical95Upper(denominate: maxDenominate(), times: self.bigNumber)*self.yScaleKeisu))...(statistical95Upper(denominate: maxDenominate(), times: self.bigNumber)+(statistical95Upper(denominate: maxDenominate(), times: self.bigNumber)*self.yScaleKeisu)))
//        .chartYScale(domain: (statistical95Lower(denominate: minDenominate(), times: self.bigNumber)*(1-self.yScaleKeisu))...(statistical95Upper(denominate: maxDenominate(), times: self.bigNumber)*(1+self.yScaleKeisu)))
        .chartYScale(domain: yScaleMin()...yScaleMax())
        .frame(height: self.chartHeight)
    }
    private func minDenominate() -> Double {
        var firstInput = false
        var minimumDenominate = 0.0
//        let currentDenominate = Double(bigNumber / currentCount)
        let currentDenominate = currentCount > 0 ? Double(bigNumber / currentCount) : 0.0
        // 設定1
        if self.setting1Enable && self.setting1Denominate >= 0 {
            minimumDenominate = self.setting1Denominate
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Denominate >= 0 {
            if !firstInput {
                minimumDenominate = self.setting2Denominate
                firstInput = true
            } else if minimumDenominate < self.setting2Denominate {
                minimumDenominate = self.setting2Denominate
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Denominate >= 0 {
            if !firstInput {
                minimumDenominate = self.setting3Denominate
                firstInput = true
            } else if minimumDenominate < self.setting3Denominate {
                minimumDenominate = self.setting3Denominate
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Denominate >= 0 {
            if !firstInput {
                minimumDenominate = self.setting4Denominate
                firstInput = true
            } else if minimumDenominate < self.setting4Denominate {
                minimumDenominate = self.setting4Denominate
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Denominate >= 0 {
            if !firstInput {
                minimumDenominate = self.setting5Denominate
                firstInput = true
            } else if minimumDenominate < self.setting5Denominate {
                minimumDenominate = self.setting5Denominate
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Denominate >= 0 {
            if !firstInput {
                minimumDenominate = self.setting6Denominate
                firstInput = true
            } else if minimumDenominate < self.setting6Denominate {
                minimumDenominate = self.setting6Denominate
            }
        }
        // 現在確率
        if minimumDenominate < currentDenominate {
            minimumDenominate = currentDenominate
        }
        
        return minimumDenominate
    }
    
    private func maxDenominate() -> Double {
        var maximumDenominate = 0.0
        var firstInput = false
//        let currentDenominate = Double(bigNumber / currentCount)
        let currentDenominate = currentCount > 0 ? Double(bigNumber / currentCount) : 0.0
        
        // 設定1
        if self.setting1Enable && self.setting1Denominate >= 0 {
            maximumDenominate = self.setting1Denominate
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Denominate >= 0 {
            if !firstInput {
                maximumDenominate = self.setting2Denominate
                firstInput = true
            } else if maximumDenominate > self.setting2Denominate {
                maximumDenominate = self.setting2Denominate
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Denominate >= 0 {
            if !firstInput {
                maximumDenominate = self.setting3Denominate
                firstInput = true
            } else if maximumDenominate > self.setting3Denominate {
                maximumDenominate = self.setting3Denominate
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Denominate >= 0 {
            if !firstInput {
                maximumDenominate = self.setting4Denominate
                firstInput = true
            } else if maximumDenominate > self.setting4Denominate {
                maximumDenominate = self.setting4Denominate
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Denominate >= 0 {
            if !firstInput {
                maximumDenominate = self.setting5Denominate
                firstInput = true
            } else if maximumDenominate > self.setting5Denominate {
                maximumDenominate = self.setting5Denominate
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Denominate >= 0 {
            if !firstInput {
                maximumDenominate = self.setting6Denominate
                firstInput = true
            } else if maximumDenominate > self.setting6Denominate {
                maximumDenominate = self.setting6Denominate
            }
        }
        // 現在確率
        if maximumDenominate > currentDenominate {
            maximumDenominate = currentDenominate
        }
        return maximumDenominate
    }
    
    private func yScaleMax() -> Double {
        var yMax: Double = 0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Denominate >= 0 {
            let y1Upper = statistical95Upper(denominate: self.setting1Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = y1Upper
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Denominate >= 0 {
            let y2Upper = statistical95Upper(denominate: self.setting2Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = y2Upper
                firstInput = true
            } else if yMax < y2Upper {
                yMax = y2Upper
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Denominate >= 0 {
            let yUpper = statistical95Upper(denominate: self.setting3Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Denominate >= 0 {
            let yUpper = statistical95Upper(denominate: self.setting4Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Denominate >= 0 {
            let yUpper = statistical95Upper(denominate: self.setting5Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Denominate >= 0 {
            let yUpper = statistical95Upper(denominate: self.setting6Denominate, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 現在カウント値
        if yMax < Double(self.currentCount) {
            yMax = Double(self.currentCount)
        }
//        print(yMax)
        return yMax * (1 + self.yScaleKeisu)
    }
    
    private func yScaleMin() -> Double {
        var yMin: Double = 0.0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting1Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting2Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting3Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting4Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting5Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Denominate >= 0 {
            let yLower = statistical95Lower(denominate: self.setting6Denominate, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 現在カウント
        if yMin > Double(self.currentCount) {
            yMin = Double(self.currentCount)
        }
        return self.currentCount > 0 ? yMin - (yScaleMax() * self.yScaleKeisu) : 0.0
    }
}


// ////////////////////////////
// ビュー：95%信頼区間のグラフ表示（パーセントバージョン）
// ////////////////////////////
struct unitChart95CiPercent: View {
    @Binding var currentCount: Int
    @Binding var bigNumber: Int
    @State var setting1Enable: Bool = true
    @State var setting1Percent: Double
    @State var setting2Enable: Bool = true
    @State var setting2Percent: Double
    @State var setting3Enable: Bool = true
    @State var setting3Percent: Double
    @State var setting4Enable: Bool = true
    @State var setting4Percent: Double
    @State var setting5Enable: Bool = true
    @State var setting5Percent: Double
    @State var setting6Enable: Bool = true
    @State var setting6Percent: Double
    let xAxisTitle: String = "設定"
    let barOpacity: Double = 0.5
    let chartHeight: CGFloat = 250
    let ruleMarkColor: Color = .red
    @State var yScaleKeisu: Double = 0.2
    
    var body: some View {
        Chart {
            // 設定1
            if self.setting1Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定1"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting1Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting1Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.gray)
                .opacity(self.barOpacity)
            }
            
            // 設定2
            if self.setting2Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定2"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting2Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting2Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.blue)
                .opacity(self.barOpacity)
            }
            
            // 設定3
            if self.setting3Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定3"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting3Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting3Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.yellow)
                .opacity(self.barOpacity)
            }
            
            // 設定4
            if self.setting4Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定4"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting4Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting4Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.green)
                .opacity(self.barOpacity)
            }
            
            // 設定5
            if self.setting5Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定5"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting5Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting5Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.purple)
                .opacity(self.barOpacity)
            }
            
            // 設定6
            if self.setting6Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定6"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting6Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting6Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.red)
                .opacity(self.barOpacity)
            }
            
            // 現在値の赤ライン
            RuleMark(
                y: .value("現状", self.currentCount)
            )
            .foregroundStyle(self.ruleMarkColor)
        }
//        .chartYScale(domain: (statistical95LowerPercent(percent: minPercent(), times: self.bigNumber)-(statistical95UpperPercent(percent: maxPercent(), times: self.bigNumber)*self.yScaleKeisu))...(statistical95UpperPercent(percent: maxPercent(), times: self.bigNumber)+(statistical95UpperPercent(percent: maxPercent(), times: self.bigNumber)*self.yScaleKeisu)))
        .chartYScale(domain: yScaleMin()...yScaleMax())
        .frame(height: self.chartHeight)
    }
    private func minPercent() -> Double {
        var firstInput = false
        var minimumPercent = 0.0
        let currentPercent = bigNumber > 0 ? Double(currentCount / bigNumber * 100) : 0.0
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            minimumPercent = self.setting1Percent
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting2Percent
                firstInput = true
            } else if minimumPercent > self.setting2Percent {
                minimumPercent = self.setting2Percent
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting3Percent
                firstInput = true
            } else if minimumPercent > self.setting3Percent {
                minimumPercent = self.setting3Percent
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting4Percent
                firstInput = true
            } else if minimumPercent > self.setting4Percent {
                minimumPercent = self.setting4Percent
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting5Percent
                firstInput = true
            } else if minimumPercent > self.setting5Percent {
                minimumPercent = self.setting5Percent
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting6Percent
                firstInput = true
            } else if minimumPercent > self.setting6Percent {
                minimumPercent = self.setting6Percent
            }
        }
        // 現在確率
        if minimumPercent > currentPercent {
            minimumPercent = currentPercent
        }
        return minimumPercent
    }
    
    private func maxPercent() -> Double {
        var maximumPercent = 0.0
        var firstInput = false
        let currentPercent = bigNumber > 0 ? Double(currentCount / bigNumber * 100) : 0.0
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            maximumPercent = self.setting1Percent
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting2Percent
                firstInput = true
            } else if maximumPercent < self.setting2Percent {
                maximumPercent = self.setting2Percent
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting3Percent
                firstInput = true
            } else if maximumPercent < self.setting3Percent {
                maximumPercent = self.setting3Percent
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting4Percent
                firstInput = true
            } else if maximumPercent < self.setting4Percent {
                maximumPercent = self.setting4Percent
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting5Percent
                firstInput = true
            } else if maximumPercent < self.setting5Percent {
                maximumPercent = self.setting5Percent
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting6Percent
                firstInput = true
            } else if maximumPercent < self.setting6Percent {
                maximumPercent = self.setting6Percent
            }
        }
        // 現在確率
        if maximumPercent < currentPercent {
            maximumPercent = currentPercent
        }
        return maximumPercent
    }
    private func yScaleMax() -> Double {
        var yMax: Double = 0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting1Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting2Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting3Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting4Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting5Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting6Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 現在カウント値
        if yMax < Double(self.currentCount) {
            yMax = Double(self.currentCount)
        }
//        print(yMax)
        return yMax * (1 + self.yScaleKeisu)
    }
    
    private func yScaleMin() -> Double {
        var yMin: Double = 0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting1Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting2Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting3Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting4Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting5Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting6Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 現在カウント値
        if yMin > Double(self.currentCount) {
            yMin = Double(self.currentCount)
        }
        return self.currentCount > 0 ? yMin - (yScaleMax() * self.yScaleKeisu) : 0.0
    }
}


// //////////////////////
// ビュー：信頼区間グラフのナビゲーション遷移用リンクボタン
struct unitNaviLink95Ci: View {
    @State var Ci95view: AnyView
    var body: some View {
        NavigationStack {
            NavigationLink {
                self.Ci95view
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "chart.bar.xaxis")
                        .font(.title2)
                        .foregroundStyle(Color.blue)
                }
            }

        }
    }
}


// ///////////////////////
// ビュー：信頼区間の説明リンクボタン
// ///////////////////////
struct unitButton95CiExplain: View {
    @State var isShow95CiExplain: Bool
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            self.isShow95CiExplain.toggle()
        } label: {
            Image(systemName: "info.circle")
        }
        .sheet(isPresented: $isShow95CiExplain) {
            NavigationView {
                PDFKitView(urlString: "ci95Explain")
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
}


// ///////////////////////
// 95%信頼グラフ　タブビュー表示用の入れ物
// ///////////////////////
struct unitListSection95Ci: View {
    @State var grafTitle: String
    @State var titleFont: Font = .title
    @State var grafView: AnyView
    var body: some View {
        List {
            Section {
                self.grafView
            } header: {
                unitLabelMachineTopTitle(machineName: self.grafTitle, titleFont: self.titleFont)
            }
            .popoverTip(tipUnit95CiViewExplain())
        }
    }
}

#Preview {
    myViewUnit()
}
