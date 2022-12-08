//
//  DiaryDetaillViewController.swift
//  Diary
//
//  Created by 1 on 2022/11/29.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

class DiaryDetaillViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    weak var delegate : DiaryDetailViewDelegate?
    
    var starButton: UIBarButtonItem?
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
            guard let diary = self.diary else { return }
            self.titleLabel.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateLabel.text = self.dateToStriong(date: diary.date)
            self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
            self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            self.starButton?.tintColor = .orange
            self.navigationItem.rightBarButtonItem = self.starButton
        }

    
    private func dateToStriong(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configureView() // 수정내용으로 뷰 업뎃시키는것
    }
    
    @objc func tapStarButton() {
            guard let isStar = self.diary?.isStar else { return }
            if isStar {
                self.starButton?.image = UIImage(systemName: "star")
            } else {
                self.starButton?.image = UIImage(systemName: "star.fill")
            }
            self.diary?.isStar = !isStar
//            NotificationCenter.default.post(name: NSNotification.Name("starDiary"), object: [
//                "diary": self.diary,
//                "isStar": self.diary?.isStar ?? false,
//                "uuidString": diary?.uuidString],
//            userInfo: nil)
        }

    
    @IBAction func tapEditButton(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        viewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
