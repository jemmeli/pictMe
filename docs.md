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

## Éditions [/editions]
Une édition d'un évènement contient plusieurs courses.

### Obtenir toutes les éditions d'un évènement [GET /api/v1/events/{event_id}/editions]

+ Parameters
    + event_id: `1105` (number, required)

+ Request return a list of editions for an event
**GET**&nbsp;&nbsp;`/api/v1/events/1105/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": 773,
                "date": "2018-09-15",
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
                "created_at": "2018-09-15T16:40:29.768+02:00",
                "updated_at": "2018-09-15T16:40:29.768+02:00",
                "raw_results_file_name": "raw_Race1",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race1",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null,
                "event": {
                  "id": 1105,
                  "name": "Event_1",
                  "place": "Place_1",
                  "website": "www.event_1.com",
                  "facebook": "Event_1",
                  "twitter": "@Event_1",
                  "instagram": "@Event_1",
                  "contact": "contact@event_1.com",
                  "email": "contact@event_1.com",
                  "phone": "+3311111111",
                  "created_at": "2018-09-15T16:40:29.717+02:00",
                  "updated_at": "2018-09-15T16:40:29.717+02:00"
                }
              }
            ]

### Obtenir une édition [GET /api/v1/editions/{id}]

+ Parameters
    + id: `774` (number, required)

+ Request return the edition
**GET**&nbsp;&nbsp;`/api/v1/editions/774`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 774,
              "date": "2018-09-15",
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
              "created_at": "2018-09-15T16:40:29.852+02:00",
              "updated_at": "2018-09-15T16:40:29.852+02:00",
              "raw_results_file_name": "raw_Race2",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race2",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 1106,
                "name": "Event_2",
                "place": "Place_2",
                "website": "www.event_2.com",
                "facebook": "Event_2",
                "twitter": "@Event_2",
                "instagram": "@Event_2",
                "contact": "contact@event_2.com",
                "email": "contact@event_2.com",
                "phone": "+3322222222",
                "created_at": "2018-09-15T16:40:29.848+02:00",
                "updated_at": "2018-09-15T16:40:29.848+02:00"
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
    + event_id: `1108` (number, required)

+ Request create a new edition for an event
**POST**&nbsp;&nbsp;`/api/v1/events/1108/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2018-09-15T16:40:29+02:00",
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
                "external_link_button": "Button_race5.com",
                "sendable_at_home": false,
                "sendable_at_home_price_cents": 0.0,
                "download_chargeable": false,
                "download_chargeable_price_cents": 0.0
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 777,
              "date": "2018-09-15",
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
              "created_at": "2018-09-15T16:40:29.899+02:00",
              "updated_at": "2018-09-15T16:40:29.899+02:00",
              "raw_results_file_name": "raw_Race5",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race5",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 1108,
                "name": "Event_4",
                "place": "Place_4",
                "website": "www.event_4.com",
                "facebook": "Event_4",
                "twitter": "@Event_4",
                "instagram": "@Event_4",
                "contact": "contact@event_4.com",
                "email": "contact@event_4.com",
                "phone": "+3344444444",
                "created_at": "2018-09-15T16:40:29.884+02:00",
                "updated_at": "2018-09-15T16:40:29.884+02:00"
              }
            }

+ Request return Unprocessable entity
**POST**&nbsp;&nbsp;`/api/v1/events/1109/editions`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2018-09-15T16:40:29+02:00",
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
                "external_link_button": "Button_race7.com",
                "sendable_at_home": false,
                "sendable_at_home_price_cents": 0.0,
                "download_chargeable": false,
                "download_chargeable_price_cents": 0.0
              }
            }

