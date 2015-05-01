;; Emacs環境設定 モード毎の設定 C/C++モード
;; C/C++言語関係設定

; リファクタ機能の追加
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; C/C++mode時にgoogleコーディングスタイルを適用する
(require 'google-c-style)

; irony-mode
(require 'irony)
(defun my:irony-cc-mode-setup ()
  (irony-mode 1)
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  )

; gtags
(defun my:gtags-cc-mode-setup()
  (gtags-mode 1)
)


; doxymacs
(require 'doxymacs)
(defun my:doxymacs-cc-mode-setup()
  (doxymacs-font-lock)
  (doxymacs-mode 1)
)

; auto-completeでC/C++ヘッダを補完できるようにする
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  ;(add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories "/usr/include/c++/4.8")
  (add-to-list 'achead:include-directories "/usr/include")
  (add-to-list 'achead:include-directories "/home/takayaman/opencv3/build/include")
  (add-to-list 'achead:include-directories "/home/takayaman/Qt/5.3/gcc_64/include")
)

; auto-completeのデフォルト設定を上書き
(defun ac-cc-mode-setup ()
  (require 'ac-irony)
  (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async)
  (setq ac-sources '(ac-source-filename
		     ac-source-dictionary
		     ac-source-abbrev
		     ac-source-gtags
		     ac-source-irony
		     ac-source-semantic
		     ;ac-source-yasnippet
		     ))
  ;(local-set-key (kbd "<C-tab>") 'ac-complete-semantic)
;  (add-to-list 'ac-omni-completion-sources
;	       (cons "\\." '(ac-source-semantic)))
;  (add-to-list 'ac-omni-completion-sources
;	       (cons "->" '(ac-source-semantic)))
)


; googleコーディングスタイル動的にチェックできるようにする
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint.py"))
  (flymake-google-cpplint-load)
)

; C/C++ modeに関連付け
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'c-mode-hook 'my:irony-cc-mode-setup)
(add-hook 'c++-mode-hook 'my:irony-cc-mode-setup)
(add-hook 'c-mode-common-hook 'my:gtags-cc-mode-setup)
(add-hook 'c-mode-common-hook 'my:doxymacs-cc-mode-setup)
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
(require 'cl)

(defun my-template-c ()
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
    ("%classname%" . (lambda() 
		   (concat (upcase-initials file-without-ext))))
    ("%namespace%" .
         (lambda () (setq namespace (concat 
				     (downcase project)
				     "_"
				     (read-from-minibuffer "namespace: ")
				     ))))
    ("%include%" .
         (lambda () 
	   (concat "<" file-without-ext ".h>")))
           ;(cond ((string= namespace "") (concat "\"" file-without-ext ".h\""))
           ;      (t (concat "<" (replace-regexp-in-string "::" "/" namespace) "/"
           ;                 file-without-ext ".h>")))))
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


