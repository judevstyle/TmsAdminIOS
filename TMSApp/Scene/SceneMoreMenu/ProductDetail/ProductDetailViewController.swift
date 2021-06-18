//
//  ProductDetailViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var btnChooseImage: UIButton!
    
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    @IBAction func handleChooseImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}


extension ProductDetailViewController {
    func setupUI() {
        self.imagePicker = ImagePicker(presentationController: self, sourceType: [.camera, .photoLibrary], delegate: self)
    }
}


extension ProductDetailViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?, imagePicker: ImagePicker) {
        self.imageThumbnail.image = image
    }
    
    
}
