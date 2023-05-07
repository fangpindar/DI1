//
//  SelectionViewCell.swift
//  DI Part 1
//
//  Created by 方品中 on 2023/5/7.
//

import UIKit

class SelectionViewCell: UIView {
    @IBOutlet var colorButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
