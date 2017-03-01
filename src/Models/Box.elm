module Models.Box exposing (..)

type alias RemainingTime = Int

type Status = Inactive
            | Active RemainingTime
            | Disabled

type Box = Box Status

makeBox : Box
makeBox = Box (Active 10)
