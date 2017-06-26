module Update exposing (..)

import Commands exposing (deletePlayerCmd, fetchPlayers, savePlayerCmd)
import Form exposing (Form)
import Models exposing (Model, Player, validation)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.FetchPlayers status ->
            ( model, fetchPlayers )

        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
            ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        Msgs.DeletePlayer player ->
            ( model, deletePlayerCmd player )

        Msgs.OnAddPlayer (Ok player) ->
            ( model, fetchPlayers )

        Msgs.OnAddPlayer (Err error) ->
            ( model, Cmd.none )

        Msgs.NoOp ->
            ( model, Cmd.none )

        Msgs.FormMsg formMsg ->
            case ( formMsg, Form.getOutput model.form ) of
                ( Form.Submit, Just player ) ->
                    ( model, savePlayerCmd player )

                _ ->
                    ( { model | form = Form.update validation formMsg model.form }, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
    { model | players = updatedPlayers }
