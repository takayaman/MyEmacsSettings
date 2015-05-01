#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" .. py:module:: %file-without-ext%
-------------------------------------------------------------------------------
.. destribe:: text
%brief%

Copyright (c) %cyear% %author% @ %company% <%email%>
-------------------------------------------------------------------------------
"""

# 標準ライブラリ
import optparse

# サードパーティライブラリ
import numpy as np


# ローカルライブラリ


# アプリケーション起動設定
USAGE = u"%prog aug0 aug1"
VERSION = u"%prog 0.1"

# テストデータディレクトリ
DIR_INPUT = "./images/"
# 結果出力ディレクトリ
DIR_OUTPUT = "./images/"


def set_optparse():
    global USAGE, VERSION

    parser = optparse.OptionParser(usage=USAGE, version=VERSION)
    return parser


# --- runによる呼び出し --------------------------------------------------------
if __name__ == "__main__":
    print __doc__

    # 引数処理
    parser = set_optparse()
    options, args = parser.parse_args()
    try:
        aug = args
    except:
        parser.error("Invalid arguments!!")
