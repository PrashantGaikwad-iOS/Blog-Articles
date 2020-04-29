//
//  Article.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation

struct ArticleModel: Decodable {
    let id: String?
    let comments: Int?
    let likes: Int?
    let content: String?
    let createdAt: String?
    let media: [MediaModel]?
    let user: [UserModel]?
}

struct MediaModel: Decodable {
    let image: String?
    let title: String?
    let url: String?
}

struct UserModel: Decodable {
    let name: String?
    let designation: String?
}
