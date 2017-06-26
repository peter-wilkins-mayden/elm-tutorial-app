module Msgs exposing (..)

import Form exposing (Form)
import Http
import Models exposing (Player, PlayerId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | FetchPlayers (WebData String)
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | DeletePlayer Player
    | AddPlayer Player
    | NoOp
    | FormMsg Form.Msg
