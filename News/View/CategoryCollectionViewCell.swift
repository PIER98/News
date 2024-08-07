//
//  CategoryCollectionViewCell.swift
//  News
//
//  Created by Pierpaolo Mariani on 05/11/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var categoryImageView: UIImageView!
    
    override func layoutSubviews() {
       setupViewLayer()
       setupLabel()
    }
    
    private func setupViewLayer() {
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 20
        categoryLabel.layer.masksToBounds = true
    }
    
    private func setupLabel() {
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.backgroundColor =  #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
    func setupImage() {
       
    }
}

