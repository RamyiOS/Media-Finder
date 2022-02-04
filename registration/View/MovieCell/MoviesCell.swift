//
//  MoviesCell.swift
//  registration
//
//  Created by Mac on 11/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMedia(media: Media) {
        self.movieImageView.sd_setImage(with: URL(string: media.poster), completed: nil)
    }
    
    func setupCellData(type: MediaType, media: Media) {
        switch type {
        case .movie:
            titleLabel.text = media.trackName
            detailsLabel.text = media.longDescription
        case .tvShow:
            titleLabel.text = media.artistName
            detailsLabel.text = media.longDescription
        case .music:
            titleLabel.text = media.trackName
            detailsLabel.text = media.artistName
        case .all:
            if media.longDescription == nil {
                titleLabel.text = media.trackName
                detailsLabel.text = media.artistName
            }
            else {
                titleLabel.text = media.artistName
                detailsLabel.text = media.longDescription
            }
        }
        self.configureMedia(media: media)
    }
    @IBAction func mediaBtnTapped(_ sender: UIButton) {
        let imageFrameX = movieImageView.frame.origin.x
        self.movieImageView.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.movieImageView.frame.origin.x -= 8
            self.movieImageView.frame.origin.x = imageFrameX
        }, completion: nil)
    }
}
