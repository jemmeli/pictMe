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
