//
//  ViewController.swift
//  appNoticias
//
//  Created by Igor Santana on 14/09/22.
//

import UIKit

class MainTableViewController:UITableViewController{

    
    var newsData = [NewsData]()
    var activityView: UIActivityIndicatorView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       showsActivityIndicator
        
        // Do any additional setup after loading the view.
//        loadNews()
        
        NetworkManager.shared.getNews { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let response):
                for item in response{
                    if let imageURL = item.media.first?.mediaMetadata.last?.url{
                        let data = NewsData(title: item.title, byline: item.byline, image: imageURL, url: item.url)
                        self.newsData.append(data)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideActivityIndicator()
                }
                
            case.failure(let error):
                print("error: \(error)")
                self.hideActivityIndicator()
            }
        }
    }
    
//    func loadNews(){
//        let fileUrl=Bundle.main.url(forResource: "file", withExtension: "json")!
//        let jsonData = try! Data(contentsOf: fileUrl)
//
//        do{
//            let data = try JSONDecoder().decode(NewYorkNews.self, from: jsonData)
//
//            news = data.results
//        }catch{
//            print(error.localizedDescription)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsData.count
        print("count =>\(newsData.count)")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewYorkTableViewCell
     
        let data = newsData[indexPath.row]
        cell.prepare(with: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: newsData[indexPath.row].url){
            UIApplication.shared.open(url)
            
        }
    }
    
    
    func activityIndicator(){
        activityView = UIActivityIndicatorView(style: .large)
        guard let activityView = activityView else {
            return
        }
        self.view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityView.widthAnchor.constraint(equalToConstant: 70),
            activityView.heightAnchor.constraint(equalToConstant: 70),
            activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        activityView.startAnimating()
    }
    
    
    func hideActivityIndicator(){
     
        guard let activityView = activityView else {
            return
        }
        activityView.stopAnimating()
        
    }

    
    
}

