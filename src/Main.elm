import Html      exposing (program)
import Model     exposing (Model, initialModel)
import GameEvent exposing (GameEvent(..))
import Update    exposing (update)
import View      exposing (view)
import Time      exposing (..)

main : Program Never Model GameEvent
main = program { init          = (initialModel, Cmd.none)
               , view          = view
               , update        = update
               , subscriptions = subscriptions
               }

subscriptions : Model -> Sub GameEvent
subscriptions model =
  Sub.batch
    [ every 700 Tick
    , every 700 CheckExpired
    , every 700 CheckForAllDisabled
    ]
