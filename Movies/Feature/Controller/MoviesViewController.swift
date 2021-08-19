//
//  MoviesViewController.swift
//  Movies
//

import UIKit

class MoviesViewController: UIViewController {
	
	// MARK: - Variable
	var movieView: MovieView?
	
	var movies = [Movie]()
	var viewModel: MoviesViewModel!
	
	
	// MARK: - Initialize
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Life cycle
	override func loadView() {
		movieView = MovieView()
		self.view = movieView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = MoviesViewModel()
		
		setupTableView()
		setupNavigationController()
		loadData()
	}
	
	
	// MARK: - Function
	private func setupTableView() {
		movieView?.setupDelegates(delegate: self, datasource: self)
	}
	
	private func setupNavigationController() {
		title = "Filmes Populares"
	}
	
	func loadData() {
		viewModel.loadContacts { movies, error in
			DispatchQueue.main.async {
				if let error = error {
					print(error)
					
					let alert = UIAlertController(title: "Ops, ocorreu um erro", message: error.localizedDescription, preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
					self.present(alert, animated: true)
					return
				}
				
				self.movies = movies ?? []
				self.movieView?.tableView.reloadData()
				self.movieView?.activity.stopAnimating()
			}
		}
	}
	
}


// MARK: - Extension UITableView
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
			return UITableViewCell()
		}
		
		let movie = movies[indexPath.row]
		cell.movieTitleLabel.text = movie.title
		
		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: movie.posterURL)
				let image = UIImage(data: data)
				DispatchQueue.main.async {
					cell.movieImage.image = image
				}
				
			} catch _ {}
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let filme = movies[indexPath.row]
		
		let alert = UIAlertController(title: "Atenção", message:"Seu filme é \(filme.title)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true)
	}
	
	
}
