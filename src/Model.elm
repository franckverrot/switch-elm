module Model exposing ( Model
                      , initialModel
                      , Status(..)
                      )

import Array      exposing (..)
import Models.Box exposing (..)
import Time       exposing (..)

type alias Model = { boxes  : Array Box
                   , status : Status
                   , tickInMilliseconds : Time
                   }

type Status = GameInProgress
            | GameWon
            | GameLost

initialModel : Model
initialModel = { boxes  = repeat (8 * 8) (Box Inactive)
               , status = GameInProgress
               , tickInMilliseconds = 800
               }
