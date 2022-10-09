//
// ContentView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/8/22.
//

import SwiftUI

struct SectionHeaderView: View {
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



struct ScenesView: View {
    
    @State var selection: Int = 1
    
    var body: some View {
        Grid {
            GridRow(alignment: .top) {
                SceneBox(s: $selection, tag: 1, name: "Listen to Music", color: .red, icon: "music.note")
                SceneBox(s: $selection, tag: 2, name: "Relaxing", color: .green, icon: "tv.and.hifispeaker.fill")
                SceneBox(s: $selection, tag: 3, name: "Arriving Home", color: .blue, icon: "figure.walk")
                SceneBox(s: $selection, tag: 4, name: "Good Night", color: .purple, icon: "moon.fill")
            }
            
        }
        .frame(maxWidth: .infinity)
    }
    
    struct SceneBox: View {
        
        @Binding var s: Int
        var tag: Int
        var name: String
        var color: Color
        var icon: String
        var active: Bool = true
        
        var body: some View {
            
            Button {
                s = tag
            } label: {
                
                VStack {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                            .padding(.horizontal, 5)
                            .foregroundColor(Color("IconBackground"))
                        
                        if active {
                            Circle()
                                .fill(color.gradient)
                                .padding(.horizontal, 10)
                                .shadow(color: color.opacity(0.33), radius: 3, y: 2)
                        } else {
                            Circle()
                                .foregroundColor(Color("IconBackground"))
                                .padding(.horizontal, 10)
                        }
                        
                        Image(systemName: icon)
                            .font(.title3)
                            .foregroundColor(active ? .white : Color("IconPrimary"))
                    }
                    Text(name)
                        .foregroundColor(Color("TextPrimary"))
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
        }
            
    }
}

struct RoomsView: View {
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

struct ContentView: View {
    
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    @State private var selection: String?
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: .constant(.all)) {
            NavigationStack {
                ScrollView {

                    Section() {
                        ScenesView()
                        Divider()
                            .padding(.vertical)
                    } header: {
                        SectionHeaderView(headerText: "Quick Scenes")
                            .padding(.top)
                    }
                    .padding(.horizontal)
                    
                    Section() {
                        RoomsView()
                        Divider()
                            .padding(.bottom)
                            .foregroundColor(.red)
                    } header: {
                        SectionHeaderView(headerText: "Rooms")
                    }
                    .padding(.horizontal)
                    
                    
                }
                .searchable(text: $searchText)
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color("ListBackground"))
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button{} label: {
                            Image(systemName: "house")
                        }
                        Button{} label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        } detail: {
            SplitDetailView(columnVisibility: $columnVisibility)

        }

    }
}

struct SplitDetailView: View {

    @Binding var columnVisibility: NavigationSplitViewVisibility

    var body: some View {
        GeometryReader { geometry in
            let viewWidth = geometry.size.width
            HStack(spacing: 0) {
                
                RoomDetialView(columnVisibility: $columnVisibility.animation(.spring()))
                    .frame(width: viewWidth*1/2, height: geometry.size.height)
                Divider()
                    .ignoresSafeArea()
                    .frame(maxHeight: .infinity )
                ItemDetailView()
                    .frame(width: viewWidth*1/2)
            }

        }
    }
}

struct RoomDetialView: View {

    @Binding var columnVisibility: NavigationSplitViewVisibility
    private var isBig: Bool {
        columnVisibility == .detailOnly
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
                        
                        var height3 = abs(geo.size.width/3-16)
                        let height4 = abs(geo.size.width/4-16)
                        Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                            GridRow {
                                DeviceCard(name: "Nest Wifi", state: "Connected", icon: "wifi", color: .blue)
                                DeviceCard(name: "Sony TV", state: "On • Standby", icon: "tv", color: .purple)
                                DeviceCard(name: "Theromastat", state: "Cooling to 26°", icon: "snowflake", color: .blue)
                                if isBig {
                                    DeviceCard(name: "Air Purifier", state: "Off", icon: "leaf.fill", color: .green)
                                }
                            }
                            .frame(height: 129)
//                            .frame(height: isBig ? height3 : height3)
                            GridRow {
                                DeviceCard(name: "Air Purifier", state: "Off", icon: "leaf.fill", color: .green)
                                DeviceCard(name: "HomePod", state: "Not Playing", icon: "homepod", color: .pink, size: .large)
                                
                            }
                            .frame(height: 129)
//                            .frame(height: isBig ? height3 : height3)

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

enum DeviceCardSize: Int {
    case regular = 1
    case large = 2
    case extralarge = 3
}

struct DeviceCard: View {

    var name: String
    var state: String
    var icon: String
    var color: Color
    var size: DeviceCardSize = .regular
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color("ListBackground"))

                VStack(alignment: .leading) {

                    ZStack {
                        Circle()
                            .fill(color.gradient)
                        Image(systemName: icon)
                            .foregroundColor(.white)
                    }.frame(width: 50, height: 50)
                    Spacer()
                    Text(name)
                        .font(.headline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    Text(state)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)

                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(Int(geometry.size.width))x\(Int(geometry.size.height))")
                    .background(.red)
            }
            .cornerRadius(12)
        }
        .gridCellColumns(size.rawValue)
    }
}

struct ItemDetailView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("ListBackground"))
            VStack {
                Spacer()
                Text("Item")
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
