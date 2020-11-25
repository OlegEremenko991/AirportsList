//
//  CustomImageView.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class CustomImageView: UIImageView {

    // MARK: Private properties

    private var task: URLSessionDataTask!
    private let spinner = UIActivityIndicatorView()
    private let imageCache = NSCache<AnyObject, AnyObject>()

    // MARK: Private methods

    private func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.startAnimating()
    }

    private func removeSpinner() {
        spinner.removeFromSuperview()
    }

    // MARK: Public methods

    func loadImage(from url: URL) {
        DispatchQueue.main.async {
            self.image = nil
            self.addSpinner()
        }        

        if let task = task { task.cancel() }

        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = imageFromCache
                self.removeSpinner()
                return
            }
        }

        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Could not load image from url: \(url)")
                return
            }

            // Store image in cache
            self.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)

            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
    }

}
