//
//  MainViewController.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        }
    }

    // MARK: - Public properties

    static let identifier = "MainViewControllerID"
    var code = ""

    // MARK: - Private properties

    private var dataSource = DataModel().data
    private var pageNumber = 1
    private var alertController: UIAlertController?
    private let queue = OperationQueue()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestData()
    }

    // MARK: - Private methods

    private func setupView() {
        title = "Airports"
    }

    private func requestData() {
        NetworkService.shared.getData(code: code, pageNumber: pageNumber) { [weak self] result in
            switch result {
            case .success(let data):
                self?.updateDataSource(with: data)
            case .failure(let error):
                print(error.rawValue)
                self?.showAlertController(title: "Error", message: error.rawValue)
                return
            }
        }
    }

    private func updateDataSource(with data: DataModel) {
        pageNumber += 1
        dataSource.append(contentsOf: data.data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func showAlertController(title: String, message: String) {
        DispatchQueue.main.async {
            let skipAction = UIAlertAction(title: "Skip", style: .default, handler: { _ in
                self.pageNumber += 1
                self.requestData()
                self.alertController = nil
            })
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: {_ in
                self.requestData()
                self.alertController = nil
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
                self.alertController = nil
            })
            
            // Prevent from showing multiple alert controllers
            guard self.alertController == nil else { return }
            
            self.alertController = AlertService.customAlert(title: title, message: message, actions: [skipAction, retryAction, cancelAction])
            guard let alert = self.alertController else { return }
            self.present(alert, animated: true)
        }
    }

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { dataSource.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else { return UITableViewCell() }

        let item = dataSource[indexPath.row]
        customCell.titleLabel.text = item.name
        customCell.countryLabel.text = item.country

        // Load image for cell
        let loadOperation = LoadImageOperation()

        if let url = URL(string: "https://cdn.countryflags.com/thumbs/\(dataSource[indexPath.row].country?.lowercased().replacingOccurrences(of: " ", with: "-") ?? "")/flag-800.png") {

            // Setup loadOperation and add it to the queue
            loadOperation.url = url
            loadOperation.imageView = customCell.flagImage
            queue.addOperation {
                loadOperation.imageView?.loadImage(from: url)
            }
        }
        return customCell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 { requestData() }
    }

}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { CGFloat(80) }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Prepare data for MapViewController
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: MapViewController.identifier) as? MapViewController else { return }

        targetVC.placeName = dataSource[indexPath.row].name ?? ""
        targetVC.placeCountry = dataSource[indexPath.row].country ?? ""
        targetVC.placeLatitude = dataSource[indexPath.row].lat ?? 0
        targetVC.placeLongitude = dataSource[indexPath.row].lon ?? 0

        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
