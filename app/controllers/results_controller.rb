class ResultsController < ApplicationController
  layout 'nude', only: [:show, :download]
  layout 'diploma_form', only: [:email_diploma, :process_diploma_email]
  protect_from_forgery with: :exception
  #http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: [:show, :download, :email_diploma, :process_diploma_email, :diploma_thumbnail]

  def diploma
    diploma = GenerateDiploma.new(params[:id])
    respond_to do |format|
      format.html {
        render inline: diploma.html
      }
      format.jpg {
        @result = Result.find(params[:id])
        diploma_image_data = diploma.image_kit(
          IMAGE_HEIGHT[@result.edition.template],
          IMAGE_WIDTH[@result.edition.template]
        ).to_img(:jpg)
        send_data diploma_image_data, type: "image/jpeg",
                                      disposition:'inline'
      }
    end
  end

  def show
    @result = Result.find(params[:id])
  end

  def download
    @result = Result.find(params[:id])
    quality = @result.purchased_at? || !@result.edition.download_chargeable? ? :original : :freemium
    respond_to do |format|
      format.jpg {  send_data(open(@result.diploma.url(quality), allow_redirections: :all).read,
                    type: 'image/jpeg',
                    filename: "#{@result.edition.event.name}-#{@result.first_name}-#{@result.last_name}.jpg",
                    disposition: 'attachment') }
    end
  end

  def diploma_thumbnail
    @result = Result.find(params[:id])
    @url = ""
    @content = ""
    if @result
      @url = @result.diploma.url
      p @url
      renderer = ERB.new <<-EOF
      <html>
      <body>
      <img src='#{@url}.jpg' width='120' style='padding:none;'>"
      </body>
      </html>
      EOF
      p renderer
      @content = renderer.result()
      @image = IMGKit.new(@content, :width => 120, height: 80).to_img(:jpeg)
    end
    send_data @image, type: "image/jpeg", disposition: 'inline' and return
  end

  def email_diploma
    @result = Result.find(params[:id])
    @url = diploma_thumbnail_path(id: @result.id)
    p @url
    @edition = Edition.find(params[:edition])
    if !@result
      redirect_to :back and return
    end
  end

  def process_diploma_email
    @name = params[:name]
    @email = params[:email]
    edition_id = params[:edition]
    @result = Result.find(params[:id])
    if @result
      EmailRequest.create(id: Time.now.to_i, result_id: @result.id, name: @name, email: @email)
      ResultMailer.mail_diploma(@result.id, @email, @name).deliver_now
      @edition = Edition.find(edition_id)
      @return_link = @edition.external_link || 'https://kapp10.com'
      flash[:notice] = "Votre diplôme vous attend dans votre boite email. :)"
      # redirect_to event_edition_path(@edition.event, @edition), notice: "Votre diplôme vous attend dans votre boite email. :)"
    end 
  end

  def stand_by
    @results = Result.where(runner_id: nil)
  end
end
