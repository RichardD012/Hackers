//
//  PostCell.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit

protocol PostCellDelegate {
    func didTapComment(_ sender: Any)
}

class PostCell : UITableViewCell {
    var delegate: PostCellDelegate?
    
    @IBOutlet weak var postTitleView: PostTitleView!
    @IBOutlet weak var postCommentsCount: UILabel!
    @IBOutlet weak var postCommentsImage: UIImageView!
    @IBOutlet weak var commentView: UIView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCommentGesture()
    }
    
    private func setupCommentGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapComment(_:)))
        commentView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? setSelectedBackground() : setUnselectedBackground()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlighted ? setSelectedBackground() : setUnselectedBackground()
    }
    
    func setSelectedBackground() {
        backgroundColor = Theme.selectedCellBackgroundColor
    }
    
    func setUnselectedBackground() {
        backgroundColor = Theme.unselectedCellBackgroundColor
    }
        
    @objc func didTapComment(_ sender: Any) {
        delegate?.didTapComment(sender)
        
    }
    
}
