//
//  HanoiRemoteDataSourceProtocol.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

protocol HanoiRemoteDataSourceProtocol {
    func getMoves(numberOfDisks: Int) async throws -> [Move]
}
