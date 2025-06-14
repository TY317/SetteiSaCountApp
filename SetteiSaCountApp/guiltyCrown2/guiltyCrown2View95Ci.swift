//
//  guiltyCrown2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import SwiftUI

struct guiltyCrown2View95Ci: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    guiltyCrown2View95Ci(
        guiltyCrown2: GuiltyCrown2()
    )
}
