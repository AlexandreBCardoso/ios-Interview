//
//  CodeView.swift
//  Movies
//
//  Created by Alexandre Cardoso on 18/08/21.
//

import Foundation

protocol CodeView {
	func setupSubviews()
	func setupConstraints()
	func setupUI()
}

extension CodeView {
	
	func setupUI() {
		setupSubviews()
		setupConstraints()
	}
	
}