+ Response 422

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/events/1110/editions`

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
                "date": "2018-09-15T16:40:29+02:00",
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
                "external_link_button": "Button_race10.com",
                "sendable_at_home": false,
                "sendable_at_home_price_cents": 0.0,
                "download_chargeable": false,
                "download_chargeable_price_cents": 0.0
              }
            }

+ Response 404

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une édition [PUT /api/v1/editions/{id}]

+ Parameters
    + id: `781` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/editions/781`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2018-09-15T16:40:29+02:00",
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
                "external_link_button": "Button_race12.com",
                "sendable_at_home": false,
                "sendable_at_home_price_cents": 0.0,
                "download_chargeable": false,
                "download_chargeable_price_cents": 0.0
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 781,
              "date": "2018-09-15",
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
              "created_at": "2018-09-15T16:40:29.957+02:00",
              "updated_at": "2018-09-15T16:40:29.965+02:00",
              "raw_results_file_name": "raw_Race12",
              "raw_results_content_type": "text/csv",
              "raw_results_file_size": 19024,
              "raw_results_updated_at": null,
              "background_image_file_name": "raw_Race12",
              "background_image_content_type": "image/jpg",
              "background_image_file_size": 19024,
              "background_image_updated_at": null,
              "event": {
                "id": 1112,
                "name": "Event_8",
                "place": "Place_8",
                "website": "www.event_8.com",
                "facebook": "Event_8",
                "twitter": "@Event_8",
                "instagram": "@Event_8",
                "contact": "contact@event_8.com",
                "email": "contact@event_8.com",
                "phone": "+3388888888",
                "created_at": "2018-09-15T16:40:29.952+02:00",
                "updated_at": "2018-09-15T16:40:29.952+02:00"
              }
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/editions/782`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "edition": {
                "date": "2018-09-15T16:40:29+02:00",
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
                "external_link_button": "Button_race14.com",
                "sendable_at_home": false,
                "sendable_at_home_price_cents": 0.0,
                "download_chargeable": false,
                "download_chargeable_price_cents": 0.0
              }
            }

+ Response 304

    + Body



### Supprimer une édition [DELETE /api/v1/editions/{id}]

+ Parameters
    + id: `783` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/editions/783`

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
                "id": 1116,
                "name": "Event_12",
                "place": "Place_12",
                "website": "www.event_12.com",
                "facebook": "Event_12",
                "twitter": "@Event_12",
                "instagram": "@Event_12",
                "contact": "contact@event_12.com",
                "email": "contact@event_12.com",
                "phone": "+331212121212121212",
                "created_at": "2018-09-15T16:40:31.028+02:00",
                "updated_at": "2018-09-15T16:40:31.028+02:00"
              }
            ]

### Obtenir un évènement particulier [GET /api/v1/events/{id}]

+ Parameters
    + id: `1117` (number, required)

+ Request return the event
**GET**&nbsp;&nbsp;`/api/v1/events/1117`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 1117,
              "name": "Event_13",
              "place": "Place_13",
              "website": "www.event_13.com",
              "facebook": "Event_13",
              "twitter": "@Event_13",
              "instagram": "@Event_13",
              "contact": "contact@event_13.com",
              "email": "contact@event_13.com",
              "phone": "+331313131313131313",
              "created_at": "2018-09-15T16:40:31.039+02:00",
              "updated_at": "2018-09-15T16:40:31.039+02:00"
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
              "id": 1120,
              "name": "Event_16",
              "place": "Place_16",
              "website": "www.event_16.com",
              "facebook": "Event_16",
              "twitter": "@Event_16",
              "instagram": "@Event_16",
              "contact": "contact@event_16.com",
              "email": "contact@event_16.com",
              "phone": "+331616161616161616",
              "created_at": "2018-09-15T16:40:31.059+02:00",
              "updated_at": "2018-09-15T16:40:31.059+02:00"
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
    + id: `1123` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/events/1123`

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
              "id": 1123,
              "name": "Event_20",
              "place": "Place_21",
              "website": "www.event_21.com",
              "facebook": "Event_21",
              "twitter": "@Event_21",
              "instagram": "@Event_21",
              "contact": "contact@event_21.com",
              "email": "contact@event_21.com",
              "phone": "+332121212121212121",
              "created_at": "2018-09-15T16:40:31.081+02:00",
              "updated_at": "2018-09-15T16:40:31.088+02:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/events/1124`

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
**PUT**&nbsp;&nbsp;`/api/v1/events/1125`

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
    + id: `1126` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/events/1126`

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



## Photos [/photos]
Photos prises lors de course. La photo n'est pas nécessairement associé à un coureur de la base (runner)

### Obtenir toutes les photos d'une course ou d'une édition [GET /api/v1/races/{race_id}/photos]

+ Parameters
    + race_id: `961f89d9-3bc6-48d4-8fbe-0a88f0705fbd` (string, required)

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/races/961f89d9-3bc6-48d4-8fbe-0a88f0705fbd/photos`

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
                  "id": "2a5f7029-8a46-4c9c-abbd-14d64c480cf6",
                  "race_id": "961f89d9-3bc6-48d4-8fbe-0a88f0705fbd",
                  "suggested_bibs": "Suggested_bib_1",
                  "bib": "Bib_1",
                  "created_at": "2018-09-15T16:40:31.190+02:00",
                  "updated_at": "2018-09-15T16:40:31.190+02:00",
                  "image_file_name": "test_1.jpg",
                  "image_content_type": "image/jpg",
                  "image_file_size": 19024,
                  "image_updated_at": "2018-09-15T16:40:31.000+02:00",
                  "edition_id": null,
                  "direct_image_url": "",
                  "processed": false
                }
              }
            ]

