//
//  BrownVC.swift
//  dormitoryFamiles
//
//  Created by leehwajin on 2024/01/31.
//

import UIKit

class SearchViewController: UIViewController {
    var articles: [Article] = []
    var path = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        //검색 화면에 들어올때 컬렉션뷰는 아예 안보여야함.
        collectionView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        self.collectionView.register(UINib(nibName: "BulluetinBoardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        network(url: Network.url + path)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeDormiotry), name: .changeDormiotry, object: nil)
        
        setSearchBar()
        
    }
    
    private func setSearchBar() {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "검색어를 입력해 주세요."
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func network(url: String) {
        Network.getMethod(url: url) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let response):
                self.articles = response.data.articles
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @objc private func changeDormiotry() {
        network(url: Network.url + path)
        self.collectionView.reloadData()
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BulluetinBoardCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 0.894, green: 0.898, blue: 0.906, alpha: 1).cgColor
        
        cell.layer.cornerRadius = 20
        
        
        let article = articles[indexPath.row]
        cell.title.text = article.title
        cell.nickName.text = article.nickName
        cell.viewCount.text = "조회" + String(article.viewCount)
        cell.commentCount.text = String(article.CommentCount)
        cell.wishCount.text = String(article.wishCount)
        cell.content.text = article.content
        cell.categoryTag.body2 = article.boardType
        cell.statusTag.body2 = article.status
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let articleElement = articles[indexPath.row]
        
        let id = articleElement.articleId
        
        let url = "http://43.202.254.127:8080/api/articles/{articleId}"
        let articleDetailViewController = BulletinBoardDetailViewViewController()
        
        self.navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 335, height: 167)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}