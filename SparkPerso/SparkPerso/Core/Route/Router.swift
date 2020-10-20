//
//  Router.swift
//  SparkPerso
//
//  Created by  on 09/10/2020.
//  Copyright © 2020 AlbanPerli. All rights reserved.
//

import Foundation

class Router {
    // CONSTANTS
    enum Activity {
        case DOG_ACTIVITY
        case CLUES_ACTIVITY
        case LABO_ACTIVITY
    }
    
    enum Action {
        case FORWARD
        case BACKWARD
        case RIGHT
        case LEFT
        case STOP
        case STANDUP
        case SEARCH
        case GOBACK
        case SITDOWN
        case COLLECT
        case START
    }

    enum Device {
        case DRONE
        case SPHERO1
        case SPHERO2
    }
    
    private var _routes: [Route] = []
    
    static let shared = Router()
    
    /**
     Handle route mapping between data received and activity action
     */
    public func dispatch(data: CommunicationData) -> Void {
        for route in self._routes {
            if self._isRouteMatch(data: data, route: route) {
                let device = self._getDeviceFromString(device: data.device)!
                route.executedCallback(device)
            }
        }
    }
    
    /**
     Register a new route
     */
    public func on(activity: Activity, action: Action, executedCallback: @escaping (Router.Device) -> ()) -> Router {
        let route = Route(activity: activity, action: action, executedCallback: executedCallback)
        self._routes.append(route)
        
        return self
    }
    
    /**
     Convert string activity into enum activity
     */
    private func _getActivityFromString(activity: String) -> Activity? {
        var returnedActivity: Activity? = nil
        
        switch activity {
        case "DOG_ACTIVITY":
            returnedActivity = Activity.DOG_ACTIVITY
        case "CLUE_ACTIVITY":
            returnedActivity = Activity.CLUES_ACTIVITY
        case "LABO_ACTIVITY":
            returnedActivity = Activity.LABO_ACTIVITY
        default:
            returnedActivity = nil
        }
        
        return returnedActivity
    }
    
    /**
     Convert string action into enum action
     */
    private func _getActionFromString(action: String) -> Action? {
        var returnedAction: Action? = nil
        
        switch action {
        case "FORWARD":
            returnedAction = Action.FORWARD
        case "BACKWARD":
            returnedAction = Action.BACKWARD
        case "RIGHT":
            returnedAction = Action.RIGHT
        case "LEFT":
            returnedAction = Action.LEFT
        case "STOP":
            returnedAction = Action.STOP
        case "STANDUP":
            returnedAction = Action.STANDUP
        case "SEARCH":
            returnedAction = Action.SEARCH
        case "GOBACK":
            returnedAction = Action.GOBACK
        case "SITDOWN":
            returnedAction = Action.SITDOWN
        case "COLLECT":
            returnedAction = Action.COLLECT
        case"START":
            returnedAction = Action.START
        default:
            returnedAction = nil
        }
        
        return returnedAction
    }
    
    /**
     Convert string device into enum device
     */
    private func _getDeviceFromString(device: String) -> Device? {
        var returnedDevice: Device? = nil
        
        switch device {
        case "DRONE":
            returnedDevice = Device.DRONE
        case "SPHERO1":
            returnedDevice = Device.SPHERO1
        case "SPHERO2":
            returnedDevice = Device.SPHERO2
        default:
            returnedDevice = nil
        }
        
        return returnedDevice
    }
    
    /**
     Check if data sent from NodeJS server match with one of the route registered
     */
    private func _isRouteMatch(data: CommunicationData, route: Route) -> Bool {
        var response = false
        
        let activity = self._getActivityFromString(activity: data.activity)
        let action = self._getActionFromString(action: data.action)
        
        if route.activity == activity && route.action == action {
            response = true
        }
        
        return response
    }
    
    /**
     Clear all routes registered
     */
    private func _clearRoutes() -> Void {
        self._routes = []
    }
    
}

struct Route {
    var activity: Router.Activity
    var action: Router.Action
    var executedCallback: (Router.Device) -> ()
}
