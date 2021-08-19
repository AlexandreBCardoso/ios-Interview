//
//  MovieService.swift
//  Movies
//

import Foundation

private let apiURL = "https://api.themoviedb.org/3/movie/popular?api_key=12936d62fffd31723a5b1cca14af9929"

enum MovieError: Error {
	case urlInvalid
	case notFound
	case unknown
}

protocol MovieServiceRepository {
	func fetchMovies(completion: @escaping(Result<[Movie], MovieError>) -> Void)
}


class MovieService: MovieServiceRepository {
	
	func fetchMovies(completion: @escaping (Result<[Movie], MovieError>) -> Void) {
		
		guard let api = URL(string: apiURL)
		else { return completion(.failure(.urlInvalid)) }
		
		let session = URLSession.shared
		let task = session.dataTask(with: api) { data, response, error in
			
			if let _ = error {
				return completion(.failure(.urlInvalid))
			}
			
			guard let jsonData = data
			else { return completion(.failure(.notFound)) }
			
			do {
				let decoder = JSONDecoder()
				let result = try decoder.decode(MoviesPage.self, from: jsonData)
				completion(.success(result.movies))
				
			} catch {
				completion(.failure(.unknown))
			}
			
		}
		
		task.resume()
	}
	
}
