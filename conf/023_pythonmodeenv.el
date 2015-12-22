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

  (setq-default py-shell-name "/usr/local/bin/ipython3")
  (setq-default py-which-bufname "IPython")
  (setq py-python-command-args
	'("qtconsole" "--pylab=qt" "--colors" "Linux"))
  (setq py-force-py-shell-name-p t)
  (setq py-shell-switch-buffers-on-execute-p t)
  (setq py-switch-buffers-on-execute-p t)
  (setq py-split-windows-on-execute-p nil)
  (setq py-smart-indentation t)
)

; pylintの設定
(defun my:pylint-mode()
  (require 'python-pylint)
)

; pyflakesの設定
(defun my:pyflakes-mode()
  (require 'pyflakes)
)

; jediの設定
(defun my:jedi-python-mode ()
  (jedi:setup)
  (setq jedi:complete-on-dot t)
)

; pep8の設定
(defcustom python-pep8-options '("--ignore=E302")
  "Options to pass to pep8.py"
  :type '(repeat string)
  :group 'python-pep8
)
(defun my:python-pep8-mode ()
  (require 'pep8)
  (local-set-key "\C-cp" 'pep8)
)


; pythonモードに関連付け
(add-hook 'python-mode-hook 'my:ipython-python-mode)
(add-hook 'python-mode-hook 'my:jedi-python-mode)
;(add-hook 'python-mode-hook 'my:pylint-mode)
(add-hook 'python-mode-hook 'my:pyflakes-mode)
(add-hook 'python-mode_hook 'my:python-pep8-mode)
(add-hook 'python-mode-hook 
	  (lambda () 
	    (setq tab-width 4)
	    (set-variable 'py-indent-offset 4)
	    (set-variable 'python-indent-guess-indent-offset nil)
	    (require 'pep8)
	    (local-set-key "\C-cp" 'pep8)
	    )
)
(add-hook 'python-mode-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "/usr/local/bin/pyck.sh" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init))
)
(load-library "flymake-cursor")


; 拡張子とモードの結びつけ
(setq auto-mode-alist
      (append '(
		("\\.py$" . python-mode)
		) auto-mode-alist)
)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

; python用テンプレート
(defun my-template-python()
  (time-stamp)
  (mapc #'(lambda(c)
            (progn
              (goto-char (point-min))
              (replace-string (car c) (funcall (cdr c)) nil)))
        template-replacements-alists-py)
  (goto-char (point-max))
  (message "done.")
)

(defvar template-replacements-alists-py
  '(("%file-without-ext%" . (lambda () 
          (setq file-without-ext (file-name-sans-extension
                                   (file-name-nondirectory (buffer-file-name))))))
    ("%author%" . (lambda () (concat "N.Takayama")))
    ("%email%" . (lambda () (concat "takayaman@uec.ac.jp")))
    ("%cyear%" . (lambda () (substring (current-time-string) -4)))
    ("%brief%" . (lambda () (read-from-minibuffer "Brief description: ")))
    ("%company%" . (lambda () (setq campany (read-from-minibuffer "company or organization: "))))
))


