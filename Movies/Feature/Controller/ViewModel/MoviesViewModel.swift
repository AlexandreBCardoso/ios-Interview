//
//  MoviesViewModel.swift
//  Movies
//

import Foundation

class MoviesViewModel {
	
	private let service: MovieServiceRepository
	private var movies = [Movie]()
	
	var count: Int {
		return movies.count
	}
	
	
	init(service: MovieServiceRepository = MovieService()) {
		self.service = service
	}
	
	func loadContacts(_ completion: @escaping ([Movie]?, MovieError?) -> Void) {
		service.fetchMovies { result in
			switch result {
				case .success(let movies):
					self.movies = movies
					completion(movies, nil)
				case .failure(let error):
					completion(nil, error)
			}
		}
	}
	
	func getMovie(index: Int) -> Movie {
		return movies[index]
	}
	
}
