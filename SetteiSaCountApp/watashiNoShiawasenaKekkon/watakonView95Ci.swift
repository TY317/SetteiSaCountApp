//
//  watakonView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct watakonView95Ci: View {
    @ObservedObject var watakon: Watakon
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    watakonView95Ci(
        watakon: Watakon(),
    )
}
