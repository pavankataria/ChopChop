//
//  ImageCollectionViewCell.swift
//  PKImageMatrixCropper
//
//  Created by Pavan Kataria on 10/01/2016.
//  Copyright © 2016 Pavan Kataria. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var croppedImageView: UIImageView!
    func setImage(image: UIImage){
        croppedImageView.image = image
    }
}
