//
//  MoviesService.swift
//  MoviesList
//
//  Created by Mihail Salari on 7/15/23.
//

import Foundation

protocol MoviesServiceProtocol: AnyObject {
    func getMovies(with urlString: String, parameters: [String: Any]?, headers: [String: String]?,
                               completion: @escaping (Result<MovieResult, Error>) -> Void)
}

final class MoviesService: MoviesServiceProtocol {
    private let network: NetworkManagerProtocol
    
    init(with network: NetworkManagerProtocol) {
        self.network = network
    }
    
    func getMovies(with urlString: String, parameters: [String: Any]?, headers: [String: String]?,
                               completion: @escaping (Result<MovieResult, Error>) -> Void) {
        network.request(with: urlString, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
}
