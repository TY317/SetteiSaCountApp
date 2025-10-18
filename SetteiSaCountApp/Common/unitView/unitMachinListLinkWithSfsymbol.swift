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
    var machineNameFont: Font = .body
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
            HStack(spacing: 10.0) {
                ZStack {
                    // アイコン部分
                    self.iconImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)   // ver3.5.0 iOS26に合わせて修正
                        .padding(.trailing, 5.0)
                        .overlay {
                            // SFシンボルを上に重ねる
                            Image(systemName: self.sfSymbolName)
                                .foregroundStyle(self.sfSymbolColor)
                                .font(self.sfSymbolfont)
                                .offset(x: -2.0, y: 0.0)
                        }
                        .overlay {
                            // newバッジ部分
                            if self.badgeStatus == "new" {
                                        ZStack {
                                            Rectangle()
                                                .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                                                .cornerRadius(11.0)
                                                .frame(width: 44.0, height: 24.0)
                                            Rectangle()
                                                .foregroundStyle(self.newBadgeBgColor)
                                                .cornerRadius(10.0)
                                                .frame(width: 40.0, height: 20.0)
                                            Text("NEW")
                                                .foregroundStyle(Color.blue)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                        }
                                        .offset(x: 1.0, y: -12.0)
                            }
                            // updateバッジ部分
                            else if self.badgeStatus == "update" {
                                        ZStack {
                                            Circle()
                                                .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                                                .frame(width: 25.0, height: 25.0)
                                            Circle()
                                                .foregroundStyle(self.updateBadgeColor)
                                                .frame(width: 20.0, height: 20.0)
                                        }
                                        .offset(x: 10.0, y: -12.0)
                            }
                        }
                }
                .frame(width: 45.0)
                VStack(alignment: .leading) {
                    Text(self.machineName)
                        .font(self.machineNameFont)
                    Text("\(self.makerName) , \(String(self.releaseYear))年 \(self.releaseMonth)月")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
            }
            .padding(.vertical, -1.5)
//            HStack(spacing: 5.0) {
//                ZStack {
//                    // アイコン部分
//                    ZStack {
//                        self.iconImage
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .cornerRadius(8)
////                            .padding(.trailing, 5.0)
//                        // SFシンボルを上に重ねる
//                        Image(systemName: self.sfSymbolName)
//                            .foregroundStyle(self.sfSymbolColor)
//                            .font(self.sfSymbolfont)
//                    }
//                    .padding(.trailing, 5.0)
//                    // newバッジ部分
//                    if self.badgeStatus == "new" {
//                        VStack {
//                            HStack {
//                                Spacer()
//                                ZStack {
//                                    Rectangle()
//                                        .foregroundStyle(self.newBadgeBgColor)
//                                        .cornerRadius(10.0)
//                                        .frame(width: 40.0, height: 20.0)
//                                    Text("NEW")
//                                        .font(.caption)
//                                        .fontWeight(.bold)
//                                }
//                            }
//                            Spacer()
//                        }
//                    }
//                    // updateバッジ部分
//                    else if self.badgeStatus == "update" {
//                        VStack {
//                            HStack {
//                                Spacer()
//                                Circle()
//                                    .foregroundStyle(self.updateBadgeColor)
//                                    .frame(width: 20.0, height: 20.0)
//                            }
//                            Spacer()
//                        }
//                    }
//                }
//                .frame(width: 45.0)
//                VStack(alignment: .leading) {
//                    Text(self.machineName)
//                    Text("\(self.makerName) , \(String(self.releaseYear))年 \(self.releaseMonth)月")
//                        .font(.caption)
//                        .foregroundStyle(Color.gray)
//                        .padding(.leading)
//                }
//                .padding(.leading)
//            }
        }
    }
}

//#Preview {
//    unitMachinListLinkWithSfsymbol()
//}
