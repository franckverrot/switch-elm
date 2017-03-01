module MyCss exposing (..)

import Css           exposing (..)
import Css.Colors    exposing (..)
import Css.Elements  exposing (body, li)
import Css.Namespace exposing (namespace)
import CssTypes      exposing (..)

css =
  (stylesheet << namespace indexNamespace.name)
  [ body
    [
    ]
  , id Page
    [ padding2 (pct 4) (pct 10)
    , margin zero
    , fontFamilies  ["Verdana", "Arial"]
    ]
  , class Header
    [
      textAlign center
    ]
  , class GithubLink
    [
      textAlign center
    ]
  , class Container
    [
      textAlign center
    , width (px 480)
    , margin2 (px 0) auto
    ]
  , class DeadEndMessage
    [
      textAlign center
    , fontSize (px 24)
    , padding (pct 5)
    ]
  , class Box
    [ display inlineBlock
    , backgroundColor blue
    , margin4 (px 2) (px 0) (px 0) (px 2)
    , flexGrow (int 1)
    , width (px 55)
    , height (px 55)
    , textAlign center
    , fontSize (px 30)
    , fontWeight bold
    , color silver
    , textDecoration none
    , borderStyle none
    , cursor pointer
    , outline none
    ]
  , class ResetButton
    [ display inlineBlock
    , width (pct 100)
    , margin (pct 0)
    ]
  , class Footer
    [ fontSize (px 25)
    , padding (px 20)
    ]
  ]