+ Request return its list of photos
**GET**&nbsp;&nbsp;`/api/v1/editions/786/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir une photo [GET /api/v1/photos/{id}]

+ Parameters
    + id: `39e6dce3-9f8a-4218-b850-29afa3b08643` (string, required)

+ Request return the photo
**GET**&nbsp;&nbsp;`/api/v1/photos/39e6dce3-9f8a-4218-b850-29afa3b08643`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "39e6dce3-9f8a-4218-b850-29afa3b08643",
              "race_id": "53d65224-919f-46f4-8d73-22291583b29b",
              "suggested_bibs": "Suggested_bib_3",
              "bib": "Bib_3",
              "created_at": "2018-09-15T16:40:31.244+02:00",
              "updated_at": "2018-09-15T16:40:31.244+02:00",
              "image_file_name": "test_3.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2018-09-15T16:40:31.000+02:00",
              "edition_id": null,
              "direct_image_url": "",
              "processed": false
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
    + race_id: `41794581-adc8-4e4d-b5c7-2098a25acfef` (string, required)

+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/races/41794581-adc8-4e4d-b5c7-2098a25acfef/photos`

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
                "image_updated_at": "2018-09-15T16:40:31+02:00",
                "race": {
                  "id": "41794581-adc8-4e4d-b5c7-2098a25acfef",
                  "name": "Race_5",
                  "email_sender": "contact@race_5.com",
                  "email_name": "Race_5",
                  "date": "2018-09-15",
                  "hashtag": "#HASH5",
                  "results_url": "results_5.com",
                  "sms_message": "Congratulation for Race5",
                  "created_at": "2018-09-15T16:40:31.280+02:00",
                  "updated_at": "2018-09-15T16:40:31.280+02:00",
                  "raw_results_file_name": "raw_Race5",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race5",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_5",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race5.com",
                  "external_link_button": "Button_race5.com",
                  "edition_id": 789,
                  "coef": 5,
                  "category": "Category_5",
                  "department": "Department_5",
                  "race_type": "route"
                }
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "f9bb38c9-5d89-417e-8fc9-cc279ccd4647",
              "race_id": "41794581-adc8-4e4d-b5c7-2098a25acfef",
              "suggested_bibs": "Suggested_bib_6",
              "bib": "Bib_6",
              "created_at": "2018-09-15T16:40:31.294+02:00",
              "updated_at": "2018-09-15T16:40:31.294+02:00",
              "image_file_name": "test_6.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2018-09-15T16:40:31.000+02:00",
              "edition_id": null,
              "direct_image_url": "",
              "processed": false
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/races/7479510e-a69d-4bfe-8575-9ef1abe34bb4/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new photo
**POST**&nbsp;&nbsp;`/api/v1/editions/791/photos`

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
                "image_updated_at": "2018-09-15T16:40:31+02:00",
                "race": {
                  "id": "18a4c164-dc6e-4b1e-9893-c7fde75cdea1",
                  "name": "Race_7",
                  "email_sender": "contact@race_7.com",
                  "email_name": "Race_7",
                  "date": "2018-09-15",
                  "hashtag": "#HASH7",
                  "results_url": "results_7.com",
                  "sms_message": "Congratulation for Race7",
                  "created_at": "2018-09-15T16:40:31.329+02:00",
                  "updated_at": "2018-09-15T16:40:31.329+02:00",
                  "raw_results_file_name": "raw_Race7",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race7",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_7",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race7.com",
                  "external_link_button": "Button_race7.com",
                  "edition_id": 791,
                  "coef": 7,
                  "category": "Category_7",
                  "department": "Department_7",
                  "race_type": "route"
                }
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "ba4c2fcb-e2ba-40db-849b-8527e133a757",
              "race_id": null,
              "suggested_bibs": "Suggested_bib_9",
              "bib": "Bib_9",
              "created_at": "2018-09-15T16:40:31.344+02:00",
              "updated_at": "2018-09-15T16:40:31.344+02:00",
              "image_file_name": "test_9.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2018-09-15T16:40:31.000+02:00",
              "edition_id": 791,
              "direct_image_url": "",
              "processed": false
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/792/photos`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une photo [PUT /api/v1/photos/{id}]

+ Parameters
    + id: `0993b148-d9ae-4f2e-9b4b-4553db6eecd8` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/photos/0993b148-d9ae-4f2e-9b4b-4553db6eecd8`

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
                "image_updated_at": "2018-09-15T16:40:31+02:00",
                "race": {
                  "id": "463403d4-11c3-4192-80ad-1e137fb25ca0",
                  "name": "Race_9",
                  "email_sender": "contact@race_9.com",
                  "email_name": "Race_9",
                  "date": "2018-09-15",
                  "hashtag": "#HASH9",
                  "results_url": "results_9.com",
                  "sms_message": "Congratulation for Race9",
                  "created_at": "2018-09-15T16:40:31.378+02:00",
                  "updated_at": "2018-09-15T16:40:31.378+02:00",
                  "raw_results_file_name": "raw_Race9",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race9",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_9",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race9.com",
                  "external_link_button": "Button_race9.com",
                  "edition_id": 793,
                  "coef": 9,
                  "category": "Category_9",
                  "department": "Department_9",
                  "race_type": "route"
                }
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "0993b148-d9ae-4f2e-9b4b-4553db6eecd8",
              "suggested_bibs": "Suggested_bib_12",
              "bib": "Bib_12",
              "image_file_name": "test_12.jpg",
              "image_content_type": "image/jpg",
              "image_file_size": 19024,
              "image_updated_at": "2018-09-15T16:40:31.000+02:00",
              "edition_id": null,
              "direct_image_url": "",
              "race_id": "463403d4-11c3-4192-80ad-1e137fb25ca0",
              "created_at": "2018-09-15T16:40:31.382+02:00",
              "updated_at": "2018-09-15T16:40:31.391+02:00",
              "processed": false
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/photos/70b67bec-d626-48b5-bc72-fb86e8749c22`

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
    + id: `365521c6-b137-4a69-9345-7360ac211a28` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/photos/365521c6-b137-4a69-9345-7360ac211a28`

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
    + edition_id: `797` (number, required)

