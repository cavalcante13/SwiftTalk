//
//  SwiftTalk1NetworkingViewController.swift
//  SwiftTalk
//
//  Created by Diego Cavalcante on 15/08/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class SwiftTalk1NetworkingViewController: UIViewController {

    

    init(artist : Artist) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


final class LoadingViewController : UIViewController {
    
    let spinner : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init<T>(service : Service<T>, build : @escaping (T?) -> UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        spinner.startAnimating()
        service.load { [weak self] result in
            self?.spinner.stopAnimating()
            
            let viewController = build(result)
            self?.add(content: viewController)
        }
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        
    }
    func add(content : UIViewController) {
        addChildViewController(content)
        view.addSubview(content.view)
        
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.didMove(toParentViewController: self)
        
        NSLayoutConstraint.activate([
            content.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    
    
    
}





