;; Pythonモードの設定

; python-modeの適用
(setq py-install-directory "~/.emacs.d/elpa/python-mode-6.1.3")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

; IPythonの設定
(defun my:ipython-python-mode ()
  (setq-default py-shell-name "/usr/local/bin/ipython")
  (setq-default py-which-bufname "IPython")
  (setq py-python-command-args
	'("qtconsole" "--pylab=qt" "--colors" "Linux"))
  (setq py-force-py-shell-name-p t)
  (setq py-shell-switch-buffers-on-execute-p t)
  (setq py-switch-buffers-on-execute-p t)
  (setq py-split-windows-on-execute-p nil)
  (setq py-smart-indentation t)
)

; jediの設定
(defun my:jedi-python-mode ()
  (jedi:setup)
  (setq jedi:complete-on-dot t)
)

; pythonモードに関連付け
(add-hook 'python-mode-hook 'my:ipython-python-mode)

; 拡張子とモードの結びつけ
(setq auto-modealist
      (append '(
		("\\.py$" . python-mode)
		) auto-mode-alist)
)
