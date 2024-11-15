//
//  HanoiRepository.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

class HanoiRepository: HanoiRepositoryProtocol {
    private let remoteDataSource: HanoiRemoteDataSourceProtocol

    init(remoteDataSource: HanoiRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchMoves(numberOfDisks: Int) async throws -> [Move] {
        try await remoteDataSource.getMoves(numberOfDisks: numberOfDisks)
    }
}
