//
//  Session.swift
//  vKontakte
//
//  Created by Andrew on 15/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

class Sessions {
    private init() { }
    
    public static let shared = Sessions()
    
    var token = ""
    var userId = ""
}
