;; Emacs環境設定 モード毎の設定 C/C++モード
;; C/C++言語関係設定

; リファクタ機能の追加
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; C/C++mode時にgoogleコーディングスタイルを適用する
(require 'google-c-style)

; auto-completeでC/C++ヘッダを補完できるようにする
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories "/usr/include/c++/4.8")
)

; googleコーディングスタイル動的にチェックできるようにする
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint.py"))
  (flymake-google-cpplint-load)
)

; C/C++ modeに関連付け
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; 拡張子とモードの結びつけ
(setq auto-mode-alist
      (append '(
		("\\.c$" . c-mode)
		("\\.cpp$" . c++-mode)
		("\\.hpp$" . c++-mode)
		("\\.h$" . c++-mode)
		) auto-mode-alist)
)

; C/C++言語ファイルのテンプレート
(when (require 'autoinsert)
  (require 'auto-insert-choose)
  (setq auto-insert-directory "~/.emacs.d/etc/")
  (setq auto-insert-alist
	(append '(
		  ("main.c$" . ["tempmain.c" my-template])
		  ("\\.c$" . ["template.c" my-template])
		  ("main.cpp$" . ["tempmain.cpp" my-template])
		  ("\\.cpp$" . ["template.cpp" my-template])
		  ("globalDef.h$" . ["tempglobalDef.h" my-template] )
		  ("\\.h$" . ["template.h" my-template])
		  ("globalDef.h$" . ["tempglobalDef.hpp" my-template])
		  ("\\.hpp$" . ["template.hpp" my-template])
		   auto-insert-alist))
	)
  )

; ファイル発見時の動作に結びつけ
(add-hook 'find-file-not-found-hooks 'auto-insert)

(require 'cl)

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacements-alists)
  (goto-char (point-max))
  (message "done.")
)


(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%project%" . (lambda () (setq project (read-from-minibuffer "project: "))))
    ("%company%" . (lambda () (setq campany (read-from-minibuffer "company or organization: "))))
    ("%file-without-ext%" . (lambda () 
          (setq file-without-ext (file-name-sans-extension
                                   (file-name-nondirectory (buffer-file-name))))))
    ("%namespace%" .
         (lambda () (setq namespace (read-from-minibuffer "namespace: "))))
    ("%include%" .
         (lambda () 
           (cond ((string= namespace "") (concat "\"" file-without-ext ".h\""))
                 (t (concat "<" (replace-regexp-in-string "::" "/" namespace) "/"
                            file-without-ext ".h>")))))
    ("%include-guard%" . 
         (lambda ()
           (format "%s_H_"
                   (upcase (concat
			    (replace-regexp-in-string "/" "_" (file-name-directory (buffer-file-name)))
			    file-without-ext)))))
;(replace-regexp-in-string "::" "_" namespace)
                             ;(unless (string= namespace "") "_")
                             ;file-without-ext)))))
    ("%author%" . (lambda () (concat "N.Takayama")))
    ("%email%" . (lambda () (concat "takayaman@uec.ac.jp")))
    ("%cyear%" . (lambda () (substring (current-time-string) -4)))
    ("%date%" . (lambda () (concat
			    (format-time-string "%Y" (current-time))
			    "/"
			    (format-time-string "%_m" (current-time))
			    "/"
			    (format-time-string "%_d" (current-time))
			    )))
    ("%brief%" . (lambda () (read-from-minibuffer "Brief description: ")))
    ("%namespace-open%" .
       (lambda ()
         (cond ((string= namespace "") "")
               (t (progn 
                   (setq namespace-list (split-string namespace "::"))
                   (setq namespace-text "")
                   (while namespace-list
                     (setq namespace-text (concat namespace-text "namespace "
                                                 (car namespace-list) " {\n"))
                     (setq namespace-list (cdr namespace-list))
                   )
                   (eval namespace-text))))))
    ("%namespace-close%" .
       (lambda ()
         (cond ((string= namespace "") "")
               (t (progn
                   (setq namespace-list (reverse (split-string namespace "::")))
                   (setq namespace-text "")
                   (while namespace-list
                      (setq namespace-text (concat namespace-text "}  // namespace " (car namespace-list) "\n"))
                      (setq namespace-list (cdr namespace-list))
                   )
                   (eval namespace-text))))))
))

