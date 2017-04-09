//
//  LocationButton.swift
//  Tipsy
//
//  Created by Christopher Martin on 6/24/16.
//  Copyright © 2016 Christopher Martin. All rights reserved.
//

import UIKit

open class LocationButton: RectTextTipButton {

    open override var buttonDescription: ButtonDescription{
        return .location
    }
}
