//
//  TeamTableViewCell.swift
//  RxSwift-JSONDecoder&Decodable
//
//  Created by EVERTRUST on 2019/1/16.
//  Copyright © 2019 EVERTRUST. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewFlag: UIImageView! {
        didSet {
            imageViewFlag.layer.cornerRadius = 30
            imageViewFlag.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lblTeamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withViewModel viewModel: TeamViewPresentable) {
        self.lblTeamName.text = viewModel.name
        self.imageViewFlag.image = UIImage(named: viewModel.flag)
    }
    
}
