//
//  MainViewController.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: Public properties
    
    static let identifier = "MainViewController"
    
    var timer = Timer()
    
    // MARK: Private properties
    
    private var stillLoading = false
    private var dataModel = DataModel()
    private var pageNumber = 1
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestData()
    }
    
    deinit {
        UD.shared.code = nil
        print("deinit")
    }
    
    // MARK: Private methods
    
    private func setupView() {
        self.title = "Airports"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: DataCell.identifier, bundle: nil), forCellReuseIdentifier: DataCell.identifier)
    }
    
    private func requestData() {
        self.stillLoading = true
        NetworkManager.getData(code: UD.shared.code ?? "", pageNumber: pageNumber) { (data, error) in
            guard data != nil else {
                DispatchQueue.main.async {
                    self.showAlertController(title: "Error", message: "Could not load data")
                }
                return
            }
            DispatchQueue.main.async {
                self.pageNumber += 1
                self.dataModel.data.append(contentsOf: data?.data ?? .init())
                self.stillLoading = false
                self.tableView.reloadData()
            }
        }
    }
    
    private func showAlertController(title: String, message: String) {
        let skipAction = UIAlertAction(title: "Skip", style: .default, handler: {_ in
            self.pageNumber += 1
            self.requestData()
        })
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: {_ in
            self.requestData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
            self.stillLoading = false
        })
        let alert = AlertManager.showAlert(title: title, message: message, actions: [skipAction, retryAction, cancelAction])
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier) as! DataCell
        cell.titleLabel.text = dataModel.data[indexPath.row].name ?? ""
        cell.countryLabel.text = dataModel.data[indexPath.row].country ?? ""
        
        // Load image
//        
//        guard let url = URL(string: "https://cdn.countryflags.com/thumbs/\(dataModel.data[indexPath.row].country?.lowercased().replacingOccurrences(of: " ", with: "-") ?? "")/flag-800.png") else { return UITableViewCell() }
//        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
//            cell.countryImageView.image = UIImage(data: cachedResponse.data)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = dataModel.data.count - 1
        if indexPath.row == lastElement {
            requestData()
        }
    }
    
    
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set cell as selected

        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier) as! DataCell
        cell.isSelected = true
        
        // Prepare data for MapViewController
        
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: MapViewController.identifier) as? MapViewController else { return }
        
        targetVC.placeNameMap = dataModel.data[indexPath.row].name ?? ""
        targetVC.placeCountryMap = dataModel.data[indexPath.row].country ?? ""
        targetVC.placeLatitudeMap = dataModel.data[indexPath.row].lat ?? 0
        targetVC.placeLongtitudeMap = dataModel.data[indexPath.row].lon ?? 0
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
