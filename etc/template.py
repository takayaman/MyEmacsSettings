#!/usr/bin/env python3
# -*- coding: utf-8 -*-

""" .. py:module:: %file-without-ext%
-------------------------------------------------------------------------------
.. destribe:: text
%brief%

Copyright (c) %cyear% %author% @ %company% <%email%>
-------------------------------------------------------------------------------
"""

# Standart modules
import argparse

# Third party's modules
import numpy as np


# Local modules


# Execution settings
VERSION = u"%(prog)s 0.1"

# Input data directories
DIR_INPUT = "./images/"
# Output data directories
DIR_OUTPUT = "./images/"


def set_argparse():

    parser = argparse.ArgumentParser(description="%brief%")
    parser.add_argument("--version", action="version", version=VERSION)
    parser.add_argument("foo", action="store", help="FOOOOOOOOOO.")
    return parser


# --- Execution --------------------------------------------------------
if __name__ == "__main__":
    print(__doc__)

    # Parse arguments
    parser = set_argparse()
    args = parser.parse_args()
    try:
        foo = args.foo
    except:
        parser.error("Invalid arguments!!")
