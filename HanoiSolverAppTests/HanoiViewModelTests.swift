//
//  HanoiSolverAppTests.swift
//  HanoiSolverAppTests
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import XCTest
@testable import HanoiSolverApp

@MainActor
final class HanoiViewModelTests: XCTestCase {
    
    var viewModel: HanoiViewModel!
    var mockUseCase: MockGetMovesUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetMovesUseCase()
        viewModel = HanoiViewModel(getMovesUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testLoadMovesSuccess() async {
        // Arrange
        let expectedMoves = [
            Move(description: "Move disk 1 from rod A to rod B"),
            Move(description: "Move disk 2 from rod A to rod C"),
            Move(description: "Move disk 1 from rod B to rod C")
        ]
        mockUseCase.result = .success(expectedMoves)
        
        // Act
        await viewModel.loadMoves(numberOfDisks: 2, startAnimation: false)
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.moves, expectedMoves)
        XCTAssertEqual(viewModel.moveDescriptions, expectedMoves.map { $0.description })
        XCTAssertEqual(viewModel.initialDiskCount, 2)
        XCTAssertEqual(viewModel.towers, [[2, 1], [], []])
    }

    func testLoadMovesFailure() async {
        // Arrange
        let expectedError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get moves"])
        mockUseCase.result = .failure(expectedError)
        
        // Act
        await viewModel.loadMoves(numberOfDisks: 2)
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
        XCTAssertTrue(viewModel.moves.isEmpty)
        XCTAssertEqual(viewModel.towers, [[], [], []])
    }

    
    func testPerformMove() {
        // Arrange
        viewModel.initialDiskCount = 2
        viewModel.towers = [[2, 1], [], []]
        let move = Move(description: "Move disk 1 from rod A to rod B")
        
        // Act
        viewModel.performMove(move)
        
        // Assert
        XCTAssertEqual(viewModel.towers, [[2], [1], []])
    }
    
    func testTowerIndex() {
        // Act & Assert
        XCTAssertEqual(viewModel.towerIndex(for: "A"), 0)
        XCTAssertEqual(viewModel.towerIndex(for: "B"), 1)
        XCTAssertEqual(viewModel.towerIndex(for: "C"), 2)
        XCTAssertEqual(viewModel.towerIndex(for: "D"), 0) // Default case
    }
}
