//
//  ViewController.swift
//  News
//
//  Created by Pierpaolo Mariani on 24/10/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
  
//    categories of the news
    var categories = ["Business💰" , "Entertainment🎬" , "General🌏" , "Health🏥" , "Science🔬" , "Sports⚽️" , "Technology💻"]

//    API EndPoints
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=it&category=sport&apiKey=82b0ccb5faeb4edca6b7f543342fa32a")
 
// create view objects
@IBOutlet private weak var tableView: UITableView!
@IBOutlet private weak var collectionView: UICollectionView!
    
//    reference for Model
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
    func getData(  url : URL , completion : @escaping ([Article]) -> ()){
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
//    edit tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = news[indexPath.row].title
        if news[indexPath.row].urlToImage != nil {
        let url = URL(string: self.news[indexPath.row].urlToImage!)
        cell.newsImage.downloaded(from: url!)  
        cell.newsImage.contentMode = .scaleAspectFill
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  display full News by opening Safari
        tableView.deselectRow(at: indexPath, animated: true)
        let urlString  = news[indexPath.row].url
        guard let url = URL(string: urlString!) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
   
    
  
    
    
    private func shareFunction(rowIndexPathAt indexPath : IndexPath) ->UIContextualAction {
         let action = UIContextualAction(style: .normal, title: "Share") { _, _, _ in
         let text = self.news[indexPath.row].url
         let activityVC = UIActivityViewController(activityItems: [text!], applicationActivities: nil)
             activityVC.popoverPresentationController?.sourceView = self.view
             self.present(activityVC, animated: true)
          
        }
        return action
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = self.shareFunction(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [share])
        return swipe
    }
    
   
   
    
    
//    edit collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryLabel.text = categories[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categories[indexPath.row])
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
//fetch image from the web
extension UIImageView {
        func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    
}




    

 
  
 
        
    
        
      

    
    
    
    
    
    
    
    

    





















