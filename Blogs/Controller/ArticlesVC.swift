//
//  ArticlesVC.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ArticlesVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var articlesTableView: UITableView!

    //MARK: - Properties
    var articlesViewModel = [ArticleViewModel]()
    let cellId = "CellID"
    var pageNumber = 1


    //MARK: - View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }

    //MARK: - Custom Methods
    fileprivate func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        articlesTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        articlesTableView.estimatedRowHeight = 460.0
        articlesTableView.rowHeight = UITableView.automaticDimension
        articlesTableView.tableFooterView = UIView()
    }

    fileprivate func fetchData() {
        if Reachability.sharedInstance.isConnectedToNetwork() {
            Service.shared.fetchArticles(pageNumKey: pageNumber) { (articles, err) in
                if let err = err {
                    print("Failed to fetching articles:", err)
                    return
                }
                if articles?.count ?? 0 > 0 {
                    let articlesVM:[ArticleViewModel] = articles?.map({return ArticleViewModel(article: $0)}) ?? []
                    self.articlesViewModel = self.articlesViewModel + articlesVM

                    let jsonData = try! articles.data()
                    OfflineManager.sharedInstance.saveArticles(data: jsonData)

                    self.articlesTableView.reloadData()
                }else{
                    //print("no more data - end of pagination")
                }
            }
        }else{
            self.articlesViewModel = OfflineManager.sharedInstance.fetchArticles() ?? []
        }
    }
}

//MARK: - Tableview Methods
extension ArticlesVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleTableViewCell
        let articleViewModel = articlesViewModel[indexPath.row]
        cell.articleViewModel = articleViewModel

        // Refresh the cells once image is downloaded from URL
        cell.refreshCell = {
            if Reachability.sharedInstance.isConnectedToNetwork(){
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articlesViewModel.count - 1 {
            pageNumber += 1
            if Reachability.sharedInstance.isConnectedToNetwork(){
                fetchData()
            }
        }
    }
}
