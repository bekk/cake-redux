module View.Talk exposing (view)

import Html exposing (Html, div, text, h2, h3, h4, p, select, option, button, ul, li)
import Html.Attributes exposing (class, value, selected)
import Html.Events exposing (onInput, onClick)
import Messages exposing (Msg(..))
import Model.Talk exposing (Talk, Speaker)


view : Talk -> Html Msg
view talk =
    div [ class "talk" ]
        [ h2 [] [ text talk.title ]
        , div [ class "talk__metadata" ] [ text <| talk.format ++ " / " ++ talk.length ++ " minutes " ]
        , p [] [ text talk.body ]
        , viewSpeakers talk.speakers
        , div []
            [ h3 [] [ text "Equipment" ]
            , p [] [ text talk.equipment ]
            , viewStatus talk
            ]
        ]


viewSpeakers : List Speaker -> Html Msg
viewSpeakers speakers =
    div []
        [ h3 []
            [ text "Speakers" ]
        , ul [ class "talk__speakers" ] <|
            List.map
                viewSpeaker
                speakers
        ]


viewSpeaker : Speaker -> Html Msg
viewSpeaker speaker =
    li []
        [ h4 [ class "talk__speaker-name" ] [ text speaker.name ]
        , p [ class "talk__speaker-bio" ] [ text speaker.bio ]
        ]


viewStatus : Talk -> Html Msg
viewStatus talk =
    if talk.canEdit then
        div []
            [ h3 [] [ text "Talk Status" ]
            , p [] [ viewTalkStatus talk ]
            , button [ onClick <| UpdateTalk talk ] [ text "Save" ]
            ]
    else
        div [] []


viewTalkStatus : Talk -> Html Msg
viewTalkStatus talk =
    select [ onInput <| UpdateTalkField << setState talk ] <|
        List.map
            (viewOption talk)
            [ "DRAFT", "SUBMITTED", "APPROVED", "REJECTED", "HISTORIC" ]


viewOption : Talk -> String -> Html Msg
viewOption talk state =
    option [ value state, selected <| talk.state == state ] [ text state ]


setState : Talk -> String -> Talk
setState talk state =
    { talk | state = state }
