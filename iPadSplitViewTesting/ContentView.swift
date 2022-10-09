//
// ContentView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/8/22.
//

import SwiftUI





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



struct ContentView: View {

    @State private var columnVisibility = NavigationSplitViewVisibility.all

    var body: some View {

        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarView()
        } detail: {
            SplitDetailView(columnVisibility: $columnVisibility)

        }

    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
