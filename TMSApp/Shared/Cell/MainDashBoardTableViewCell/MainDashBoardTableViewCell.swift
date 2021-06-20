//
//  MainDashBoardTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/5/21.
//

import UIKit

class MainDashBoardTableViewCell: UITableViewCell {
    
    static let identifier = "MainDashBoardTableViewCell"
    
    @IBOutlet var viewBox: [UIView]!
    @IBOutlet var iconBox: [UIImageView]!
    @IBOutlet var headLabel: [UILabel]!
    @IBOutlet var valueLabel: [UILabel]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupUI(){
        for (index, view) in viewBox.enumerated() {
            switch index {
            case 0:
                let gradientView = GradientView(frame: view.bounds, fColor: .systemPink, sColor: .systemPink.withAlphaComponent(0.8))
                view.insertSubview(gradientView, at: 0)
                break
            case 1:
                let gradientView = GradientView(frame: view.bounds, fColor: .systemBlue, sColor: .systemBlue.withAlphaComponent(0.8))
                view.insertSubview(gradientView, at: 0)
                break
            case 2:
                let gradientView = GradientView(frame: view.bounds, fColor: .systemGreen, sColor: .systemGreen.withAlphaComponent(0.8))
                view.insertSubview(gradientView, at: 0)
                break
            case 3:
                let gradientView = GradientView(frame: view.bounds, fColor: .systemGray, sColor: .systemGray.withAlphaComponent(0.8))
                view.insertSubview(gradientView, at: 0)
                break
            default:
                break
            }
            view.layer.cornerRadius = 8
        }
        
    }
}
    
    
    class GradientView: UIView {
        
        init(frame: CGRect, fColor: UIColor, sColor: UIColor) {
            super.init(frame: frame)
            setupView(fColor: fColor, sColor: sColor)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        private func setupView(fColor: UIColor, sColor: UIColor) {
            autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            guard let theLayer = self.layer as? CAGradientLayer else {
                return;
            }
            
            theLayer.colors = [fColor.cgColor, sColor.cgColor]
            theLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            theLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            theLayer.locations = [0.0, 1.0]
            theLayer.cornerRadius = 8
            theLayer.frame = self.bounds
        }
        
        override class var layerClass: AnyClass {
            return CAGradientLayer.self
        }
    }


