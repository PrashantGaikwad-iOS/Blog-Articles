//
//  ArticleTableViewCell.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

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

    //MARK: - Properties
    var refreshCell: (() -> Void)?

    var articleViewModel: ArticleViewModel! {
        didSet {
            self.nameLabel.text = articleViewModel.name
            self.designationLabel.text = articleViewModel.designation
            self.timeLabel.text = Date.timeAgoDisplay(dateStr: articleViewModel.time)
            self.articleDescriptionLabel.text = articleViewModel.articleDescription
            self.articleTitleLabel.text = articleViewModel.articleTitle
            self.articleUrlLabel.text = articleViewModel.articleUrl
            self.likesCountLabel.text = String(describing: Utils.suffixNumber(number:articleViewModel?.likesCount as NSNumber? ?? 0)) + " Likes"
            self.commentsCountLabel.text = String(describing: Utils.suffixNumber(number:articleViewModel?.commentsCount as NSNumber? ?? 0)) + " Comments"

            if let url = URL(string: articleViewModel.avatarImage) {
                if let cachedImage = imageCache.object(forKey: url as AnyObject) {
                    self.avatarImageView.image = cachedImage as? UIImage
                }else{
                    UIImage.loadFrom(url: url) { image in
                        self.avatarImageView.image = image
                    }
                }
            }else{
                self.avatarImageView.image = UIImage(named: "avatar")
            }

            if let url = URL(string: articleViewModel.articleImage) {
                if let cachedImage = imageCache.object(forKey: url as AnyObject) {
                    self.articleImageView.image = cachedImage as? UIImage
                }else{
                    UIImage.loadFrom(url: url) { image in
                        self.articleImageView.image = image
                        self.refreshCell?()
                    }
                }
            }else{
                self.articleImageView.image = nil
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Circular avatar image
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.cornerRadius = (avatarImageView.frame.height)/2
        avatarImageView.layer.masksToBounds = false
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 0.5
        avatarImageView.contentMode = .scaleAspectFill
    }
}