+ Request return a list of races for an edition
**GET**&nbsp;&nbsp;`/api/v1/editions/797/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "526dc130-5195-4e96-90e8-ee42b543c0a8",
                "name": "Race_13",
                "date": "2018-09-15",
                "email_sender": "contact@race_13.com",
                "hashtag": "#HASH13",
                "results_url": "results_13.com",
                "sms_message": "Congratulation for Race13",
                "template": "Template_13",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race13.com",
                "external_link_button": "Button_race13.com",
                "created_at": "2018-09-15T16:40:31.608+02:00",
                "updated_at": "2018-09-15T16:40:31.608+02:00",
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
                  "id": 797,
                  "date": "2018-09-15",
                  "description": "Desc_29",
                  "email_sender": "contact@race_29.com",
                  "hashtag": "#HASH29",
                  "results_url": "results_29.com",
                  "sms_message": "Congratulation for Race29",
                  "template": "Template_27",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race29.com",
                  "external_link_button": "Button_race29.com",
                  "created_at": "2018-09-15T16:40:31.604+02:00",
                  "updated_at": "2018-09-15T16:40:31.604+02:00",
                  "raw_results_file_name": "raw_Race29",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race29",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null
                }
              }
            ]

### Obtenir une course [GET /api/v1/races/{id}]

+ Parameters
    + id: `f99fcfdf-1129-468a-9ee5-49434371d51e` (string, required)

+ Request return the race
**GET**&nbsp;&nbsp;`/api/v1/races/f99fcfdf-1129-468a-9ee5-49434371d51e`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "f99fcfdf-1129-468a-9ee5-49434371d51e",
              "name": "Race_14",
              "date": "2018-09-15",
              "email_sender": "contact@race_14.com",
              "hashtag": "#HASH14",
              "results_url": "results_14.com",
              "sms_message": "Congratulation for Race14",
              "template": "Template_14",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race14.com",
              "external_link_button": "Button_race14.com",
              "created_at": "2018-09-15T16:40:31.634+02:00",
              "updated_at": "2018-09-15T16:40:31.634+02:00",
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
                "id": 798,
                "date": "2018-09-15",
                "description": "Desc_30",
                "email_sender": "contact@race_30.com",
                "hashtag": "#HASH30",
                "results_url": "results_30.com",
                "sms_message": "Congratulation for Race30",
                "template": "Template_28",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race30.com",
                "external_link_button": "Button_race30.com",
                "created_at": "2018-09-15T16:40:31.631+02:00",
                "updated_at": "2018-09-15T16:40:31.631+02:00",
                "raw_results_file_name": "raw_Race30",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race30",
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
    + edition_id: `800` (number, required)

+ Request create a new race for an edition
**POST**&nbsp;&nbsp;`/api/v1/editions/800/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_17",
                "email_sender": "contact@race_17.com",
                "email_name": "Race_17",
                "date": "2018-09-15T16:40:31+02:00",
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
                "department": "Department_17",
                "race_type": "route"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "0bf9d9d1-4f75-4ba4-a08a-03ad7706ade6",
              "name": "Race_17",
              "date": "2018-09-15",
              "email_sender": "contact@race_17.com",
              "hashtag": "#HASH17",
              "results_url": "results_17.com",
              "sms_message": "Congratulation for Race17",
              "template": "Template_17",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race17.com",
              "external_link_button": "Button_race17.com",
              "created_at": "2018-09-15T16:40:31.678+02:00",
              "updated_at": "2018-09-15T16:40:31.678+02:00",
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
                "id": 800,
                "date": "2018-09-15",
                "description": "Desc_32",
                "email_sender": "contact@race_32.com",
                "hashtag": "#HASH32",
                "results_url": "results_32.com",
                "sms_message": "Congratulation for Race32",
                "template": "Template_30",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race32.com",
                "external_link_button": "Button_race32.com",
                "created_at": "2018-09-15T16:40:31.665+02:00",
                "updated_at": "2018-09-15T16:40:31.665+02:00",
                "raw_results_file_name": "raw_Race32",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race32",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/801/races`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour une course [PUT /api/v1/races/{id}]

