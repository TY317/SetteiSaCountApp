//
//  unitMachinListLinkWithSfsymbol.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct unitMachinListLinkWithSfsymbol: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    var badgeStatus: String = "none"
    var newBadgeBgColor: Color = .yellow
    var updateBadgeColor: Color = .red
    var sfSymbolName: String = ""
    var sfSymbolColor: Color = .gray
    var sfSymbolfont: Font = .title3
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            HStack(spacing: 5.0) {
                ZStack {
                    // アイコン部分
                    ZStack {
                        self.iconImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
//                            .padding(.trailing, 5.0)
                        // SFシンボルを上に重ねる
                        Image(systemName: self.sfSymbolName)
                            .foregroundStyle(self.sfSymbolColor)
                            .font(self.sfSymbolfont)
                    }
                    .padding(.trailing, 5.0)
                    // newバッジ部分
                    if self.badgeStatus == "new" {
                        VStack {
                            HStack {
                                Spacer()
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(self.newBadgeBgColor)
                                        .cornerRadius(10.0)
                                        .frame(width: 40.0, height: 20.0)
                                    Text("NEW")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                            }
                            Spacer()
                        }
                    }
                    // updateバッジ部分
                    else if self.badgeStatus == "update" {
                        VStack {
                            HStack {
                                Spacer()
                                Circle()
                                    .foregroundStyle(self.updateBadgeColor)
                                    .frame(width: 20.0, height: 20.0)
                            }
                            Spacer()
                        }
                    }
                }
                .frame(width: 45.0)
                VStack(alignment: .leading) {
                    Text(self.machineName)
                    Text("\(self.makerName) , \(String(self.releaseYear))年 \(self.releaseMonth)月")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

//#Preview {
//    unitMachinListLinkWithSfsymbol()
//}
