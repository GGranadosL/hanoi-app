//
//  HanoiViewModel.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation
import SwiftUI

@MainActor
class HanoiViewModel: ObservableObject {
    // Main properties
    @Published var moves: [Move] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Properties for graphical representation
    @Published var towers: [[Int]] = [[], [], []]
    @Published var currentMoveIndex: Int = 0
    @Published var isAnimating = false
    @Published var initialDiskCount: Int = 0
    @Published var moveDescriptions: [String] = []
    
    private let getMovesUseCase: GetMovesUseCaseProtocol
    
    init(getMovesUseCase: GetMovesUseCaseProtocol) {
        self.getMovesUseCase = getMovesUseCase
    }
    
    func loadMoves(numberOfDisks: Int, startAnimation: Bool = true) async {
        // Clear previous moves
        self.moveDescriptions = []
        
        isLoading = true
        errorMessage = nil
        moves = []
        towers = [[], [], []]
        currentMoveIndex = 0
        initialDiskCount = numberOfDisks
        
        do {
            let moves = try await getMovesUseCase.execute(numberOfDisks: numberOfDisks)
            self.moves = moves
            // Initialize towers with disks on the first tower
            self.towers = [
                Array((1...numberOfDisks).reversed()), // Tower A
                [],                                     // Tower B
                []                                      // Tower C
            ]
            
            // Store move descriptions
            self.moveDescriptions = self.moves.map { $0.description }
            
            isLoading = false
            if startAnimation {
                self.startAnimation()
            }
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func startAnimation() {
        isAnimating = true
        currentMoveIndex = 0
        animateNextMove()
    }
    
    func animateNextMove() {
        guard currentMoveIndex < moves.count else {
            isAnimating = false
            return
        }
        
        let move = moves[currentMoveIndex]
        performMove(move)
        currentMoveIndex += 1
        
        // Schedule the next move
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateNextMove()
        }
    }
    
    func performMove(_ move: Move) {
        // Parse the move description to determine from and to towers
        // Example: "Move disk 1 from rod A to rod C"
        
        print("Move description: \(move.description)")
        
        let components = move.description.components(separatedBy: " ")
        guard components.count >= 6 else { return }
        
        
        guard
            let diskNumber = Int(components[2]),
            let fromRod = components[5].last,
            let toRod = components[8].last
        else {
            return
        }
        
        let fromIndex = towerIndex(for: fromRod)
        let toIndex = towerIndex(for: toRod)
        
        withAnimation(.easeInOut(duration: 0.5)) {
            // Remove the disk from the fromTower
            if let index = towers[fromIndex].firstIndex(of: diskNumber) {
                towers[fromIndex].remove(at: index)
                // Add the disk to the toTower
                towers[toIndex].append(diskNumber)
            }
        }
    }
    
    func towerIndex(for rod: Character) -> Int {
        switch rod {
        case "A", "a":
            return 0
        case "B", "b":
            return 1
        case "C", "c":
            return 2
        default:
            return 0
        }
    }
    
}

