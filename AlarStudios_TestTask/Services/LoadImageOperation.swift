//
//  LoadOperation.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 10.10.2020.
//

import UIKit

public final class LoadImageOperation: Operation {

    // MARK: Public properties

    var url: URL?
    var imageView: CustomImageView?

    // MARK: Lifecycle

    public override func main() {
        guard let url = url else { return }
        imageView?.loadImage(from: url)
    }
}
