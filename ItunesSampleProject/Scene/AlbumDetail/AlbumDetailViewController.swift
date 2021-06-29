//
//  AlbumDetailViewController.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 28/06/21.
//

import UIKit
import Kingfisher

class AlbumDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var artisNameLabel: UILabel!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var trackCountLabel: UILabel!
    
    // MARK: Properties
    var viewModel: AlbumViewModel?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    // MARK: Configuration
    private func configure() {
        guard let urlImage = viewModel?.iconURL else { return }
        imageView.kf.setImage(with: URL(string: urlImage))
        artisNameLabel.text = viewModel?.artistName
        albumNameLabel.text = viewModel?.albumName
        trackCountLabel.text = viewModel?.trackCount
    }
    
    // MARK: Events
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
