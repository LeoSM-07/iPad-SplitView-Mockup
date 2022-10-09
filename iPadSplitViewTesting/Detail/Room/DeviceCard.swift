//
// DeviceCard.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI



struct Device: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var state: String
    var icon: String
    var color: Color
    var size: DeviceCardSize = .regular

    enum DeviceCardSize: Int {
        case regular = 1
        case large = 2
        case extralarge = 3
    }
}

struct DeviceIcon: View {
    var device: Device
    var body: some View {
        ZStack {
            Circle()
                .fill(device.color.gradient)
            Image(systemName: device.icon)
                .foregroundColor(.white)
        }.frame(width: 40, height: 40)
    }
}

struct DeviceCard: View {

    var device: Device

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color("ListBackground"))

                VStack(alignment: .leading) {
                    DeviceIcon(device: device)
                    Spacer()
                    Text(device.name)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    Text(device.state)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
//                Text("\(Int(geometry.size.width))x\(Int(geometry.size.height))")
//                    .background(.red)
            }
            .cornerRadius(12)
        }
        .gridCellColumns(device.size.rawValue)
    }
}


struct DeviceCard_Previews: PreviewProvider {
    static var previews: some View {
        DeviceCard(device: Device(name: "Nest Wifi", state: "Connected", icon: "wifi", color: .blue))
    }
}
