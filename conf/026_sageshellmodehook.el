;;; 026_sageshellmodehook.el --- SAGEMathモード

;; Copyright (C) 2015  takayaman

;; Author: takayaman <takayaman@takayaman-Z68MX-UD2H-B3>


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


;; 環境設定
(defun my:sage-shell-mode ()
  )

;; sage本体のパス
(setq sage-shell:sage-root "/usr/local/bin/sage")
(setq sage-shell:sage-executable "/usr/local/bin/sage/sage")
;; エイリアス設定 sage-mode使用の場合は競合するので注意
(sage-shell:define-alias)

;; FlyCheck関連
;; 下のループ上手く動かんかった...
;; (dolist (ckr '(python-pylint python-flake8))
;;   (flycheck-add-mode ckr 'sage-shell:sage-mode))
(require 'flycheck nil t)
;; (flycheck-add-mode 'python-pylint 'sage-shell:sage-mode)
;; (flycheck-add-mode 'python-flake8 'sage-shell:sage-mode)
;; .pyの時だけflycheckする
(defun sage-shell:flycheck-turn-on ()
    "Enable flycheck-mode only in a file ended with py."
    (when (let ((bfn (buffer-file-name)))
	    (and bfn (string-match (rx ".py" eol) bfn)))
      (flycheck-mode 1)))

;; eldocモード
(add-hook 'sage-shell-mode-hook 'my:sage-shell-mode)
(add-hook 'sage-shell:sage-mode-hook 'my:sage-shell-mode)
;; (add-hook 'sage-shell-mode-hook #'eldoc-mode)
;; (add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)
(add-hook 'sage-shell-mode-hook 'ac-sage-setup)
(add-hook 'sage-shell:sage-mode-hook 'ac-sage-setup)
;; 先にFlyCheckを起動しておく python-modeの設定と競合したので中止...
;; (add-hook 'python-mode-hook 'sage-shell:flycheck-turn-on)


