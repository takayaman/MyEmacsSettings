;;; 03_englishenv.el --- 英語文章環境設定

;; Copyright (C) 2015  takayaman

;; Author: takayaman <takayaman@takayaman-Z68MX-UD2H-B3>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

; google-translate Google翻訳 ----------------------------
; 先にpopwinを設定
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-posiiton 'bottom)

(require 'google-translate)

(global-set-key "\C-xt" 'google-translate-at-point)
(global-set-key "\C-xT" 'google-translate-query-translate)

;; 翻訳のデフォルト値を設定 (ja -> en) (無効化はC-u)
(custom-set-variables
 '(google-translate-default-source-language "ja")
 '(google-translate-default-target-language "en")
)

;; 翻訳バッファをポップアップ表示
(push '("*Google Translate*") popwin:special-display-config)

; google-this Google検索-----------------------------------
(require 'google-this)
(google-this-mode 1)

; search-web emacsからweb検索------------------------------
(require 'search-web)

; codic エンジニアのためのネーミング辞書---------------------
(require 'codic)

; ispell-buffer(built-in) バッファタイプのスペルチェック-----
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

; flyspell-lazy リアルタイムスペルチェック-------------------
(require 'flyspell-lazy)
(global-set-key (kbd "C-c <f8>") 'flyspell-mode)
(global-set-key (kbd "C-c <f9>") 'ispell-word)
(global-set-key (kbd "C-c <f10>") 'flyspell-buffer)

(ac-flyspell-workaround)
;; プログラム時はコメント領域のみ有効
(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(
   c-mode-common-hook
   python-mode-hook
   emacs-lisp-mode-hook
   matlab-mode-hook
   )
)
;; 他は常時
(mapc
 (lambda (hook)
   (add-hook hook
	     '(lambda () (flyspell-mode 1))))
 '(
   text-mode-hook
   yatex-mode-hook
   rst-mode-hook
   )
)

; grammer 文法チェッカ--------------------------------------
(require 'grammar)
(setq grammar-program-name "~/.emacs.d/elisp/grammar/grammar")
;; 青背景用の色変更
(set-face-attribute 'grammar-error-face nil
		    :background "#Ff6347"
		    :foreground "#000000")
(add-hook 'text-mode-hook 'grammar-mode)
(add-hook 'yatex-mode-hook 'grammar-mode)


; sdic 辞書設定--------------------------------------------
(require 'sdic-inline)
(sdic-inline-mode t)
(setq sdic-inline-world-at-point-strinct t)
; 辞書ファイル設定
(cond ((eq system-type 'gnu/linux)
       (setq sdic-inline-eiwa-dictionary "/usr/share/dict/gene.sdic")
       (setq sdic-inline-waei-dictionary "/usr/share/dict/jedict.sdic")
       ))
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



;;; 03_englishenv.el ends here
