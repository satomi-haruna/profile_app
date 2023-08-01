class SkillsController < ApplicationController
  # before_action :correct_user, except: [:show, :index]

  def new
    @skill = current_user.skills.build
    category_params
  end

  def create
    @skill = current_user.skills.build(skill_params)
    category_params
    @skill.category_id = @category_id
    @category = Category.find(@category_id)
    if @skill.save
      flash[:success] = "#{@category.category_name} に
                         #{@skill.skill_name} を
                         習得レベル#{@skill.level} で追加しました！"
      redirect_to edit_skill_path(current_user)
    else
      flash.now[:danger] = "スキルの追加に失敗しました。"
      render new_skill_path, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    # if @skill.update(skill_params)
    #   flash[:success] = "#{@skill.skill_name} の習得レベルを保存しました！"
    # else
    #   flash.now[:danger] = "習得レベルの更新に失敗しました。"
    #   render edit_skill_path, status: :unprocessable_entity
    # end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    flash[:success] = "#{@skill.skill_name} の項目を削除しました！"
    redirect_to request.referrer, status: :see_other
  end

  private

    def skill_params
      params.require(:skill).permit(:skill_name, :level)
    end

    def category_params
      @category_id = params[:category_id]
      @category = Category.find(@category_id)
    end

    # # 正しいユーザーかどうか確認
    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_url, status: :see_other) unless @user == current_user
    # end
end
