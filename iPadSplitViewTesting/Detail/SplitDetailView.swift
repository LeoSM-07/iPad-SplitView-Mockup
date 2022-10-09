//
// SplitDetailView.swift
// iPadSplitViewTesting
//
// Created by LeoSM_07 on 10/9/22.
//

import SwiftUI

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

struct SplitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SplitDetailView(columnVisibility: .constant(.all))
    }
}
