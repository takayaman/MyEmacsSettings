;; Yatexモード設定ファイル
; 拡張子とモードの結びつけ
(setq auto-mode-alist 
      (append '(
	       ("\\.tex$" . yatex-mode)
	       ) auto-mode-alist)
)
; 必要になったときに読み込む
(autoload 'yatex-mode "yatex" "Yet Another Latex mode" t)
;; LaTexコマンド，プレビューワ，プリンタなどの設定
(setq tex-command "platex")
; Linux, mac : pxdvi, windows or console : dviout
(setq dvi2-command 
      (cond ((eq window-system 'x)
	     "pxdvi -expert -p 300 -s 3 -geo 750x575+0+0")
	    ((eq window-system 'ns)
	     "pxdvi -expert -p 300 -s 3 -geo 750x575+0+0")
	    ((eq window-system 'w32)
	     "dviout")
	    (nil
	     "dviout"))
)
(setq dviprint-command-format "dvipdfmx %s | lpr")
; (nil ignore, 0 no convert, 1 JIS, 2 SJIS, 3 EUC, 4 UTF-8)
(setq YaTeX-kanji-code nil)
; AMS-LaTexを使う
(setq YaTeX-user-AMS-LaTex t)
(setq makeindex-command "mendex")

;; 動作設定
; 括弧入力時に閉じ括弧の同時挿入禁止
(setq YaTeX-modify-mode t)
(setq YaTeX-close-paren-always nil)

; yatex outline-minor-mode--------------------------------------
(setq-default outline-level 'outline-level)
(defun my:yatex-mode-hook ()
  (make-variable-buffer-local 'outline-level)
  (setq outline-level 'latex-outline-level)
  (make-variable-buffer-local 'outline-regexp)
  (setq outline-regexp
	(concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
                  "chapter\\|section\\|subsection\\|subsubsection\\)"
                  "\\*?[ \t]*[[{]"))
)

(defun latex-outline-level ()
  (save-excursion
    (looking-at outline-regexp)
    (let ((title (buffer-substring (match-beginning 1) (match-end 1))))
      (cond ((eq (substring title 0 4) "docu") 20)
	    ((eq (substring title 0 4) "para")
	    ((eq (substring title 0 4) "chap") 0)
	    ((eq (substring title 0 4) "appe") 0)
	    (t (length title))))
      )
    )
)

(add-hook 'yatex-mode-hook 'my:yatex-mode-hook)
(add-hook 'yatex-mode-hook '(lambda () (outline-minor-mode t)))
(add-hook 'yatex-mode-hook '(lambda () (local-set-key "\C-c\C-d" 'sdic)))

