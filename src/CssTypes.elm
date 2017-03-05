module CssTypes exposing ( Classes(..)
                         , Ids(..)
                         , indexNamespace)

import Html.CssHelpers exposing (withNamespace)
import Models.Box as M exposing (..)

type Classes
  = Box M.Status
  | Header
  | GithubLink
  | Container
  | ResetButton

type Ids
  = Page

indexNamespace : Html.CssHelpers.Namespace String class id msg
indexNamespace =
  withNamespace "index"

