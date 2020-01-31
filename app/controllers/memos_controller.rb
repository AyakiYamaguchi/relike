class MemosController < ApplicationController
  def create
    @memo = Memo.create!(memo_params)
    # redirect_to "/remind_lists/#{@memo.remind_list_id}"
  end


  def memo_params
    params.require(:memo).permit(:content , :remind_list_id)
  end
end
