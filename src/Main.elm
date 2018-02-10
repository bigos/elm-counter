port module Main exposing (..)

import Html exposing (Html, text, div, h1, img, p, button, span)
import Html.Attributes exposing (src, style, disabled)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { counter : Int }


init : ( Model, Cmd Msg )
init =
    ( { counter = 0 }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | Inc
    | Dec


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Inc ->
            ( { model | counter = model.counter + 1}
            , windowTitle ("Elm-count up " ++ (toString (model.counter + 1)))
            )
        Dec ->
            ( { model | counter = model.counter - 1}
            , windowTitle ("Elm-count down " ++ (toString (model.counter - 1))))
        NoOp ->
            ( model, Cmd.none )


counterBackground : Model -> String
counterBackground model =
    if model.counter < 0 then       "#f60"
    else if model.counter < 10 then "#ffa"
    else if model.counter < 20 then "#8f8"
    else if model.counter < 30 then "#8cf"
    else
        "white"

incDisabled model =
    if model.counter >= 40 then True else False

decDisabled model =
    if model.counter <= 0 then True else False

---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , p []
            [ button [ onClick Inc
                     , disabled (incDisabled model) ] [ text "Inc" ]
            , span [ style [ ("margin", "1em")
                           , ("background", counterBackground model )
                           ]
                   ] [text (toString model.counter)]
            , button [ onClick Dec
                     , disabled (decDisabled model) ] [ text "Dec" ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

port windowTitle : String -> Cmd msg
