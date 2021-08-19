//
//  MovieCell.swift
//  Movies
//

import UIKit

class MovieCell: UITableViewCell {
	
	lazy var movieImage: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		imgView.clipsToBounds = true
		return imgView
	}()
	
	lazy var movieTitleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	// MARK: - Initialize
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}


// MARK: - Extension CodeView
extension MovieCell: CodeView {
	
	func setupSubviews() {
		contentView.addSubview(movieImage)
		contentView.addSubview(movieTitleLabel)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			movieImage.heightAnchor.constraint(equalToConstant: 100),
			movieImage.widthAnchor.constraint(equalToConstant: 100),
			
			movieTitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
			movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
			movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}

}
