require 'spec_helper'
require 'rails_helper'

RSpec.describe DeviseHelper, type: :helper do
  let(:resource_name) { (:contact) }
  let(:devise_mapping){ (Devise.mappings[:contact]) }

  context 'no error messages' do
    let(:resource) { (User.new) }
    it '#devise_error_messages!' do
      expect(devise_error_messages!).to eq("")
    end
  end

  context 'with error messages' do
    let(:resource) { (User.create) } 
    it '#devise_error_messages!' do
      expect(devise_error_messages!).to_not eq("")
    end
  end
end

#module DeviseHelper
#	def devise_error_messages!
#		return '' if resource.errors.empty?
#
#		messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
#		sentence = I18n.t('errors.messages.not_saved', count: resource.errors.count, resource: resource.class.model_name.human.downcase)
#
#		html = <<-HTML
#		<div class="alert alert-danger alert-dismissable">
#			<h4>#{sentence}</h4>
#			#{messages}
#		</div>
#		HTML
#
#		html.html_safe
#
#	end
#end