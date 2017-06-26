module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Models exposing (Player)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (addPath, playerPath)


view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text "Players"
            , addBtn
            ]
        ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player, btnDeletePlayer player ]
        ]


editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
    a
        [ class "btn regular"
        , href path
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]


btnDeletePlayer : Player -> Html Msg
btnDeletePlayer player =
    let
        message =
            Msgs.DeletePlayer player
    in
    a [ class "btn regular", onClick message ]
        [ i [ class "fa fa-trash-o" ] [], text " Delete" ]


addBtn : Html Msg
addBtn =
    a
        [ class "btn regular"
        , href addPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "Add Player" ]
