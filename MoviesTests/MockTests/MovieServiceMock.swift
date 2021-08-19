//
//  MovieServiceMock.swift
//  MoviesTests
//
//  Created by Alexandre Cardoso on 18/08/21.
//

import Foundation
@testable import Movies



class MovieServiceMock: MovieServiceRepository {
	
	var typeProcess: MovieError?
	
	init(process: MovieError?) {
		self.typeProcess = process
	}
	
	func fetchMovies(completion: @escaping (Result<[Movie], MovieError>) -> Void) {
		
		switch typeProcess {
			case .urlInvalid:
				completion(.failure(.urlInvalid))
			case .notFound:
				completion(.failure(.notFound))
			case .unknown:
				completion(.failure(.unknown))
			default:
				guard let jsonData = mockData
				else { return completion(.failure(.notFound)) }
				
				do {
					let decoder = JSONDecoder()
					let result = try decoder.decode(MoviesPage.self, from: jsonData)
					completion(.success(result.movies))
					
				} catch {
					completion(.failure(.unknown))
				}
		}
	}
	
}
