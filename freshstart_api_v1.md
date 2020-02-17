FORMAT: 1A
HOST: https://freshstart-kapp10.herokuapp.com

# API Freshstart

L'API Freshstart fonctionne uniquement en JSON.

Elle est constituée de 2 API de haut niveau : Courses et Coureurs.


# Sécurité

L'accès à l'API Freshstart est contrôlé et limité. Pour accéder à l'API, vous devez posséder une clé d'API. Cette dernière prend la forme d'un couple de UUID _Application ID_ et _Application Secret_. Vous pouvez obtenir cette clé auprès de votre interlocuteur habituel de Freshstart.

## Obtenir un jeton d'accès à l'API [GET /oauth/token]

Pour interroger l'API, vous devez au préalable obtenir un jeton d'accès temporaire, comme expliqué ci-dessous :

+ Request an oAuth Token
**POST**&nbsp;&nbsp;`/oauth/token`

  + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "grant_type": "client_credentials",
              "client_id": <API_KEY_APPLICATION_ID>,
              "client_secret": <API_KEY_APPLICATION_SECRET>
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              access_token: 519e5af7d1592a77168e90982998c121d564c8d0b60e7378dbf1d14989eab476
            }

# Group API Résultat de Courses
L'API Courses est organisée hiérarchiquement : Évènements > Éditions > Courses > Résultats.

## Évènements [/events]
Un évènement contient plusieurs éditions.

### Obtenir tous les évènements [GET /api/v1/events]


+ Request return a list of events
**GET**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": 4006,
                "name": "Event_12",
                "place": "Place_12",
                "website": "www.event_12.com",
                "facebook": "Event_12",
                "twitter": "@Event_12",
                "instagram": "@Event_12",
                "contact": "contact@event_12.com",
                "email": "contact@event_12.com",
                "phone": "+331212121212121212",
                "created_at": "2017-12-22T14:40:55.660+01:00",
                "updated_at": "2017-12-22T14:40:55.660+01:00"
              }
            ]

### Obtenir un évènement particulier [GET /api/v1/events/{id}]

+ Parameters
    + id: `4007` (number, required)

+ Request return the event
**GET**&nbsp;&nbsp;`/api/v1/events/4007`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 4007,
              "name": "Event_13",
              "place": "Place_13",
              "website": "www.event_13.com",
              "facebook": "Event_13",
              "twitter": "@Event_13",
              "instagram": "@Event_13",
              "contact": "contact@event_13.com",
              "email": "contact@event_13.com",
              "phone": "+331313131313131313",
              "created_at": "2017-12-22T14:40:55.666+01:00",
              "updated_at": "2017-12-22T14:40:55.666+01:00"
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/events/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Créer un évènement [POST /api/v1/events]


+ Request create a new event
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "Event_16",
                "place": "Place_16",
                "website": "www.event_16.com",
                "facebook": "Event_16",
                "twitter": "@Event_16",
                "instagram": "@Event_16",
                "contact": "contact@event_16.com",
                "email": "contact@event_16.com",
                "phone": "+331616161616161616"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 4010,
              "name": "Event_16",
              "place": "Place_16",
              "website": "www.event_16.com",
              "facebook": "Event_16",
              "twitter": "@Event_16",
              "instagram": "@Event_16",
              "contact": "contact@event_16.com",
              "email": "contact@event_16.com",
              "phone": "+331616161616161616",
              "created_at": "2017-12-22T14:40:55.678+01:00",
              "updated_at": "2017-12-22T14:40:55.678+01:00"
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "",
                "place": "Place_18",
                "website": "www.event_18.com",
                "facebook": "Event_18",
                "twitter": "@Event_18",
                "instagram": "@Event_18",
                "contact": "contact@event_18.com",
                "email": "contact@event_18.com",
                "phone": "+331818181818181818"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/events`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un évènement [PUT /api/v1/events/{id}]

+ Parameters
    + id: `4013` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/events/4013`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "Event_20",
                "place": "Place_21",
                "website": "www.event_21.com",
                "facebook": "Event_21",
                "twitter": "@Event_21",
                "instagram": "@Event_21",
                "contact": "contact@event_21.com",
                "email": "contact@event_21.com",
                "phone": "+332121212121212121"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 4013,
              "name": "Event_20",
              "place": "Place_21",
              "website": "www.event_21.com",
              "facebook": "Event_21",
              "twitter": "@Event_21",
              "instagram": "@Event_21",
              "contact": "contact@event_21.com",
              "email": "contact@event_21.com",
              "phone": "+332121212121212121",
              "created_at": "2017-12-22T14:40:55.691+01:00",
              "updated_at": "2017-12-22T14:40:55.694+01:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/events/4014`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": {
                "name": "",
                "place": "Place_23",
                "website": "www.event_23.com",
                "facebook": "Event_23",
                "twitter": "@Event_23",
                "instagram": "@Event_23",
                "contact": "contact@event_23.com",
                "email": "contact@event_23.com",
                "phone": "+332323232323232323"
              }
            }

+ Response 304

    + Body



+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/events/4015`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "event": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer un évènement [DELETE /api/v1/events/{id}]

+ Parameters
    + id: `4016` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/events/4016`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/events/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body




## Éditions [/editions]
Une édition d'un évènement contient plusieurs courses.

