//
//  PKImageUtil.swift
//  PKImageMatrixCropper
//
//  Created by Pavan Kataria on 10/01/2016.
//  Copyright © 2016 Pavan Kataria. All rights reserved.
//
/*
The MIT License (MIT)

Copyright (c) [2016] [Pavan Kataria]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation
import UIKit

protocol PKImageMatrixCropperProtocol {
    func cropToSquare() -> UIImage
    func cropToMatrix(matrix: (rowNum: Int, colNum: Int)) -> [UIImage]
}
extension UIImage: PKImageMatrixCropperProtocol {
    func cropToSquare() -> UIImage
    {
        return PKImageMatrixCropper.cropToSquare(image: self)
    }
    
    func cropToMatrix(matrix: (rowNum: Int, colNum: Int)) -> [UIImage]
    {
        return PKImageMatrixCropper.cropImage(image: self, toMatrix: (matrix.rowNum, matrix.colNum))
    }
    
    // Example
    func cropToFourQuadrantsWithResize() -> [UIImage] {
        return self
            .cropToSquare()
            .cropToMatrix((2,2))
    }
}

class PKImageMatrixCropper: NSObject {
    
    // Crops to square based on the shortest length
    static func cropToSquare(image originalImage: UIImage) -> UIImage {
        let imageSize: CGSize = originalImage.size
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if imageSize.width > imageSize.height {
            posX = ((imageSize.width - imageSize.height) / 2)
            posY = 0
            width = imageSize.height
            height = imageSize.height
        } else {
            posX = 0
            posY = ((imageSize.height - imageSize.width) / 2)
            width = imageSize.width
            height = imageSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        return self.crop(image: originalImage, cropRect: rect)
    }
    
    // A matrix cropper
    static func cropImage(image originalImage: UIImage, toMatrix matrix: (rows: Int, cols: Int)) -> [UIImage]{
        //TODO:
        /*        guard originalSquareImage.size.width % matrix.rows == 0 &&
        originalSquareImage.size.height % matrix.cols == 0 else {
        assertionFailure("For now, the square image needs to divide exactly by the matrix provided, at least until this package is further developed to handle odd image sized edge cases.")
        }
        */
        var images = [UIImage]()
        let quadrantSize: CGSize = CGSize(width: CGFloat(Int(originalImage.size.width) / matrix.rows), height: CGFloat(Int(originalImage.size.height) / matrix.cols))
        
        for rowPosition in 0 ..< matrix.rows {
            for colPosition in 0 ..< matrix.cols {
                let x: CGFloat = CGFloat(rowPosition * Int(quadrantSize.width))
                let y: CGFloat = CGFloat(colPosition * Int(quadrantSize.height))
                let rect = CGRect(x: x, y: y, width: quadrantSize.width, height: quadrantSize.height)
                images.append(self.crop(image: originalImage, cropRect: rect))
            }
        }
        return images
    }
    
    // Crops image to specified rect
    static func crop(image originalImage: UIImage, cropRect originalCropRect: CGRect) -> UIImage{
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, originalCropRect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        return image
    }
}
