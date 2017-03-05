module GameEvent exposing ( GameEvent(..)
                          )
import Time       exposing (..)
import Models.Box exposing (..)

type GameEvent = BoxClicked Box Int
               | Tick Time
               | ActivateBox Int
               | CheckExploded Time
               | CheckForAllDisabled Time
               | PickAgain Time
               --| Lost
               | Reset