### Obtenir toutes les éditions d'un évènement [GET /api/v1/events/{event_id}/editions]

+ Parameters
    + event_id: `3995` (number, required)

+ Request return a list of editions for an event
**GET**&nbsp;&nbsp;`/api/v1/events/3995/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": 2407,
                "date": "2017-12-22",
                "description": "Desc_1",
                "email_sender": "contact@race_1.com",
                "hashtag": "#HASH1",
                "results_url": "results_1.com",
                "sms_message": "Congratulation for Race1",
                "template": "Template_1",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race1.com",
                "external_link_button": "Button_race1.com",
                "created_at": "2017-12-22T14:40:54.905+01:00",
                "updated_at": "2017-12-22T14:40:54.905+01:00",
                "raw_results_file_name": "raw_Race1",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race1",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "event": {
                  "id": 3995,
                  "name": "Event_1",
                  "place": "Place_1",
                  "website": "www.event_1.com",
                  "facebook": "Event_1",
                  "twitter": "@Event_1",
                  "instagram": "@Event_1",
                  "contact": "contact@event_1.com",
                  "email": "contact@event_1.com",
                  "phone": "+3311111111",
                  "created_at": "2017-12-22T14:40:54.875+01:00",
                  "updated_at": "2017-12-22T14:40:54.875+01:00"
                }
              }
            ]

### Obtenir une édition [GET /api/v1/editions/{id}]

+ Parameters
    + id: `2408` (number, required)

+ Request return the edition
**GET**&nbsp;&nbsp;`/api/v1/editions/2408`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 2408,
              "date": "2017-12-22",
              "description": "Desc_2",
              "email_sender": "contact@race_2.com",
              "hashtag": "#HASH2",
              "results_url": "results_2.com",
              "sms_message": "Congratulation for Race2",
              "template": "Template_2",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race2.com",
              "external_link_button": "Button_race2.com",
              "created_at": "2017-12-22T14:40:54.983+01:00",
              "updated_at": "2017-12-22T14:40:54.983+01:00",
              "raw_results_file_name": "raw_Race2",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race2",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 3996,
                "name": "Event_2",
                "place": "Place_2",
                "website": "www.event_2.com",
                "facebook": "Event_2",
                "twitter": "@Event_2",
                "instagram": "@Event_2",
                "contact": "contact@event_2.com",
                "email": "contact@event_2.com",
                "phone": "+3322222222",
                "created_at": "2017-12-22T14:40:54.980+01:00",
                "updated_at": "2017-12-22T14:40:54.980+01:00"
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/editions/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une édition à un évènement [POST /api/v1/events/{event_id}/editions]

+ Parameters
    + event_id: `3998` (number, required)

+ Request create a new edition for an event
**POST**&nbsp;&nbsp;`/api/v1/events/3998/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T13:40:55+00:00",
                "description": "Desc_5",
                "email_sender": "contact@race_5.com",
                "email_name": "Race_5",
                "hashtag": "#HASH5",
                "results_url": "results_5.com",
                "sms_message": "Congratulation for Race5",
                "raw_results_file_name": "raw_Race5",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race5",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_5",
                "external_link": "Race5.com",
                "external_link_button": "Button_race5.com"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 2411,
              "date": "2017-12-22",
              "description": "Desc_5",
              "email_sender": "contact@race_5.com",
              "hashtag": "#HASH5",
              "results_url": "results_5.com",
              "sms_message": "Congratulation for Race5",
              "template": "Template_5",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race5.com",
              "external_link_button": "Button_race5.com",
              "created_at": "2017-12-22T14:40:55.018+01:00",
              "updated_at": "2017-12-22T14:40:55.018+01:00",
              "raw_results_file_name": "raw_Race5",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race5",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 3998,
                "name": "Event_4",
                "place": "Place_4",
                "website": "www.event_4.com",
                "facebook": "Event_4",
                "twitter": "@Event_4",
                "instagram": "@Event_4",
                "contact": "contact@event_4.com",
                "email": "contact@event_4.com",
                "phone": "+3344444444",
                "created_at": "2017-12-22T14:40:55.003+01:00",
                "updated_at": "2017-12-22T14:40:55.003+01:00"
              }
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/events/3999/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T13:40:55+00:00",
                "description": "Desc_7",
                "email_sender": "contact@race_7.com",
                "email_name": "Race_7",
                "hashtag": "#HASH7",
                "results_url": "results_7.com",
                "sms_message": "Congratulation for Race7",
                "raw_results_file_name": "raw_Race7",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race7",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": null,
                "external_link": "Race7.com",
                "external_link_button": "Button_race7.com"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/events/4000/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T13:40:55+00:00",
                "description": "Desc_10",
                "email_sender": "contact@race_10.com",
                "email_name": "Race_10",
                "hashtag": "#HASH10",
                "results_url": "results_10.com",
                "sms_message": "Congratulation for Race10",
                "raw_results_file_name": "raw_Race10",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race10",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_9",
                "external_link": "Race10.com",
                "external_link_button": "Button_race10.com"
              }
            }

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une édition [PUT /api/v1/editions/{id}]

