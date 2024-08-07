//
//  ViewController.swift
//  News
//
//  Created by Pierpaolo Mariani on 24/10/22.
//

import UIKit
import SafariServices

class ArticlesListViewController: UIViewController {
    
    private var newsCategories = New
    
    //    API EndPoints
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=sport&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
    
    // MARK: View objects
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var news = [Article]()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupTableView()
        setupCollectionView()
        
        activityIndicator.startAnimating()
        getData(url: url!) { data in
            self.news = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupActivityIndicator(){
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    //    parse Json from web Api
    func getData(url : URL, completion: @escaping ([Article]) -> ()){
        //  let url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=sport&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
        
        //    create  dataTask
        let task = URLSession.shared.dataTask(with : url) { data , response , error in
            if error == nil {
                //    do try catch
                do {
                    //    Create decoder
                    let result   =  try JSONDecoder().decode(ArticleResponse.self, from: data!)
                    print("Data fetched successfully")
                    print(result.articles.count)
                    
                    completion(result.articles)
                    
                } catch {
                    print("error \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
    
extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlString  = news[indexPath.row].url
        guard let url = URL(string: urlString!) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    private func shareFunction(rowIndexPathAt indexPath : IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Share") { _, _, _ in
            guard let text = self.news[indexPath.row].url else { return }
            let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            self.present(activityVC, animated: true)
        }
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = self.shareFunction(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [share])
        return swipe
    }
}

extension ArticlesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let  UrlString = "https://newsapi.org/v2/top-headlines?country=it&category=sport&apiKey=82b0ccb5faeb4edca6b7f543342fa32a"
        var Url = URL(string: UrlString)
        
        switch categories[indexPath.row] {
            
        case categories[0]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=business&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[1]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=entertainment&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[2]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=general&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[3]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=health&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[4]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=science&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[5]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=sports&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case categories[6]:
            Url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=technology&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
            getData(url: Url!) { data in
                self.news = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        default:
            print("Nothing")
        }
    }
}
















































