module Api::V1::Users::UsersDocument
  extend Apipie::DSL::Concern

  # View API Doc with url: http://localhost:3000/docs/1/users
  api :GET, "/users/", "Get list of users, sort by newest"
  param "AUTH-TOKEN", String, desc: "In header. This is auth token return when sign in successfully", required: true
  param :page, :number
  error code: 401, desc: "Unauthorized"
  formats %w(json)
  example <<-EXAM
  {
    "status": 401,
    "messages": "Invalid token"
  }
  EXAM

  example <<-EOS
    - Request
    ■ URL: /api/v1/users/
    ■ Method: GET
    Header:
      AUTHOR-TOKEN: "eyJhbGciOiJIUzI1NiJ9.IkNWM0Rxa3dWYVhpRXRvQ3pDMzhYb21lVCI.T-jn1Aay5E0n3dEQNTNHeyRyJJVZ0RP5izDBQAzi2yw"
    Params:
      page: 1

    - Response
    ■ Status: 200
    ■ Body:
    [
      {
        "id": 2,
        "name": "FirstName LastName 2",
        "email": "user2@example.com"
      },
      {
        "id": 1,
        "name": "FirstName LastName 1",
        "email": "user1@example.com"
      }
    ]
  EOS

  def index; end
end