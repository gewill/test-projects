//
//  SmallPictureCell.swift
//  5News
//
//  Created by Will on 1/4/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

class SmallPictureCell: UITableViewCell {


    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var publishTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.selectionStyle = .None
        coverImage.contentMode = .ScaleAspectFill
        coverImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
