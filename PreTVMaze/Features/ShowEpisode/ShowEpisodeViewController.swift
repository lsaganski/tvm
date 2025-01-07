//
//  ShowEpisodeViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class ShowEpisodeViewController: ViewController<ShowEpisodeView> {
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        loadData()
    }
    
    //MARK: Private functions
    private func setupUI() {
        navigationItem.title = "Episode details"
    }
    
    private func setupActions() {
        showBarBackButton()
    }
    
    private func loadData() {
        guard let viewModel = viewModel as? ShowEpisodeViewModel,
              let episode = viewModel.episodeDetails else { return }
        if let url = URL(string: episode.image?.medium ?? "") {
            customView.posterImageView.load(url: url)
        }
        customView.nameLabel.text = String(format: "%1$d. %2$@", episode.number ?? 0, episode.name ?? "")
        customView.seasonLabel.text = String(format: Constants.String.season, episode.season ?? 0)
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                   .foregroundColor: UIColor.white]
        if let htmlText = NSString(string: episode.summary ?? "").data(using: String.Encoding.unicode.rawValue),
           let attrText = try? NSMutableAttributedString(data: htmlText,
                                                         options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attrText.addAttributes(attr, range: NSRange(location: 0, length: attrText.length))
            customView.summaryLabel.attributedText = attrText
        }
    }
}
