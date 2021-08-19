//
//  MoviesViewModel.swift
//  Movies
//

import Foundation

class MoviesViewModel {
	
	private let service: MovieServiceRepository
	
	init(service: MovieServiceRepository = MovieService()) {
		self.service = service
	}
	
	func loadContacts(_ completion: @escaping ([Movie]?, MovieError?) -> Void) {
		service.fetchMovies { result in
			switch result {
				case .success(let movies):
					completion(movies, nil)
				case .failure(let error):
					completion(nil, error)
			}
		}
	}
	
}
