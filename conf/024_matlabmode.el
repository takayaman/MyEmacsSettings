; Matlabmode

; (load "_/.emacs.d/elpa/matlab-mode-20141227.1244/matlab.el")

; matlab-modeの適用
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)

(setq matlab-shell-command "/home/takayaman/matlab/bin/matlab"
      matlab-indent-level 4
      matlab-indent-function-body nil
      matlab-highlight-cross-function-variables t
      matlab-return-add-semicolon nil
      matlab-show-mlint-warnings t
      matlab-auto-fill nil
      matlab-fill-fudge 1
      mlint-programs '("/home/takayaman/matlab/bin/glnxa64/mlint")
      matlab-mode-install-path (list (expand-file-name "/home/takayaman/.emacs.d/elpa/matlab-mode-20141227.1244/"))
      )

(autoload 'mlint-minor-mode "mlint" nil t)
(add-hook 'matlab-mode-hook (lambda () (mlint-minor-mode 1)))
(add-hook 'matlab-shell-mode-hook 'ansi-color-for-comint-mode-on)
(eval-after-load "shell"
  '(define-key shell-mode-map [down] 'comint-next-matching-input-from-input))
(eval-after-load "shell"
  '(define-key shell-mode-map [up] 'comint-previous-matching-input-from-input)) 
