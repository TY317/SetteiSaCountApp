//
//  reSwordView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordView95Ci: View {
    @ObservedObject var reSword: ReSword
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    reSwordView95Ci(
        reSword: ReSword(),
    )
}
