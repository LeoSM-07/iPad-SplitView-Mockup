//
// SidebarRoomsView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

struct SidebarRoomsView: View {

    @Binding var path: [RoomItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoomRow(path: $path, room: RoomItem(name: "Entrance", devices: []))
            RoomRow(path: $path, room: RoomItem(name: "Backyard", devices: []))
            RoomRow(path: $path, room: RoomItem(name: "Living Room", devices: [
                Device(name: "Nest Wifi", state: "Connected", icon: "wifi", color: .blue),
                Device(name: "Sony TV", state: "On • Standby", icon: "tv", color: .purple),
                Device(name: "Couch Lamp", state: "On", icon: "lightbulb.fill", color: .yellow),
                Device(name: "Air Purifier", state: "Off", icon: "leaf.fill", color: .green),
                Device(name: "Living Room Sonos", state: "Not Playing", icon: "homepod", color: .pink, size: .large),
            ]))
            RoomRow(path: $path, room: RoomItem(name: "Hallway", devices: []))
            RoomRow(path: $path, room: RoomItem(name: "Bedroom", devices: []))
            RoomRow(path: $path, room: RoomItem(name: "Front Door", devices: []))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    struct RoomRow: View {
        @Binding var path: [RoomItem]
        var room: RoomItem
        var active: Bool {
            path.last?.name == room.name
        }

        var body: some View {

            NavigationLink {
                RoomDetialView(room: room)
            } label: {
                HStack {
                    Image(systemName: active ? "square.split.bottomrightquarter.fill" : "square.split.bottomrightquarter")
                        .foregroundColor(active ? .white : Color("IconPrimary"))
                    Text(room.name)
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