+ Parameters
    + id: `2415` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/editions/2415`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T13:40:55+00:00",
                "description": "Desc_12",
                "email_sender": "contact@race_12.com",
                "email_name": "Race_12",
                "hashtag": "#HASH12",
                "results_url": "results_12.com",
                "sms_message": "Congratulation for Race12",
                "raw_results_file_name": "raw_Race12",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race12",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_11",
                "external_link": "Race12.com",
                "external_link_button": "Button_race12.com"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 2415,
              "date": "2017-12-22",
              "description": "Desc_12",
              "email_sender": "contact@race_12.com",
              "hashtag": "#HASH12",
              "results_url": "results_12.com",
              "sms_message": "Congratulation for Race12",
              "template": "Template_11",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race12.com",
              "external_link_button": "Button_race12.com",
              "created_at": "2017-12-22T14:40:55.070+01:00",
              "updated_at": "2017-12-22T14:40:55.075+01:00",
              "raw_results_file_name": "raw_Race12",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race12",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 4002,
                "name": "Event_8",
                "place": "Place_8",
                "website": "www.event_8.com",
                "facebook": "Event_8",
                "twitter": "@Event_8",
                "instagram": "@Event_8",
                "contact": "contact@event_8.com",
                "email": "contact@event_8.com",
                "phone": "+3388888888",
                "created_at": "2017-12-22T14:40:55.067+01:00",
                "updated_at": "2017-12-22T14:40:55.067+01:00"
              }
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/editions/2416`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2017-12-22T13:40:55+00:00",
                "description": "Desc_14",
                "email_sender": "contact@race_14.com",
                "email_name": "Race_14",
                "hashtag": "#HASH14",
                "results_url": "results_14.com",
                "sms_message": "Congratulation for Race14",
                "raw_results_file_name": "raw_Race14",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race14",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": null,
                "external_link": "Race14.com",
                "external_link_button": "Button_race14.com"
              }
            }

+ Response 304

    + Body



### Supprimer une édition [DELETE /api/v1/editions/{id}]

+ Parameters
    + id: `2417` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/editions/2417`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/editions/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body




## Photos [/photos]
Photos prises lors de course. La photo n'est pas nécessairement associé à un coureur de la base (runner)

### Obtenir toutes les photos d'une course ou d'une édition [GET /api/v1/races/{race_id}/photos]

+ Parameters
    + race_id: `34237a7a-dd17-45ca-b9c3-a8bba2a7c689` (string, required)

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/races/34237a7a-dd17-45ca-b9c3-a8bba2a7c689/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "photos": {
                  "id": "1eb4161f-7dd6-4186-b8b9-3f30cb7e24d2",
                  "race_id": "34237a7a-dd17-45ca-b9c3-a8bba2a7c689",
                  "suggested_bibs": "Suggested_bib_1",
                  "bib": "Bib_1",
                  "created_at": "2017-12-22T14:40:55.766+01:00",
                  "updated_at": "2017-12-22T14:40:55.766+01:00",
                  "image_file_name": "test_1.jpg",
                  "image_content_type": "image/jpg",
                  "image_file_size": 19024,
                  "image_updated_at": "2017-12-22T14:40:55.000+01:00",
                  "edition_id": 2420
                }
              }
            ]

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/editions/2421/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir une photo [GET /api/v1/photos/{id}]

+ Parameters
    + id: `df376013-08f5-4520-8959-af7cac16c74b` (string, required)

+ Request return the photo
**GET**&nbsp;&nbsp;`/api/v1/photos/df376013-08f5-4520-8959-af7cac16c74b`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "df376013-08f5-4520-8959-af7cac16c74b",
              "race_id": "212a8088-f7f2-4f60-b789-b93e0aca1377",
              "suggested_bibs": "Suggested_bib_3",
              "bib": "Bib_3",
              "created_at": "2017-12-22T14:40:55.809+01:00",
              "updated_at": "2017-12-22T14:40:55.809+01:00",
              "image_file_name": "test_3.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T14:40:55.000+01:00",
              "edition_id": 2424
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/photos/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une photo à une course ou à une édition [POST /api/v1/races/{race_id}/photos]

+ Parameters
    + race_id: `c0bac509-33af-4a8a-9fe5-f7433917526a` (string, required)

+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/races/c0bac509-33af-4a8a-9fe5-f7433917526a/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_6",
                "bib": "Bib_6",
                "image_file_name": "test_6.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T13:40:55+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "11e4b5b5-8281-4e41-ac97-c5ef6ed2f9d9",
              "race_id": "c0bac509-33af-4a8a-9fe5-f7433917526a",
              "suggested_bibs": "Suggested_bib_6",
              "bib": "Bib_6",
              "created_at": "2017-12-22T14:40:55.856+01:00",
              "updated_at": "2017-12-22T14:40:55.856+01:00",
              "image_file_name": "test_6.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T14:40:55.000+01:00",
              "edition_id": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/races/7c38367e-62e5-46e1-a29b-f9a5b34e68fc/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/editions/2431/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_9",
                "bib": "Bib_9",
                "image_file_name": "test_9.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T13:40:55+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "241d2497-d4de-4614-a922-c5204646d1d3",
              "race_id": null,
              "suggested_bibs": "Suggested_bib_9",
              "bib": "Bib_9",
              "created_at": "2017-12-22T14:40:55.896+01:00",
              "updated_at": "2017-12-22T14:40:55.896+01:00",
              "image_file_name": "test_9.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T14:40:55.000+01:00",
              "edition_id": 2431
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2433/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une photo [PUT /api/v1/photos/{id}]

+ Parameters
    + id: `3707e090-8cea-4b01-b784-72c98cd875ee` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/photos/3707e090-8cea-4b01-b784-72c98cd875ee`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": {
                "suggested_bibs": "Suggested_bib_12",
                "bib": "Bib_12",
                "image_file_name": "test_12.jpg",
                "image_content_type": "image/jpg",
                "image_file_size": 19024,
                "image_updated_at": "2017-12-22T13:40:55+00:00"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "3707e090-8cea-4b01-b784-72c98cd875ee",
              "suggested_bibs": "Suggested_bib_12",
              "bib": "Bib_12",
              "image_file_name": "test_12.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2017-12-22T14:40:55.000+01:00",
              "edition_id": 2436,
              "race_id": "ac6afec3-58c0-48e1-9119-6a92fbd6f2b6",
              "created_at": "2017-12-22T14:40:55.934+01:00",
              "updated_at": "2017-12-22T14:40:55.940+01:00"
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/photos/92046940-23de-4da0-bfe0-1eeafe0c1426`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "photo": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une photo [DELETE /api/v1/photos/{id}]

+ Parameters
    + id: `7fee42dc-faf0-41d4-bfb3-1754c7c45bb3` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/photos/7fee42dc-faf0-41d4-bfb3-1754c7c45bb3`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/photos/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Courses [/races]
