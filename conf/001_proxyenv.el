;; Emacs環境設定 proxyenv

(setq url-proxy-services
       '(("no_proxy" . "^\\(localhost\\|10.*\\)")
         ("http" . "proxy.uec.ac.jp:8080")
         ("https" . "proxy.uec.ac.jp:8080")))
