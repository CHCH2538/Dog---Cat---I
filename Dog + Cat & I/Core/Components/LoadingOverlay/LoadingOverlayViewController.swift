//
//  LoadingOverlayViewController.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

final class LoadingOverlayViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Properties
    private var message: String = "Loading..."
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
    // MARK: Configuration
    func configure(with message: String) {
        self.message = message
        messageLabel?.text = message
    }
    
    // MARK: Private Methods
    private func setupUI() {
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        activityIndicator.color = .white
        activityIndicator.style = .large
    }
    
}

final class LoadingOverlayManager {
    
    // MARK: Properties
    static let shared = LoadingOverlayManager()
    
    private init() {}
    
    // MARK: Public Methods
    func showModalLoading(
        from parentViewController: UIViewController,
        message: String = "Loading..."
    ) -> LoadingOverlayViewController {
        let storyboard = UIStoryboard(name: "LoadingOverlayViewController", bundle: nil)
        let loadingVC = storyboard.instantiateViewController(withIdentifier: "LoadingOverlayViewController") as! LoadingOverlayViewController
        loadingVC.configure(with: message)
        
        loadingVC.modalPresentationStyle = .overFullScreen
        loadingVC.modalTransitionStyle = .crossDissolve
        
        parentViewController.present(loadingVC, animated: true)
        
        return loadingVC
    }
    
    func hideModalLoading(_ loadingViewController: LoadingOverlayViewController) {
        loadingViewController.dismiss(animated: true)
    }
    
}
