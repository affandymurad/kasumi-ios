//
//  BaseDelegate.swift
//  Kasumi
//
//  Created by docotel on 22/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import UIKit

protocol BaseDelegate {
    func taskDidBegin()
    func taskDidFinish()
    func taskDidRelogin()
    func taskDidUpdate()
    func taskDidErrorServer()
    func taskDidError(message: String)
    func taskDidWrongError(message: String)
}

extension BaseDelegate {
    func taskDidBegin(){}
    func taskDidFinish(){}
    func taskDidRelogin(){}
    func taskDidUpdate(){}
    func taskDidErrorServer(){}
    func taskDidError(message: String){}
    func taskDidWrongError(message: String){}
}
