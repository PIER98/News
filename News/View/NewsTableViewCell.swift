//
//  NewsTableViewCell.swift
//  News
//
//  Created by Pierpaolo Mariani on 04/11/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
//    create cell objects
    
    @IBOutlet weak var layerSubView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layerSubView.layer.cornerRadius = 10 
        newsImage.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
