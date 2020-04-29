//
//  ArticleViewModel.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

struct ArticleViewModel {

    let name: String
    let designation: String
    let avatarImage: String
    let time: String
    let articleImage: String
    let articleDescription: String
    let articleTitle: String
    let articleUrl: String
    let likesCount: Int
    let commentsCount: Int

    // Dependency Injection (DI)
    init(article: ArticleModel) {
        self.name = article.user?[0].name ?? ""
        self.designation = article.user?[0].designation ?? ""
        self.avatarImage = article.user?[0].avatar ?? ""
        self.time = article.createdAt ?? ""
        self.articleDescription = article.content ?? ""
        self.likesCount = article.likes ?? 0
        self.commentsCount = article.comments ?? 0

        if ((article.media?.count ?? 0) > 0) {
            if let str = article.media?[0].image {
                self.articleImage = str
            }else{
                self.articleImage = ""
            }
            if let str = article.media?[0].title {
                self.articleTitle = str
            }else{
                self.articleTitle = ""
            }
            if let str = article.media?[0].url {
                self.articleUrl = str
            }else{
                self.articleUrl = ""
            }
        }else{
            self.articleImage = ""
            self.articleTitle = ""
            self.articleUrl = ""
        }
    }
}
