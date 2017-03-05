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
     getBox index = get index model.boxes
                     |> Maybe.withDefault (M.Box M.Inactive)
     showBox box  = case box of
                      (M.Box (Active x))  -> toString x
                      (M.Box (Enabled x)) -> toString x
                      _                   -> "."

     boxHtml : Int -> Html GameEvent
     boxHtml index = getBox index
                       |> \box ->
                         case box of
                           (M.Box status) -> button
                                             [ class [ CssTypes.Box status ]
                                             , onClick (BoxClicked box index)
                                             ]
                                             [ text <| showBox box ]

     showResult : Model.Status -> Html GameEvent
     showResult result =
       case result of
         GameWon -> text "You are amazing. Truly."
         GameLost -> text "Ouch, you're not really good at it. U MAD?"
         GameInProgress -> text ""

     boxes = case model.status of
               GameInProgress -> div [ class [ Container ] ]
                          (toList <| Array.initialize 64 boxHtml)
               x -> div
                         [ class [ Container ], onClick Reset ]
                         [ h2 [] [ showResult model.status ]
                         , button
                           [ class [ ResetButton ] ]
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
