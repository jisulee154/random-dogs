//
//  CustomCollectionViewCell.swift
//  random-dogs
//
//  Created by 이지수 on 2023/06/29.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func prepareForReuse() {
        cellImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