Une course contient plusieurs résultats.

### Obtenir toutes les courses d'une édition [GET /api/v1/editions/{edition_id}/races]

+ Parameters
    + edition_id: `2443` (number, required)

+ Request return a list of races for an edition
**GET**&nbsp;&nbsp;`/api/v1/editions/2443/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "cc95fb4a-575b-4eef-82fd-0f6db6112d6f",
                "name": "Race_13",
                "date": "2017-12-22",
                "email_sender": "contact@race_13.com",
                "hashtag": "#HASH13",
                "results_url": "results_13.com",
                "sms_message": "Congratulation for Race13",
                "template": "Template_13",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race13.com",
                "external_link_button": "Button_race13.com",
                "created_at": "2017-12-22T14:40:56.067+01:00",
                "updated_at": "2017-12-22T14:40:56.067+01:00",
                "raw_results_file_name": "raw_Race13",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race13",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 13,
                "category": "Category_13",
                "department": "Department_13",
                "edition": {
                  "id": 2443,
                  "date": "2017-12-22",
                  "description": "Desc_41",
                  "email_sender": "contact@race_41.com",
                  "hashtag": "#HASH41",
                  "results_url": "results_41.com",
                  "sms_message": "Congratulation for Race41",
                  "template": "Template_39",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race41.com",
                  "external_link_button": "Button_race41.com",
                  "created_at": "2017-12-22T14:40:56.065+01:00",
                  "updated_at": "2017-12-22T14:40:56.065+01:00",
                  "raw_results_file_name": "raw_Race41",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race41",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null
                }
              }
            ]

### Obtenir une course [GET /api/v1/races/{id}]

+ Parameters
    + id: `16484933-729b-4163-9b48-f8cdd9135216` (string, required)

+ Request return the race
**GET**&nbsp;&nbsp;`/api/v1/races/16484933-729b-4163-9b48-f8cdd9135216`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "16484933-729b-4163-9b48-f8cdd9135216",
              "name": "Race_14",
              "date": "2017-12-22",
              "email_sender": "contact@race_14.com",
              "hashtag": "#HASH14",
              "results_url": "results_14.com",
              "sms_message": "Congratulation for Race14",
              "template": "Template_14",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race14.com",
              "external_link_button": "Button_race14.com",
              "created_at": "2017-12-22T14:40:56.084+01:00",
              "updated_at": "2017-12-22T14:40:56.084+01:00",
              "raw_results_file_name": "raw_Race14",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race14",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 14,
              "category": "Category_14",
              "department": "Department_14",
              "edition": {
                "id": 2444,
                "date": "2017-12-22",
                "description": "Desc_42",
                "email_sender": "contact@race_42.com",
                "hashtag": "#HASH42",
                "results_url": "results_42.com",
                "sms_message": "Congratulation for Race42",
                "template": "Template_40",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race42.com",
                "external_link_button": "Button_race42.com",
                "created_at": "2017-12-22T14:40:56.082+01:00",
                "updated_at": "2017-12-22T14:40:56.082+01:00",
                "raw_results_file_name": "raw_Race42",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race42",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/races/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une course à une édition [POST /api/v1/editions/{edition_id}/races]

+ Parameters
    + edition_id: `2446` (number, required)

+ Request create a new race for an edition
**POST**&nbsp;&nbsp;`/api/v1/editions/2446/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_17",
                "email_sender": "contact@race_17.com",
                "email_name": "Race_17",
                "date": "2017-12-22T13:40:56+00:00",
                "hashtag": "#HASH17",
                "results_url": "results_17.com",
                "sms_message": "Congratulation for Race17",
                "raw_results_file_name": "raw_Race17",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race17",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_17",
                "external_link": "Race17.com",
                "external_link_button": "Button_race17.com",
                "coef": "17",
                "category": "Category_17",
                "department": "Department_17"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "5ffc059e-ea64-40f4-9d34-f50e24f080d5",
              "name": "Race_17",
              "date": "2017-12-22",
              "email_sender": "contact@race_17.com",
              "hashtag": "#HASH17",
              "results_url": "results_17.com",
              "sms_message": "Congratulation for Race17",
              "template": "Template_17",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race17.com",
              "external_link_button": "Button_race17.com",
              "created_at": "2017-12-22T14:40:56.112+01:00",
              "updated_at": "2017-12-22T14:40:56.112+01:00",
              "raw_results_file_name": "raw_Race17",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race17",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 17,
              "category": "Category_17",
              "department": "Department_17",
              "edition": {
                "id": 2446,
                "date": "2017-12-22",
                "description": "Desc_44",
                "email_sender": "contact@race_44.com",
                "hashtag": "#HASH44",
                "results_url": "results_44.com",
                "sms_message": "Congratulation for Race44",
                "template": "Template_42",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race44.com",
                "external_link_button": "Button_race44.com",
                "created_at": "2017-12-22T14:40:56.104+01:00",
                "updated_at": "2017-12-22T14:40:56.104+01:00",
                "raw_results_file_name": "raw_Race44",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race44",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2447/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une course [PUT /api/v1/races/{id}]

+ Parameters
    + id: `b95452f0-5b54-4e97-8641-a2559aef829a` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/races/b95452f0-5b54-4e97-8641-a2559aef829a`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_20",
                "email_sender": "contact@race_20.com",
                "email_name": "Race_20",
                "date": "2017-12-22T13:40:56+00:00",
                "hashtag": "#HASH20",
                "results_url": "results_20.com",
                "sms_message": "Congratulation for Race20",
                "raw_results_file_name": "raw_Race20",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "background_image_file_name": "raw_Race20",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "template": "Template_20",
                "external_link": "Race20.com",
                "external_link_button": "Button_race20.com",
                "coef": "20",
                "category": "Category_20",
                "department": "Department_20"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "b95452f0-5b54-4e97-8641-a2559aef829a",
              "name": "Race_20",
              "date": "2017-12-22",
              "email_sender": "contact@race_20.com",
              "hashtag": "#HASH20",
              "results_url": "results_20.com",
              "sms_message": "Congratulation for Race20",
              "template": "Template_20",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race20.com",
              "external_link_button": "Button_race20.com",
              "created_at": "2017-12-22T14:40:56.132+01:00",
              "updated_at": "2017-12-22T14:40:56.138+01:00",
              "raw_results_file_name": "raw_Race20",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race20",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "coef": 20,
              "category": "Category_20",
              "department": "Department_20",
              "edition": {
                "id": 2448,
                "date": "2017-12-22",
                "description": "Desc_46",
                "email_sender": "contact@race_46.com",
                "hashtag": "#HASH46",
                "results_url": "results_46.com",
                "sms_message": "Congratulation for Race46",
                "template": "Template_44",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race46.com",
                "external_link_button": "Button_race46.com",
                "created_at": "2017-12-22T14:40:56.129+01:00",
                "updated_at": "2017-12-22T14:40:56.129+01:00",
                "raw_results_file_name": "raw_Race46",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race46",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/races/fafa78b6-12e8-4012-be22-2b041971eac3`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une course [DELETE /api/v1/races/{id}]

+ Parameters
    + id: `79e6c711-b237-4f3e-9b1f-7889e3f17dce` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/races/79e6c711-b237-4f3e-9b1f-7889e3f17dce`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/races/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



## Résultats [/results]
Résultat d'un coureur pour une course donnée. Attention ! Les résultats peuvent être associés à des coureurs qui ne sont pas dans la base coureurs !

### Obtenir toutes les résultats d'une course, d'une édition ou d'un coureur [GET /api/v1/races/{race_id}/results]

+ Parameters
    + race_id: `52a1cbba-f7d1-43a9-955f-21705366153a` (string, required)

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/races/52a1cbba-f7d1-43a9-955f-21705366153a/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "cffea934-be64-4277-8f59-238bc133e2cd",
                "phone": "+3311111111",
                "mail": "contact@1.com",
                "rank": 1,
                "name": "Result_1",
                "country": "FR",
                "bib": "Bib_1",
                "categ_rank": 1,
                "categ": "Categ_1",
                "sex_rank": 1,
                "time": "1'1''1'",
                "speed": "1km/h",
                "message": "Congrats ! 1",
                "race_detail": "Race 1",
                "created_at": "2017-12-22T14:40:56.213+01:00",
                "updated_at": "2017-12-22T14:40:56.213+01:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_1.com",
                "points": 1,
                "first_name": "First_1",
                "last_name": "Last_1",
                "dob": "2017-12-22T14:40:56.000+01:00",
                "race": {
                  "id": "52a1cbba-f7d1-43a9-955f-21705366153a",
                  "name": "Race_24",
                  "date": "2017-12-22",
                  "email_sender": "contact@race_24.com",
                  "hashtag": "#HASH24",
                  "results_url": "results_24.com",
                  "sms_message": "Congratulation for Race24",
                  "template": "Template_24",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race24.com",
                  "external_link_button": "Button_race24.com",
                  "created_at": "2017-12-22T14:40:56.181+01:00",
                  "updated_at": "2017-12-22T14:40:56.181+01:00",
                  "raw_results_file_name": "raw_Race24",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race24",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "coef": 24,
                  "category": "Category_24",
                  "department": "Department_24"
                },
                "edition": null,
                "runner": {
                  "id": 1059,
                  "id_key": "ID_1",
                  "first_name": "First_1",
                  "last_name": "Last_1",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2017-12-22T14:40:56.192+01:00",
                  "updated_at": "2017-12-22T14:40:56.192+01:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/runners/1060/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "686d8faf-4fbf-45ca-9989-9b6e08c547c9",
                "phone": "+3322222222",
                "mail": "contact@2.com",
                "rank": 2,
                "name": "Result_2",
                "country": "FR",
                "bib": "Bib_2",
                "categ_rank": 2,
                "categ": "Categ_2",
                "sex_rank": 2,
                "time": "2'2''2'",
                "speed": "2km/h",
                "message": "Congrats ! 2",
                "race_detail": "Race 2",
                "created_at": "2017-12-22T14:40:56.247+01:00",
                "updated_at": "2017-12-22T14:40:56.247+01:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_2.com",
                "points": 2,
                "first_name": "First_2",
                "last_name": "Last_2",
                "dob": "2017-12-22T14:40:56.000+01:00",
                "race": {
                  "id": "09a5c5ce-b9b2-4a2a-bf20-fc1af2d7c3ca",
                  "name": "Race_25",
                  "date": "2017-12-22",
                  "email_sender": "contact@race_25.com",
                  "hashtag": "#HASH25",
                  "results_url": "results_25.com",
                  "sms_message": "Congratulation for Race25",
                  "template": "Template_25",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race25.com",
                  "external_link_button": "Button_race25.com",
                  "created_at": "2017-12-22T14:40:56.242+01:00",
                  "updated_at": "2017-12-22T14:40:56.242+01:00",
                  "raw_results_file_name": "raw_Race25",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race25",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "coef": 25,
                  "category": "Category_25",
                  "department": "Department_25"
                },
                "edition": null,
                "runner": {
                  "id": 1060,
                  "id_key": "ID_2",
                  "first_name": "First_2",
                  "last_name": "Last_2",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2017-12-22T14:40:56.245+01:00",
                  "updated_at": "2017-12-22T14:40:56.245+01:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/editions/2454/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir un résultat [GET /api/v1/results/{id}]

+ Parameters
    + id: `a53ab541-0156-4f35-94d1-0826e72130c9` (string, required)

+ Request return the result
**GET**&nbsp;&nbsp;`/api/v1/results/a53ab541-0156-4f35-94d1-0826e72130c9`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "a53ab541-0156-4f35-94d1-0826e72130c9",
              "phone": "+3344444444",
              "mail": "contact@4.com",
              "rank": 4,
              "name": "Result_4",
              "country": "FR",
              "bib": "Bib_4",
              "categ_rank": 4,
              "categ": "Categ_4",
              "sex_rank": 4,
              "time": "4'4''4'",
              "speed": "4km/h",
              "message": "Congrats ! 4",
              "race_detail": "Race 4",
              "created_at": "2017-12-22T14:40:56.283+01:00",
              "updated_at": "2017-12-22T14:40:56.283+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_4.com",
              "points": 4,
              "first_name": "First_4",
              "last_name": "Last_4",
              "dob": "2017-12-22T14:40:56.000+01:00",
              "race": {
                "id": "dbecd516-5288-4fb8-8054-5500120fa402",
                "name": "Race_27",
                "date": "2017-12-22",
                "email_sender": "contact@race_27.com",
                "hashtag": "#HASH27",
                "results_url": "results_27.com",
                "sms_message": "Congratulation for Race27",
                "template": "Template_27",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race27.com",
                "external_link_button": "Button_race27.com",
                "created_at": "2017-12-22T14:40:56.278+01:00",
                "updated_at": "2017-12-22T14:40:56.278+01:00",
                "raw_results_file_name": "raw_Race27",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race27",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 27,
                "category": "Category_27",
                "department": "Department_27"
              },
              "edition": null,
              "runner": {
                "id": 1062,
                "id_key": "ID_4",
                "first_name": "First_4",
                "last_name": "Last_4",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T14:40:56.281+01:00",
                "updated_at": "2017-12-22T14:40:56.281+01:00"
              }
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/results/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter un résultat à une course, une édition ou un coureur [POST /api/v1/races/{race_id}/results]

+ Parameters
    + race_id: `ddea0317-f4ad-4a54-97c4-9d9e142804ff` (string, required)

+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/races/ddea0317-f4ad-4a54-97c4-9d9e142804ff/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_7",
                "phone": "+3377777777",
                "mail": "contact@7.com",
                "rank": "7",
                "country": "FR",
                "bib": "Bib_7",
                "categ_rank": "7",
                "categ": "Categ_7",
                "sex_rank": "7",
                "sex": "M",
                "time": "7'7''7'",
                "speed": "7km/h",
                "message": "Congrats ! 7",
                "race_detail": "Race 7",
                "diploma_url": "www.result_7.com",
                "points": "7",
                "first_name": "First_7",
                "last_name": "Last_7",
                "dob": "2017-12-22T13:40:56+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "37b6ce9d-f49e-43c5-9723-1ef5d5e0d05c",
              "phone": "+3377777777",
              "mail": "contact@7.com",
              "rank": null,
              "name": "Result_7",
              "country": "FR",
              "bib": "Bib_7",
              "categ_rank": 7,
              "categ": "Categ_7",
              "sex_rank": 7,
              "time": "7'7''7'",
              "speed": "7km/h",
              "message": "Congrats ! 7",
              "race_detail": "Race 7",
              "created_at": "2017-12-22T14:40:56.323+01:00",
              "updated_at": "2017-12-22T14:40:56.323+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_7.com",
              "points": 7,
              "first_name": "First_7",
              "last_name": "Last_7",
              "dob": "2017-12-22T14:40:56.000+01:00",
              "race": {
                "id": "ddea0317-f4ad-4a54-97c4-9d9e142804ff",
                "name": "Race_29",
                "date": "2017-12-22",
                "email_sender": "contact@race_29.com",
                "hashtag": "#HASH29",
                "results_url": "results_29.com",
                "sms_message": "Congratulation for Race29",
                "template": "Template_29",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race29.com",
                "external_link_button": "Button_race29.com",
                "created_at": "2017-12-22T14:40:56.311+01:00",
                "updated_at": "2017-12-22T14:40:56.311+01:00",
                "raw_results_file_name": "raw_Race29",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race29",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 29,
                "category": "Category_29",
                "department": "Department_29"
              },
              "edition": null,
              "runner": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/races/2a422cac-a444-463b-8ab2-92c9acb34438/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/runners/1066/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_10",
                "phone": "+331010101010101010",
                "mail": "contact@10.com",
                "rank": "10",
                "country": "FR",
                "bib": "Bib_10",
                "categ_rank": "10",
                "categ": "Categ_10",
                "sex_rank": "10",
                "sex": "M",
                "time": "10'10''10'",
                "speed": "10km/h",
                "message": "Congrats ! 10",
                "race_detail": "Race 10",
                "diploma_url": "www.result_10.com",
                "points": "10",
                "first_name": "First_10",
                "last_name": "Last_10",
                "dob": "2017-12-22T13:40:56+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "db771948-5d52-4ad0-b7ad-c28fc8b7fca8",
              "phone": "+331010101010101010",
              "mail": "contact@10.com",
              "rank": null,
              "name": "Result_10",
              "country": "FR",
              "bib": "Bib_10",
              "categ_rank": 10,
              "categ": "Categ_10",
              "sex_rank": 10,
              "time": "10'10''10'",
              "speed": "10km/h",
              "message": "Congrats ! 10",
              "race_detail": "Race 10",
              "created_at": "2017-12-22T14:40:56.359+01:00",
              "updated_at": "2017-12-22T14:40:56.359+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_10.com",
              "points": 10,
              "first_name": "First_10",
              "last_name": "Last_10",
              "dob": "2017-12-22T14:40:56.000+01:00",
              "race": null,
              "edition": null,
              "runner": {
                "id": 1066,
                "id_key": "ID_8",
                "first_name": "First_8",
                "last_name": "Last_8",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T14:40:56.350+01:00",
                "updated_at": "2017-12-22T14:40:56.350+01:00"
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/runners/1067/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/editions/2461/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_13",
                "phone": "+331313131313131313",
                "mail": "contact@13.com",
                "rank": "13",
                "country": "FR",
                "bib": "Bib_13",
                "categ_rank": "13",
                "categ": "Categ_13",
                "sex_rank": "13",
                "sex": "M",
                "time": "13'13''13'",
                "speed": "13km/h",
                "message": "Congrats ! 13",
                "race_detail": "Race 13",
                "diploma_url": "www.result_13.com",
                "points": "13",
                "first_name": "First_13",
                "last_name": "Last_13",
                "dob": "2017-12-22T13:40:56+00:00"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "e2b3d188-5579-49fd-97fd-173dc5927b51",
              "phone": "+331313131313131313",
              "mail": "contact@13.com",
              "rank": null,
              "name": "Result_13",
              "country": "FR",
              "bib": "Bib_13",
              "categ_rank": 13,
              "categ": "Categ_13",
              "sex_rank": 13,
              "time": "13'13''13'",
              "speed": "13km/h",
              "message": "Congrats ! 13",
              "race_detail": "Race 13",
              "created_at": "2017-12-22T14:40:56.396+01:00",
              "updated_at": "2017-12-22T14:40:56.396+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_13.com",
              "points": 13,
              "first_name": "First_13",
              "last_name": "Last_13",
              "dob": "2017-12-22T14:40:56.000+01:00",
              "race": null,
              "edition": {
                "id": 2461,
                "date": "2017-12-22",
                "description": "Desc_59",
                "email_sender": "contact@race_59.com",
                "hashtag": "#HASH59",
                "results_url": "results_59.com",
                "sms_message": "Congratulation for Race59",
                "template": "Template_57",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race59.com",
                "external_link_button": "Button_race59.com",
                "created_at": "2017-12-22T14:40:56.382+01:00",
                "updated_at": "2017-12-22T14:40:56.382+01:00",
                "raw_results_file_name": "raw_Race59",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race59",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              },
              "runner": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/2462/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un résultat [PUT /api/v1/results/{id}]

+ Parameters
    + id: `644355a9-fbc4-4b42-8db7-e4d52d5fc58f` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/results/644355a9-fbc4-4b42-8db7-e4d52d5fc58f`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": {
                "name": "Result_16",
                "phone": "+331616161616161616",
                "mail": "contact@16.com",
                "rank": "16",
                "country": "FR",
                "bib": "Bib_16",
                "categ_rank": "16",
                "categ": "Categ_16",
                "sex_rank": "16",
                "sex": "M",
                "time": "16'16''16'",
                "speed": "16km/h",
                "message": "Congrats ! 16",
                "race_detail": "Race 16",
                "diploma_url": "www.result_16.com",
                "points": "16",
                "first_name": "First_16",
                "last_name": "Last_16",
                "dob": "2017-12-22T13:40:56+00:00"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "644355a9-fbc4-4b42-8db7-e4d52d5fc58f",
              "phone": "+331616161616161616",
              "mail": "contact@16.com",
              "rank": 15,
              "name": "Result_16",
              "country": "FR",
              "bib": "Bib_16",
              "categ_rank": 16,
              "categ": "Categ_16",
              "sex_rank": 16,
              "time": "16'16''16'",
              "speed": "16km/h",
              "message": "Congrats ! 16",
              "race_detail": "Race 16",
              "created_at": "2017-12-22T14:40:56.426+01:00",
              "updated_at": "2017-12-22T14:40:56.431+01:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_16.com",
              "points": 16,
              "first_name": "First_16",
              "last_name": "Last_16",
              "dob": "2017-12-22T14:40:56.000+01:00",
              "race": {
                "id": "63c9312c-f560-403d-811b-1fdf4ade4f93",
                "name": "Race_35",
                "date": "2017-12-22",
                "email_sender": "contact@race_35.com",
                "hashtag": "#HASH35",
                "results_url": "results_35.com",
                "sms_message": "Congratulation for Race35",
                "template": "Template_35",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race35.com",
                "external_link_button": "Button_race35.com",
                "created_at": "2017-12-22T14:40:56.421+01:00",
                "updated_at": "2017-12-22T14:40:56.421+01:00",
                "raw_results_file_name": "raw_Race35",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race35",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "coef": 35,
                "category": "Category_35",
                "department": "Department_35"
              },
              "edition": null,
              "runner": {
                "id": 1070,
                "id_key": "ID_12",
                "first_name": "First_12",
                "last_name": "Last_12",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T14:40:56.424+01:00",
                "updated_at": "2017-12-22T14:40:56.424+01:00"
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/results/95e90050-9341-47c6-a89f-86ff8363d9c5`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "result": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer un résultat [DELETE /api/v1/results/{id}]

+ Parameters
    + id: `c47ab621-5995-4f7d-be2c-1e739367faa0` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/results/c47ab621-5995-4f7d-be2c-1e739367faa0`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/results/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



# Group API des coureurs


## Coureur [/runner]
Un coureur possède plusieurs résultats de courses et plusieurs photos.

### Obtenir tous les coureurs [GET /api/v1/runners]


+ Request return a list of runners
**GET**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": 1074,
                "id_key": "ID_16",
                "first_name": "First_16",
                "last_name": "Last_16",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2017-12-22T14:40:56.495+01:00",
                "updated_at": "2017-12-22T14:40:56.495+01:00"
              }
            ]

