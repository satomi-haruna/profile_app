class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new

  end

  def create
  end

  def show
    @user = User.find(params[:id])

    # chart
    # バックエンドの平均値
    skills_backend = Skill.where(category_id: 1)
    backend_a = skills_backend.map {|b| b.level}
    @dataset1 = backend_a.sum.fdiv(backend_a.length)
    gon.dataset1 = @dataset1

    # フロントエンドの平均値
    skills_frontend = Skill.where(category_id: 2)
    frontend_a = skills_frontend.map {|f| f.level}
    @dataset2 = frontend_a.sum.fdiv(frontend_a.length)
    gon.dataset2 = @dataset2

    # インフラの平均値
    skills_infra = Skill.where(category_id: 3)
    infra_a = skills_infra.map {|i| i.level}
    @dataset3 = infra_a.sum.fdiv(infra_a.length)
    gon.dataset3 = @dataset3


    # day = Date.today #→Fri, 04 Aug 2023
    # day << 1 #Tue, 04 Jul 2023 1ヶ月前
    # day << 2 #Sun, 04 Jun 2023 2ヶ月前

    # day.month #8
    # # 1つのスキルデータ　@skill
    # @skill.update_at.month #8

    # # 今月
    # Date.today.month




  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:introduction, :image_id)
    end

    # ログイン済みかどうか　beforeフィルタで使用
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url, status: :see_other
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
