module Model.Talk exposing (Talk, talksDecoder)

import Json.Decode exposing (Decoder, string, list)
import Json.Decode.Pipeline exposing (decode, required)


type alias Talk =
    { audience : String
    , body : String
    , equipment : String
    , format : String
    , infoToProgramCommittee : String
    , keywords : List String
    , lang : String
    , length : String
    , level : String
    , outline : String
    , published : String
    , ref : String
    , state : String
    , suggestedKeywords : String
    , summary : String
    , tags : List String
    , title : String
    }


talksDecoder : Decoder (List Talk)
talksDecoder =
    list talkDecoder


talkDecoder : Decoder Talk
talkDecoder =
    decode Talk
        |> required "audience" string
        |> required "body" string
        |> required "equipment" string
        |> required "format" string
        |> required "infoToProgramCommittee" string
        |> required "keywords" (list string)
        |> required "lang" string
        |> required "length" string
        |> required "level" string
        |> required "outline" string
        |> required "published" string
        |> required "ref" string
        |> required "state" string
        |> required "suggestedKeywords" string
        |> required "summary" string
        |> required "tags" (list string)
        |> required "title" string
