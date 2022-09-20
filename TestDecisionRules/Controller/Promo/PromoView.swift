//
//  PromoView.swift
//  TestDecisionRules
//
//  Created by efloresco on 09/09/22.
//

import UIKit

class PromoView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.textColor = .white
            lblTitle.textAlignment = .center
        }
    }
    @IBOutlet weak var lblSubtitle: UILabel! {
        didSet {
            lblSubtitle.textColor = .white
            lblSubtitle.textAlignment = .center
        }
    }
    @IBOutlet weak var imgStep: ImageLoader!
    

}
