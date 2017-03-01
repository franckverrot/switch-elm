module GameEvent exposing ( GameEvent(..)
                          )
import Time       exposing (..)
import Models.Box exposing (..)

type GameEvent = BoxClicked Box Int
               | Tick Time
               | ActivateBox Int
               | CheckExpired Time
               | CheckForAllDisabled Time
               | PickAgain Time
               | Reset
