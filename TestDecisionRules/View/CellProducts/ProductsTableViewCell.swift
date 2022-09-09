//  ProductsTableViewCell.swift
//  TestDecisionRules
//  Created by Moisés Abraham Vázquez Pérez on 09/09/22.

import UIKit

class ProductsTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var vwContainer: UIView!{
        didSet{
            self.vwContainer.layer.cornerRadius = 10
        }
    }
    
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
