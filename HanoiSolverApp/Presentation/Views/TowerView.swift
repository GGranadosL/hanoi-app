//
//  TowerView.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import SwiftUI

struct TowerView: View {
    let disks: [Int]
    let totalDisks: Int
    let towerLabel: String

    var body: some View {
        VStack {
            Text(towerLabel)
                .font(.headline)
                .padding(.bottom, 8)
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 10, height: CGFloat(totalDisks) * 25 + 20)
                ForEach(Array(disks.enumerated()), id: \.offset) { index, diskNumber in
                    DiskView(diskNumber: diskNumber, totalDisks: totalDisks)
                        .offset(y: CGFloat(-index * 25))
                        .animation(.easeInOut, value: disks)
                }
            }
        }
    }
}
