//
//  Extensions.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

//MARK: -  Image extension to load image from Url
extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    imageCache.setObject(UIImage(data: data)!, forKey: url as AnyObject)
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

//MARK: -  Date extension to show times ago
extension Date {
    public static func timeAgoDisplay(dateStr: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        let dateToCheck = dateFormatter.date(from: dateStr)

        let secondsAgo = Int(Date().timeIntervalSince(dateToCheck ?? Date()))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let year = 12 * month

        if secondsAgo < minute {
            return "\(secondsAgo) sec"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hr"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) day"
        } else if secondsAgo < month {
            return "\(secondsAgo / week) week"
        } else if secondsAgo < year {
            return "\(secondsAgo / month) month"
        }

        return "\(secondsAgo / year) year"
    }
}

//MARK: - Encode
extension Encodable {
    func data(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
