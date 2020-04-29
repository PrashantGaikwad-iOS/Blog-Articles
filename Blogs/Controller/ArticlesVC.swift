//
//  ArticlesVC.swift
//  Blogs
//
//  Created by Prashant Gaikwad on 29/04/20.
//  Copyright © 2020 Prashant Gaikwad. All rights reserved.
//

import UIKit

class ArticlesVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var articlesTableView: UITableView!

    //MARK:- Properties
    var articlesViewModel = [ArticleViewModel]()
    let cellId = "CellID"
    var pageNumber = 1


    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }

    //MARK:- Custom Methods
    fileprivate func setupView() {
        articlesTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        articlesTableView.estimatedRowHeight = 460.0
        articlesTableView.rowHeight = UITableView.automaticDimension
        articlesTableView.tableFooterView = UIView()
    }

    fileprivate func fetchData() {
        Service.shared.fetchArticles(pageNumKey: pageNumber) { (articles, err) in
            if let err = err {
                print("Failed to fetching articles:", err)
                return
            }
            if articles?.count ?? 0 > 0 {
                let articles:[ArticleViewModel] = articles?.map({return ArticleViewModel(article: $0)}) ?? []
                self.articlesViewModel = self.articlesViewModel + articles
                self.articlesTableView.reloadData()
            }else{
                print("no more data")
            }
        }
    }

}

//MARK:- Tableview Methods
extension ArticlesVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleTableViewCell
        let articleViewModel = articlesViewModel[indexPath.row]
        cell.articleViewModel = articleViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articlesViewModel.count - 1 {
            print("You are at last cell - \(pageNumber)")
            pageNumber += 1
            fetchData()
        }
    }
}
