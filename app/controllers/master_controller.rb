class MasterController < ApplicationController

  http_basic_authenticate_with name: "master", password: "Mpass123"

  layout 'master'

end
