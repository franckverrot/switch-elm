module Model exposing ( Model
                      , initialModel
                      , Status(..)
                      )

import Array      exposing (..)
import Models.Box exposing (..)

type alias Model = { boxes  : Array Box
                   , status : Status
                   }

type Status = InProgress
            | Won
            | Lost

initialModel : Model
initialModel = { boxes  = repeat 64 (Box Inactive)
               , status = InProgress
               }
