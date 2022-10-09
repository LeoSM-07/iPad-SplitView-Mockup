//
// ItemDetailView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

struct ItemDetailView: View {

    let device = Device(name: "Couch Lamp", state: "On", icon: "lightbulb.fill", color: .yellow)

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("ListBackground"))

            VStack {


                HStack(spacing: 10) {
                    DeviceIcon(device: device)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(device.name)
                            .font(.title3.bold())
                            .lineLimit(1)
                        Text(device.state)
                            .foregroundColor(.secondary)
                            .font(.headline.weight(.medium))
                            .lineLimit(1)
                    }
                    Spacer()

                    HStack {
                        Text("On")
                        Text("•")
                        Text("Off")
                            .foregroundColor(Color("IconPrimary"))
                            .opacity(0.5)
                        Button {} label: {
                            Image(systemName: "power")
                                .foregroundColor(Color.primary).colorInvert()
                                .padding(10)
                                .background(.primary)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                    }
                    .fontWeight(.medium)
                    .padding(.leading)
                    .background(Capsule().foregroundColor(Color("IconBackground")))
                    .fixedSize(horizontal: false, vertical: true)
                }


                Spacer()

            }
            .padding(.top, 25)
            .padding()
        }
        .ignoresSafeArea(.all, edges: .vertical)

    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
