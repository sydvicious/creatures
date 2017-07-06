//
//  VerticallyCenteredTextView.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//  Copyright (c) 2017 Bone Jarring Software and Games, LLC. All rights reserved.
//

import UIKit

class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
}

