module Players.Add exposing (..)

import Form exposing (Form)
import Form.Input as Input
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Models exposing (Model, Player)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ nav
        , Html.map Msgs.FormMsg (formView model.form)
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


formView : Form () Player -> Html Form.Msg
formView form =
    let
        -- error presenter
        errorFor field =
            case field.liveError of
                Just error ->
                    -- replace toString with your own translations
                    div [ class "error" ] [ text (toString error) ]

                Nothing ->
                    text ""

        -- fields states
        name =
            Form.getFieldAsString "name" form

        level =
            Form.getFieldAsString "level" form
    in
    div []
        [ label [] [ text "Name" ]
        , Input.textInput name []
        , errorFor name
        , label []
            [ Input.textInput level []
            , text "Level"
            ]
        , errorFor level
        , button
            [ onClick Form.Submit ]
            [ text "Submit" ]
        ]
