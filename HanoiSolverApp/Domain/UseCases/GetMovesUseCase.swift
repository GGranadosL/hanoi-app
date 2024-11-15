//
//  GetMovesUseCase.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

class GetMovesUseCase: GetMovesUseCaseProtocol {
    private let repository: HanoiRepositoryProtocol

    init(repository: HanoiRepositoryProtocol) {
        self.repository = repository
    }

    func execute(numberOfDisks: Int) async throws -> [Move] {
        try await repository.fetchMoves(numberOfDisks: numberOfDisks)
    }
}
