//
//  ShowListTableViewCell.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import Foundation
import UIKit

class ShowListTableViewCell: UITableViewCell {
    //MARK: Properties
    static var identifier: String {
        String(describing: self)
    }
    
    var posterImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    var label: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ShowListTableViewCell.identifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func didMoveToSuperview() {
        layoutIfNeeded()
    }

    //MARK: Private functions
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(posterImageView)
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 85),
            posterImageView.heightAnchor.constraint(equalToConstant: 120),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
    
    //MARK: Public functions
    func setupCell(imageUrl: String, text: String) {
        if let url = URL(string: imageUrl) {
            self.posterImageView.load(url: url)
        }
        self.label.text = text
    }
}

