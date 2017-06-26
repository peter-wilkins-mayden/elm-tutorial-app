module Models exposing (..)

import Form exposing (Form)
import Form.Field as Field
import Form.Validate as Validate exposing (..)
import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    , form : Form () Player
    , errorMessage : Maybe String
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , errorMessage = Nothing
    , form = Form.initial initialFields validation
    }


initialFields : List ( String, Field.Field )
initialFields =
    [ ( "name", Field.string "name" )
    , ( "level", Field.string "level" )
    ]


validation : Validation () Player
validation =
    map3 Player
        (field "id" string)
        (field "name" string)
        (field "level" int)


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | AddPlayerRoute
    | NotFoundRoute
