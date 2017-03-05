module Models.Box exposing (..)

type alias RemainingTime = Int

type Status = Inactive
            | Active RemainingTime
            | Enabled RemainingTime
            | Exploded
            | Disabled

type Box = Box Status
