//
//  ShowDetailsViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import UIKit

class ShowDetailsViewController: ViewController<ShowDetailsView> {
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        Task {
            await loadData()
        }
    }
    
    //MARK: Private functions
    private func setupUI() {
        navigationItem.title = "Details"
    }
    
    private func setupActions() {
        showBarBackButton()
    }
    
    private func loadData() async {
        customView.loading?.start()
        guard let viewModel = viewModel as? ShowDetailsViewModel,
              let show = viewModel.showDetails else { return }
        if let url = URL(string: show.image?.medium ?? "") {
            customView.posterImageView.load(url: url)
        }
        customView.nameLabel.text = show.name
        customView.scheduleLabel.text = show.getFormattedSchedule()
        customView.genresLabel.text = show.getFormattedGenres()
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                   .foregroundColor: UIColor.white]
        if let htmlText = NSString(string: show.summary ?? "").data(using: String.Encoding.unicode.rawValue),
           let attrText = try? NSMutableAttributedString(data: htmlText,
                                                         options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attrText.addAttributes(attr, range: NSRange(location: 0, length: attrText.length))
            customView.summaryLabel.attributedText = attrText
        }
           
        do {
            try await viewModel.fetchEpisodeList()
            reloadTableView()
        } catch(let error) {
            handleError(error)
        }
    }
    
    private func reloadTableView() {
        customView.episodesTableView.delegate = self
        customView.episodesTableView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            self?.customView.isLoading = false
            self?.customView.loading?.stop()
            self?.customView.episodesTableView.reloadData()
        }
    }
}

extension ShowDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel as? ShowDetailsViewModel else { return 0 }
        let numberOfSections = viewModel.seasons.count
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel as? ShowDetailsViewModel else { return "" }
        let seasonTitles = viewModel.seasons.map { String(format: Constants.String.season, $0) }
        return seasonTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? ShowDetailsViewModel else { return 0 }
        let numberOfRows = viewModel.showEpisodeList.filter { $0.season == viewModel.seasons[section] }.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel as? ShowDetailsViewModel else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowDetailsTableViewCell.identifier) as? ShowDetailsTableViewCell else {
            return UITableViewCell()
        }
        let episode = viewModel.showEpisodeList.filter { $0.season == viewModel.seasons[indexPath.section] }[indexPath.row]
        cell.setupCell(text: episode.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? ShowDetailsViewModel else { return }
        let episode = viewModel.showEpisodeList.filter { $0.season == viewModel.seasons[indexPath.section] }[indexPath.row]
        SessionManager.shared.coordinator?.goToEpisodeDetails(info: episode)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.cyan
    }
}
