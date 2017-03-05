module Model exposing ( Model
                      , initialModel
                      , Status(..)
                      )

import Array      exposing (..)
import Models.Box exposing (..)

type alias Model = { boxes  : Array Box
                   , status : Status
                   }

type Status = GameInProgress
            | GameWon
            | GameLost

initialModel : Model
initialModel = { boxes  = repeat (8 * 8) (Box Inactive)
               , status = GameInProgress
               }
