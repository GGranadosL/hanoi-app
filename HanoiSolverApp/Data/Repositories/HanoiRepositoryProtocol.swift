//
//  HanoiRepositoryProtocol.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

protocol HanoiRepositoryProtocol {
    func fetchMoves(numberOfDisks: Int) async throws -> [Move]
}
