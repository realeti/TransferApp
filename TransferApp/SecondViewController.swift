//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Apple M1 on 27.02.2023.
//

import UIKit

// #1. Передача данных с помощью свойств
protocol UpdatingDataController: AnyObject {
    var updatingData: String { get set }
}
// end of #1.

class SecondViewController: UIViewController, UpdatingDataController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var dataTextField: UITextField!
    
    // #1. Передача данных с помощью свойств
    var updatingData: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    // обновляем данные в текстовом поле
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? UpdatebleDataController)?.updatedData = dataTextField.text ?? ""
        }
    }
    // end of #1.
    
    // #3. Передача данных с помощью unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toFirstScreen":
            // обрабатываем переход
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на первый экран
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        // извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    // end of #3.
    
    // #4. Передача данных с помощью делегирования
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    // Переход от Б к А
    // Передача данных с помощью делегата
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        // получаем обновление данные
        let updatedData = dataTextField.text ?? ""
        // вызываем метода делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
    }
    // end of #4.
}
