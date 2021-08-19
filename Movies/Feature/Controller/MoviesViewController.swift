//
//  MoviesViewController.swift
//  Movies
//

import UIKit

class MoviesViewController: UIViewController {
	
	// MARK: - Variable
	private var movieView: MovieView?
	private var viewModel: MoviesViewModel!
	
	
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
		
		setupViewModel()
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
	
	private func setupViewModel() {
		viewModel = MoviesViewModel()
	}
	
	private func loadData() {
		viewModel.loadMovies { success, error in
			success ? self.movieSuccess() : self.movieError(error)
		}
	}
	
	private func movieSuccess() {
		DispatchQueue.main.async {
			self.movieView?.activity.stopAnimating()
			self.movieView?.tableView.reloadData()
		}
	}
	
	private func movieError(_ error: MovieError?) {
		DispatchQueue.main.async {
			var message = ""
			
			switch error {
				case .urlInvalid:
					message = "URL inválida"
				case .notFound:
					message = "Não foi encontrado dados"
				case .unknown:
					message = "Serviço indisponível"
				default:
					message = String(describing: error?.localizedDescription)
			}
			
			let alert = UIAlertController(title: "Ops, ocorreu um erro", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true)
		}
	}

}


// MARK: - Extension UITableView
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let movie = viewModel.getMovie(index: indexPath.row)
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell
		else { return UITableViewCell() }
		
		cell.setupCell(movie: movie)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movie = viewModel.getMovie(index: indexPath.row)
		
		let alert = UIAlertController(title: "Atenção", message: "Seu filme é \(movie.title)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true)
	}
	
	
}