+ Parameters
    + id: `76f5c4ec-c39a-47ba-9faa-c758c7c1c50c` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/races/76f5c4ec-c39a-47ba-9faa-c758c7c1c50c`

    + Headers

            Accept: application/json
            Content-Type: application/json

    + Body

            {
              "race": {
                "name": "Race_20",
                "email_sender": "contact@race_20.com",
                "email_name": "Race_20",
                "date": "2018-09-15T16:40:31+02:00",
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
                "department": "Department_20",
                "race_type": "route"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "76f5c4ec-c39a-47ba-9faa-c758c7c1c50c",
              "name": "Race_20",
              "date": "2018-09-15",
              "email_sender": "contact@race_20.com",
              "hashtag": "#HASH20",
              "results_url": "results_20.com",
              "sms_message": "Congratulation for Race20",
              "template": "Template_20",
              "widget_generated_at": null,
              "photos_widget_generated_at": null,
              "external_link": "Race20.com",
              "external_link_button": "Button_race20.com",
              "created_at": "2018-09-15T16:40:31.709+02:00",
              "updated_at": "2018-09-15T16:40:31.718+02:00",
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
                "id": 802,
                "date": "2018-09-15",
                "description": "Desc_34",
                "email_sender": "contact@race_34.com",
                "hashtag": "#HASH34",
                "results_url": "results_34.com",
                "sms_message": "Congratulation for Race34",
                "template": "Template_32",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race34.com",
                "external_link_button": "Button_race34.com",
                "created_at": "2018-09-15T16:40:31.706+02:00",
                "updated_at": "2018-09-15T16:40:31.706+02:00",
                "raw_results_file_name": "raw_Race34",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race34",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/races/d6e03022-5af5-42be-8659-38f4eaf5ac13`

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
    + id: `0e099462-21c8-46a7-ba7d-6231727ea4d3` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/races/0e099462-21c8-46a7-ba7d-6231727ea4d3`

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
    + race_id: `0496b14e-9a94-4be4-97be-1d0b06dffdd8` (string, required)

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/races/0496b14e-9a94-4be4-97be-1d0b06dffdd8/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "92edce99-134f-4e59-890b-36b4d9cddd61",
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
                "created_at": "2018-09-15T16:40:31.831+02:00",
                "updated_at": "2018-09-15T16:40:31.831+02:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_1.com",
                "points": 1,
                "first_name": "First_1",
                "last_name": "Last_1",
                "dob": "2018-09-15T16:40:31.000+02:00",
                "race": {
                  "id": "0496b14e-9a94-4be4-97be-1d0b06dffdd8",
                  "name": "Race_24",
                  "date": "2018-09-15",
                  "email_sender": "contact@race_24.com",
                  "hashtag": "#HASH24",
                  "results_url": "results_24.com",
                  "sms_message": "Congratulation for Race24",
                  "template": "Template_24",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race24.com",
                  "external_link_button": "Button_race24.com",
                  "created_at": "2018-09-15T16:40:31.788+02:00",
                  "updated_at": "2018-09-15T16:40:31.788+02:00",
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
                  "id": 429,
                  "id_key": "ID_1",
                  "first_name": "First_1",
                  "last_name": "Last_1",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:31.803+02:00",
                  "updated_at": "2018-09-15T16:40:31.803+02:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/runners/430/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            [
              {
                "id": "7445c76e-42dc-4dbb-aa66-efb87a487743",
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
                "created_at": "2018-09-15T16:40:31.889+02:00",
                "updated_at": "2018-09-15T16:40:31.889+02:00",
                "uploaded_at": null,
                "diploma_generated_at": null,
                "email_sent_at": null,
                "sms_sent_at": null,
                "diploma_url": "www.result_2.com",
                "points": 2,
                "first_name": "First_2",
                "last_name": "Last_2",
                "dob": "2018-09-15T16:40:31.000+02:00",
                "race": {
                  "id": "a20d1149-5492-48a2-b6a5-16f64c5e8002",
                  "name": "Race_25",
                  "date": "2018-09-15",
                  "email_sender": "contact@race_25.com",
                  "hashtag": "#HASH25",
                  "results_url": "results_25.com",
                  "sms_message": "Congratulation for Race25",
                  "template": "Template_25",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race25.com",
                  "external_link_button": "Button_race25.com",
                  "created_at": "2018-09-15T16:40:31.875+02:00",
                  "updated_at": "2018-09-15T16:40:31.875+02:00",
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
                  "id": 430,
                  "id_key": "ID_2",
                  "first_name": "First_2",
                  "last_name": "Last_2",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:31.885+02:00",
                  "updated_at": "2018-09-15T16:40:31.885+02:00"
                }
              }
            ]

+ Request return its list of results
**GET**&nbsp;&nbsp;`/api/v1/editions/808/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Obtenir un résultat [GET /api/v1/results/{id}]

