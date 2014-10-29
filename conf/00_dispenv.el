;; Emacs環境設定 表示，ウィンドウ設定関連

;; ウィンドウ設定-----------------------------
; ツールバー，スクロールバー表示/非表示
; 1 : 表示, 0 : 非表示
; window-system : ターミナルからの呼び出しでないとき
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
)

; ns CocoaEmacs(Mac)の時の設定
; メニューバー表示
(unless (eq window-system 'ns)
  (menu-bar-mode 1)
)

;; モードライン表示項目-------------------------------
; t : 表示, nil : 非表示
; カラム番号
(column-number-mode t)
; ファイルサイズ
(size-indication-mode t)
; 時計
; 曜日，月，日の順で24時間表示
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)
; バッテリー残量
; デスクトップだと勝手に無視される?
; macだとバッテリーが発見できない?
(if (eq system-type 'gnu/linux)
    (display-battery-mode t)
)
(if (eq system-type 'windows-nt)
    (display-battery-mode t)
)
;(if (eq system-type 'darwin)
;    (display-battery-mode t)
;)

;; フレーム設定----------------------------------
; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
; 行番号を常に表示
(global-linum-mode t)

;; ハイライト設定--------------------------------
; 対応する括弧を強調
; show-paren-delay : 遅延時間の設定
; show-paren-style : 強調方法
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(show-paren-mode t)

;; 特殊文字の表示設定----------------------------
(require 'whitespace)
; 空白，改行，タブに色付け
(setq whitespace-style '(face trailing tabs tab-mark spaces empty space-mark newline-mark))
; 全角空白，改行，タブは他の文字に置き換え
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
	(newline-mark ?\n [?\xAB ?\n]))
)
(setq whitespace-space-regexp "\\(\u3000+\\)")
; 色付け
(defvar my:white-space-bgcolor "#333333")
(set-face-attribute 'whitespace-trailing nil
		    :background nil
		    :foreground "DeepPink"
		    :underline t)
(set-face-attribute 'whitespace-tab nil
		    :background nil
		    :foreground "LightSkyBlue"
		    :underline t)
(set-face-attribute 'whitespace-space nil
		    :background nil
		    :foreground "GreenYellow"
		    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
		    :background nil
)
(global-whitespace-mode 1)
;(global-set-key (kbd "C-x w") 'global-whitespace-mode)

