;; Emacs環境設定 入力，フォント関連

;; キーマップ設定---------------------------------------------
; 基本は全体に適用のもの，モード毎の設定はそれの設定ファイルの中で行う

; C-c l : 折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

; M-`は使わない 日本語/英語切り替えに使うため
(define-key global-map (kbd "M-`") nil)

; C-. : redo機能
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))

;; IME設定---------------------------------------------------
; Windows設定
; 標準IME : W32-IME
; set-cur-sor-color : IME OFF時のカーソル色
; バッファ切替時にIME状態を引き継ぎ
(cond ((eq window-system 'w32)
       (setq default-input-method "W32-IME")
       (w32-ime-initialize)
       (set-cursor-color "red")
       (setq w32-ime-buffer-switch-p nil)
       )
)
; MAC設定
(cond ((or (eq window-system 'ns) (eq window-system 'mac))
       (setq default-input-method "MACOSX")
       (set-cursor-color "red")
       )
)
; LINUX設定
(cond ((eq window-system 'x)
       )
)

; IME ON/OFF時のカーソルカラー
; LINUX Mintだと上手く色付けできない
(add-hook 'input-method-activate-hook
	  (lambda() (set-cursor-color "grey")))
(add-hook 'input-method-inactivate-hook
	  (lambda() (set-cursor-color "red")))

;; ファイル文字コード設定----------------------------------------------
; Mac用 HFS+
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locali-coding-system 'utr-8-hfs)
)

; Windows用 ShiftJis
(when (eq system-type 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932)
)

;; CommonUserAccess設定-------------------------------------------
; 矩形選択のために使用
(cua-mode t)
; Emacsキーバインドが使えなくなるのでキーバインドは使わない
(setq cua-enable-cua-keys nil)

;; 拡張機能-------------------------------------------------------
; 範囲指定時に指定箇所の行数と文字数をモードラインに表示
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines, %d chars"
	      (count-lines (region-beginning) (region-end))
	      (- (region-end) (region-beginning)))
    (count-lines-region (region-beginning) (region-end))
    "")
)
; これを加えるとエラーになる?
;(add-to-list 'default-mode-line-format
;	     '(:eval (count-lines-and-chars)))

; wgrep
(require 'wgrep nil t)

; color-moccur
(when (require 'color-moccur nil t)
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "/.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (when (and (executable-find "cmigemo")
	     (eq system-type 'gnu/linux)
	     (require 'migemo nil t)
	     )
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))
    (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
    (setq migemo-user-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (setq migemo-regex-dictionary nil)
    (load-library "migemo")
    (migemo-init)
    (setq moccur-use-migemo t)
    )
)
; TODO migemo起動時にIMEをOFFにする

; moccur-edit
(require 'moccur-edit nil t)


