//
//  BillPaymentTableViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/3/21.
//

import UIKit

class BillPaymentTableViewCell: UITableViewCell {
    
    static let identifier = "BillPaymentTableViewCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var orderNo: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var productCount: UILabel!
    @IBOutlet var paymentPrice: UILabel!
    @IBOutlet var paymentOverduePrice: UILabel!
    
    @IBOutlet var statusHead: UILabel!
    
    var itemsBillNow: OrderItems? {
        didSet {
            setupBillNowValue()
        }
    }
    
    var itemsBillPayment: OrderItems? {
        didSet {
            setupBillPaymentValue()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        bgView.setRounded(rounded: 5)
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.Primary.cgColor

    }
    
    func setupBillNowStlye() {
        productCount.textColor = .darkGray
        paymentPrice.textColor = .darkGray
        paymentOverduePrice.textColor = .darkGray
        
        //shipping status
        statusHead.text = "สถานะ"
        paymentOverduePrice.text = "รอจัดส่ง"
    }
    
    
    func setupBillNowValue(){
        orderNo.text =  "Order No. \(itemsBillNow?.orderId ?? 0)"
        productCount.text = "\(itemsBillNow?.totalItem ?? 0)"
        paymentPrice.text = "\(itemsBillNow?.totalPrice ?? 0)"
    }
    
    func setupBillPaymentValue(){
        orderNo.text =  "Order No. \(itemsBillPayment?.orderId ?? 0)"
        productCount.text = "\(itemsBillPayment?.totalItem ?? 0)"
        paymentPrice.text = "\(itemsBillPayment?.totalPrice ?? 0)"
        paymentOverduePrice.text = "\(itemsBillPayment?.totalPrice ?? 0)"
    }
}
