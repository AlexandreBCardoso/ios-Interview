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
	
	func loadMovies(_ completion: @escaping(Bool, MovieError?) -> Void) {
		service.fetchMovies { result in
			switch result {
				case .success(let movies):
					self.movies = movies
					completion(true, nil)
					
				case .failure(let error):
					completion(false, error)
			}
		}
	}
	
	func getMovie(index: Int) -> Movie {
		return movies[index]
	}
	
}
