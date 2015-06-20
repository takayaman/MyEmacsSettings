; rstmodeの環境設定

; 拡張子とモードの結びつけ
(setq auto-mode-alist
      (append '(
		("\\.rst$" . rst-mode)
		) auto-mode-alist)
)

