module API
  module V1
    class Messages < Grape::API
      include API::V1::Defaults

      resource :messages do
        desc "Return all messages"
        get "", root: :messages do
          Message.all
        end

        desc "Return a Message"
        params do
          requires :id, type: String, desc: "ID of the
            Message"
        end
        get ":id", root: "message" do
          Message.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
