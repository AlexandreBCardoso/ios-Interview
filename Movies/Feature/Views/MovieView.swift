//
//  MovieView.swift
//  Movies
//
//  Created by Alexandre Cardoso on 18/08/21.
//

import UIKit

class MovieView: UIView {
	
	// MARK: - UI Element
	lazy var activity: UIActivityIndicatorView = {
		 let activity = UIActivityIndicatorView()
		 activity.hidesWhenStopped = true
		 activity.startAnimating()
		 return activity
	}()

	lazy var tableView: UITableView = {
		 let tableView = UITableView(frame: .zero, style: .plain)
		 tableView.translatesAutoresizingMaskIntoConstraints = false
		 tableView.rowHeight = 120
		 tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
		 tableView.backgroundView = activity
		 tableView.tableFooterView = UIView()
		 return tableView
	}()
	
	
	// MARK: - Initialize
	override init(frame: CGRect = .zero) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Function
	func setupDelegates(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
		tableView.delegate = delegate
		tableView.dataSource = datasource
	}
	
}


// MARK: - Extension CodeView
extension MovieView: CodeView {
	
	func setupSubviews() {
		addSubview(activity)
		addSubview(tableView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
		])
	}
	
}
