//
//  myButtonStyle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

struct myButtonStyle: View {
    @State var TestBool = false
    
    var body: some View {
        VStack {
            Button("") {
                
            }
            .buttonStyle(CountButtonStyle(MinusBool: false))
            
            Button("aaa") {
                TestBool.toggle()
            }
            .buttonStyle(PlusDeleatButtonStyle(MinusBool: TestBool))
        }
    }
}
// /////////////////////////
// カウントボタンのボタンスタイル
// /////////////////////////
struct CountButtonStyle: ButtonStyle {
    var color: Color = .yellow
//    var plusColor: Color = .black
    var plusColor: Color = .secondary
    var minusColor: Color = .red
    var MinusBool = false
    var Vsize = 70.0
    var Hsize = 70.0
//    var Rsize = 10.0
    var Rsize = 15.0
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .frame(width: Vsize, height: Hsize)
                .background(color)
                .cornerRadius(Rsize)
                .labelStyle(IconOnlyLabelStyle())
                .font(.largeTitle)
                .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
                .shadow(color: color.opacity(configuration.isPressed ? 4.0 : 0.0), radius: 30, x: 0, y: 0)
                .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            if MinusBool == false {
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
//                    .foregroundColor(self.plusColor)
                    .foregroundStyle(self.plusColor)
            
            } else {
                Image(systemName: "minus.circle")
                    .font(.largeTitle)
//                    .foregroundColor(self.minusColor)
//                    .foregroundStyle(self.minusColor)
                    .foregroundStyle(minusColorSet())
                    .fontWeight(.bold)
            }
            
                
        }
    }
    private func minusColorSet() -> Color {
        if self.color == Color.red {
            return .black
        } else if self.color == Color.pink {
            return .black
        } else {
            return self.minusColor
        }
    }
}

// /////////////////////////
// データの追加または1行削除ボタン（主に履歴データ）
// /////////////////////////
struct PlusDeleatButtonStyle: ButtonStyle {
    var PlusColor: Color = Color("grayBack")
    var MinusColor: Color = .red
    var MinusBool = false
    var Wsize = 120.0
    var Hsize = 40.0
    var Rsize = 20.0
    
    func makeBody(configuration: Configuration) -> some View {
        if MinusBool == false {
            configuration.label
                .frame(width: Wsize, height: Hsize)
                .font(.largeTitle)
                .fontWeight(.bold)
                .background(PlusColor)
                .cornerRadius(Rsize)
        }
        else {
            configuration.label
                .frame(width: Wsize, height: Hsize)
                .font(.largeTitle)
                .fontWeight(.bold)
                .background(MinusColor)
                .cornerRadius(Rsize)
        }
    }
}


#Preview {
    myButtonStyle()
}
