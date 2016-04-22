//
//  EditVideoCell.swift
//  xiaoxianhuo
//
//  Created by Will on 3/28/16.
//  Copyright © 2016 xiaoxianhuo. All rights reserved.
//

import UIKit

protocol EditVideoCellDelegate: NSObjectProtocol {
    func didClickDeleteButton(cell: EditVideoCell)
}

class EditVideoCell: UICollectionViewCell {
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var sequenceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!

    var delegate: EditVideoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func deleteButtonClick(sender: AnyObject) {
        self.delegate?.didClickDeleteButton(self)
    }
}
