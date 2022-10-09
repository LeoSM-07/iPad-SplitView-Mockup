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

//    @Binding var columnVisibility: NavigationSplitViewVisibility
//    private var isBig: Bool {
//        columnVisibility == .detailOnly
//    }

    var room: RoomItem

    var devicesList: [[Device]] {
        calcDeviceGrid()
    }

    func calcDeviceGrid() -> [[Device]] {
        let columns = 3
        var devicesSpaced: [Device] = []
        var finalArray: [[Device]] = []
        var itemTotals: Int = 0

        // Calcuate Item Total
        for item in room.devices {
            itemTotals += item.size.rawValue
        }

        // Calculate Devices Spaced
        for item in room.devices {
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

    init(room: RoomItem) {
        self.room = room
    }

    var body: some View {

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
            GeometryReader { geo in
                let height3 = abs(geo.size.width/3-16)
//                let height4 = abs(geo.size.width/3-16)
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {

                    ForEach(devicesList, id: \.self) { deviceArray in
                        GridRow {
                            ForEach(deviceArray.prefix(3)) { device in
                                DeviceCard(device: device)
                            }
                        }
                        .frame(height: height3)
                    }

                }
            }

        }
        .padding(.horizontal, 12)
        .background(Color("MainBackground"))
        .navigationTitle(room.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("EDIT"){}
            }
        }
    }
}

