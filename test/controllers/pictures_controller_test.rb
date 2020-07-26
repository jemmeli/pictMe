require "test_helper"

describe PicturesController do
  let(:picture) { pictures :one }

  it "gets index" do
    get pictures_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_picture_url
    value(response).must_be :success?
  end

  it "creates picture" do
    expect {
      post pictures_url, params: { picture: { image_data: picture.image_data } }
    }.must_change "Picture.count"

    must_redirect_to picture_path(Picture.last)
  end

  it "shows picture" do
    get picture_url(picture)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_picture_url(picture)
    value(response).must_be :success?
  end

  it "updates picture" do
    patch picture_url(picture), params: { picture: { image_data: picture.image_data } }
    must_redirect_to picture_path(picture)
  end

  it "destroys picture" do
    expect {
      delete picture_url(picture)
    }.must_change "Picture.count", -1

    must_redirect_to pictures_path
  end
end
