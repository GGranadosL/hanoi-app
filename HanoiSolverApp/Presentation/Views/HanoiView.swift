//
//  HanoiView.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import SwiftUI

struct HanoiView: View {
    @StateObject var viewModel: HanoiViewModel
    @State private var numberOfDisks: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Number of disks", text: $numberOfDisks)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($isTextFieldFocused)
                    Button(action: {
                        isTextFieldFocused = false
                        solveHanoi()
                    }) {
                        Text("Solve")
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                }

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                         

                            if viewModel.moveDescriptions.count > 0 {
                                
                                // Towers View
                                HStack(alignment: .bottom, spacing: 20) {
                                    TowerView(disks: viewModel.towers[0], totalDisks: viewModel.initialDiskCount, towerLabel: "A")
                                    TowerView(disks: viewModel.towers[1], totalDisks: viewModel.initialDiskCount, towerLabel: "B")
                                    TowerView(disks: viewModel.towers[2], totalDisks: viewModel.initialDiskCount, towerLabel: "C")
                                }
                                .padding(.bottom, 50)
                                
                                // Moves List
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Moves:")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    ForEach(Array(viewModel.moveDescriptions.enumerated()), id: \.offset) { index, description in
                                        Text("\(index + 1). \(description)")
                                            .font(.body)
                                    }
                                }
                                .padding()
                                .frame(minWidth: 300, maxWidth: .infinity)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Towers of Hanoi")
            .padding()
        }
    }

    private func solveHanoi() {
        if let disks = Int(numberOfDisks), disks > 0 && disks <= 10 {
            Task {
                await viewModel.loadMoves(numberOfDisks: disks)
            }
        } else {
            viewModel.errorMessage = "Please enter a number between 1 and 10"
        }
    }
}

struct HanoiView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUseCase = PreviewGetMovesUseCase()
        let viewModel = HanoiViewModel(getMovesUseCase: mockUseCase)
        return HanoiView(viewModel: viewModel)
    }
}

struct PreviewGetMovesUseCase: GetMovesUseCaseProtocol {
    func execute(numberOfDisks: Int) async throws -> [Move] {
        // Datos mock para la vista previa
        return [
            Move(description: "Move disk 1 from rod A to rod B"),
            Move(description: "Move disk 2 from rod A to rod C"),
            Move(description: "Move disk 1 from rod B to rod C")
        ]
    }
}
