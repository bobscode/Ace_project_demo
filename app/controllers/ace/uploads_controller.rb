require 'QuickBaseClient'

class Ace::UploadsController < ApplicationController

  require 'rexml/document'
  include REXML
  require 'xmlsimple'
  require 'active_support'
  require 'nokogiri'

  @@quickbase_username = "brohrer@advantagequickbase.com"
  @@quickbase_password = "azswigzu2"
  @@attachment_dbid = "bgufdjsk6"
  @@app_token = "dc3bx5acb4zujxt7w3ac8r8vp9"
  @@attachment_fid = "9"
  @@document_name_fid = "6"
  @@document_type_fid = "7"
  @@related_customer_fid = "25"
  @@MAX_FILE_ATTACHMENTS = 10

  def new
  	@all = []
  	client = QuickBase::Client.init("username" => @@quickbase_username, "password" => @@quickbase_password, "stopOnError"=>true)
    client.apptoken = @@app_token
  	schema = client.getSchema(@@attachment_dbid)
  	choices = REXML::XPath.first(schema, ".//choices")
  	@all = choices.elements.map(&:text).map {|e| [e.titleize, e] }.sort
  end

  def create
      puts params["related_customer"]
      client = QuickBase::Client.init("username" => @@quickbase_username, "password" => @@quickbase_password, "stopOnError"=>true)
      client.apptoken = @@app_token
	
      for i in 1..@@MAX_FILE_ATTACHMENTS
        if params["file_attachment_#{i}"]
          client.addFieldValuePair(nil, @@attachment_fid, params["file_attachment_#{i}"].original_filename, params["file_attachment_#{i}"].open)
          client.addFieldValuePair(nil, @@document_name_fid, nil, params["document_name_#{i}"])
          client.addFieldValuePair(nil, @@document_type_fid, nil, params["document_type_#{i}"])
          client.addFieldValuePair(nil, @@related_customer_fid, nil, params["related_customer"])
          client.addRecord(@@attachment_dbid, client.fvlist)
          client.clearFieldValuePairList
        end
      end
      redirect_to("https://www.quickbase.com/db/bgvham6e3?a=dr&rid=" + params["related_customer"])
  end
end

