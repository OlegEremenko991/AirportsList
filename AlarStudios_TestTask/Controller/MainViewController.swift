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
    
//    private var stillLoading = false
    private var dataSource = DataModel()
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
        TempStorageService.shared.code = nil
        print("deinit")
    }
    
    // MARK: Private methods
    
    private func setupView() {
        self.title = "Airports"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    private func requestData() {
        NetworkService.getData(code: TempStorageService.shared.code ?? "", pageNumber: pageNumber) { (data, error) in
            guard data != nil else {
                DispatchQueue.main.async {
                    self.showAlertController(title: "Error", message: "Could not load data")
                }
                return
            }
            DispatchQueue.main.async {
                self.pageNumber += 1
                self.dataSource.data.append(contentsOf: data?.data ?? .init())
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        let alert = AlertService.showAlert(title: title, message: message, actions: [skipAction, retryAction, cancelAction])
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        let item = dataSource.data[indexPath.row]
        
        customCell.titleLabel.text = item.name
        customCell.countryLabel.text = item.country
        
        // Load image for cell
        
        if let url = URL(string: "https://cdn.countryflags.com/thumbs/\(dataSource.data[indexPath.row].country?.lowercased().replacingOccurrences(of: " ", with: "-") ?? "")/flag-800.png") {
            customCell.flagImage.loadImage(from: url)
        }
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = dataSource.data.count - 1
        if indexPath.row == lastElement {
            requestData()
        }
    }
    
    
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Prepare data for MapViewController
        
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: MapViewController.identifier) as? MapViewController else { return }
        
        targetVC.placeName = dataSource.data[indexPath.row].name ?? ""
        targetVC.placeCountry = dataSource.data[indexPath.row].country ?? ""
        targetVC.placeLatitude = dataSource.data[indexPath.row].lat ?? 0
        targetVC.placeLongitude = dataSource.data[indexPath.row].lon ?? 0
        targetVC.title = targetVC.placeName
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
