//
//  SwiftTalk1NetworkingViewController.swift
//  SwiftTalk
//
//  Created by Diego Cavalcante on 15/08/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class SwiftTalk1NetworkingViewController: UIViewController {
    @IBOutlet weak var label: UILabel?

    var artist : Artist?

    init(item : Any?) {
        if let artist = item as? Artist {
            self.artist = artist
        }else if let error = item as? Error {
            print(error)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label?.text = artist?.artists.first?.artistName
    }
}


final class LoadingViewController : UIViewController {
    
    let spinner : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    init<T>(service : NetworkingService<T>, build : @escaping (T?) -> UIViewController) {
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
        spinner.color   = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
        content.view.layoutIfNeeded()
        
        let views : [String : Any] = ["contentView" : content.view, "height" : content.view.frame.size.height]

        let vertical    = NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(height)]", options: [], metrics: views, views: views)
        let horizontal  = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: views, views: views)
        
        NSLayoutConstraint.activate(vertical + horizontal)
    }
}