+ Parameters
    + id: `19593c2c-3bef-41d8-bab6-9de4c3ec948c` (string, required)

+ Request return the result
**GET**&nbsp;&nbsp;`/api/v1/results/19593c2c-3bef-41d8-bab6-9de4c3ec948c`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "19593c2c-3bef-41d8-bab6-9de4c3ec948c",
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
              "created_at": "2018-09-15T16:40:31.948+02:00",
              "updated_at": "2018-09-15T16:40:31.948+02:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_4.com",
              "points": 4,
              "first_name": "First_4",
              "last_name": "Last_4",
              "dob": "2018-09-15T16:40:31.000+02:00",
              "race": {
                "id": "977809c3-0ba5-479f-8b47-384ff13e0db7",
                "name": "Race_27",
                "date": "2018-09-15",
                "email_sender": "contact@race_27.com",
                "hashtag": "#HASH27",
                "results_url": "results_27.com",
                "sms_message": "Congratulation for Race27",
                "template": "Template_27",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race27.com",
                "external_link_button": "Button_race27.com",
                "created_at": "2018-09-15T16:40:31.939+02:00",
                "updated_at": "2018-09-15T16:40:31.939+02:00",
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
                "id": 432,
                "id_key": "ID_4",
                "first_name": "First_4",
                "last_name": "Last_4",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2018-09-15T16:40:31.944+02:00",
                "updated_at": "2018-09-15T16:40:31.944+02:00"
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
    + race_id: `91b3d369-bb67-4a34-8c40-436793110386` (string, required)

+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/races/91b3d369-bb67-4a34-8c40-436793110386/results`

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
                "dob": "2018-09-15T16:40:32+02:00",
                "race": {
                  "id": "91b3d369-bb67-4a34-8c40-436793110386",
                  "name": "Race_29",
                  "email_sender": "contact@race_29.com",
                  "email_name": "Race_29",
                  "date": "2018-09-15",
                  "hashtag": "#HASH29",
                  "results_url": "results_29.com",
                  "sms_message": "Congratulation for Race29",
                  "created_at": "2018-09-15T16:40:31.995+02:00",
                  "updated_at": "2018-09-15T16:40:31.995+02:00",
                  "raw_results_file_name": "raw_Race29",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race29",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_29",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race29.com",
                  "external_link_button": "Button_race29.com",
                  "edition_id": 811,
                  "coef": 29,
                  "category": "Category_29",
                  "department": "Department_29",
                  "race_type": "route"
                },
                "runner": {
                  "id": 434,
                  "id_key": "ID_6",
                  "first_name": "First_6",
                  "last_name": "Last_6",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:31.999+02:00",
                  "updated_at": "2018-09-15T16:40:31.999+02:00",
                  "category": null
                }
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "80ba4a4a-e51f-4c9b-a08c-c4af9d445b77",
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
              "created_at": "2018-09-15T16:40:32.015+02:00",
              "updated_at": "2018-09-15T16:40:32.015+02:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_7.com",
              "points": 7,
              "first_name": "First_7",
              "last_name": "Last_7",
              "dob": "2018-09-15T16:40:32.000+02:00",
              "race": {
                "id": "91b3d369-bb67-4a34-8c40-436793110386",
                "name": "Race_29",
                "date": "2018-09-15",
                "email_sender": "contact@race_29.com",
                "hashtag": "#HASH29",
                "results_url": "results_29.com",
                "sms_message": "Congratulation for Race29",
                "template": "Template_29",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race29.com",
                "external_link_button": "Button_race29.com",
                "created_at": "2018-09-15T16:40:31.995+02:00",
                "updated_at": "2018-09-15T16:40:31.995+02:00",
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
**POST**&nbsp;&nbsp;`/api/v1/races/d500f4d7-7b47-4cde-b8ca-5513981bb040/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/runners/436/results`

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
                "dob": "2018-09-15T16:40:32+02:00",
                "race": {
                  "id": "2ad0e1b7-6638-4f83-8d9f-9ad9776ca81a",
                  "name": "Race_31",
                  "email_sender": "contact@race_31.com",
                  "email_name": "Race_31",
                  "date": "2018-09-15",
                  "hashtag": "#HASH31",
                  "results_url": "results_31.com",
                  "sms_message": "Congratulation for Race31",
                  "created_at": "2018-09-15T16:40:32.057+02:00",
                  "updated_at": "2018-09-15T16:40:32.057+02:00",
                  "raw_results_file_name": "raw_Race31",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race31",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_31",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race31.com",
                  "external_link_button": "Button_race31.com",
                  "edition_id": 813,
                  "coef": 31,
                  "category": "Category_31",
                  "department": "Department_31",
                  "race_type": "route"
                },
                "runner": {
                  "id": 436,
                  "id_key": "ID_8",
                  "first_name": "First_8",
                  "last_name": "Last_8",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:32.062+02:00",
                  "updated_at": "2018-09-15T16:40:32.062+02:00",
                  "category": null
                }
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "010e4b71-088e-4a51-bdaa-2a9453a9cd47",
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
              "created_at": "2018-09-15T16:40:32.083+02:00",
              "updated_at": "2018-09-15T16:40:32.083+02:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_10.com",
              "points": 10,
              "first_name": "First_10",
              "last_name": "Last_10",
              "dob": "2018-09-15T16:40:32.000+02:00",
              "race": null,
              "edition": null,
              "runner": {
                "id": 436,
                "id_key": "ID_8",
                "first_name": "First_8",
                "last_name": "Last_8",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2018-09-15T16:40:32.062+02:00",
                "updated_at": "2018-09-15T16:40:32.062+02:00"
              }
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/runners/437/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



+ Request create a new result
**POST**&nbsp;&nbsp;`/api/v1/editions/815/results`

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
                "dob": "2018-09-15T16:40:32+02:00",
                "race": {
                  "id": "fcdf3a56-ba56-4ae6-8613-b43536ca60ac",
                  "name": "Race_33",
                  "email_sender": "contact@race_33.com",
                  "email_name": "Race_33",
                  "date": "2018-09-15",
                  "hashtag": "#HASH33",
                  "results_url": "results_33.com",
                  "sms_message": "Congratulation for Race33",
                  "created_at": "2018-09-15T16:40:32.130+02:00",
                  "updated_at": "2018-09-15T16:40:32.130+02:00",
                  "raw_results_file_name": "raw_Race33",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race33",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_33",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race33.com",
                  "external_link_button": "Button_race33.com",
                  "edition_id": 815,
                  "coef": 33,
                  "category": "Category_33",
                  "department": "Department_33",
                  "race_type": "route"
                },
                "runner": {
                  "id": 438,
                  "id_key": "ID_10",
                  "first_name": "First_10",
                  "last_name": "Last_10",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:32.135+02:00",
                  "updated_at": "2018-09-15T16:40:32.135+02:00",
                  "category": null
                }
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "9cfdb276-631d-4409-ab72-c481ee333acc",
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
              "created_at": "2018-09-15T16:40:32.150+02:00",
              "updated_at": "2018-09-15T16:40:32.150+02:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_13.com",
              "points": 13,
              "first_name": "First_13",
              "last_name": "Last_13",
              "dob": "2018-09-15T16:40:32.000+02:00",
              "race": null,
              "edition": {
                "id": 815,
                "date": "2018-09-15",
                "description": "Desc_47",
                "email_sender": "contact@race_47.com",
                "hashtag": "#HASH47",
                "results_url": "results_47.com",
                "sms_message": "Congratulation for Race47",
                "template": "Template_45",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race47.com",
                "external_link_button": "Button_race47.com",
                "created_at": "2018-09-15T16:40:32.127+02:00",
                "updated_at": "2018-09-15T16:40:32.127+02:00",
                "raw_results_file_name": "raw_Race47",
                "raw_results_content_type": "text/csv",
                "raw_results_file_size": 19024,
                "raw_results_updated_at": null,
                "background_image_file_name": "raw_Race47",
                "background_image_content_type": "image/jpg",
                "background_image_file_size": 19024,
                "background_image_updated_at": null
              },
              "runner": null
            }

+ Request return Bad request
**POST**&nbsp;&nbsp;`/api/v1/editions/816/results`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 400

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body



### Mettre à jour un résultat [PUT /api/v1/results/{id}]

+ Parameters
    + id: `0608dee6-b150-4c4f-862b-2b764189f97d` (string, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/results/0608dee6-b150-4c4f-862b-2b764189f97d`

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
                "dob": "2018-09-15T16:40:32+02:00",
                "race": {
                  "id": "a6962dd1-afd8-4731-b199-a97acedfe3f3",
                  "name": "Race_35",
                  "email_sender": "contact@race_35.com",
                  "email_name": "Race_35",
                  "date": "2018-09-15",
                  "hashtag": "#HASH35",
                  "results_url": "results_35.com",
                  "sms_message": "Congratulation for Race35",
                  "created_at": "2018-09-15T16:40:32.192+02:00",
                  "updated_at": "2018-09-15T16:40:32.192+02:00",
                  "raw_results_file_name": "raw_Race35",
                  "raw_results_content_type": "text/csv",
                  "raw_results_file_size": 19024,
                  "raw_results_updated_at": null,
                  "background_image_file_name": "raw_Race35",
                  "background_image_content_type": "image/jpg",
                  "background_image_file_size": 19024,
                  "background_image_updated_at": null,
                  "template": "Template_35",
                  "widget_generated_at": null,
                  "photos_widget_generated_at": null,
                  "external_link": "Race35.com",
                  "external_link_button": "Button_race35.com",
                  "edition_id": 817,
                  "coef": 35,
                  "category": "Category_35",
                  "department": "Department_35",
                  "race_type": "route"
                },
                "runner": {
                  "id": 440,
                  "id_key": "ID_12",
                  "first_name": "First_12",
                  "last_name": "Last_12",
                  "dob": "2017-11-16T11:05:06.000+01:00",
                  "department": "40",
                  "sex": "M",
                  "created_at": "2018-09-15T16:40:32.197+02:00",
                  "updated_at": "2018-09-15T16:40:32.197+02:00",
                  "category": null
                }
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": "0608dee6-b150-4c4f-862b-2b764189f97d",
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
              "created_at": "2018-09-15T16:40:32.200+02:00",
              "updated_at": "2018-09-15T16:40:32.211+02:00",
              "uploaded_at": null,
              "diploma_generated_at": null,
              "email_sent_at": null,
              "sms_sent_at": null,
              "diploma_url": "www.result_16.com",
              "points": 16,
              "first_name": "First_16",
              "last_name": "Last_16",
              "dob": "2018-09-15T16:40:32.000+02:00",
              "race": {
                "id": "a6962dd1-afd8-4731-b199-a97acedfe3f3",
                "name": "Race_35",
                "date": "2018-09-15",
                "email_sender": "contact@race_35.com",
                "hashtag": "#HASH35",
                "results_url": "results_35.com",
                "sms_message": "Congratulation for Race35",
                "template": "Template_35",
                "widget_generated_at": null,
                "photos_widget_generated_at": null,
                "external_link": "Race35.com",
                "external_link_button": "Button_race35.com",
                "created_at": "2018-09-15T16:40:32.192+02:00",
                "updated_at": "2018-09-15T16:40:32.192+02:00",
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
                "id": 440,
                "id_key": "ID_12",
                "first_name": "First_12",
                "last_name": "Last_12",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2018-09-15T16:40:32.197+02:00",
                "updated_at": "2018-09-15T16:40:32.197+02:00"
              }
            }

