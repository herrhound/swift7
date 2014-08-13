//
//  NDApiResponse.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-08-12.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class NDApiResponse<G> {
    var ErrorStatus: String?
    var ErrorMessage: String?
    var Data: G!

    init(){
        ErrorStatus = nil
        ErrorMessage = nil
        Data = nil
    }
}