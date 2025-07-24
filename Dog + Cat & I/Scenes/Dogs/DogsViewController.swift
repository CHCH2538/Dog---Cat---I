//
//  DogsViewController.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

protocol DogsDisplayLogic: AnyObject {
    func displayDogImages(viewModel: Dogs.LoadImages.ViewModel)
    func displayConcurrentReload(viewModel: Dogs.ReloadConcurrent.ViewModel)
    func displaySequentialReload(viewModel: Dogs.ReloadSequential.ViewModel)
}

final class DogsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var concurrentButton: UIButton!
    @IBOutlet weak var sequentialButton: UIButton!
    
    // MARK: IBAction
    @IBAction func concurrentButtonTapped(_ sender: UIButton) {
        showLoading()
        let request = Dogs.ReloadConcurrent.Request(count: defaultDogCount)
        interactor?.reloadConcurrent(request: request)
    }
    
    @IBAction func sequentialButtonTapped(_ sender: UIButton) {
        showLoading()
        let request = Dogs.ReloadSequential.Request(count: defaultDogCount)
        interactor?.reloadSequential(request: request)
    }
    
    // MARK: Properties
    var interactor: DogsBusinessLogic?
    var router: (NSObjectProtocol & DogsRoutingLogic & DogsDataPassing)?
    private var imageData: [DogImageDisplayData] = []
    private let defaultDogCount = 3
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = DogsInteractor()
        let presenter = DogsPresenter()
        let router = DogsRouter()
        let worker = DogsWorker()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupCollectionView() {
        DogImageCell.register(for: collectionView)
        collectionView.dataSource = self
    }
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Additional view lifecycle setup if needed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        loadDogImages()
    }
    
    // MARK: Request Methods
    private func loadDogImages() {
        showLoading()
        let request = Dogs.LoadImages.Request(count: defaultDogCount)
        interactor?.loadDogImages(request: request)
    }
    
    func loadDogImages(count: Int) {
        showLoading()
        let request = Dogs.LoadImages.Request(count: count)
        interactor?.loadDogImages(request: request)
    }
    
    func loadDogImagesConcurrently(count: Int) {
        showLoading()
        let request = Dogs.ReloadConcurrent.Request(count: count)
        interactor?.reloadConcurrent(request: request)
    }
    
    func loadDogImagesSequentially(count: Int) {
        showLoading()
        let request = Dogs.ReloadSequential.Request(count: count)
        interactor?.reloadSequential(request: request)
    }
    
    // MARK: Display Logic
    private func showLoading() {
        showModalLoading(message: "Loading dog images...")
    }
    
    private func hideLoading() {
        dismiss(animated: true)
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: Private Methods
    private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

// MARK: - Display Logic Extension
extension DogsViewController: DogsDisplayLogic {
    
    func displayDogImages(viewModel: Dogs.LoadImages.ViewModel) {
        imageData = viewModel.displayedImages
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            if let errorMessage = viewModel.errorMessage {
                self?.showError(message: errorMessage)
            } else {
                self?.updateCollectionView()
            }
        }
    }
    
    func displayConcurrentReload(viewModel: Dogs.ReloadConcurrent.ViewModel) {
        imageData = viewModel.displayedImages
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            if let errorMessage = viewModel.errorMessage {
                self?.showError(message: errorMessage)
            } else {
                self?.updateCollectionView()
            }
        }
    }
    
    func displaySequentialReload(viewModel: Dogs.ReloadSequential.ViewModel) {
        imageData = viewModel.displayedImages
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            if let errorMessage = viewModel.errorMessage {
                self?.showError(message: errorMessage)
            } else {
                self?.updateCollectionView()
            }
        }
    }
    
}

// MARK: - Collection View Data Source
extension DogsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogImageCell.identifier, for: indexPath) as? DogImageCell else {
            return UICollectionViewCell()
        }
        
        let imageData = imageData[indexPath.item]
        cell.configure(with: imageData)
        
        return cell
    }
    
}
