//
//  AlbumsViewController.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 27/06/21.
//

import UIKit
import Combine

class AlbumsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: Properties
    var viewModel: AlbumsViewModel?
    private var cancellable = Set<AnyCancellable>()
    private lazy var dataSource = makeDataSource()
    private var selectedAlbum: AlbumViewModel?

    // MARK: Initializer
    init?(coder: NSCoder,
          viewModel: AlbumsViewModel) {
        
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        bindViewModel()
        initialize()
    }
    
    private func initialize() {
        searchBar.text = "jack Johnson"
        viewModel?.search(with: "jack Johnson")
    }
    
    private func bindViewModel() {
        viewModel?.$results
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { albums in
                var snapshot = NSDiffableDataSourceSnapshot<Int, AlbumViewModel>()
                snapshot.appendSections([0])
                snapshot.appendItems(albums, toSection: 0)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            })
            .store(in: &cancellable)
        
        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { error in
                guard let error = error else { return }
                self.showErrorMessage(message: error.localizedDescription)
            })
            .store(in: &cancellable)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AlbumDetailViewController {
            guard let albumDetailViewController = segue.destination as? AlbumDetailViewController else { return }
            albumDetailViewController.viewModel = selectedAlbum
        }
    }
}

// MARK: UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAlbum = viewModel?.results[indexPath.row]
        performSegue(withIdentifier: "ToAlbumDetail", sender: nil)
    }
}

extension AlbumsViewController: UISearchBarDelegate {
    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        viewModel?.search(with: term)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

private extension AlbumsViewController {
    // MARK: UITableViewDiffableDataSource
    func makeDataSource() -> UITableViewDiffableDataSource<Int, AlbumViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, album in
                guard let cell: AlbumTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: AlbumTableViewCell.cellIdentifier,
                    for: indexPath
                ) as? AlbumTableViewCell else { preconditionFailure("Could not load AlbumTableViewCell")}
                
                cell.configure(albumTitle: album.trackName, artistName: album.artistName, iconURL: album.iconURL)
                
                return cell
            }
        )
    }
}
