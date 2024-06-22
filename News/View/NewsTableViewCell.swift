//
//  NewsTableViewCell.swift
//  News
//
//  Created by Pierpaolo Mariani on 04/11/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
//    create cell objects
    
    @IBOutlet private weak var layerSubView: UIView!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerSubView.layer.cornerRadius = 10 
        newsImage.layer.cornerRadius = 10
    }
    
    private func setup(article: Article) {
        titleLabel.text = article.title
        newsImage.image = UIImage(named: article.url ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
