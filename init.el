;; 環境ロード設定---------------------
;; Emacs 23以前
;; user-emacs-directory変数を定義
(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d")
)
;; load-pathを追加する関数
;; サブディレクトリを自動で探索して追加
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
; elpa : package.elで落としてきたもの
; etc : 各種サポートファイル, 主に.el以外
; conf : 分割設定ファイル
(add-to-load-path "elisp" "elpa" "etc" "conf")

;; パッケージインストーラの設定
; /elpaにインストールされる
(when (require 'package nil t)
  ;;パッケージリボジトリにMarmalade, ELPA, melpaを追加
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  ;(add-to-list 'package-archives '("ELPA" "http://troemy.com/elpa/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize)
) ;;ロードパスを通して読み込む

;; auto-installの設定
; auto-install-directory : インストール先
; Emacswikiからelisp名を取得
; url-proxy-services : プロキシ名，必要な場合
; auto-install-compatibility-setup : install-elispエイリアス
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  ;;(setq url-proxy-services'(("http" . "localhost::8339")))
  (auto-install-compatibility-setup)
)

;; auto-completeの起動
;(global-auto-complete-mode t)
(require 'auto-complete)
; auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories (expand-file-name
					   "~/.emacs.d/elpa/auto-complete-1.4/dict"))
  (setq ac-comphist-file (expand-file-name
			  "~/.emacs.d/ac-comphist.dat"))
)
(ac-config-default)
(setq ac-auto-start 4)
(setq ac-auto-show-menu 0.8)
(setq ac-use-comphist t)
(setq ac-candidate-limit nil)
(setq ac-use-quick-help t)
(setq ac-use-menu-map t)
(define-key ac-menu-map (kbd "C-n") 'ac-next)
(define-key ac-menu-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "ESC") 'ac-stop)
(ac-set-trigger-key "TAB")
;(define-key ac-menu-map (kbd "<tab>") 'ac-complete)

;; yasnippetの設定
;(defalias 'yas/get-snippet-tables 'yas--get-snippet-tables)
;(defalias 'yas/table-hash 'yas--table-hash)

; snippet保存先
(add-to-list 'load-path "~/.emacs.d/public_repos")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/public_repos/snippets"
	"~/.emacs.d/public_repos/extras/imported")
      )
(yas/global-mode 1)
; auto-completeと競合するのでキーを変える
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d04dd8b4037085a93353a66660c7a6bf2aacd89f5c5c253db09ba15b4938be60" default)))
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/home/takayaman/Documents/Programming/opencv/CvDisplayImage" "/home/takayaman/Documents/Programming/opencv" "/home/takayaman/temp/myproject/include" "/home/takayaman/temp/myproject/src" "/home/takayaman/temp/myproject")))
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint.py")
 '(irony-additional-clang-options (quote ("-I/home/takayaman/opencv3/build/include")))
 '(yas-trigger-key "<C-tab>"))
; 既存スニペット挿入
(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
; 新規スニペットを作成するバッファを用意
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
; 既存スニペットを閲覧・編集
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

;(yas-reload-all)
; auto-completeとの競合解決
(setf (symbol-function 'yas-active-keys)
      (lambda ()
	(remove-duplicates
	 (mapcan #'yas--table-all-keys (yas-get-snippet-tables)))))

;; CEDET関連の設定 built-inではなくローカルから読むので -----> irony-modeに鞍替え
; 先頭に書く必要がある
; Semantic設定
;(load-file "~/cedet/cedet-devel-load.el")
;(semantic-mode 1)
;(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-hightlight-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;(semantic-mode 1)
;(require 'semantic/ia) ; インタラクティブアナライザの起動
;(require 'semantic/bovine/gcc) ; 文法チェック?
;(cond ((eq system-type 'gnu/linux)
;       (setq qt53-base-dir "/home/takayaman/Qt/5.3/gcc_64/include")
;       (setq opencv3-base-dir "/home/takayaman/opencv3/build/include")
;       ))
;(semantic-add-system-include qt53-base-dir 'c++-mode)
;(semantic-add-system-include opencv3-base-dir 'c++-mode)


; EDE関連の設定 emacs用のcmake, qmakeのようなもの
; edeのプロジェクトロード時のエラー対策
;(cond ((eq system-type 'gnu/linux)
;       (require 'cedet)
;       (require 'eieio)
;       (require 'eieio-speedbar)
;       (require 'eieio-opt)
;       (require 'eieio-base)
;       (require 'ede/source)
;       (require 'ede/base)
;       (require 'ede/auto)
;       (require 'ede/proj)
;       (require 'ede/proj-archive)
;       (require 'ede/proj-aux)
;       (require 'ede/proj-comp)
;       (require 'ede/proj-elisp)
;       (require 'ede/proj-info)
;       (require 'ede/proj-misc)
;       (require 'ede/proj-obj)
;       (require 'ede/proj-prog)
;       (require 'ede/proj-scheme)
;       (require 'ede/proj-shared)
;       )
;      )

;(global-ede-mode 1)
; Lisp内でEDEのパスを直接指定する場合の書き方
; もう少し上手い方法が無いか模索中
;(ede-cpp-root-project "my_project" :file "~/testcpp/src/main.cpp"
;		      :include-path '("~/testcpp/my_inc/"))

; I can use system-include-path for setting up the system header file locations.

; ECB関連の設定 emacsをIDEっぽい外観にする
; 起動は M-x ecb-activate
; 落とすときは M-x ecb-deactivate
(add-to-list 'load-path (expand-file-name
			 "~/.emacs.d/ecb/"))
(require 'ecb)

; themeフレームワークの設定
(setq custom-theme-directory "~/.emacs.d/theme")
(load-theme 'molokai t)
(enable-theme 'molokai)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; バックアップ設定
(if (eq system-type 'windows-nt)
    (add-to-list 'backup-directory-alist
		 (cons "." "$(HOME)/Document/BackUps"))
)

(if (eq system-type 'gnu/linux)
    (add-to-list 'backup-directory-alist
		 (cons "." "$(HOME)/Documents/emacsBackups"))
)

(if (eq system-type 'darwin)
    (add-to-list 'backup-directory-alist
		 (cons "." "$(HOME)/Documents/Backups/emacsBackups"))
)

;; オートセーブ設定
; timeout : 30秒経過後
; interval : 300打鍵後
; auto-save-buffersは本体を自動でセーブするものなので
; Gitを本格的に使用するようにしてから導入予定
(setq auto-save-timeout 30)
(setq auto-save-interval 300)
;(require 'auto-save-buffers)
;(run-with-idle-timer 0.5 t 'auto-save-buffers)

;; 分割設定ファイルの自動読み込み
; 必ずinit.elの最後の方で呼び出す
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")

; shellから環境変数を引き継ぐ
;(exec-path-from-shell-initialize)
(let ((envs '("PATH" "PKG_CONFIG_PATH" "DMYGITPATH" "LD_LIBRARY_PATH")))
  (exec-path-from-shell-copy-envs envs)
)

;; HOMEディレクトリの設定
(if (eq system-type 'gnu/linux)
    (setq default-directory "~/")
)
(if (eq system-type 'windows-nt)
    (setq default-directory "e:/")
)
(if (eq system-type 'darwin)
    (setq default-directory "~/")
)

;; Trampのハング対応
(setq tramp-chunksize 500)
(setq tramp-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
