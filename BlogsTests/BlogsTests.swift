//
//  BlogsTests.swift
//  BlogsTests
//
//  Created by Prashant Gaikwad on 02/05/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import XCTest
@testable import Blogs

class BlogsTests: XCTestCase {
    var session: URLSession!

    override func setUp() { // create objects here
        super.setUp()
        session = URLSession(configuration: .default)
    }

    override func tearDown() { // release objects here
        session = nil
        super.tearDown()
    }

    // Test the View Model
    func testArticleViewModel() {
        //given
        let article = ArticleModel(id: "1", comments: 123, likes: 456, content: "Hi, I'm Prashant", createdAt: "2nd May 2020", media: nil, user: nil)
        //when
        let articleViewModel = ArticleViewModel(article: article)
        //then
        XCTAssertEqual(article.comments, articleViewModel.commentsCount)
        XCTAssertEqual(article.likes, articleViewModel.likesCount)
        XCTAssertEqual(article.content, articleViewModel.articleDescription)
    }

    func testTimeAgoLogic() {
        //given
        let currentDate = "2020-04-17T12:13:44.575Z"
        //when
        let result = Date.timeAgoDisplay(dateStr: currentDate)
        //then
        XCTAssertNotNil(result)
    }

    func testAPICallToArticles() {
        // given
        let url =
            URL(string: "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5) // fails if slow internet

        // then
        XCTAssertNil(responseError) // fail
        XCTAssertEqual(statusCode, 200) // pass
    }

}
