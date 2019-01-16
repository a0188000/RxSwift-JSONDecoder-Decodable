//
//  GroupCollectionViewCell.swift
//  RxSwift-JSONDecoder&Decodable
//
//  Created by EVERTRUST on 2019/1/16.
//  Copyright © 2019 EVERTRUST. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(withViewModel viewModel: GroupViewPresentable) {
        self.lbl.text = viewModel.title
        self.backgroundColor = viewModel.backgroundColor
        self.layer.cornerRadius = 10.0
    }

}
