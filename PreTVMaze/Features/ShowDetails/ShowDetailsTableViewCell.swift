//
//  ShowDetailsTableViewCell.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import Foundation
import UIKit

class ShowDetailsTableViewCell: UITableViewCell {
    //MARK: Properties
    static var identifier: String {
        String(describing: self)
    }
    
    var label: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ShowDetailsTableViewCell.identifier)
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
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
    
    //MARK: Public functions
    func setupCell(text: String) {
        self.label.text = text
    }
}

