module OembedTweet

  # 埋め込み用ツイート取得メソッド
  def get_oembed_tweet(remind_lists)

    # APIで取得したoEmbed互換形式のツイート情報を格納するハッシュ
    @tweets = []

    # 1件ずつリストを取得して、oEmbedAPIにリクエスト投げる
    remind_lists.each do |list|

      # リクエスト用のURLを生成
      tweet_url = "https://twitter.com/#{list.tweet_acount_id}/status/#{list.tweet_id}"
      # リクエストパラーメータをURL形式にエンコード
      params = URI.encode_www_form({url: tweet_url})
      # URIを解析し、hostやportをバラバラに取得できるようにする
      uri = URI.parse("https://publish.twitter.com/oembed?#{params}")

      logger.debug(uri)

      http = Net::HTTP.new(uri.host, uri.port)

      # これが無いとSSLページ接続時に「end of file reached (EOFError)」というエラー出る
      http.use_ssl = uri.scheme === "https"

      req = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(req)

      begin
        case response
        when Net::HTTPSuccess
          @result = JSON.parse(response.body)
          @tweets << @result['html']
        when Net::HTTPRedirection
          @message = "Redirection: code=#{response.code} message=#{response.message}"
        else
          @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
        end
      # 〇〇へ格納
      end
      
    end
  
    return @tweets
  end


  def get_oembed_tweet_only_one(remind_list)
    # リクエスト用のURLを生成
    tweet_url = "https://twitter.com/#{remind_list.tweet_acount_id}/status/#{remind_list.tweet_id}"

    # リクエストパラーメータをURL形式にエンコード
    params = URI.encode_www_form({url: tweet_url})

    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("https://publish.twitter.com/oembed?#{params}")

    http = Net::HTTP.new(uri.host, uri.port)

    # これが無いとSSLページ接続時に「end of file reached (EOFError)」というエラー出る
    http.use_ssl = uri.scheme === "https"

    req = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(req)

    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
        @result['html']
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    end

  end
end