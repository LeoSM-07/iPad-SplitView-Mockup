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
                            .font(.headline)
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
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
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
            SplitDetailView()
        }
    }
}

struct SplitDetailView: View {
    var body: some View {
        GeometryReader { geometry in
            let viewWidth = geometry.size.width
            HStack(spacing: 0) {
                
                RoomDetialView()
                    .frame(width: viewWidth*1/2)
                Divider()
                    .frame(maxHeight: .infinity )
                ItemDetailView()
                    .frame(width: viewWidth*1/2)
            }

        }
//        .ignoresSafeArea()
    }
}

struct RoomDetialView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("MainBackground"))
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Living Room")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView {
                    Spacer()
                        .frame(height: 15)
                    Rectangle()
                        .frame(height: 300)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding()

        }
//        .navigationTitle("Living Room")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("EDIT"){}
            }
            ToolbarItem {
                Text("test")
            }
        }
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
