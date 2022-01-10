//
//  ViewController.swift
//  TODOLISTWITHRxSwiftApp
//
//  Created by IwasakIYuta on 2022/01/10.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay(value: [Task]())
    private var filterTasks = [Task]()
    
    //var testTasks = Variable<Task>([])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
    }
    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let naV = segue.destination as? UINavigationController,
              let AddTaskVC = naV.viewControllers.first as? AddTaskViewController else {
            fatalError("Controllers is not found")
              }
        //此処でselectImageViewにimageを伝えてる
        let priority = Priority(rawValue: prioritySegmentController.selectedSegmentIndex - 1)
                                
        AddTaskVC.taskSubjectObservable.subscribe { [weak self] task in
           
            guard let task = task.element,
                  let taskvalue = self?.tasks.value else { return }
            
            self?.tasks.accept( taskvalue + [task])
            self?.filterTasks(by: priority)
            
            self?.upDateTableView()
            
        }.disposed(by: disposeBag) //川の流れを止める
    }
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        //此処でsegmentedControlの選択肢を使う
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        //filterする
        filterTasks(by: priority)

    }
    
    private func upDateTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    private func filterTasks(by priority: Priority?) {
         
        if priority ==  nil {
            filterTasks = tasks.value
            upDateTableView()
        } else {
            
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority }//優先順位が同じものだけがfilterTasksに入る
            }.subscribe(onNext: { [ weak self ] tasks in
                self?.filterTasks = tasks
                self?.upDateTableView()
            }).disposed(by: disposeBag)
        }
        
    }
 

}

extension TaskListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filterTasks[indexPath.row].title
        return cell
    }
    
  
    
    
    
}
