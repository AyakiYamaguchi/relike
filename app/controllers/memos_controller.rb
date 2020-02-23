class MemosController < ApplicationController
  before_action :set_remind_list

  def create
    @memo = @remind_list.memos.create!(memo_params)
    # redirect_to "/remind_lists/#{@memo.remind_list_id}"
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end

  def set_remind_list
    @remind_list = RemindList.params[:remind_list_id]
  end
end
