require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # atuthenticate api
  describe 'Post authenticate' do
    # unauthorized 401
    it 'returns unauthorized' do
      params = {
        data: {
          attributes: {
            email: "dummy@example.com",
            password: "password"
          }
        }
      }
      post '/authenticate', params: params
      expect_status(401)
      # todo expect_json(error messages)
    end
    describe 'authorized' do
      before { create(:user) }

      it 'returns invalid_credentials' do
        params = {
          data: {
            attributes: {
              email: "test1@example.com",
              password: "invalidpassword"
            }
          }
        }
        post '/authenticate', params: params
        expect_status(401)
        # todo expect_json(error messages)
      end

      it 'returns authorized' do
        params = {
          data: {
            attributes: {
              email: "test1@example.com",
              password: "password"
            }
          }
        }
        post '/authenticate', params: params
        expect_status(200)
        expect(json_body[:access_token]).to be_present
      end
    end
  end
end
