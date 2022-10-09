//
// RoomDetailView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

    func unique(selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
}
extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

struct RoomDetialView: View {

    @Binding var columnVisibility: NavigationSplitViewVisibility
    private var isBig: Bool {
        columnVisibility == .detailOnly
    }

    let devices: [Device] = [
        Device(name: "Nest Wifi", state: "Connected", icon: "wifi", color: .blue),
        Device(name: "Sony TV", state: "On • Standby", icon: "tv", color: .purple),
        Device(name: "Couch Lamp", state: "On", icon: "lightbulb.fill", color: .yellow),
        Device(name: "Air Purifier", state: "Off", icon: "leaf.fill", color: .green),
        Device(name: "Living Room Sonos", state: "Not Playing", icon: "homepod", color: .pink, size: .large),
    ]

    var devicesList: [[Device]] {
        calcDeviceGrid()
    }

    func calcDeviceGrid() -> [[Device]] {
        let columns = 3
        var devicesSpaced: [Device] = []
        var finalArray: [[Device]] = []
        var itemTotals: Int = 0

        // Calcuate Item Total
        for item in devices {
            itemTotals += item.size.rawValue
        }

        // Calculate Devices Spaced
        for item in devices {
            for _ in 1 ... item.size.rawValue {
                devicesSpaced.append(item)
            }

        }

        // Split array into array of arrays
        finalArray = devicesSpaced.chunked(into: columns)

        // Remove duplicate placeholders
        for (index, _) in finalArray.enumerated() {
            finalArray[index] = finalArray[index].unique {$0.name == $1.name}
        }

        // Remove any overflow
        for (index, array) in finalArray.enumerated() {
            if array[safe: 2]?.size == .extralarge {
                finalArray[index].removeLast()
            } else if array[safe: 1]?.size == .extralarge {
                finalArray[index].remove(at: 1)
            } else if array[safe: 2]?.size == .large {
                finalArray[index].remove(at: 2)
            }
        }

//        print("ItemTotal: \(itemTotals)")
//        print("Rows: \(rows)")
//        print(devicesSpaced.chunked(into: columns))
//        print(finalArray)

        return finalArray
    }

    var body: some View {
        GeometryReader { geo in
            ZStack{
                Rectangle()
                    .foregroundColor(Color("MainBackground"))
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("Living Room")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("Accessories")
                                .fontWeight(.medium)
                            Spacer()
                            Button{} label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color("IconPrimary"))
                            }
                        }

                        let height3 = abs(geo.size.width/3-16)
                        let height4 = abs(geo.size.width/3-16)
                        Grid(horizontalSpacing: 12, verticalSpacing: 12) {

                            ForEach(devicesList, id: \.self) { deviceArray in
                                GridRow {
                                    ForEach(deviceArray.prefix(3)) { device in
                                        DeviceCard(device: device)
                                    }
                                }
                                .frame(height: isBig ? height4 : height3)
                            }

                        }
                    }
                }
                .padding(12)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("EDIT"){}
            }
        }
    }
}

