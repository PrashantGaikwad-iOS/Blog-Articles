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
    var trackViewModels = [ArticleModel]()
    let cellId = "CellID"

    //MARK:- IBActions

    //MARK:- Custom Methods

    //MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        articlesTableView.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        articlesTableView.estimatedRowHeight = 460.0
        articlesTableView.rowHeight = UITableView.automaticDimension


    }

}

//MARK:- Tableview Methods
extension ArticlesVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleTableViewCell
        if indexPath.row % 2 ==  0 {
            UIImage.loadFrom(url: URL(string: "https://s3.amazonaws.com/uifaces/faces/twitter/erwanhesry/128.jpg")!) { image in
                cell.articleImageView.image = image
            }
        }else{
            cell.articleImageView.image = nil
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
