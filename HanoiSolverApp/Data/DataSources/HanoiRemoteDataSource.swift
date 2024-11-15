//
//  HanoiRemoteDataSource.swift
//  HanoiSolverApp
//
//  Created by Gerardo Granados Lopez on 12/11/24.
//

import Foundation

class HanoiRemoteDataSource: HanoiRemoteDataSourceProtocol {
    func getMoves(numberOfDisks: Int) async throws -> [Move] {
        guard let url = URL(string: "https://us-central1-uh-balam.cloudfunctions.net/solveHanoi") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body: [String: Any] = ["numberOfDisks": numberOfDisks]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        // Check for HTTP errors
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let responseDTO = try decoder.decode(HanoiResponseDTO.self, from: data)
        let moves = responseDTO.moves.map { Move(description: $0) }
        return moves
    }
}
