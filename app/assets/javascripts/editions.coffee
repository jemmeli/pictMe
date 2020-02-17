$ ->
  uploadedFilesCount = 0
  $('#s3_uploader').S3Uploader
    remove_completed_progress_bar: false
    progress_bar_target: $('#uploads_container')
  $('#s3_uploader').on 's3_upload_failed', (e, content) ->
    console.error e, content
    alert content.filename + ' failed to upload'
  $('#s3_uploader').on 's3_upload_complete', (e, content) ->
    uploadedFilesCount += 1
  $('#s3_uploader').on 's3_uploads_complete', (e, content) ->
    $('#modal-import-photos').modal 'hide'
    $alertSelector = $('#alert-import-photos-success')
    $alertSelector.text(uploadedFilesCount + ' photos ont été importées')
    $alertSelector.show()
    setTimeout (->
      $alertSelector.fadeOut 'slow'
      $alertSelector.empty()
    ), 3000
    uploadedFilesCount = 0
