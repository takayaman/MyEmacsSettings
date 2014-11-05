;; Emacs環境設定 モード毎の設定

; outline-mode全体設定
(setq outline-minor-mode-prefix "\C-c\C-o")
(eval-after-load 'outline
  '(progn
     (require 'outline-magic)
     (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)
     )
  )

; sdic 辞書設定--------------------------------------------
(require 'sdic-inline)
(sdic-inline-mode t)
(setq sdic-inline-world-at-point-strinct t)
; 辞書ファイル設定
(if (eq system-type 'gnu/linux)
    (setq sdic-inline-eiwa-dictionary "/usr/share/dict/gene.sdic")
  (setq sdic-inline-waei-dictionary "/usr/share/dict/jedict.sdic")
  )
; sdit tooltip
(require 'sdic-inline-pos-tip)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show)

(setq transient-mark-mode t)
(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show-when-region-selected)
; ONにする拡張子設定
(setq sdic-inline-enable-filename-regex "\\.\\(txt\\|tex\\)$")
(define-key sdic-inline-map "\C-c\C-p" 'sdic-inline-pos-tip-show)

(defun sdic-inline-pos-tip-show-when-region-selected (entry)
  (cond
   ((and transient-mark-mode mark-active)
    (funcall 'sdic-inline-pos-tip-show entry))
   (t
    ;;(funcall 'sdic-inline-display-minibuffer entry)
    )
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

; shell script-----------------------------------------
; 保存時に実行権を与える
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

