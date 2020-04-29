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

    //MARK:- IBActions

    //MARK:- Custom Methods

    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }

    fileprivate func setupView() {
        articlesTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        articlesTableView.estimatedRowHeight = 460.0
        articlesTableView.rowHeight = UITableView.automaticDimension
    }

    fileprivate func fetchData() {
        let pageNum = 1
        Service.shared.fetchArticles(pageNumKey: pageNum) { (articles, err) in
            if let err = err {
                print("Failed to fetching articles:", err)
                return
            }
            self.articlesViewModel = articles?.map({return ArticleViewModel(article: $0)}) ?? []
            self.articlesTableView.reloadData()
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
}
