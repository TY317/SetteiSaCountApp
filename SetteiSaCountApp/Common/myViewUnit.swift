//
//  myViewUnit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI
import TipKit

struct myViewUnit: View {
    @State var count = 10
    var body: some View {
//        unitVerticalCountDenominate(count: self.$count)
        Text("aaa")
    }
}


//// //////////////////////
//// [旧式今後使用禁止]ビュー：縦型カウントボタン、確率分母タイプ
//// //////////////////////
//struct unitVerticalCountDenominate: View {
//    @State var title: String
//    @Binding var count: Int
//    @State var color: Color
//    @Binding var startGames: Int
//    @Binding var currentGames: Int
//    @State var numberofDicimal: Int
//    @Binding var minusBool: Bool
//    var denominator: Double {
//        let playGames = (currentGames - startGames) > 0 ? (currentGames - startGames) : 0
//        let deno = Double(playGames) / Double(count)
//        return count > 0 ? deno : 0.0
//    }
//    
//    var body: some View {
//        ZStack {
//            // 背景フラッシュ部分
//            Rectangle()
//                .backgroundFlashModifier(trigger: self.count, color: self.color)
//            // //// ボタンと表示部分
//            VStack(spacing: 5) {
//                // タイトル
//                Text(self.title)
//                // 確率
//                Text("\(self.count > 0 ? 1 : 0)/\(String(format:"%.\(self.numberofDicimal)f",self.denominator))")
//                    .fontWeight(.bold)
//                    .lineLimit(1)
//                // 回数
//                Text("\(self.count)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .lineLimit(1)
//                // カウントボタン
//                Button(action: {
//                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
//                }, label: {
//                    Text("")
//                })
//                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: minusBool))
//            }
//        }
//    }
//}
//
//
//// //////////////////////
//// [旧式今後使用禁止ビュー：縦型カウントボタン、％タイプ
//// //////////////////////
//struct unitVerticalCountPercent: View {
//    @State var title: String
//    @Binding var count: Int
//    @State var color: Color
//    @Binding var startGames: Int
//    @Binding var currentGames: Int
//    @State var numberofDicimal: Int
//    @Binding var minusBool: Bool
//    @State var totalNumber: Int
//    var ratio: Double {
//        let rat = Double(count) / Double(totalNumber) * 100
//        return totalNumber > 0 ? rat : 0.0
//    }
//    
//    var body: some View {
//        ZStack {
//            // 背景フラッシュ部分
//            Rectangle()
//                .backgroundFlashModifier(trigger: self.count, color: self.color)
//            // //// ボタンと表示部分
//            VStack(spacing: 5) {
//                // タイトル
//                Text(self.title)
//                // 確率
//                Text("\(String(format:"%.\(self.numberofDicimal)f",self.ratio))%")
//                    .font(.footnote)
//                    .fontWeight(.bold)
//                    .lineLimit(1)
//                // 回数
//                Text("\(self.count)")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .lineLimit(1)
//                // カウントボタン
//                Button(action: {
//                    self.count = countUpDown(minusCheck: self.minusBool, count: self.count)
//                }, label: {
//                    Text("")
//                })
//                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: self.minusBool))
//            }
//        }
//    }
//}


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
                        .foregroundColor(Color.gray)
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
                    .foregroundColor(Color.primary)
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
                    .foregroundColor(Color.blue)
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
                        .foregroundColor(Color.clear)
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
                        .foregroundColor(Color.clear)
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
                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: minusBool))
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
                        .foregroundColor(Color.clear)
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
    @State var color: Color
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
                    .foregroundColor(self.color)
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
    @State var color: Color
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
                    .foregroundColor(self.color)
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
    @State var color: Color
    @Binding var count: Int
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    var ratio: Double {
        let ra = Double(count) / Double(bigNumber) * 100
        return bigNumber > 0 ? ra : 0.0
    }
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(self.color)
                    .cornerRadius(15)
                Spacer()
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
                    .foregroundColor(self.color)
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
                    .foregroundColor(Color.red)
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
                .foregroundColor(.primary)
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
    var column2: String?
    var column3: String?
    var column4: String?
    var column5: String?
    
    
    var body: some View {
        HStack {
            Text(column1)
                .frame(width: column1Width)
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
        .frame(height: 150)
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
                                .foregroundColor(Color.red)
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
                                .foregroundColor(Color.green)
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
                            .foregroundColor(Color.green)
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
                    .foregroundColor(.gray)
            } else {
                Image(systemName: "rectangle.on.rectangle.slash")
                    .foregroundColor(.blue)
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
                .foregroundColor(.clear)
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
                .foregroundColor(.clear)
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
    
    var body: some View {
        HStack {
            Image(systemName: self.imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.gray)
                .frame(width: self.imageWidthSize)
            Text(self.textBody)
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
    
    // カスタムイニシャライザを追加
//    init(machineName: String, selectedMemory: Binding<String>, memoMemory1: Binding<String>, dateDoubleMemory1: Binding<Double>, actionMemory1: @escaping () -> Void = {}, memoMemory2: Binding<String>, dateDoubleMemory2: Binding<Double>, actionMemory2: @escaping () -> Void = {}, memoMemory3: Binding<String>, dateDoubleMemory3: Binding<Double>, actionMemory3: @escaping () -> Void = {}, isShowSaveAlert: Binding<Bool>) {
//        self._selectedMemory = selectedMemory
//        self._memoMemory1 = memoMemory1
//        self._dateDoubleMemory1 = dateDoubleMemory1
//        
//        // dateDoubleMemory1 から Date を生成して初期化
//        self._dateMemory1 = State(initialValue: Date(timeIntervalSince1970: dateDoubleMemory1.wrappedValue))
//        self._memoInput1 = State(initialValue: memoMemory1.wrappedValue)
//        self.actionMemory1 = actionMemory1
//        self.machineName = machineName
//        
//        // メモリー2
//        self._memoMemory2 = memoMemory2
//        self._dateDoubleMemory2 = dateDoubleMemory2
//        self._dateMemory2 = State(initialValue: Date(timeIntervalSince1970: dateDoubleMemory2.wrappedValue))
//        self._memoInput2 = State(initialValue: memoMemory2.wrappedValue)
//        self.actionMemory2 = actionMemory2
//        
//        // メモリー3
//        self._memoMemory3 = memoMemory3
//        self._dateDoubleMemory3 = dateDoubleMemory3
//        self._dateMemory3 = State(initialValue: Date(timeIntervalSince1970: dateDoubleMemory3.wrappedValue))
//        self._memoInput3 = State(initialValue: memoMemory3.wrappedValue)
//        self.actionMemory3 = actionMemory3
//        
//        self._isShowSaveAlert = isShowSaveAlert
//    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // //// 機種名
                    HStack {
                        Text("機種")
                        Spacer()
                        Text(self.machineName)
                            .foregroundColor(.secondary)
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
                            .foregroundColor(.secondary)
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
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
                            }
                        } else if self.selectedMemory == "メモリー2" {
                            if self.memoMemory2 != "" {
                                Text(self.memoMemory2)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            if self.memoMemory3 != "" {
                                Text(self.memoMemory3)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
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
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
                            }
                        } else if self.selectedMemory == "メモリー2" {
                            if self.dateDoubleMemory2 > 10000.0 {
                                let date = Date(timeIntervalSince1970: self.dateDoubleMemory2)
                                Text(date, format: Date.FormatStyle(date: .long, time: .none))
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            if self.dateDoubleMemory3 > 10000.0 {
                                let date = Date(timeIntervalSince1970: self.dateDoubleMemory3)
                                Text(date, format: Date.FormatStyle(date: .long, time: .none))
                                    .foregroundColor(.secondary)
                            } else {
                                Text("なし")
                                    .foregroundColor(.secondary)
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




#Preview {
    myViewUnit()
}
