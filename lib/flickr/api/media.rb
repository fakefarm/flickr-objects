class Flickr
  class Media < Object
    def add_tags(tags, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end
    instance_api_method :add_tags, "flickr.photos.addTags"

    def delete(params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id)
      self
    end
    instance_api_method :delete, "flickr.photos.delete"

    def get_info!(params = {})
      response = client.get flickr_method(__method__), params.merge(photo_id: id)
      @hash.update(response["photo"])
      self
    end
    instance_api_method :get_info!, "flickr.photos.getInfo"

    def remove_tag(tag_id, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tag_id: tag_id)
      tag_id
    end
    instance_api_method :remove_tag, "flickr.photos.removeTag"

    def self.search(params = {})
      response = client.get flickr_method(__method__), include_media(params)
      Collection.new(response["photos"].delete("photo"), self, response["photos"], client)
    end
    class_api_method :search, "flickr.photos.search"

    def set_content_type(content_type, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, content_type: content_type)
      content_type
    end
    alias content_type= set_content_type
    instance_api_method :set_content_type, "flickr.photos.setContentType"

    def set_tags(tags, params = {})
      client.post flickr_method(__method__), params.merge(photo_id: id, tags: tags)
      tags
    end
    alias tags= set_tags
    instance_api_method :set_tags, "flickr.photos.setTags"
  end
end
