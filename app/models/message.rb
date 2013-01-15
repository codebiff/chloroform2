class Message < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore
  serialize :label, ActiveRecord::Coders::Hstore

  belongs_to :user

  attr_accessible :data

  REJECTED_PARAMS = ["^api_key$", "^controller$", "^action$", "^confirm_url$", "^form_label$", "^_"]

  def self.generate user, params, referer=nil
    m = user.messages.build
    m.confirm_url = parse_confirm(user, params, referer)
    m.label = {name: params[:form_label].strip, slug: sluggerize(params[:form_label].strip)}
    m.data = clean(params)
    return false if m.data.empty?
    m.save
    MessageMailer.new_message(user, m).deliver if user.confirmed?
    return m
  end

  def self.clean params
    params.each {|k,v| params[k] = v.join(", ") if v.kind_of?(Array)}
    params.delete_if {|k,v| REJECTED_PARAMS.any? {|r| k =~ /#{r}/ }}
  end

  def self.parse_confirm user, params, referer
    return params[:confirm_url] if params.has_key?(:confirm_url)
    return user.settings[:confirm_url] || referer
  end

  def self.sluggerize text
    text.downcase.gsub('&','and').gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-')
  end

end