+ Request return Bad request
**PUT**&nbsp;&nbsp;`/api/v1/results/eddf4e4e-b5a4-4dd9-a359-a35f9c0f3c2c`

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
    + id: `4ce758a8-a3a2-481b-bb77-4d1f7459470d` (string, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/results/4ce758a8-a3a2-481b-bb77-4d1f7459470d`

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
                "id": 444,
                "id_key": "ID_16",
                "first_name": "First_16",
                "last_name": "Last_16",
                "dob": "2017-11-16T11:05:06.000+01:00",
                "department": "40",
                "sex": "M",
                "created_at": "2018-09-15T16:40:32.317+02:00",
                "updated_at": "2018-09-15T16:40:32.317+02:00"
              }
            ]

### Obtenir un coureur [GET /api/v1/runners/{id}]

+ Parameters
    + id: `445` (number, required)

+ Request return the runner
**GET**&nbsp;&nbsp;`/api/v1/runners/445`

    + Headers

            Accept: application/json
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "id": 445,
              "id_key": "ID_17",
              "first_name": "First_17",
              "last_name": "Last_17",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2018-09-15T16:40:32.329+02:00",
              "updated_at": "2018-09-15T16:40:32.329+02:00"
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
              "id": 448,
              "id_key": "ID_20",
              "first_name": "First_20",
              "last_name": "Last_20",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2018-09-15T16:40:32.353+02:00",
              "updated_at": "2018-09-15T16:40:32.353+02:00"
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
    + id: `451` (number, required)

+ Request return Success
**PUT**&nbsp;&nbsp;`/api/v1/runners/451`

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
              "id": 451,
              "id_key": "ID_25",
              "first_name": "First_24",
              "last_name": "Last_25",
              "dob": "2017-11-16T11:05:06.000+01:00",
              "department": "40",
              "sex": "M",
              "created_at": "2018-09-15T16:40:32.379+02:00",
              "updated_at": "2018-09-15T16:40:32.386+02:00"
            }

+ Request return Not Modified
**PUT**&nbsp;&nbsp;`/api/v1/runners/452`

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
**PUT**&nbsp;&nbsp;`/api/v1/runners/453`

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
    + id: `454` (number, required)

+ Request return No content
**DELETE**&nbsp;&nbsp;`/api/v1/runners/454`

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


