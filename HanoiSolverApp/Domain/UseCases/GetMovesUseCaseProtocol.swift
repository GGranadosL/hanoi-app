//
//  GetMovesUseCaseProtocol.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

protocol GetMovesUseCaseProtocol {
    func execute(numberOfDisks: Int) async throws -> [Move]
}
