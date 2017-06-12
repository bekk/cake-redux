module Model.Talk exposing (Talk, Speaker, talkDecoder, talksDecoder, talkEncoder)

import Json.Decode exposing (Decoder, string, list)
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)


type alias Talk =
    { body : String
    , equipment : String
    , format : String
    , length : String
    , published : String
    , ref : String
    , state : String
    , title : String
    , speakers : List Speaker
    , lastModified : String
    }


type alias Speaker =
    { bio : String
    , name : String
    , twitter : String
    }


talksDecoder : Decoder (List Talk)
talksDecoder =
    list talkDecoder


talkDecoder : Decoder Talk
talkDecoder =
    decode Talk
        |> required "body" string
        |> required "equipment" string
        |> required "format" string
        |> required "length" string
        |> required "published" string
        |> required "ref" string
        |> required "state" string
        |> required "title" string
        |> required "speakers" (list speakerDecoder)
        |> required "lastModified" string


talkEncoder : Talk -> Encode.Value
talkEncoder talk =
    Encode.object
        [ ( "ref", Encode.string talk.ref )
        , ( "state", Encode.string talk.state )
        , ( "tags", Encode.list <| [ Encode.string "" ] )
        , ( "keywords", Encode.list <| [ Encode.string "" ] )
        , ( "lastModified", Encode.string talk.lastModified )
        ]


speakerDecoder : Decoder Speaker
speakerDecoder =
    decode Speaker
        |> required "bio" string
        |> required "name" string
        |> required "twitter" string
