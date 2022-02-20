//
//  UIImageExtension.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit

extension UIImage {
    func resize(size _size: CGSize) -> UIImage? {
            let widthRatio = _size.width / size.width
            let heightRatio = _size.height / size.height
            let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
            
            let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
            
            UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
            draw(in: CGRect(origin: .zero, size: resizedSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return resizedImage
        }
}
