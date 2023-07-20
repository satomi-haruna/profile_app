class SkillsController < ApplicationController
  # before_action :correct_user, except: [:show, :index]

  def new
    @skill = current_user.skills.build
  end

  def create
    @skill = current_user.skills.build(skill_params)
    @skill.save
    #   flash[:success] = "Save"
    redirect_to root_path(@user)
    # else
    #   flash[:success] = "Miss"
    #   render new_skill_path, status: :unprocessable_entity
    # end
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
