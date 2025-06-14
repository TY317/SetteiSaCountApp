//
//  unitMachinListLink.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct unitMachinListLink: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    @State var makerName: String
    @State var releaseYear: Int
    @State var releaseMonth: Int
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    let newBadgeBgColor: Color = .yellow
    let updateBadgeColor: Color = .red
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            HStack(spacing: 10.0) {
                ZStack {
                    // アイコン部分
                    self.iconImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            if self.btBadgeBool {
                                unitIconBtTriangleShape()
                                    .fill(Color.orange)
                                    .frame(width: 25, height: 25)
                                Text("BT")
                                    .font(.caption)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                    .rotationEffect(.degrees(-45))
                                    .offset(x: -4, y: -4)
                            }
                        }
                        .cornerRadius(8)
                        .padding(.trailing, 5.0)
                    // newバッジ部分
                    if self.badgeStatus == "new" {
                        VStack {
                            HStack {
                                Spacer()
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
                                        .frame(width: 25.0, height: 25.0)
                                    Circle()
                                        .foregroundStyle(self.updateBadgeColor)
                                        .frame(width: 20.0, height: 20.0)
                                }
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
//                .padding(.leading)
            }
        }
    }
}

#Preview {
    unitMachinListLink(
        linkView: AnyView(evaYakusokuViewTop()),
        iconImage: Image("evaYakusokuMachineIcon"),
        machineName: "ヱヴァンゲリオン〜約束の扉〜",
        makerName: "ビスティ",
        releaseYear: 2025,
        releaseMonth: 7,
        badgeStatus: "update",
        btBadgeBool: true,
    )
    .frame(height: 60)
}
