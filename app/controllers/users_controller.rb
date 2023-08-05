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
    # skills_backend = Skill.where(user_id: current_user.id, category_id: 1)
    # backend_a = skills_backend.map {|b| b.level}
    # @dataset1 = backend_a.sum.fdiv(backend_a.length)
    # gon.dataset1 = @dataset1

    # # フロントエンドの平均値
    # skills_frontend = Skill.where(user_id: current_user.id, category_id: 2)
    # frontend_a = skills_frontend.map {|f| f.level}
    # @dataset2 = frontend_a.sum.fdiv(frontend_a.length)
    # gon.dataset2 = @dataset2

    # # インフラの平均値
    # skills_infra = Skill.where(user_id: current_user.id, category_id: 3)
    # infra_a = skills_infra.map {|i| i.level}
    # @dataset3 = infra_a.sum.fdiv(infra_a.length)
    # gon.dataset3 = @dataset3


    now = Time.current
    this_month = now.all_month #当月いっぱい
    last_month = now.prev_month.all_month #先月いっぱい
    two_months_ago = now.ago(2.month).all_month #先々月いっぱい

    current_user_skills = Skill.where(user_id: current_user.id) #current_userのskill
    skills_backend = current_user_skills.where(category_id: 1) #バックエンドのskill
    skills_frontend = Skill.where(user_id: current_user.id, category_id: 2) #フロントエンドのskill
    skills_infra = Skill.where(user_id: current_user.id, category_id: 3) #インフラのskill

    # バックエンドの平均値
    skills_backend_1 = skills_backend.where(updated_at: this_month)
    backend_a_1 = skills_backend_1.map {|b| b.level}
    @dataset1_1 = backend_a_1.sum.fdiv(backend_a_1.length)
    gon.dataset1_1 = @dataset1_1

    skills_backend_2 = skills_backend.where(updated_at: last_month)
    backend_a_2 = skills_backend_2.map {|b| b.level}
    @dataset1_2 = backend_a_2.sum.fdiv(backend_a_2.length)
    gon.dataset1_2 = @dataset1_2

    skills_backend_3 = skills_backend.where(updated_at: two_months_ago)
    backend_a_3 = skills_backend_3.map {|b| b.level}
    @dataset1_3 = backend_a_3.sum.fdiv(backend_a_3.length)
    gon.dataset1_3 = @dataset1_3

    # フロントエンドの平均値
    skills_frontend_1 = skills_frontend.where(updated_at: this_month)
    frontend_a_1 = skills_frontend_1.map {|f| f.level}
    @dataset2_1 = frontend_a_1.sum.fdiv(frontend_a_1.length)
    gon.dataset2_1 = @dataset2_1

    skills_frontend_2 = skills_frontend.where(updated_at: last_month)
    frontend_a_2 = skills_frontend_2.map {|f| f.level}
    @dataset2_2 = frontend_a_2.sum.fdiv(frontend_a_2.length)
    gon.dataset2_2 = @dataset2_2

    skills_frontend_3 = skills_frontend.where(updated_at: two_months_ago)
    frontend_a_3 = skills_frontend_3.map {|f| f.level}
    @dataset2_3 = frontend_a_3.sum.fdiv(frontend_a_3.length)
    gon.dataset2_3 = @dataset2_3

    # インフラの平均値
    skills_infra_1 = skills_infra.where(updated_at: this_month)
    infra_a_1 = skills_infra_1.map {|i| i.level}
    @dataset3_1 = infra_a_1.sum.fdiv(infra_a_1.length)
    gon.dataset3_1 = @dataset3_1

    skills_infra_2 = skills_infra.where(updated_at: last_month)
    infra_a_2 = skills_infra_2.map {|i| i.level}
    @dataset3_2 = infra_a_2.sum.fdiv(infra_a_2.length)
    gon.dataset3_2 = @dataset3_2

    skills_infra_3 = skills_infra.where(updated_at: two_months_ago)
    infra_a_3 = skills_infra_3.map {|i| i.level}
    @dataset3_3 = infra_a_3.sum.fdiv(infra_a_3.length)
    gon.dataset3_3 = @dataset3_3
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
