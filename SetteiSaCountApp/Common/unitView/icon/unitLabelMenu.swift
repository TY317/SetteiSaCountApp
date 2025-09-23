//
//  unitLabelMenu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/21.
//

import SwiftUI

struct unitLabelMenu: View {
    @State var imageSystemName: String
    @State var textBody: String
    @State var imageWidthSize: Double = 20.0//25.0
    @State var imageHeightSize: Double = 20.0
    @State var statisticsBool: Bool = false
    let rectangleColor: Color = Color(UIColor.systemGray2)
//    let rectangleCornerRadius: CGFloat = 6.0
    let rectangleCornerRadius: CGFloat = 8.0
//    let rectangleSize: CGFloat = 30.0
    let rectangleSize: CGFloat = 35.0
//    var rectangleSize: CGFloat = 35.0
    let imageColor: Color = .white
    let hstackSpacing: CGFloat = 15.0
    var badgeStatus: String = ""
    let newBadgeBgColor: Color = .yellow
    let updateBadgeColor: Color = .red
    
    var body: some View {
        HStack(spacing: self.hstackSpacing) {
            ZStack {
                Rectangle()
                    .foregroundStyle(self.rectangleColor)
                    .cornerRadius(self.rectangleCornerRadius)
                    .padding(2.5)
                Image(systemName: self.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(self.imageColor)
                    .frame(width: self.imageWidthSize, height: self.imageHeightSize)
                // newバッジ部分
                if self.badgeStatus == "new" {
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                                    .cornerRadius(7.0)
                                    .frame(width: 27.0, height: 14.0)
                                Rectangle()
                                    .foregroundStyle(self.newBadgeBgColor)
                                    .cornerRadius(6.0)
                                    .frame(width: 25.0, height: 12.0)
//                                Rectangle()
//                                    .foregroundStyle(self.newBadgeBgColor)
//                                    .cornerRadius(7.0)
//                                    .frame(width: 30.0, height: 15.0)
                                Text("NEW")
                                    .foregroundStyle(Color.blue)
//                                    .font(.system(size: 10.0))
                                    .font(.system(size: 9.0))
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
                            ZStack {
                                Circle()
                                    .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                                    .frame(width: 16.0, height: 16.0)
                                Circle()
                                    .foregroundStyle(self.updateBadgeColor)
                                    .frame(width: 13.0, height: 13.0)
                            }
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: self.rectangleSize, height: self.rectangleSize)
            Text(self.textBody)
        }
        .padding(.vertical, -10)
    }
}
#Preview {
    List {
//        Text("test\ntest\ntest")
        Text("test\ntest")
            .padding(.vertical, -10)
        unitLabelMenu(
            imageSystemName: "bell.fill",
            textBody: "test",
        )
//        .padding(.vertical, -10)
        unitLabelMenu(
            imageSystemName: "bell.fill",
            textBody: "test",
//            rectangleSize: 30.0,
            badgeStatus: "update",
        )
//        .padding(.vertical, -10)
        unitLabelMenu(
            imageSystemName: "bell.fill",
            textBody: "test",
            badgeStatus: "new",
        )
//        .padding(.vertical, -10)
        HStack(spacing: 30.0) {
            ZStack {
                Rectangle()
                    .foregroundStyle(Color(UIColor.systemGray2))
                    .cornerRadius(8.0)
                    .padding(-5)
                    .overlay {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.white)
                            .frame(width: 20.0, height: 20.0)
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(7.0)
                                .frame(width: 27.0, height: 14.0)
                            Rectangle()
                                .foregroundStyle(Color.yellow)
                                .cornerRadius(6.0)
                                .frame(width: 25.0, height: 12.0)
                            Text("NEW")
                                .foregroundStyle(Color.blue)
                                .font(.system(size: 9.0))
                                .fontWeight(.bold)
                        }
                        .offset(x:4, y:-11)
                    }
            }
            .frame(width: 20.0, height: 20.0)
            .offset(x: 7.5, y: 0)
            Text("test")
        }
    }
}

