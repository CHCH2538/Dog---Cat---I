//
//  CatsViewController.swift
//  Dog + Cat & I
//
//  Created by Pongpubate Charoensinputthakhun on 23/7/2568 BE.
//

import UIKit

// MARK: - Cats Display Logic Protocol

protocol CatsDisplayLogic: AnyObject {
    func displayCatBreeds(viewModel: Cats.LoadBreeds.ViewModel)
    func displayToggledBreed(viewModel: Cats.ToggleBreedExpansion.ViewModel)
}

// MARK: - Cats View Controller
final class CatsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var interactor: CatsBusinessLogic?
    var router: (NSObjectProtocol & CatsRoutingLogic & CatsDataPassing)?
    private var items: [CatsItem] = []
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CatsInteractor()
        let presenter = CatsPresenter()
        let router = CatsRouter()
        let worker = CatsWorker()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        CatBreedHeaderCell.register(for: tableView)
        CatBreedContentCell.register(for: tableView)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        loadCatBreeds()
    }
    
    // MARK: Request Methods
    private func loadCatBreeds() {
        showLoading()
        let request = Cats.LoadBreeds.Request()
        interactor?.loadCatBreeds(request: request)
    }
    
    // MARK: Display Logic
    private func showLoading() {
        showModalLoading(message: "Loading cat breeds...")
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
    private func calculateTableChanges(oldItems: [CatsItem], newItems: [CatsItem]) -> [TableChange] {
        var changes: [TableChange] = []
        
        var oldExpansionStates: [String: Bool] = [:]
        var newExpansionStates: [String: Bool] = [:]
        
        for item in oldItems {
            if case .header(let breed, let isExpanded) = item {
                oldExpansionStates[breed.id] = isExpanded
            }
        }
        
        for item in newItems {
            if case .header(let breed, let isExpanded) = item {
                newExpansionStates[breed.id] = isExpanded
            }
        }
        
        for (breedId, newExpanded) in newExpansionStates {
            if let oldExpanded = oldExpansionStates[breedId], oldExpanded != newExpanded {
                if let oldIndex = oldItems.firstIndex(where: { item in
                    if case .header(let breed, _) = item {
                        return breed.id == breedId
                    }
                    return false
                }) {
                    if newExpanded {
                        changes.append(.insert(IndexPath(row: oldIndex + 1, section: 0)))
                        changes.append(.reload(IndexPath(row: oldIndex, section: 0)))
                    } else {
                        changes.append(.delete(IndexPath(row: oldIndex + 1, section: 0)))
                        changes.append(.reload(IndexPath(row: oldIndex, section: 0)))
                    }
                }
            }
        }
        
        return changes
    }
    
}

// MARK: - Display Logic Extension
extension CatsViewController: CatsDisplayLogic {
    
    func displayCatBreeds(viewModel: Cats.LoadBreeds.ViewModel) {
        items = viewModel.items
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            if let errorMessage = viewModel.errorMessage {
                self?.showError(message: errorMessage)
            } else {
                self?.tableView.reloadData()
            }
        }
    }
    
    func displayToggledBreed(viewModel: Cats.ToggleBreedExpansion.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let oldItems = self.items
            self.items = viewModel.items
            
            let changes = self.calculateTableChanges(oldItems: oldItems, newItems: viewModel.items)
            
            if !changes.isEmpty {
                self.tableView.beginUpdates()
                
                let deletions = changes.filter { $0.isDeletion }.map { $0.indexPath }.sorted(by: >)
                for indexPath in deletions {
                    self.tableView.deleteRows(at: [indexPath], with: .top)
                }
                
                let insertions = changes.filter { $0.isInsertion }.map { $0.indexPath }.sorted()
                for indexPath in insertions {
                    self.tableView.insertRows(at: [indexPath], with: .top)
                }
                
                let reloads = changes.filter { $0.isReload }.map { $0.indexPath }
                for indexPath in reloads {
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
                
                self.tableView.endUpdates()
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - Table View Data Source
extension CatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        switch item {
        case .header(let breed, let isExpanded):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CatBreedHeaderCell.identifier, for: indexPath) as? CatBreedHeaderCell else {
                return UITableViewCell()
            }
            cell.configure(with: breed, isExpanded: isExpanded)
            return cell
            
        case .content(let breed):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CatBreedContentCell.identifier, for: indexPath) as? CatBreedContentCell else {
                return UITableViewCell()
            }
            cell.configure(with: breed)
            return cell
        }
    }
    
}

// MARK: - Table View Delegate

extension CatsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        
        if case .header(let breed, _) = item {
            let request = Cats.ToggleBreedExpansion.Request(breedId: breed.id)
            interactor?.toggleBreedExpansion(request: request)
        }
    }
    
}

// MARK: - Private Types
private enum TableChange {
    case insert(IndexPath)
    case delete(IndexPath)
    case reload(IndexPath)

    var indexPath: IndexPath {
        switch self {
        case .insert(let path), .delete(let path), .reload(let path):
            return path
        }
    }

    var isDeletion: Bool {
        if case .delete = self { return true }
        return false
    }

    var isInsertion: Bool {
        if case .insert = self { return true }
        return false
    }

    var isReload: Bool {
        if case .reload = self { return true }
        return false
    }
}
