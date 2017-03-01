module Tests  exposing (..)

import Test   exposing (..)
import Expect
import Fuzz   exposing (list, int, tuple, string)
import String
import List   exposing (append)

all : Test
all =
  describe "Test Suite" []
