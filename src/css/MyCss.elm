module MyCss exposing (..)

import Array           exposing (..)
import Css             exposing (..)
import Css.Colors      exposing (..)
import Css.Elements    exposing (body, li)
import Css.Namespace   exposing (namespace)
import CssTypes   as T exposing (..)
import Models.Box as M exposing (..)

classForBox status bgColor fontColor =
  class (T.Box status)
    [ display inlineBlock
    , backgroundColor bgColor
    , margin4 (px 2) (px 2) (px 2) (px 2)
    , width (px 36)
    , height (px 36)
    , textAlign center
    , fontSize (px 10)
    , fontWeight bold
    , color fontColor
    , textDecoration none
    , borderStyle none
    , cursor pointer
    , outline none
    , float left
    , padding (px 0)
    , property "touch-action" "manipulation"
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
    [ textAlign center
    , width (px 320)
    , margin2 (px 0) auto
    ]
  , class DifficultyIndicator
    [ textAlign right
    , fontSize (px 8)
    , color gray
    ]
  , classForBox M.Inactive gray silver
  , classForBox M.Exploded black silver
  , classForBox M.Disabled yellow black
  , class ResetButton
    [ display inlineBlock
    , backgroundColor gray
    , margin4 (px 2) (px 2) (px 2) (px 2)
    , width (px (320 / 2 - 4))
    , height (px 36)
    , textAlign center
    , fontSize (px 10)
    , fontWeight bold
    , color black
    , textDecoration none
    , borderStyle none
    , cursor pointer
    , outline none
    , float left
    , padding (px 0)
    ]
  ])
    ++ (toList <| initialize 11 (\i -> classForBox (M.Active i)  red silver))
    ++ (toList <| initialize  5 (\i -> classForBox (M.Enabled i) green black))
  )
