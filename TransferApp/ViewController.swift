//
//  ViewController.swift
//  TransferApp
//
//  Created by Apple M1 on 27.02.2023.
//

import UIKit

// #1. Передача данных с помощью свойств
protocol UpdatebleDataController: AnyObject {
    var updatedData: String { get set }
}
// end of #1.

class ViewController: UIViewController, UpdatebleDataController, DataUpdateProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var dataLabel: UILabel!
    
    // #1. Передача данных с помощью свойств
    var updatedData: String = "Test data"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    // Обновляем данные в текстовой метке
    private func updateLabel(withText text: String) {
        dataLabel.text = text
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    // end of #1.
    
    // #2. Передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    // end of #2.
    
    // #3. Передача данных с помощью unwind segue
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    // end of #3.
    
    // #4. Передача данных с помощью делегирования
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    // переход от А к Б
    // передача данных с помощью свойства и установка делегата
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    // end of #4.
    
    // #5. Передача данных от Б к А с помощью замыкания
    
    // переход от А к Б
    // передача данных с помощью свойства и инициализация замыкания
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        
        // передаем необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // end of #5.

}

