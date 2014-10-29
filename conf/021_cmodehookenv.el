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
  (setq auto-insert-directory "~/.emacs.d/etc/")
  (setq auto-insert-alist
	(append '(
		  ("\\.c$" . ["template.c" my-template])
		  ("\\.cpp$" . ["template.cpp" my-template])
		  ("\\.h$" . ["template.h" my-template])
		  ("\\.hpp$" . ["template.hpp" my-template])
		  ) auto-insert-alist))
)
; ファイル発見時の動作に結びつけ
(add-hook 'find-file-hooks 'auto-insert)
