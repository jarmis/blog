if $('#with-button').size() > 0
  $('.pagination').hide()
  loading_posts = false

  $('#load_more_posts').show().click ->
    unless loading_posts
      loading_posts = true
      more_posts_url = $('.pagination .next_page a').attr('href')
      $this = $(this)
      $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled')
      $.getScript more_posts_url, ->
        $this.text('More posts').removeClass('disabled') if $this
        loading_posts = false
    return