module Main exposing (main)

import Model exposing (Model)
import Model.Page exposing (Page(..))
import Messages exposing (Msg(..))
import Update exposing (update, updatePage)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Requests exposing (getEvents, getTalks)
import Navigation exposing (Location, program)
import Nav exposing (hashParser)


initialRequests : Page -> List (Cmd Msg)
initialRequests page =
    case page of
        EventsPage ->
            [ getEvents ]

        EventPage eventId ->
            [ getEvents, getTalks eventId ]

        TalkPage eventId talkId ->
            [ getEvents, getTalks eventId, Cmd.none ]


init : Location -> ( Model, Cmd Msg )
init location =
    let
        requests =
            initialRequests <| hashParser location
    in
        ( Model [] [], Cmd.batch requests )


main : Program Never Model Msg
main =
    program (ChangePage << hashParser)
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
