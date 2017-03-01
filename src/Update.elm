module Update exposing ( update
                       )

import Array                   exposing (..)
import GameEvent               exposing (..)
import Model                   exposing (..)
import Models.Box              exposing (..)
import Random exposing (..)
import Task exposing (..)
import Time exposing (..)

boxAt : Int -> Array Box -> Box
boxAt position boxes =
  boxes
    |> get position
    |> Maybe.withDefault (Box Inactive)

activateBox : Int -> Array Box -> Maybe Box
activateBox position boxes =
  boxAt position boxes
    |> \box -> case box of
                 (Box Inactive) -> Just <| makeBox
                 any -> Nothing

tickBox : Box -> Box
tickBox box = case box of
                (Box (Active x)) -> Box <| (Active <| x - 1)
                any -> any

update : GameEvent -> Model -> (Model, Cmd GameEvent)
update msg model =
  case msg of
    Reset -> initialModel ! []

    PickAgain x ->
      model
      !
      [ Random.generate ActivateBox (Random.int 0 ((length model.boxes) - 1))
      ]

    ActivateBox x ->
      let newBox = activateBox x model.boxes
          events = case newBox of
                     Nothing -> [ Task.perform PickAgain Time.now ]
                     Just newBox -> []
      in
          { model
          | boxes = case newBox of
                      Nothing -> model.boxes
                      Just newBox -> set x newBox model.boxes
          } ! events

    Tick time -> { model
                 | boxes = Array.map tickBox model.boxes
                 } !
                 [ Random.generate ActivateBox (Random.int 0 ((length model.boxes) - 1))
                 ]

    CheckExpired time ->
      let
          expired : Box -> Bool
          expired box = case box of
                          (Box (Active x)) -> x <= 0
                          any -> False
      in
          case length <| filter expired model.boxes of
            0  -> model ! []
            _  -> { model | status = Lost } ! []


    CheckForAllDisabled time ->
      let
          notDisabled : Box -> Bool
          notDisabled box = case box of
                              Box Disabled -> False
                              any -> True
      in
          case length <| filter notDisabled model.boxes of
            0  -> { model | status = Won } ! []
            _  -> model ! []


    BoxClicked (Box status) index ->
        { model
        | boxes = boxAt index model.boxes
                    |> (\box -> case box of
                                 (Box (Active x)) -> Box Disabled
                                 any -> any)
                    |> \newBox -> set index newBox model.boxes
        } ! []
