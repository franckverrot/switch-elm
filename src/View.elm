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
                      (M.Box (Active x))  -> ("HOLD ", x)
                      (M.Box (Enabled x)) -> ("NOW ", x)
                      _                   -> ("OFF", 0)

     boxHtml : Int -> Html GameEvent
     boxHtml index = getBox index
                       |> \box ->
                         case box of
                           (M.Box M.Disabled) -> button
                                                   [ class [ CssTypes.Box M.Disabled ]
                                                   ]
                                                   [ text <| Tuple.first <| showBox box
                                                   , br [] []
                                                   , text <| " "]
                           (M.Box M.Inactive) -> button
                                                   [ class [ CssTypes.Box M.Inactive ]
                                                   ]
                                                   [ text <| " "]
                           (M.Box status) -> button
                                               [ class [ CssTypes.Box status ]
                                               , onMouseDown (BoxClicked box index)
                                               ]
                                               [ text <| Tuple.first <| showBox box
                                               , br [] []
                                               , text <| toString <| Tuple.second <|  showBox box ]

     showResult : Model.Status -> Html GameEvent
     showResult result =
       case result of
         GameWon -> text "You are amazing. Truly."
         GameLost -> text "Ouch, you're not really good at it. U MAD?"
         GameInProgress -> text ""

     boxes = case model.status of
               GameInProgress -> div [] (toList <| Array.initialize 64 boxHtml)
               x -> h2 [] [ showResult model.status ]
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
        , div
            [ class [ Container ] ]
            [ boxes
            , div
                [ class [ DifficultyIndicator ] ]
                [ text <| "Difficulty level: " ++ toString model.tickInMilliseconds ++ "ms per tick" ]
            , button
              [ class [ ResetButton ], onClick <| Reset model.tickInMilliseconds ]
              [ text "Restart Game" ]
            , button
              [ class [ ResetButton ], onClick <| Reset <| model.tickInMilliseconds - 100 ]
              [ text "Harder" ]
            ]
       ]
