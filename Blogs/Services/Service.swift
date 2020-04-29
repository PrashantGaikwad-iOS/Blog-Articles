//
//  Service.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation

// Service to fetch Server data
class Service: NSObject {
    static let shared = Service()

    //https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10

    func fetchArticles(pageNumKey:String,completion: @escaping ([Article]?, Error?) -> ()) {
        let urlString = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pageNumKey)&limit=10"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch result:", err)
                return
            }

            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([Article].self, from: data)
                DispatchQueue.main.async {
                    completion(result, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
