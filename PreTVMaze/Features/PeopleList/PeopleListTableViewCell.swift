//
//  PeopleListTableViewCell.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class PeopleListTableViewCell: UITableViewCell {
    //MARK: Properties
    static var identifier: String {
        String(describing: self)
    }
    
    var photoImageView: UIImageView = {
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
        super.init(style: style, reuseIdentifier: PeopleListTableViewCell.identifier)
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
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoImageView.widthAnchor.constraint(equalToConstant: 85),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22)
        ])
    }
    
    //MARK: Public functions
    func setupCell(imageUrl: String, text: String) {
        if let url = URL(string: imageUrl) {
            self.photoImageView.load(url: url)
        }
        self.label.text = text
    }
}
