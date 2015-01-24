; EDE関連の設定 emacs用のcmake, qmakeのようなもの
;(global-ede-mode 1)
; Lisp内でEDEのパスを直接指定する場合の書き方
; もう少し上手い方法が無いか模索中
;(ede-cpp-root-project "trycedet" :file "~/trycedet/main.cpp"
;		      :include-path '("~/trycedet/")
;)

; I can use system-include-path for setting up the system header file locations.
