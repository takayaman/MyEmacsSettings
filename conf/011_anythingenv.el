;;  Emacs環境設定 anything設定
; 他の入力設定よりもあとに読み込む

(when (require 'anything nil t)
  ; 全体設定
  (setq
   anything-idle-delay 0.3 ; 候補を表示するまでの時間
   anything-input-idle-delay 0.2 ; タイプして再描画するまでの時間
   anything-candidate-number-limit 100 ; 候補の最大表示数
   anything-quick-update t ; 候補が多い場合は体感速度を速くする
   anything-enable-shorcuts 'alphabet ; 選択ショートカットをアルファベットに設定
   )
  (when (require 'anything-config nil t)
    ; root権限でアクションするときのコマンド
    (setq anything-su-or-sudo "sudo")
    )
  ; スペース区切りでAND検索可能にする
  (require 'anything-match-plugin nil t)
  ; cmigemoが入っている場合はanything経由で使えるようにする
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t)
    )
  ; 補完関連の設定
  (when (require 'anything-complete nil t)
    ; lispシンボルの再検索時間
    (anything-lisp-complete-symbol-set-timer 150)
    )
  (require 'anything-show-completion nil t)
  ; auto-installとの結合
  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))
  ; describe-bindingsをanythingに置き換え
  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install))
  ; color-moccurとの結合
  (when (require 'anything-c-moccur nil t)
    (setq
     anything-c-moccur-anything-idle-delay 0.1 ; 候補を表示するまでの時間
     anything-c-moccur-highlight-info-line-flag t ; バッファの情報をハイライト
     anything-c-moccur-enable-auto-look-flag t ; 選択中の候補位置を別windowに表示
     anything-c-moccur-enable-initial-pattern t ; 起動時にカーソルの位置の単語を初期パターンにする
     )
    ; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
    (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur)
    )
  ; M-yにanything-show-kill-ringを割り当てる
  (define-key global-map (kbd "M-y") 'anything-show-kill-ring)
)
