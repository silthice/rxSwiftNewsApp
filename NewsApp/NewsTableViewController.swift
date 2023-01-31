//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Giap on 31/01/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    private func populateNews() {
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8df1353389ed43a6b6ba142136c17d22")!
//
//        let resource = Resource<ArticleList>(url: url)
//
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
}

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("giap check", self.articles.count)
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not exist")
        }
        
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descLabel.text = self.articles[indexPath.row].description
        
        return cell
    }
}
