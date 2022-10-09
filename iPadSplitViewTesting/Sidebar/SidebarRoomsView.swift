//
// SidebarRoomsView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

struct SidebarRoomsView: View {
    @State var selection: Int = 3
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoomRow(s: $selection, tag: 1, name: "Entrance")
            RoomRow(s: $selection, tag: 2,name: "Backyard")
            RoomRow(s: $selection, tag: 3,name: "Living Room")
            RoomRow(s: $selection, tag: 4,name: "Hallway")
            RoomRow(s: $selection, tag: 5,name: "Bedroom")
            RoomRow(s: $selection, tag: 6,name: "Front Door")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    struct RoomRow: View {
        @Binding var s: Int
        var tag: Int
        var name: String
        var active: Bool {
            s == tag
        }

        var body: some View {

            Button {
                s = tag
            } label: {
                HStack {
                    Image(systemName: active ? "square.split.bottomrightquarter.fill" : "square.split.bottomrightquarter")
                        .foregroundColor(active ? .white : Color("IconPrimary"))
                    Text(name)
                        .foregroundColor(active ? .white : Color("TextPrimary"))
                    Spacer()
                }
                .padding()
                .background(active ? .blue : .clear)
                .cornerRadius(10)
            }
        }
    }
}

struct SidebarRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarRoomsView()
    }
}
