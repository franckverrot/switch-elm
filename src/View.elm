module View exposing ( view
                     )

import Array           exposing (..)
import CssTypes        exposing (..)
import Html            exposing (..)
import Html.Attributes exposing (..)
import Html.Events     exposing (..)
import Model           exposing (..)
import Models.Box as M exposing (..)
import GameEvent       exposing (..)

{ id, class, classList } =
  indexNamespace

view : Model -> Html GameEvent
view model =
  let
     getBox index = Maybe.withDefault (M.Box M.Inactive) <| get index model.boxes
     showBox index = getBox index
                     |> \b -> case b of
                                (M.Box Inactive) -> "..."
                                (M.Box Disabled) -> ":-)"
                                (M.Box (Active x)) -> toString x

     boxHtml : Int -> Html GameEvent
     boxHtml index =  button
                        ([ class [ CssTypes.Box ], onClick (BoxClicked (M.Box Inactive) index) ])
                        [ text <| showBox index ]

     showResult : Model.Status -> Html GameEvent
     showResult result =
       case result of
         Won -> text "You are amazing. Truly."
         Lost -> text "Ouch, you're not really good at it. U MAD?"
         InProgress -> text ""

     boxes = case model.status of
               InProgress -> div [ class [ Container ] ]
                          (toList <| Array.initialize 64 boxHtml)
               x -> div
                         [ class [ Container ], onClick Reset ]
                         [ h2 [] [ showResult model.status ]
                         , button
                           [ class [ CssTypes.Box, ResetButton ] ]
                           [ text "Play again" ] ]
  in
      div
        [ id Page ]
        [ h1 [ class [ Header ] ] [ text "Switch in Elm" ]
        , p
            [ class [ GithubLink ] ]
            [ a
                [ href "https://github.com/franckverrot/switch-elm" ]
                [ text "Source code on GitHub" ]
            ]
        , boxes
       ]
