//
//  BasePresenter.swift
//  Kasumi
//
//  Created by docotel on 22/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation

protocol PresenterCommonDelegate {}
    
class BasePresenter<T>: PresenterCommonDelegate {
    var view: T!
    init (view: T!) {
        self.view = view!
    }
}
