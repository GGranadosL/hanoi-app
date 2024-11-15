//
//  DiskView.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import SwiftUI

struct DiskView: View {
    let diskNumber: Int
    let totalDisks: Int

    var body: some View {
        Rectangle()
            .fill(diskColor)
            .frame(width: diskWidth, height: diskHeight)
            .cornerRadius(diskHeight / 2)
            .shadow(radius: 2)
    }

    private var diskHeight: CGFloat {
        20
    }

    private var diskWidth: CGFloat {
        // Calculate width based on disk number
        let baseWidth: CGFloat = 30
        let increment: CGFloat = 20
        return baseWidth + increment * CGFloat(diskNumber - 1)
    }

    private var diskColor: Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
        return colors[(diskNumber - 1) % colors.count]
    }
}
