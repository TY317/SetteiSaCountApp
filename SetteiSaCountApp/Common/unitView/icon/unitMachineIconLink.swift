//
//  unitMachineIconLink.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

// //////////////////////////
// ビュー：機種選択ページ　アイコン表示用のリンク
// //////////////////////////
struct unitMachineIconLink: View {
    @State var linkView: AnyView
    @State var iconImage: Image
    @State var machineName: String
    var badgeStatus: String = "none"
    var btBadgeBool: Bool = false
    let newBadgeBgColor: Color = .yellow
    let updateBadgeColor: Color = .red
    
    var body: some View {
        NavigationLink(destination: self.linkView) {
            ZStack {
                // アイコン本体部分
                VStack {
                    self.iconImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(alignment: .topLeading) {
                            if self.btBadgeBool {
                                unitIconBtTriangleShape()
                                    .fill(Color.orange)
                                    .frame(width: 35, height: 35)
                                Text("BT")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                    .rotationEffect(.degrees(-45))
                                    .offset(x: -6, y: -6)
                            }
                        }
                        .cornerRadius(13.0)
                        .padding(.horizontal, 4.0)
                        .padding(.top, 4.0)
                    Text(self.machineName)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundStyle(Color.primary)
                }
                // newバッジ部分
                if self.badgeStatus == "new" {
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color(UIColor.systemGroupedBackground))
                                    .cornerRadius(11.25)
                                    .frame(width: 45.0, height: 25.0)
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
                            ZStack {
                                Circle()
                                    .foregroundStyle(Color(UIColor.systemGroupedBackground))
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
        }
    }
}

#Preview {
    unitMachineIconLink(
        linkView: AnyView(evaYakusokuViewTop()),
        iconImage: Image("evaYakusokuMachineIcon"),
        machineName: "ヱヴァ約束",
        badgeStatus: "none",
        btBadgeBool: true,
    )
    .frame(width: 70, height: 90)
}
