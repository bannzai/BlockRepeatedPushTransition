//
//  ViewController.swift
//  BlockRepeatedPushTransition
//
//  Created by Yudai.Hirose on 2019/02/14.
//  Copyright © 2019 asobica. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    var isTransitioning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if isTransitioning {
            return
        }
        super.pushViewController(viewController, animated: true)
    }
}
extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        isTransitioning = true
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isTransitioning = false
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let button = UIButton(type: .custom)
        button.setTitle("Pressed", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ]
        )
    }

    @objc func buttonPressed(button: UIButton)  {
        for i in (0...3)  {
            let time = TimeInterval(i) / 10
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.push()
            }
        }
    }
    
    func push() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

class NextViewController: UIViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .orange
    }
}
