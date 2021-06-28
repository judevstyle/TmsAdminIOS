//
//  ImageChoose1x1ButtonView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/18/21.
//

import UIKit

protocol ImageChoose1x1ButtonDelegate {
    func didSelectImage(base64: String)
}

class ImageChoose1x1ButtonView: UIView {
    
    let nibName = "ImageChoose1x1ButtonView"
    var contentView:UIView?
    
    @IBOutlet weak var bgImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonImage: UIButton!
    
    public var delegate: ImageChoose1x1ButtonDelegate?
    
    var imagePicker: ImagePicker!
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupUI()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupUI() {
        bgImageView.setRounded(rounded: 5)
        imageView.setRounded(rounded: 5)
        
        buttonImage.contentVerticalAlignment = .fill
        buttonImage.contentHorizontalAlignment = .fill
        buttonImage.imageView?.contentMode = .scaleAspectFit
        buttonImage.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func setupImagePicker(vc: UIViewController, delegate: ImageChoose1x1ButtonDelegate) {
        self.delegate = delegate
        self.imagePicker = ImagePicker(presentationController: vc, sourceType: [.camera, .photoLibrary], delegate: self)
    }
    
    @IBAction func handlePickerImage(_ sender: Any) {
        self.imagePicker.present(from: self)
    }
}

extension ImageChoose1x1ButtonView: ImagePickerDelegate {
    func didSelectImage(image: UIImage?, imagePicker: ImagePicker, base64: String) {
        self.imageView.image = image
        self.buttonImage.imageView?.tintColor = .clear
        self.delegate?.didSelectImage(base64: "data:image/png;base64," + base64)
    }
}
