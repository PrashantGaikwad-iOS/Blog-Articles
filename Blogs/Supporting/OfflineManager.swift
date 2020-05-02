//
//  OfflineManager.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 01/05/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import Foundation

class OfflineManager {
    // Singleton Pattern
    static let sharedInstance = OfflineManager()
    private init() {}

    func readmyJson(fileName: String) -> String?  {

        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        let dataURL = documentsDirectoryPath.appendingPathComponent("OfflineManagerFile")
        let jsonFilePath = dataURL?.appendingPathComponent(fileName + ".json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let finalDataDict = NSKeyedUnarchiver.unarchiveObject(withFile: (jsonFilePath?.absoluteString)!) as! String
            return finalDataDict
        }
        else{
            print("File does not exists")
            return nil
        }
    }


    func writeToFile(fileName: String, finalDataDict:String)  {

        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        let dataURL = documentsDirectoryPath.appendingPathComponent("OfflineManagerFile")
        do {
            try FileManager.default.createDirectory(atPath: (dataURL?.absoluteString)!, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        let jsonFilePath = dataURL?.appendingPathComponent(fileName + ".json")
        NSKeyedArchiver.archiveRootObject(finalDataDict, toFile:(jsonFilePath?.absoluteString)!)

    }

}


//MARK: - Offline Mode
extension OfflineManager {
    // Only saving the latest page data to avoid the increase in app size
    func saveArticles(data:Data) {
        let stringData = String(data: data, encoding: .utf8)!
        OfflineManager.sharedInstance.writeToFile(fileName:"ArticlesData",finalDataDict:stringData)
    }
    // fetching the data for offline mode
    func fetchArticles() -> [ArticleViewModel]? {
        let jsonStr = OfflineManager.sharedInstance.readmyJson(fileName: "ArticlesData")
        let data = jsonStr!.data(using: String.Encoding.utf8)
        do {
            let result = try JSONDecoder().decode([ArticleModel].self, from: data!)
            let articles:[ArticleViewModel] = result.map({return ArticleViewModel(article: $0)})
            return articles
        } catch let jsonErr {
            print("Failed to decode:", jsonErr)
        }
        return nil
    }
}
