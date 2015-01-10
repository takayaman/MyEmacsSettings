;; Pythonモードの設定
(defun run-python (&rest args) nil)
(defun python-mode (&rest args) nil)
(defun jython-mode (&rest args) nil)
(defun python-shell (&rest args) nil)

(load "~/.emacs.d/elpa/python-mode-6.1.3/python-mode.el")

; python-modeの適用
(autoload 'python-mode "python-mode" "Python Mode." t)
(setq py-install-directory "~/.emacs.d/elpa/python-mode-6.1.3")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

; IPythonの設定
(defun my:ipython-python-mode ()
  ; pytho.elが時々読み込まれてしまうので殺す設定
  (defun run-python (&rest args) nil)
  (defun python-mode (&rest args) nil)
  (defun jython-mode (&rest args) nil)
  (defun python-shell (&rest args) nil)
  (load "~/.emacs.d/elpa/python-mode-6.1.3/python-mode.el")

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
(add-hook 'python-mode-hook 'my:jedi-python-mode)
(add-hook 'python-mode-hook 
	  (lambda () 
	    (setq tab-width 4)
	    (set-variable 'py-indent-offset 4)
	    (set-variable 'python-indent-guess-indent-offset nil)
	    )
)

; 拡張子とモードの結びつけ
(setq auto-mode-alist
      (append '(
		("\\.py$" . python-mode)
		) auto-mode-alist)
)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
