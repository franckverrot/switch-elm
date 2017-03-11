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

activateBox : Int -> RemainingTime -> Array Box -> Maybe Box
activateBox position time boxes =
  boxAt position boxes
    |> \box -> case box of
                 (Box Inactive) -> Just <| Box (Active time)
                 any -> Nothing

tickBox : Box -> Box
tickBox box = case box of
                (Box (Active 1)) -> Box <| (Enabled <| 4)
                (Box (Active x)) -> Box <| (Active <| x - 1)
                (Box (Enabled 1)) -> Box <| (Exploded)
                (Box (Enabled x)) -> Box <| (Enabled <| x - 1)
                any -> any

update : GameEvent -> Model -> (Model, Cmd GameEvent)
update msg model =
  case msg of
    Reset time -> { initialModel | tickInMilliseconds = max 100 time }
                  ! []

    PickAgain x ->
      model
      !
      [ Random.generate ActivateBox (Random.int 0 ((length model.boxes) - 1)) ]

    ActivateBox x ->
      let defaultTime = 10
          newBox      = activateBox x defaultTime model.boxes
          events      = case newBox of
                          Nothing -> [ Task.perform PickAgain Time.now ]
                          Just newBox -> []
      in
          case model.status of
            GameWon  -> model ! []

            GameLost -> model ! []

            _        -> { model
                        | boxes = case newBox of
                                    Nothing -> model.boxes
                                    Just newBox -> set x newBox model.boxes
                        } ! events

    Tick time -> { model
                 | boxes = Array.map tickBox model.boxes
                 } !
                 [ Random.generate ActivateBox (Random.int 0 ((length model.boxes) - 1))
                 ]

    CheckExploded time ->
      let
          exploded : Box -> Bool
          exploded box = case box of
                           (Box Exploded)    -> True
                           (Box (Enabled x)) -> x <= 0
                           any -> False
      in
          case length <| filter exploded model.boxes of
            0  -> model ! []
            _  -> { model | status = GameLost } ! []


    CheckForAllDisabled time ->
      let
          notDisabled : Box -> Bool
          notDisabled box = case box of
                              Box Disabled -> False
                              any -> True
      in
          case length <| filter notDisabled model.boxes of
            0  -> { model | status = GameWon } ! []
            _  -> model ! []


    BoxClicked (Box status) index ->
        let newBox = boxAt index model.boxes
                      |> (\box -> case box of
                                   Box (Active x) -> Box Exploded
                                   Box (Enabled 0) -> Box Exploded -- checking now can save a new event
                                   Box (Enabled x) -> Box Disabled
                                   any -> any)
        in
            { model
            | boxes = set index newBox model.boxes
            , status = case newBox of
                         Box Exploded -> GameLost
                         any -> model.status
            } ! []
