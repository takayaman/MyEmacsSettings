;; Emacs環境設定 モード毎の設定

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

