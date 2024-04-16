#if canImport(UIKit)
import UIKit
import Combine

class SongsListViewController: UITableViewController, SongsListViewInput {
    
    let cellIdentifier = "SongTableViewCell"
    var viewModel: SongsListViewModel
    var cancellables: [AnyCancellable] = []
    
    init(viewModel: SongsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.primaryBackground.uiColor
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        
        viewModel.$state.sink { [weak self] state in
            self?.render(state: state)
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onWillAppear()
    }
    
    func render(state: SongsListViewModel.ViewState) {
        LegacyActivityIndicatorView.hide()
        switch state {
        case .error(let error):
            showError(errorMessage: error)
        case .loading:
            LegacyActivityIndicatorView.present(in: self)
        case .songs:
            break;
        }
        tableView.reloadData()
    }
    
    // MARK: - Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SongTableViewCell
        let item = viewModel.items[indexPath.row]
        cell.songTitleLabel.text = item.song.name
        cell.statusView.configure(with: item.status)
        
        cell.progressCancellable = viewModel.interactor?.activeLoadings[item.song.id]?
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak cell] progress in
                cell?.statusView.progressView.setProgress(with: CGFloat(progress))
            })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onSelectItem(at: indexPath.row)
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
}

import Router

extension SongsListViewController: UIKitDestination {
    func viewController() -> UIViewController {
        self
    }
}

#endif
