//
//  Router.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class Router {
    static let instance = Router()
    
    var totoCalback:((CommunicationData)->())? = nil
    
    
    func dispatch(data: CommunicationData) -> Void {
        // get la bonne classe
        switch "t" {
        case "t":
            if let c = totoCalback{
                c(data)
            }
        default:
            break
        }
    }
    
//    func toto(titi:Int,callBack:@escaping ()->()) {
//        self.totoCalback = callBack
//    }
    
    func toto(callBack:@escaping (CommunicationData)->()) {
        self.totoCalback = callBack
    }
}
