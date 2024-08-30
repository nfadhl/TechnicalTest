//
//  UIImageViewExtension.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIImage? = UIImage(systemName: "xmark")) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        ImageCache.shared.loadImage(with: url) { image in
            self.image = image ?? placeholder
        }
    }
}

