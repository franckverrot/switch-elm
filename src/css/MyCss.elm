module MyCss exposing (..)

import Array           exposing (..)
import Css             exposing (..)
import Css.Colors      exposing (..)
import Css.Elements    exposing (body, li)
import Css.Namespace   exposing (namespace)
import CssTypes   as T exposing (..)
import Models.Box as M exposing (..)

classForBox status computedColor =
  class (T.Box status)
    [ display inlineBlock
    , backgroundColor computedColor
    , margin4 (px 2) (px 2) (px 2) (px 2)
    , width (px 36)
    , height (px 36)
    , textAlign center
    , fontSize (px 15)
    , fontWeight bold
    , color silver
    , textDecoration none
    , borderStyle none
    , cursor pointer
    , outline none
    , float left
    , padding (px 0)
    ]

css =
  (stylesheet << namespace indexNamespace.name)
  (([ body
    [
    ]
  , id Page
    [ margin zero
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
    , width (px 320)
    , margin2 (px 0) auto
    ]
  , classForBox M.Inactive gray
  , classForBox M.Exploded black
  , classForBox M.Disabled yellow
  , class ResetButton
    [ display inlineBlock
    , width (pct 100)
    , margin (pct 0)
    ]
  ])
    ++ (toList <| initialize 11 (\i -> classForBox (M.Active i) red))
    ++ (toList <| initialize 5 (\i -> classForBox (M.Enabled i) green))
  )
