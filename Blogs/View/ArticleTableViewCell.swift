//
//  ArticleTableViewCell.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleUrlLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!

    var articleViewModel: ArticleViewModel! {
        didSet {
            self.nameLabel.text = articleViewModel.name
            self.designationLabel.text = articleViewModel.designation
            self.timeLabel.text = Date.timeAgoDisplay(dateStr: articleViewModel.time)
            self.articleDescriptionLabel.text = articleViewModel.articleDescription
            self.articleTitleLabel.text = articleViewModel.articleTitle
            self.articleUrlLabel.text = articleViewModel.articleUrl
            self.likesCountLabel.text = String(describing: articleViewModel.likesCount)
            self.commentsCountLabel.text = String(describing: articleViewModel.commentsCount)
            if let url = URL(string: articleViewModel.avatarImage) {
                UIImage.loadFrom(url: url) { image in
                    self.avatarImageView.image = image
                }
            }else{
                self.avatarImageView.image = UIImage(named: "avatar")
            }
            if let url = URL(string: articleViewModel.articleImage) {
                UIImage.loadFrom(url: url) { image in
                    self.articleImageView.image = image
                }
            }else{
                self.articleImageView.image = nil
            }
        }
    }
}
