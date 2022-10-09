//
// SidebarSectionHeader.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI


struct SidebarSectionHeaderView: View {
    let headerText: String

    var body: some View {
        VStack {
            Text("\(headerText.uppercased())")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .foregroundColor(Color("TextLabel"))
        }
        .padding(.bottom, 6)
    }
}

struct SidebarSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SidebarSectionHeaderView(headerText: "Rooms")
    }
}
