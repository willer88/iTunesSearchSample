//
//  AlbumTableViewCell.swift
//  ItunesSampleProject
//
//  Created by Wilmar on 27/06/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    
    // MARK: Properties
    static let cellIdentifier = "AlbumTableViewCellIdentifier"
    
    // MARK: Configuration
    func configure(albumTitle: String?, artistName: String?, iconURL: String?) {
        albumTitleLabel.text = albumTitle
        artistNameLabel.text = artistName
        
        guard let imageURL = iconURL else { return }
        icon.kf.setImage(with: URL(string: imageURL))
    }
}
