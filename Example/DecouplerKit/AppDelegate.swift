//
//  AppDelegate.swift
//  ExerciseTracker
//
//  Created by Nazario Mariano on 06/06/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import Dip
import Dip_UI
import DecouplerKit

extension HomeTableViewController: StoryboardInstantiatable { }
extension ComposerContainerViewController: StoryboardInstantiatable { }
extension ExerciseComposerTableViewController: StoryboardInstantiatable { }

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let container = DependencyContainer { container in
        
        container.register(.singleton) { ResponderRegistry() as ResponderRegistry }
        
        container.register(storyboardType: HomeTableViewController.self, tag: "HomeTableViewController")
            .resolvingProperties { container, controller in
                controller.registry = try container.resolve() as ResponderRegistry
        }
        
        container.register(storyboardType: ComposerContainerViewController.self, tag: "ComposerContainerViewController")
            .resolvingProperties { container, controller in
                controller.registry = try container.resolve() as ResponderRegistry
        }
        
        container.register(storyboardType: ExerciseComposerTableViewController.self, tag: "ExerciseComposerTableViewController")
            .resolvingProperties { container, controller in
                controller.registry = try container.resolve() as ResponderRegistry
        }
        DependencyContainer.uiContainers = [container]
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let registry = try! container.resolve() as ResponderRegistry
        let formattter = DateFormatter()
            formattter.dateStyle = .medium
        let exerciseController = ExerciseController()
            exerciseController.dateFormatter = formattter
            exerciseController.dataStoreController = RealmPersistentStoreController()
        let formController = FormController()
        
        registry.register(inputHandler: exerciseController)
        registry.register(inputHandler: formController)
        
        return true
    }
}

