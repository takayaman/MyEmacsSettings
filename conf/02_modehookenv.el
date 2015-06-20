;; Emacs環境設定 モード毎の設定

;; fileオープン時に同じフォルダにede設定ファイルがあるか探す --> ironyモードに鞍替えしたので不要
;(defun check-for-Project-el ()
;  (if (file-exists-p "Project.el")
;      (load-file "Project.el")
;    )
;)
;(add-hook 'find-file-hook 'check-for-Project-el)

; outline-mode全体設定
(setq outline-minor-mode-prefix "\C-c\C-o")
(eval-after-load 'outline
  '(progn
     (require 'outline-magic)
     (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)
     )
  )

; elisp-------------------------------------------------
(defun my:elisp-mode-hooks ()
  ; モードラインにelispシンボルの内容を表示
  (when (require 'eldoc nil t)
    (setq 
     eldoc-idle-delay 0.2
     eldoc-echo-area-use-multiline-p t
     )
    (turn-on-eldoc-mode)
    )
)
(add-hook 'emacs-lisp-mode-hook 'my:elisp-mode-hooks)

; elispファイル用テンプレート
(defun my-eltemplate ()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        eltemplate-replacements-alists)
  (goto-char (point-max))
  (message "done.")
)

(defvar eltemplate-replacements-alists
  '(
    ("%project%" . (lambda () (setq project (read-from-minibuffer "project: "))))
    )
  )


; shell script-----------------------------------------
; 保存時に実行権を与える
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

; autoinsert--------------------------------------------
; ファイルオープン時にテンプレート貼り付け
(when (require 'autoinsert)
  ;(require 'auto-insert-choose)
  (setq auto-insert-directory "~/.emacs.d/etc/")
  (setq auto-insert-alist
	(append '(
		  ("main.c" . ["tempmain.c" my-template-c])
		  ("\\.c$" . ["template.c" my-template-c])
		  ("main.cpp" . ["tempmain.cpp" my-template-c])
		  ("\\.cpp$" . ["template.cpp" my-template-c])
		  ("globalDef.h" . ["tempglobalDef.h" my-template-c] )
		  ("\\.h$" . ["template.h" my-template-c])
		  ("globalDef.hpp" . ["tempglobalDef.hpp" my-template-c])
		  ("\\.hpp$" . ["template.hpp" my-template-c])
		  ("Project.el" . ["tempProject.el" my-eltemplate])
		  ("\\.py$" . ["template.py" my-template-python])
		  ) auto-insert-alist))
  )

; ファイル発見時の動作に結びつけ
(add-hook 'find-file-not-found-hooks 'auto-insert)
