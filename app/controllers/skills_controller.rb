class SkillsController < ApplicationController
  # before_action :correct_user, except: [:show, :index]

  def new
    @skill = current_user.skills.build
    @category_id = params[:category_id]
    @category = Category.find(@category_id)
  end

  def create
    @skill = current_user.skills.build(skill_params)
    @category_id = params[:category_id]
    @category = Category.find(@category_id)
    if @skill.save
      flash.now[:success] = "Save"
      redirect_to edit_skill_path(current_user)
    else
      flash.now[:danger] = "Miss"
      render new_skill_path, status: :unprocessable_entity
    end
  end

  def edit
    # @skills = Skill.where(category_id: 1)
    # @skill = current_user.skills.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

    def skill_params
      params.require(:skill).permit(:skill_name, :level)
    end

    # # 正しいユーザーかどうか確認
    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_url, status: :see_other) unless @user == current_user
    # end
end
