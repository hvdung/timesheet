class GroupsController < AuthorizeController
  before_action :find_group, only: :destroy
  def index
    @pagy, @groups = pagy Group.all, items: Settings.per_page
  end

  def new
    @group_form = GroupForm.new
  end

  def create
    @group_form = GroupForm.new group_params
    if @group_form.save
      flash[:success] = t ".success"
      redirect_to groups_path
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def edit
    @group_form = GroupForm.new nil, (Group.find params[:id])
  end

  def update
    @group_form = GroupForm.new group_params, (Group.find params[:id])
    if @group_form.save
      flash[:success] = t ".success"
      redirect_to groups_path
    else
      flash.now[:danger] = t ".error"
      render :edit
    end
  end

  def destroy
    if @group.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit :name, user_ids: []
  end

  def find_group
    @group = Group.find params[:id]
  end
end
