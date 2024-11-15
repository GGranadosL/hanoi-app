//
//  MockGetMovesUseCase.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 14/11/24.
//
@testable import HanoiSolverApp

class MockGetMovesUseCase: GetMovesUseCaseProtocol {
    var result: Result<[Move], Error> = .success([])
    
    func execute(numberOfDisks: Int) async throws -> [Move] {
        switch result {
        case .success(let moves):
            return moves
        case .failure(let error):
            throw error
        }
    }
}

