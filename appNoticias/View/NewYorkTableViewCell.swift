//
//  NewYorkTableViewCell.swift
//  appNoticias
//
//  Created by Igor Santana on 21/02/23.
//

import UIKit

class NewYorkTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var by: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageNews.layer.cornerRadius = 10
        imageNews.layer.borderWidth = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
        
    }
    
//    Vamos linkar o que estamos recebendo da table view controller e linkar com os objetos acima que são: title, imageNews e BY
    func prepare(with news: NewsData){
        title.text = news.title
        by.text = news.byline
        
        
        guard let url = URL(string: news.image) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self.imageNews.image = UIImage(data: data)
            }
        }.resume()
        
        
//        imageNews.image = UIImage(named:"malcomX")
    }
}
