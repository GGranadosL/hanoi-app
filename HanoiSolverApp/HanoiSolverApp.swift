//
//  HanoiSolverAppApp.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import SwiftUI

@main
struct HanoiSolverApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = HanoiRemoteDataSource()
            let repository = HanoiRepository(remoteDataSource: remoteDataSource)
            let useCase = GetMovesUseCase(repository: repository)
            let viewModel = HanoiViewModel(getMovesUseCase: useCase)
            HanoiView(viewModel: viewModel)
        }
    }
}
