#!/usr/bin/env python3
# -*- coding: utf-8 -*-

""" .. py:module:: %file-without-ext%
-------------------------------------------------------------------------------
.. destribe:: text
%brief%

Copyright (c) %cyear% %author% @ %company% <%email%>
-------------------------------------------------------------------------------
"""

# 標準ライブラリ
import argparse

# サードパーティライブラリ
import numpy as np


# ローカルライブラリ


# アプリケーション起動設定
VERSION = u"%(prog)s 0.1"

# テストデータディレクトリ
DIR_INPUT = "./images/"
# 結果出力ディレクトリ
DIR_OUTPUT = "./images/"


def set_argparse():

    parser = argparse.ArgumentParser(description="%brief%")
    parser.add_argument("--version", action="version", version=VERSION)
    parser.add_argument("foo", action="store", help="FOOOOOOOOOO.")
    return parser


# --- runによる呼び出し --------------------------------------------------------
if __name__ == "__main__":
    print(__doc__)

    # 引数処理
    parser = set_argparse()
    args = parser.parse_args()
    try:
        foo = args.foo
    except:
        parser.error("Invalid arguments!!")
