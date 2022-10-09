//
// SidebarView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

struct SidebarView: View {

    @State private var selection: String?

    @State private var searchText: String = ""

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {

                    Section() {
                        ScenesView()
                        Divider()
                            .padding(.vertical)
                    } header: {
                        SidebarSectionHeaderView(headerText: "Quick Scenes")
                            .padding(.top)
                    }
                    .padding(.horizontal)

                    Section() {
                        SidebarRoomsView()
                        Divider()
                            .padding(.bottom)
                            .foregroundColor(.red)
                    } header: {
                        SidebarSectionHeaderView(headerText: "Rooms")
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

                VStack {
                    Spacer()


                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("ListBackground"))
                        Button{} label: {
                            HStack {
                                Circle()
                                    .foregroundColor(.black)
                                    .padding(.vertical)
                                VStack(alignment: .leading) {
                                    Text("7ahang")
                                        .font(.headline)
                                    Text("Admin • Full Access")
                                        .font(.subheadline)
                                        .foregroundColor(Color("TextLabel"))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("IconPrimary"))
                            }
                            .padding()
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 100)
                    .shadow(color: colorScheme == .light ? .gray.opacity(0.2) : .black, radius: 25, y: -5)

                }
                .ignoresSafeArea(.all, edges: .bottom)

            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewLayout(.fixed(width: 300, height: 800))
    }
}
