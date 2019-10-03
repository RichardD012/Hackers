//
//  PostCell.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit
import Kingfisher

protocol PostCellDelegate: class {
    func didTapThumbnail(_ sender: Any)
}

class PostCell: SwipeTableViewCell {
    public weak var postDelegate: PostCellDelegate?
    private var downloadTask: DownloadTask?

    @IBOutlet weak var cellStackView: UIStackView!
    @IBOutlet weak var postTitleView: PostTitleView!
    @IBOutlet weak var thumbnailImageView: ThumbnailImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentIconView: UIView!
    @IBOutlet weak var commentIconCount: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheming()
        setupThumbnailGesture()
    }

    private func setupThumbnailGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapThumbnail(_:)))
        thumbnailImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? setSelectedBackground() : setUnselectedBackground()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlighted ? setSelectedBackground() : setUnselectedBackground()
    }

    private func setSelectedBackground() {
        backgroundColor = AppThemeProvider.shared.currentTheme.cellHighlightColor
    }

    private func setUnselectedBackground() {
        backgroundColor = AppThemeProvider.shared.currentTheme.backgroundColor
    }

    @objc private func didTapThumbnail(_ sender: Any) {
        postDelegate?.didTapThumbnail(sender)
    }

    public func setImageWithPlaceholder(url: URL?) {
        downloadTask = thumbnailImageView.setImageWithPlaceholder(url: url)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
    }
}

extension PostCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.cellBackgroundColor
        thumbnailImageView?.isHidden = theme.iconHidden
        commentIconView?.isHidden = theme.alternatePostCellLayout == false
        if theme.iconHidden {
            separatorInset = .zero
        } else {
            separatorInset = UIEdgeInsets(top: 0,
                                                    left: 88, //TODO: const?
                                                    bottom: 0,
                                                    right: 0)
        }
        commentIconCount?.textColor = theme.appTintColor
        commentIcon?.tintColor = theme.largeCommentTintColor //TODO: Update this to be separate?
        separatorView?.backgroundColor = theme.separatorColor
        thumbnailImageView.backgroundColor = theme.groupedTableViewBackgroundColor
        cellStackView?.layoutIfNeeded()
    }
}