### Obtenir un coureur [GET /api/v1/runners/{id}]

+ Parameters
    + id: `1075` (number, required)

+ Request return the runner
**GET**&nbsp;&nbsp;`/api/v1/runners/1075`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 1075,
              "id_key": "ID_17",
              "first_name": "First_17",
              "last_name": "Last_17",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T14:40:56.503+01:00",
              "updated_at": "2017-12-22T14:40:56.503+01:00"
            }

+ Request return Not found
**GET**&nbsp;&nbsp;`/api/v1/runners/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Ajouter une coureur [POST /api/v1/runners]


+ Request create a new runner
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_20",
                "first_name": "First_20",
                "last_name": "Last_20",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 1078,
              "id_key": "ID_20",
              "first_name": "First_20",
              "last_name": "Last_20",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T14:40:56.516+01:00",
              "updated_at": "2017-12-22T14:40:56.516+01:00"
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_22",
                "first_name": "",
                "last_name": "Last_22",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/runners`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un coureur [PUT /api/v1/runners/{id}]

+ Parameters
    + id: `1081` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/runners/1081`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_25",
                "first_name": "First_24",
                "last_name": "Last_25",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 1081,
              "id_key": "ID_25",
              "first_name": "First_24",
              "last_name": "Last_25",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2017-12-22T14:40:56.531+01:00",
              "updated_at": "2017-12-22T14:40:56.536+01:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/runners/1082`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": {
                "id_key": "ID_27",
                "first_name": "",
                "last_name": "Last_27",
                "dob": "2017-11-16 11:05:06",
                "department": "40",
                "sex": "M"
              }
            }

+ Response 304

    + Body



+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/runners/1083`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "runner": null
            }

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Supprimer une coureur [DELETE /api/v1/runners/{id}]

+ Parameters
    + id: `1084` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/runners/1084`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 204

    + Body



+ Request return Not Found
**DELETE**&nbsp;&nbsp;`/api/v1/runners/-1`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body
